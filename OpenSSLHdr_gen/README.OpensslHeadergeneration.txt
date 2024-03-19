OPENSSL HEADER GENERATION

The OpenSSL library is written in 'C' and the programmatic interface is defined in a series of 'C' header files. These have to be translated into Pascal units in order to declare the interface to a Pascal code library, such as Indy.

The approach take here is:

1. To perform an initial automated translation using a tool such as Free Pascal's “h2pas”. This generates a Pascal unit from each 'C' header file and aims to create a Pascal procedure or function declaration and supporting constants and types for each 'C' function found. 

2. Each such unit is reviewed and marked up as described below and, where necessary, backwards and forwards compatibility procedures and functions are added in order to allow for more than one version of the OpenSSL library to be used by Indy. The saved file is given the extension “.h2pas” in order to distinguish it from a genuine Pascal unit.

3. A shell script is run. This uses the line editor (sed) to perform multiple edits on each .h2pas unit in order to transform it into a Pascal unit (.pas file) suitable for use by Indy. The script is named “genOpenSSLHdrs.sh”. It processes every .h2pas file in the directory “sslheaders_source” and outputs a corresponding .pas file by default to the directory “../Lib/protocols”. The output directory can be overridden when the script is run by providing the output directory path as the only command parameter.

Note: backwards compatibility procedures/functions are used instead of an OpenSSL procedure/function with the same name when that procedure/function has been removed from the version of the OpenSSL library that has been loaded.

Note: forwards compatibility procedures/functions are needed when an internal OpenSSL data structure that was exposed in earlier versions of the OpenSSL library is opaque in later versions; the data structure being accessed through procedures/functions instead. The forwards compatibility functions replicate the action of the data structure access procedures/functions so that earlier versions of the OpenSSL library can continue to be used whilst the using code assumes the later version.

H2PAS FILE STRUCTURE

1. Standard unit layout with no external definitions.

2. function/procedure definitions in interface section must each be on a single line and not split over multiple lines.

3. Special bracketed comments after each function/procedure definition used to identify new (introduced) and removed functions procedures together with the 3 level release number (major.minor.fix) in which they were introduced/removed. e.g. {introduced 1.1.1} or {introduced 1.0.0 removed 3.0.0}. Removed clauses may also be followed by "allow_nil" indicating that it is not an error if the function/procedure cannot be loaded. e.g. {removed 3.0.0 allow_nil}.

4. Special comments in implementation section "{forward_compatibility}" to "{/forward_compatibility}" used to indicate section comprising consts, types and function/procedure declarations used to provide an external function/procedure in a library version before it is introduced. Function/procedure names are the same as the external function/procedure. Typical use is when a later version of the SSL library hides a previously exposed data structure (e.g. SSL_CTX) and provides access functions instead. Providing early versions of these functions using the exposed data structure allows for the same user code to access both version of the SSL library.

5. Implementation section otherwise) comprises const, types and local procedure/function bodies for removed procedure/functions where a backwards compatible procedure/function is needed.

6. Both interface and implementation sections may contain a section delimited by "{helper_functions}" and "{/helper_functions}". These sections are copied unchanged to the output unit.

GENERATION OF OUTPUT UNIT

1. Same unit name as h2pas source.

2. All const, var and type definitions in interface copied to output unit.

3. The helper_functions section in the input unit's interface section is copied unchanged to the output unit's interface section.

4. Defined symbol "USE_EXTERNAL_LIBRARY" used to separate static and dynamic interface sections in both interface and implementation sections.

5. In the unit's static library "interface" section:

i. All functions/procedures in interface section that have not been commented as removed are included and made external. A conditional definition is used to identify when the external library name is also included. Note: In FPC, the external library name is omitted when the intention is to link the program to a static OpenSSL library (.a file). Otherwise, the shared library name implies static linking to the shared OpenSSL library (.so or .dll).

ii. All functions/procedures in interface section that have been commented as removed are included as normal function/procedure definitions provided that a function/procedure with the same name is located in the implementation section (backwards compatibility).

6. In the unit's Dynamic Library "interface" Section all functions/procedures in interface section are converted to procedure variables. This includes all introduced and removed functions/procedures.

7. In the unit's implementation section

i. The implementation "uses" clause extended to include the classes, IdResourceStringsOpenSSL and IdOpenSSLLoader units for the dynamic library only.

ii. This is followed by  a list of consts to give the OpenSSL formatted version number of each introduced and removed function in the format "<name>_introduced = ..." and "<name>_removed = ...". e.g.

X509_get0_serialNumber_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(1);

iii.The helper_functions section in the input unit's implementation section are copied unchanged to the output unit's implementation section.

8. In the unit's static library "implementation" section:

i. The original implementation body, including consts and types except for the {helper_functions} and the {forward_compatibility} sections.
 
9. In the unit's Dynamic Library "implementation" Section

i. All of implementation body, except for the {helper_functions} and the {forward_compatibility} sections, is then copied to the implementation section with procedure/function names prepended with an underscore to avoid name conflict with procedure variables of the same name.

ii. The  {forward_compatibility} section is then copied to the implementation with procedure/function names prepended with "FC_".

iii. An error handling function/procedure is added for each introduced/removed function/procedure in the interface section other than those with the "allow_nil" tag. This has the same name and function signature as given in the interface section, except that the name is prepended with ERR_.

10. A Load procedure is added to the dynamic interface section. This comprises:

 i. A Call to load the address of each procedure/function into the corresponding procedure variable.

 ii. If the procedure/function is neither "introduced" nor "removed" then a failure to load is handled by adding the procedure/function name to the "failed" list.

 iii. After all procedures/functions are loaded, the procedure/function variables for "introduced" procedures/functions are checked and, if null, the “{$IF declared” syntax is used to assigned the address of any procedure/function with the same name prepended with FC_, if one exists. 

iv. Otherwise, the procedure/function variables for "removed" procedures/functions are checked and, if null, the “{$IF declared” syntax is used to assigned the address of any procedure/function with the same name (plus a leading underscore).

v. Otherwise, the variable is assigned the address of the procedure/function (prepended with ERR_) that raises an exception if it is called at runtime. Use of the “{$IF declared” syntax here ensure that "allow_nil" tagged procedures do not have an error handler.

11. An Unload procedure is added to the dynamic interface section setting each function/procedure variable to nil.

12. An initialization section is added for the dynamic library only. This registers the Load and Unload procedures with the OpenSSLLoader.
