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

   include('CML_ClarionTest_TestRunner.inc'),once
   include('CML_ClarionTest_TestResult.inc'),once
   include('CML_System_Diagnostics_Logger.inc'),once

dbg                                             CML_System_Diagnostics_Logger

CML_ClarionTest_TestRunner.GetFailedTest           procedure(string errormsg)
result                                                &CML_ClarionTest_TestResult
   CODE
   result &= new CML_ClarionTest_TestResult
   result.status = CML_ClarionTest_Status_Fail
   result.Message = errormsg
   return result
	
	
CML_ClarionTest_TestRunner.RunTest                 procedure(CML_ClarionTest_TestDLL testDLL,long index)!,CML_ClarionTest_TestResult	
TestResult                                                &CML_ClarionTest_TestResult
lptr                                                  long
KillDLL                                               bool
   code
   dbg.write('CML_ClarionTest_TestRunner.RunTest')
   if testDLL &= NULL 
      return self.GetFailedTest('The DLL manager object is null')
   end
   if testDLL.IsInitialized() = false
      return self.GetFailedTest('The DLL was not initialized')
   end
   if self.TestProceduresQ &= null
      return self.GetFailedTest('No tests exist (queue not assigned)')
   end
   get(self.TestProceduresQ,index)
   if errorcode()
      return self.GetFailedTest('Could not find the requested test (index ' & index & ') ' & error())
   end
   dbg.write('This is a valid test, executing now')
   r# = TestDLL.Call(upper(clip(self.TestProceduresQ.testname)),address(lptr))
   if r# <> 0
      return self.GetFailedTest('Could not execute the test: ' & TestDLL.ErrorStr)
   END
   TestResult &= (lptr)
   dbg.write('address(TestResult) ' & address(TestResult))
   dbg.write('TestResult.Status: ' & TestResult.Status)
   dbg.write('TestResult.Message: ' & TestResult.Message)
   return TestResult

	
CML_ClarionTest_TestRunner.RunTestByName           procedure(CML_ClarionTest_TestDLL testDLL,string name)!,*CML_ClarionTest_TestResult	
x                                                     long
   CODE
   if self.TestProceduresQ &= null 
      return self.GetFailedTest('The test queue was not assigned')
   end
   loop x = 1 to records(self.TestProceduresQ)
      !dbg.write('Test ' & x & ' "' & self.TestProceduresQ.TestName & '"')
      get(self.TestProceduresQ,x)
      if lower(clip(self.TestProceduresQ.TestName)) = lower(clip(name))
         dbg.write('Found test ' & x & ' "' & self.TestProceduresQ.TestName & '"')
         return self.RunTest(testDLL,x)
      END
   END
   return self.GetFailedTest('The test ' & clip(name) & ' could not be found')
	
CML_ClarionTest_TestRunner.SetTestProcedures       procedure(CML_ClarionTest_TestProceduresQueue TestProcedureQ)
   code
   self.TestProceduresQ &= TestProcedureQ
			
