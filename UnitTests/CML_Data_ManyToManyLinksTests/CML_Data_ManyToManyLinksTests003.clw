

   MEMBER('CML_Data_ManyToManyLinksTests.clw')             ! This is a MEMBER module

                     MAP
                       INCLUDE('CML_DATA_MANYTOMANYLINKSTESTS003.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - TestProcedure
!!! </summary>
DeleteSaveAndLoadData PROCEDURE  (*long addr)              ! Declare Procedure
ManytoMany                  CML_Data_ManyToManyLinks 
                            itemize(),pre()
RightRecordX                    equate
RightRecordY                    equate
RightRecordZ                    equate
                            end

Persister                   CML_Data_ManyToManyLinksPersisterForTPS

Filename                    cstring(500)

  CODE
  addr = address(UnitTestResult)
  BeginUnitTest('DeleteSaveAndLoadData')
    Filename = longpath() & '\CML_Data_ManyToManyLinksTests\LinksData.tps'
    !if exists(filename)
    !    remove(filename)
    !end
    !AssertThat(exists(filename),IsEqualTo(false),'Could not delete ' & filename)
    
    Persister.SetFilename(Filename)
    ManytoMany.Persister &= Persister
    ManyToMany.LeftRecordID = 1
    
    ManyToMany.SetLinkTo(RightRecordX)
    ManyToMany.SetLinkTo(RightRecordZ)

    AssertThat(ManyToMany.IsLinkedTo(RightRecordX),IsEqualTo(true), 'before save, record X should be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordY),IsEqualTo(false),'before save, record Y should not be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordZ),IsEqualTo(true), 'before save, record Z should be linked')
    
    ManyToMany.Save()
    ManyToMany.Reset()

    AssertThat(ManyToMany.IsLinkedTo(RightRecordX),IsEqualTo(false),'after reset, record X should not be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordY),IsEqualTo(false),'after reset, record Y should not be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordZ),IsEqualTo(false),'after reset, record Z should not be linked')
    
    ManytoMany.Load()
    
    AssertThat(ManyToMany.IsLinkedTo(RightRecordX),IsEqualTo(true), 'after load, record X should be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordY),IsEqualTo(false),'after load, record Y should not be linked')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordZ),IsEqualTo(true), 'after load, record Z should be linked')
    
  DO ProcedureReturn ! dgh
ProcedureReturn   ROUTINE
  RETURN 0
