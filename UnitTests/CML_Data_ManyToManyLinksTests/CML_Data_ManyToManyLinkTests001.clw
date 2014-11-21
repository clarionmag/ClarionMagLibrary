

   MEMBER('CML_Data_ManyToManyLinkTests.clw')              ! This is a MEMBER module

                     MAP
                       INCLUDE('CML_DATA_MANYTOMANYLINKTESTS001.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - TestProcedure
!!! </summary>
DemonstrationTest_ReturnsTrue PROCEDURE  (*long addr)      ! Declare Procedure

  CODE
  addr = address(UnitTestResult)
  BeginUnitTest('DemonstrationTest_ReturnsTrue')
	AssertThat(1,IsEqualTo(1),'This test should never fail, so this message should never appear')
  DO ProcedureReturn ! dgh
ProcedureReturn   ROUTINE
  RETURN 0
