#!/bin/sh
#Create PKI for openssl server test
#
CADIR=ca
SERVER=myserver
CLIENT=myclient
PASSWORD=mypassword

cd certs

mkdir -p $CADIR

cd $CADIR
if [ ! -f ca.key ]; then
  openssl genrsa -aes256 -passout pass:$PASSWORD -out cakey.pem 4096
fi

# Self-sign root certificate
CONFIG="root-ca.conf"
cat >$CONFIG <<EOT
[ req ]
prompt = no
default_bits			= 2048 
default_keyfile			= cakey.pem
distinguished_name		= req_distinguished_name
x509_extensions			= v3_ca
string_mask			= nombstr
req_extensions			= v3_req
[ req_distinguished_name ]
countryName		= GB 
stateOrProvinceName	= London
localityName		= Westminster
0.organizationName	= Snake Oil (Sales) Ltd
organizationalUnitName	= Certification Services Division
commonName			= Snake Oil Root CA
emailAddress			= cobra@badguys.com
[ v3_ca ]
extendedKeyUsage	= serverAuth,clientAuth,msSGC,nsSGC
basicConstraints		= critical,CA:true
subjectKeyIdentifier		= hash
[ v3_req ]
nsCertType			= objsign,email,server
EOT

echo "Self-sign the root CA..."
openssl req -new -x509 -days 3650 -config $CONFIG -key cakey.pem -out ca.pem -passin pass:$PASSWORD

rm -f $CONFIG

#   make sure environment exists
if [ ! -d ca.db.certs ]; then
    mkdir ca.db.certs
fi
if [ ! -f ca.db.serial ]; then
    echo '01' >ca.db.serial
fi
if [ ! -f ca.db.index ]; then
    cp /dev/null ca.db.index
fi

cd ..

if [ ! -f $SERVER.key.pem ]; then
  openssl genrsa -aes256 -passout pass:$PASSWORD -out ${SERVER}key.pem 2048 
fi

CONFIG="server-cert.conf"
cat >$CONFIG <<EOT
[ req ]
prompt = no
default_bits			= 2048 
default_keyfile			= ${SERVER}key.pem
distinguished_name		= req_distinguished_name
string_mask			= nombstr
req_extensions			= v3_req
[ req_distinguished_name ]
countryName		= GB
stateOrProvinceName	= London
localityName		= Westminster
0.organizationName	= Snake Oil (Trading) Ltd
organizationalUnitName	= Secure Web Server
commonName			= localhost
emailAddress			= python@badguys.com
[ v3_req ]
nsCertType			= server
basicConstraints		= critical,CA:false
EOT

echo "Creating the Server csr"
openssl req -new -config $CONFIG -key ${SERVER}key.pem -out $SERVER.csr -passin pass:$PASSWORD

rm -f $CONFIG

#Now sign the server cert request
cat >ca.config <<EOT
[ ca ]
prompt = no
default_ca              = default_CA
[ default_CA ]
dir                     = $CADIR 
certs                   = \$dir
new_certs_dir           = \$dir/ca.db.certs
database                = \$dir/ca.db.index
serial                  = \$dir/ca.db.serial
RANDFILE                = \$dir/random-bits
certificate             = \$dir/ca.pem
private_key             = \$dir/cakey.pem
default_days            = 1000 
default_crl_days        = 30
default_md              = sha256 
preserve                = no
x509_extensions		= server_cert
policy                  = policy_anything
unique_subject		= no
[ policy_anything ]
countryName             = optional
stateOrProvinceName     = optional
localityName            = optional
organizationName        = optional
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional
[ server_cert ]
#subjectKeyIdentifier	= hash
authorityKeyIdentifier	= keyid:always
extendedKeyUsage	= serverAuth,clientAuth,msSGC,nsSGC
basicConstraints	= critical,CA:false
EOT

#  sign the certificate
echo "Signing the server certificate"
openssl ca -config ca.config -passin pass:$PASSWORD -batch -out $SERVER.pem -infiles $SERVER.csr 
if ! openssl verify -CAfile $CADIR/ca.pem $SERVER.pem; then
  echo "Verification of server certificate failed!"
  exit 1
fi

#  cleanup 
rm -f ca.config
rm -f $CADIR/ca.db.serial.old
rm -f $CADIR/ca.db.index.old
rm $SERVER.csr

if [ ! -f $CLIENT.key ]; then
	openssl genrsa -aes256 -passout pass:$PASSWORD -out ${CLIENT}key.pem 2048
fi

# Fill the necessary certificate data
CONFIG="user-cert.conf"
cat >$CONFIG <<EOT
[ req ]
prompt = no
default_bits			= 2048 
default_keyfile			= ${CLIENT}key.pem
distinguished_name		= req_distinguished_name
string_mask			= nombstr
req_extensions			= v3_req
[ req_distinguished_name ]
commonName			= John Smith
emailAddress			= adder@badguys.com
[ v3_req ]
nsCertType			= client,email
basicConstraints		= critical,CA:false
EOT

echo "Creating the Client csr"
openssl req -new -config $CONFIG -key ${CLIENT}key.pem -out $CLIENT.csr -passin pass:$PASSWORD

rm -f $CONFIG

cat >ca.config <<EOT
[ ca ]
default_ca              = default_CA
[ default_CA ]
dir                     = $CADIR 
certs                   = \$dir
new_certs_dir           = \$dir/ca.db.certs
database                = \$dir/ca.db.index
serial                  = \$dir/ca.db.serial
RANDFILE                = \$dir/random-bits
certificate             = \$dir/ca.pem
private_key             = \$dir/cakey.pem
default_days            = 1095
default_crl_days        = 30
default_md              = sha256 
preserve                = yes
x509_extensions		= user_cert
policy                  = policy_anything
[ policy_anything ]
commonName              = supplied
emailAddress            = supplied
[ user_cert ]
#SXNetID		= 3:yeak
subjectAltName		= email:copy
basicConstraints	= critical,CA:false
authorityKeyIdentifier	= keyid:always
extendedKeyUsage	= clientAuth,emailProtection
EOT

#  sign the certificate
echo "Signing the client certificate"
openssl ca -config ca.config -passin pass:$PASSWORD -batch -out $CLIENT.pem -infiles $CLIENT.csr 
if ! openssl verify -CAfile $CADIR/ca.pem $CLIENT.pem; then
  echo "Verfiication of Client Certificate Failed!"
  exit 1
fi

#  cleanup 
rm -f ca.config
rm -f $CAPATH/ca.db.serial.old
rm -f $CAPATH/ca.db.index.old
rm $CLIENT.csr

username="`openssl x509 -noout  -in $CLIENT.pem -subject | sed -e 's;.*CN=;;' -e 's;/Em.*;;'`"
caname="`openssl x509 -noout  -in $CADIR/ca.pem -subject | sed -e 's;.*CN=;;' -e 's;/Em.*;;'`"

echo "Creating the client p12 package"
# Package it.
openssl pkcs12 \
 	-export \
 	-in "${CLIENT}.pem" \
	-inkey "${CLIENT}key.pem" \
	-certfile $CADIR/ca.pem \
	-name "$username" \
	-caname "$caname" \
	-passin pass:$PASSWORD \
	-passout pass:$PASSWORD \
	-out $CLIENT.p12

openssl rehash ../cacerts
#convert softlinks to files (because of windows...)
for FN in `ls -1`; do
  if [ -h "$FN" ]; then 
    SRC=`readlink "$FN"`
    rm "$FN"
    cp "$SRC" "$FN"
  fi
done
	
#cleanup
rm ${CLIENT}key.pem $CLIENT.pem
mv $CADIR/ca.pem ../cacerts
rm -r $CADIR


