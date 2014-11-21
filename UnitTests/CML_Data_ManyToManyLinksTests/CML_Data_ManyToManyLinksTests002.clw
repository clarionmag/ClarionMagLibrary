

   MEMBER('CML_Data_ManyToManyLinksTests.clw')             ! This is a MEMBER module

                     MAP
                       INCLUDE('CML_DATA_MANYTOMANYLINKSTESTS002.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - TestProcedure
!!! </summary>
SetLinkToVerifyLinkTo PROCEDURE  (*long addr)              ! Declare Procedure
ManytoMany                  CML_Data_ManyToManyLinks 
                            itemize(),pre()
RightRecordX                    equate
RightRecordY                    equate
RightRecordZ                    equate
                            end


  CODE
  addr = address(UnitTestResult)
  BeginUnitTest('SetLinkToVerifyLinkTo')
    ManyToMany.SetLinkTo(RightRecordX)
    ManyToMany.SetLinkTo(RightRecordZ)

    AssertThat(ManyToMany.IsLinkedTo(RightRecordX),IsEqualTo(true), 'Test 1 failed')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordY),IsEqualTo(false),'Test 2 failed')
    AssertThat(ManyToMany.IsLinkedTo(RightRecordZ),IsEqualTo(true), 'Test 3 failed')

  DO ProcedureReturn ! dgh
ProcedureReturn   ROUTINE
  RETURN 0
