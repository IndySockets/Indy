brc32 IdRegister.rc -r -foIdRegister.dcr
copy IdRegister.dcr ..\Lib\Protocols
brc32 IdCoreRegister.rc -r -foIdCoreRegister.dcr
copy IdCoreRegister.dcr ..\Lib\Core
brc32 IdSuperCoreRegister.rc -r -foIdSuperCoreRegister.dcr
copy IdSuperCoreRegister.dcr ..\Lib\SuperCore