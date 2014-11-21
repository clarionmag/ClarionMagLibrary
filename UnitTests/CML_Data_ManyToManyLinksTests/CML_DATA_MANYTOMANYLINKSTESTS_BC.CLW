  MEMBER('CML_Data_ManyToManyLinksTests.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('CML_Data_ManyToManyLinksTests_BC0.CLW')
CML_Data_ManyToManyLinksTests_BC0:DctInit             PROCEDURE
CML_Data_ManyToManyLinksTests_BC0:DctKill             PROCEDURE
CML_Data_ManyToManyLinksTests_BC0:FilesInit           PROCEDURE
    END
  END

DLLInit              DllInitializer                          !This object is used to initialize the dll, it is defined in the main program module

DctInit PROCEDURE
  CODE
  CML_Data_ManyToManyLinksTests_BC0:DctInit
  CML_Data_ManyToManyLinksTests_BC0:FilesInit


DctKill PROCEDURE
  CODE
  CML_Data_ManyToManyLinksTests_BC0:DctKill

