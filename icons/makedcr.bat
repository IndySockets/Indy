brc32 IdRegister.rc -rv -foIdRegisterCool.dcr
copy IdRegisterCool.dcr ..\lib\Protocols
copy IdRegisterCool.dcr ..\..\branches\Tiburon\Lib\Protocols
brc32 IdCoreRegister.rc -rv -foIdCoreRegisterCool.dcr
copy IdCoreRegisterCool.dcr ..\lib\Core
copy IdCoreRegisterCool.dcr ..\..\branches\Tiburon\Lib\Core
brc32 IdSuperCoreRegister.rc -rv -foIdSuperCoreRegisterCool.dcr
copy IdSuperCoreRegisterCool.dcr ..\lib\SuperCore