

   MEMBER('CML_Data_ManyToManyLinksTests.clw')             ! This is a MEMBER module

                     MAP
                       INCLUDE('CML_DATA_MANYTOMANYLINKSTESTS005.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - TestProcedure
!!! </summary>
SaveAndLoadDataUsingABCFileMSSQL PROCEDURE  (*long addr)   ! Declare Procedure
FilesOpened     BYTE(0)
ManytoMany                  CML_Data_ManyToManyLinks 
                            itemize(),pre()
RightRecordX                    equate
RightRecordY                    equate
RightRecordZ                    equate
                            end

Persister                   CML_Data_ManyToManyLinksPersisterForABC


FileName                        cstring(500)

  CODE
  addr = address(UnitTestResult)
  BeginUnitTest('SaveAndLoadDataUsingABCFileMSSQL')
    !FileName = longpath() & '\CML_Data_ManyToManyLinksTests\M2MLinkData.tps'
    do OpenFiles
    
    
    Persister.Init(Access:M2MLinkDataMSSQL,M2MS:kLeftRecordIDRightRecordID,M2MS:LeftRecordID,M2MS:RightRecordID)
    
    ManytoMany.Persister &= Persister
    ManyToMany.LeftRecordID = 1
    
    ManyToMany.SetLinkTo(RightRecordX)
    ManyToMany.SetLinkTo(RightRecordZ)

    AssertThat(ManyToMany.IsLinkedTo(RightRecordX),IsEqualTo(true), 'before save, record X should be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordY),IsEqualTo(false),'before save, record Y should not be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordZ),IsEqualTo(true), 'before save, record Z should be linked')
    ManyToMany.SaveAllLinkingData()
    ManyToMany.Reset()

    AssertThat(ManyToMany.IsLinkedTo(RightRecordX),IsEqualTo(false),'after reset, record X should not be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordY),IsEqualTo(false),'after reset, record Y should not be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordZ),IsEqualTo(false),'after reset, record Z should not be linked')
    ManytoMany.LoadAllLinkingData()
    
    AssertThat(ManyToMany.IsLinkedTo(RightRecordX),IsEqualTo(true), 'after load, record X should be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordY),IsEqualTo(false),'after load, record Y should not be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordZ),IsEqualTo(true), 'after load, record Z should be linked')

    ManyToMany.ClearLinkTo(RightRecordX)
    ManyToMany.ClearLinkTo(RightRecordZ)
    
    ManyToMany.SaveAllLinkingData()
    
    do CloseFiles

    if exists(FileName)
        remove(FileName)
        if exists(FileName)
            SetUnitTestFailed('Could not delete ' & FileName)
            do ProcedureReturn
        end
    end
  DO ProcedureReturn ! dgh
ProcedureReturn   ROUTINE
  RETURN 0
!--------------------------------------
OpenFiles  ROUTINE
  Access:M2MLinkDataMSSql.Open                             ! Open File referenced in 'Other Files' so need to inform its FileManager
  Access:M2MLinkDataMSSql.UseFile                          ! Use File referenced in 'Other Files' so need to inform its FileManager
  FilesOpened = True
!--------------------------------------
CloseFiles ROUTINE
  IF FilesOpened THEN
     Access:M2MLinkDataMSSql.Close
     FilesOpened = False
  END
