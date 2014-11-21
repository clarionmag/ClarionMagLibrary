

   MEMBER('CML_Data_ManyToManyLinksTests.clw')             ! This is a MEMBER module

                     MAP
                       INCLUDE('CML_DATA_MANYTOMANYLINKSTESTS001.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - TestProcedure
!!! </summary>
SetLinkBetweenVerifyLinkBetween PROCEDURE  (*long addr)    ! Declare Procedure
ManytoMany                  CML_Data_ManyToManyLinks 
                            itemize(),pre()
LeftRecordA                     equate
LeftRecordB                     equate
LeftRecordC                     equate
RightRecordX                    equate
RightRecordY                    equate
RightRecordZ                    equate
                            end


  CODE
  addr = address(UnitTestResult)
  BeginUnitTest('SetLinkBetweenVerifyLinkBetween')
    ManyToMany.SetLinkBetween(LeftRecordA,RightRecordX)
    ManyToMany.SetLinkBetween(LeftRecordA,RightRecordZ)
    ManyToMany.SetLinkBetween(LeftRecordC,RightRecordY)
    ManyToMany.SetLinkBetween(LeftRecordC,RightRecordZ)

    AssertThat(ManyToMany.IsLinkBetween(LeftRecordA,RightRecordX),IsEqualTo(true), 'Test 1 failed')
    AssertThat(ManyToMany.IsLinkBetween(LeftRecordA,RightRecordY),IsEqualTo(false),'Test 2 failed')
    AssertThat(ManyToMany.IsLinkBetween(LeftRecordA,RightRecordZ),IsEqualTo(true), 'Test 3 failed')

    AssertThat(ManyToMany.IsLinkBetween(LeftRecordB,RightRecordX),IsEqualTo(false),'Test 4 failed')
    AssertThat(ManyToMany.IsLinkBetween(LeftRecordB,RightRecordY),IsEqualTo(false),'Test 5 failed')
    AssertThat(ManyToMany.IsLinkBetween(LeftRecordB,RightRecordZ),IsEqualTo(false),'Test 6 failed')
    
    AssertThat(ManyToMany.IsLinkBetween(LeftRecordC,RightRecordX),IsEqualTo(false),'Test 7 failed')
    AssertThat(ManyToMany.IsLinkBetween(LeftRecordC,RightRecordY),IsEqualTo(true), 'Test 8 failed')
    AssertThat(ManyToMany.IsLinkBetween(LeftRecordC,RightRecordZ),IsEqualTo(true), 'Test 9 failed')
  DO ProcedureReturn ! dgh
ProcedureReturn   ROUTINE
  RETURN 0
