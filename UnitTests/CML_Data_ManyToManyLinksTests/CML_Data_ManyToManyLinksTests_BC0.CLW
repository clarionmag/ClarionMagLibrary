  MEMBER('CML_Data_ManyToManyLinksTests.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
CML_Data_ManyToManyLinksTests_BC0:DctInit    PROCEDURE
CML_Data_ManyToManyLinksTests_BC0:DctKill    PROCEDURE
CML_Data_ManyToManyLinksTests_BC0:FilesInit  PROCEDURE
  END

Hide:Access:M2MLinkData CLASS(FileManager),TYPE            ! FileManager for M2MLinkData
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:M2MLinkData CLASS(RelationManager),TYPE        ! RelationManager for M2MLinkData
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:M2MLinkDataMSSql CLASS(FileManager),TYPE       ! FileManager for M2MLinkDataMSSql
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:M2MLinkDataMSSql CLASS(RelationManager),TYPE   ! RelationManager for M2MLinkDataMSSql
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:M2MLinkData &Hide:Access:M2MLinkData,AUTO,THREAD
_Hide:Relate:M2MLinkData &Hide:Relate:M2MLinkData,AUTO,THREAD
_Hide:Access:M2MLinkDataMSSql &Hide:Access:M2MLinkDataMSSql,AUTO,THREAD
_Hide:Relate:M2MLinkDataMSSql &Hide:Relate:M2MLinkDataMSSql,AUTO,THREAD


CML_Data_ManyToManyLinksTests_BC0:DctInit PROCEDURE
  CODE
  _Hide:Access:M2MLinkData &= NEW(Hide:Access:M2MLinkData)
  _Hide:Relate:M2MLinkData &= NEW(Hide:Relate:M2MLinkData)
  _Hide:Access:M2MLinkDataMSSql &= NEW(Hide:Access:M2MLinkDataMSSql)
  _Hide:Relate:M2MLinkDataMSSql &= NEW(Hide:Relate:M2MLinkDataMSSql)
  Relate:M2MLinkData &= _Hide:Relate:M2MLinkData
  Relate:M2MLinkDataMSSql &= _Hide:Relate:M2MLinkDataMSSql


CML_Data_ManyToManyLinksTests_BC0:FilesInit PROCEDURE
  CODE
  _Hide:Relate:M2MLinkData.Init
  _Hide:Relate:M2MLinkDataMSSql.Init


CML_Data_ManyToManyLinksTests_BC0:DctKill PROCEDURE
  CODE
  _Hide:Relate:M2MLinkData.Kill
  DISPOSE(_Hide:Relate:M2MLinkData)
  _Hide:Relate:M2MLinkDataMSSql.Kill
  DISPOSE(_Hide:Relate:M2MLinkDataMSSql)


Hide:Relate:M2MLinkData.Init PROCEDURE
  CODE
  _Hide:Access:M2MLinkData.Init
  SELF.Init(Access:M2MLinkData,1)


Hide:Access:M2MLinkData.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= M2M:Record
  SELF.FileNameValue = 'M2MLinkData'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= M2MLinkData
  PARENT.Init
  Access:M2MLinkData &= SELF


Hide:Access:M2MLinkData.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:M2MLinkData &= NULL                               ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:M2MLinkData.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(M2MLinkData,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(M2M:kLeftRecordIDRightRecordID,'M2M:kLeftRecordIDRightRecordID',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:M2MLinkData.Kill PROCEDURE

  CODE
  _Hide:Access:M2MLinkData.Kill                            ! Kill the file manager
  PARENT.Kill
  Relate:M2MLinkData &= NULL                               ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:M2MLinkData)                        ! destroy the file manager


Hide:Relate:M2MLinkDataMSSql.Init PROCEDURE
  CODE
  _Hide:Access:M2MLinkDataMSSql.Init
  SELF.Init(Access:M2MLinkDataMSSql,1)


Hide:Access:M2MLinkDataMSSql.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= M2M1:Record
  SELF.FileNameValue = 'M2MLinkDataMSSql'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= M2MLinkDataMSSql
  PARENT.Init
  Access:M2MLinkDataMSSql &= SELF


Hide:Access:M2MLinkDataMSSql.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:M2MLinkDataMSSql &= NULL                          ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:M2MLinkDataMSSql.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(M2MLinkDataMSSql,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(M2M1:kLeftRecordIDRightRecordID,'M2M1:kLeftRecordIDRightRecordID',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:M2MLinkDataMSSql.Kill PROCEDURE

  CODE
  _Hide:Access:M2MLinkDataMSSql.Kill                       ! Kill the file manager
  PARENT.Kill
  Relate:M2MLinkDataMSSql &= NULL                          ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:M2MLinkDataMSSql)                   ! destroy the file manager

