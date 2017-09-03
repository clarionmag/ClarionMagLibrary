!---------------------------------------------------------------------------------------------!
! Copyright (c) 2013, 2017, CoveComm Inc.
!---------------------------------------------------------------------------------------------!
!region
! 
! 
! Redistribution and use in source and binary forms, with or without
! modification, are permitted provided that the following conditions are met: 
! 
! 1. Redistributions of source code must retain the above copyright notice, this
!    list of conditions and the following disclaimer. 
! 2. Redistributions in binary form must reproduce the above copyright notice,
!    this list of conditions and the following disclaimer in the documentation
!    and/or other materials provided with the distribution. 
! 3. The use of this software in a paid-for programming toolkit (that is, a commercial 
!    product that is intended to assist in the process of writing software) is 
!    not permitted.
! 
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
! ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
! WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
! DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
! ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
! (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
! LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
! ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
! (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
! SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
! 
! The views and conclusions contained in the software and documentation are those
! of the authors and should not be interpreted as representing official policies, 
! either expressed or implied, of www.DevRoadmaps.com or www.ClarionMag.com.
! 
! If you find this software useful, please support its creation and maintenance
! by taking out a subscription to www.DevRoadmaps.com.
!---------------------------------------------------------------------------------------------!
!endregion

                                                   member()


                                                   MAP
                                                   END

   include('CML_ClarionTest_ListLoader.inc'),once
   include('CML_System_Diagnostics_Logger.inc'),once

!logger                                             CML_System_Diagnostics_Logger

	
CML_ClarionTest_ListLoader.GetTestProceduresFromDLL      procedure(CML_ClarionTest_TestDLL TestDLL,*CML_ClarionTest_TestProceduresQueue TestProceduresQ)
DllProceduresQ                                                      QUEUE
ProcName                                                       cstring(200)
                                                            end
x                                                           long
Found_GetListOfTestProcedures                               byte(false)
GetListProc                                                 string('CLARIONTEST_GETLISTOFTESTPROCEDURES')
TestProcedures                                              &CML_ClarionTest_TestProcedures
lptr                                                        long
!utr                                                 &CML_ClarionTest_TestResult
DllInitialized                                              byte
   CODE
   !logger.write('CML_ClarionTest_TestRunner.GetTestProcedures')
   free(TestProceduresQ)
   clear(TestProceduresQ)
   ! Close the DLL so the list of exported procedures can be extracted
   ! But save the current state so it can be restored
   DllInitialized = TestDLL.IsInitialized()
   if DllInitialized = true
      TestDLL.kill()
   end
   !logger.write('Calling TestDLL.GetExportedProcedures with dllname ' & TestDLL.FullyQualifiedName)
   if TestDLL.GetExportedProcedures(TestDLL.FullyQualifiedName,DllProceduresQ) = Level:Benign
      free(TestProceduresQ)
      ! Look for the CLARIONTEST_GETLISTOFTESTPROCEDURES procedure
      loop x = 1 to records(DllProceduresQ)
         get(DllProceduresQ,x)
         !logger.Write('>' & upper(left(clip(DllProceduresQ.ProcName))) & '<<')
         if upper(sub(left(DllProceduresQ.procname),1,len(GetListproc))) = GetListProc
            ! Get the list of procedures from that method
            !logger.write('************** found ' & GetListProc & ' *************')
            Found_GetListOfTestProcedures = TRUE
            BREAK
         END
!			if upper(sub(DllProceduresQ.ProcName,1,5)) = 'TEST_'
!				clear(TestProceduresQ)
!				TestProceduresQ.testname = DllProceduresQ.ProcName
!				add(TestProceduresQ)
!			 !logger.write('CML_ClarionTest_TestRunner.GetTestProcedures added test procedure ' & q)
!			end				
      end
      if Found_GetListOfTestProcedures
         !logger.write('Found_GetListOfTestProcedures = true')
         if TestDLL.Init(TestDLL.FullyQualifiedName) = Level:Benign
            !logger.write('calling ' & GetListProc & ' with address(lptr) ' & address(lptr))
            r# = TestDLL.Call(GetListProc,address(lptr))
            !logger.write('return value: ' & r#)
         end
         !logger.write('lptr ' & lptr)
         TestProcedures &= (lptr)
         !utr &= (lptr)
         !logger.write('ref address now ' & address(TestProcedures))
         if ~TestProcedures &= null 
            !logger.write('TestProcedures is not null')
            !logger.write('TestProcedures.Names: ' & TestProcedures.Names[1])
            !logger.write(records(TestProcedures.List) & ' records found')
            loop x = 1 to records(TestProcedures.List)
               !logger.write('record ' & x)
               !logger.write('Group: ' & clip(TestProcedures.List.TestGroupName) & ', priority: ' & TestProcedures.List.TestPriority & ', Test: ' & clip(TestProcedures.list.TestName))
               get(TestProcedures.List,x)
               clear(TestProceduresQ)
               TestProceduresQ.testname = TestProcedures.List.testname
               TestProceduresQ.TestPriority = TestProcedures.List.TestPriority
               TestProceduresQ.TestGroupName = TestProcedures.list.TestGroupName
               TestProceduresQ.TestGroupPriority = TestProcedures.List.TestGroupPriority
               add(TestProceduresQ,TestProceduresQ.TestGroupPriority,TestProceduresQ.TestGroupName,TestProceduresQ.TestPriority,TestProceduresQ.TestPriority)
               !logger.write('Added test procedure to TestProceduresQ: ' & TestProceduresQ.testname)
            END
            loop x = 1 to records(TestProceduresQ)
               get(TestProceduresQ,x)
               !logger.write('record ' & x)
               !logger.write('Group: ' & clip(TestProceduresQ.TestGroupName) & ', priority: ' & TestProceduresQ.TestPriority & ', Test: ' & clip(TestProceduresQ.TestName))
            END
					
         ELSE
            !logger.write('TestProcedures is null')
         end
         TestDLL.Kill()
      end
   end
!   free(q)
!   loop x = 1 to records(TestProceduresQ)
!      get(TestProceduresQ,x)
!      q.TestName = TestProceduresQ.testname
!      q.TestPriority = TestProceduresQ.TestPriority
!      q.TestGroupName = TestProceduresQ.TestGroupName
!      q.TestGroupPriority = TestProceduresQ.TestGroupPriority
!      add(q)
!      !logger.write('Added procedure ' & q)
!   END
   TestDLL.Kill()
!	if DllInitialized = true and TestDLL.IsInitialized() = FALSE
!		TestDLL.Init(TestDLL.FullyQualifiedName)
!	end
	