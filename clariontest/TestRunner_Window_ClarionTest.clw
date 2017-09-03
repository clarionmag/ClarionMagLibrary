!---------------------------------------------------------------------------------------------!
! Copyright (c) 2017, CoveComm Inc.
!
!Permission is hereby granted, free of charge, to any person obtaining a copy
!of this software and associated documentation files (the "Software"), to deal
!in the Software without restriction, including without limitation the rights
!to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
!copies of the Software, and to permit persons to whom the Software is
!furnished to do so, subject to the following conditions:
!
!The above copyright notice and this permission notice shall be included in all
!copies or substantial portions of the Software.
!
!THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
!IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
!FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
!AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
!LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
!OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
!SOFTWARE.
!---------------------------------------------------------------------------------------------!

                                                   Member('ClarionTest.clw')                               ! This is a MEMBER module

                                                   map
                                                      SetTestDllName()
                                                      RunTests()
                                                      LoadTests()
                                                      SetDirectoryWatcher()
                                                      PrepareWindow()
                                                   end






TestRunner_Window                                  PROCEDURE 

Resizer                                               CLASS(WindowResizeClass)
Init                                                     PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                                                      END

DirectoryWatcher                                      class(CML_System_Runtime_DirectoryWatcher)
DoTask                                                   procedure,VIRTUAL
                                                      end
StdOut                                                CML_System_IO_StdOut

                                                      itemize(1),pre(Style)
Default                                                  equate
Failed                                                   equate
Passed                                                   equate
Bold                                                     equate
NoResult                                                 equate
                                                      end

FailedTestCount                                       long
FirstFailedTest                                       long

TestDllPathAndName                                    CSTRING(File:MaxFilePath + File:MaxFileName + 1)

PreviousGroupOrTestName                               string(200)
TestsQ                                                QUEUE,PRE(TestsQ)
GroupOrTestName                                          STRING(200)                           
GroupOrTestLevel                                         LONG                                  
GroupOrTestStyle                                         LONG                                  
TestResult                                               STRING(400)                           
TestResultStyle                                          LONG                                  
! Following fields are not used for display
TestDescription                                          STRING(100)                           
TestLongDescription                                      STRING(5000)                          
TestStatus                                               Long
GroupOrTestPriority                                      real
GroupOrTestPriorityStyle                                 LONG                                  
Mark                                                     BYTE                                  
ProcedureQIndex                                          LONG                                  
Type                                                     BYTE                                  
                                                      END                                   

TestRunner                                            CML_ClarionTest_TestRunner
TestListLoader                                        CML_ClarionTest_ListLoader
TestProceduresQ                                       queue(CML_ClarionTest_TestProceduresQueue)
                                                      end
TestResult                                            &CML_ClarionTest_TestResult
str                                                   CML_System_String
RunTestsOnDllChange                                   bool
ListOfDlls                                            CML_System_IO_Directory


Window                                                WINDOW('ClarionTest'),AT(,,600,170),CENTER,GRAY,IMM,SYSTEM,MAX, |
                                                         ICON('ClarionTest.ico'),FONT('Segoe UI',8,,FONT:regular),TIMER(100),RESIZE
                                                         TOOLBAR,AT(0,0,600,20),USE(?TOOLBAR1)
                                                            BUTTON('Select All'),AT(2,3,63),USE(?SelectAll),FLAT,TRN
                                                            BUTTON('Run Selected'),AT(69,3,63,14),USE(?RunSelectedTests),FLAT,TRN
                                                            BUTTON('Clear Results'),AT(202,3,63,14),USE(?ClearResults),FLAT,TRN
                                                            CHECK('Run on DLL change'),AT(269,6),USE(RunTestsOnDllChange),TRN
                                                            BUTTON('Close'),AT(513,3,63,14),USE(?Close),FLAT,TRN
                                                            BUTTON('Run All'),AT(135,3,63,14),USE(?RunAllTests),FLAT,TRN
                                                         END
                                                         PROMPT('Test DLL:'),AT(8,6,35,12),USE(?TestDllPathAndName:Prompt),TRN
                                                         ENTRY(@s255),AT(42,4,533,12),USE(TestDllPathAndName),COLOR(COLOR:BTNFACE), |
                                                            READONLY
                                                         BUTTON('...'),AT(579,3,12,12),USE(?LookupTestDllPathAndName)
                                                         PROGRESS,AT(3,20,595,8),USE(?Progress),RANGE(0,100)
                                                         LIST,AT(3,32,595,116),USE(?TestList),HVSCROLL,FONT(,10),MARK(testsq.Mark), |
                                                            FROM(TestsQ),FORMAT('259L(2)|MYT(1)~Test~@s200@1020L(2)Y~Result~' & |
                                                            '@s255@')
                                                      END


ProcedureName                                         equate('Main')
x                                                     long
RunAllTests                                           bool
TimeOfLastDirectoryChange                             long
TestsToRun                                            long
CurrentTestIndex                                      long
DelayBeforeAutorun                                    long(90)
PreviousDllsChecksum                                  REAL
CurrentDllsChecksum                                   real
ShowUI                                                bool
TestDLL                                               CML_ClarionTest_TestDLL

   CODE
   ShowUI = true        
   open(window)
   Window{PROP:MinWidth} = 400
   Window{PROP:MinHeight} = 170
   Resizer.Init(AppStrategy:Spread)
   SetTestDllName()
   ACCEPT
      DirectoryWatcher.TakeEvent()
      case event()
      of EVENT:OpenWindow
         PrepareWindow()
         LoadTests()
      of EVENT:Sized
         Resizer.Resize()
         ?Close{PROP:Xpos} = 0{prop:width} - 70
      of EVENT:Timer
         if TimeOfLastDirectoryChange > 0
            if clock() < TimeOfLastDirectoryChange or clock() >  TimeOfLastDirectoryChange + DelayBeforeAutorun
               TimeOfLastDirectoryChange = 0
               ListOfDlls.GetDirectoryListing()
               CurrentDllsChecksum = ListOfDlls.GetChecksum()
               if CurrentDllsChecksum <> PreviousDllsChecksum
                  PreviousDllsChecksum = CurrentDllsChecksum
                  RunTests()
               END
					
            end
         end
      END
      case accepted()
      of ?Close
         post(event:closewindow)
      of ?LookupTestDllPathAndName
         FILEDIALOG('Chose a test dll',TestDllPathAndName,'Test DLLs|*.dll')
         display(?TestDllPathAndName)
         logger.write('dgh selected DLL ' & TestDllPathAndName)
         !update(?TestDllPathAndName)
         LoadTests()
      of ?RunSelectedTests
         RunAllTests = false
         RunTests()
      of ?RunAllTests
         RunAllTests = true
         RunTests()
      of ?RunTestsOnDllChange
         SetDirectoryWatcher()
      of ?SelectAll
         loop x = 1 to records(testsq)
            get(testsq,x)
            if testsq.ProcedureQIndex = 0 then cycle.
            if ?SelectAll{prop:text} = 'Select All' 
               testsq.Mark = TRUE
            else
               testsq.Mark = FALSE
            end
            put(testsq)
         end
         if ?SelectAll{prop:text} = 'Select All' 
            ?SelectAll{prop:text} = 'Clear All' 
         else
            ?SelectAll{prop:text} = 'Select All' 
         end
      end
   end
   settings.Update(ProcedureName,window)
   logger.write('calling settings.update with ' & ProcedureName & ',TestDllPathAndName,' & TestDllPathAndName)
   settings.Update(ProcedureName,'TestDllPathAndName',TestDllPathAndName)
   settings.Update(ProcedureName,'DelayBeforeAutorun',DelayBeforeAutorun)
   close(window)

  
	
PrepareWindow        Procedure
   code
   ?TestList{PROPSTYLE:TextColor, Style:Default}     = -1
   ?TestList{PROPSTYLE:BackColor, Style:Default}     = -1
   ?TestList{PROPSTYLE:TextSelected, Style:Default}  = -1
   ?TestList{PROPSTYLE:BackSelected, Style:Default}  = -1
   ?TestList{PROPSTYLE:FontStyle, Style:Default}  	 = -1

   ?TestList{PROPSTYLE:TextColor, Style:NoResult}     = color:black
   ?TestList{PROPSTYLE:BackColor, Style:NoResult}     = color:white
   ?TestList{PROPSTYLE:TextSelected, Style:NoResult}  = color:black
   ?TestList{PROPSTYLE:BackSelected, Style:NoResult}  = color:white
   ?TestList{PROPSTYLE:FontStyle, Style:NoResult}  	 = -1
  
   ?TestList{PROPSTYLE:TextColor, Style:Passed}     = color:green
   ?TestList{PROPSTYLE:BackColor, Style:Passed}     = color:white
   ?TestList{PROPSTYLE:TextSelected, Style:Passed}  = color:green
   ?TestList{PROPSTYLE:BackSelected, Style:Passed}  = color:white
   ?TestList{PROPSTYLE:FontStyle, Style:Passed}  	 = -1
  
   ?TestList{PROPSTYLE:TextColor, Style:Failed}     = color:red
   ?TestList{PROPSTYLE:BackColor, Style:Failed}     = color:white
   ?TestList{PROPSTYLE:TextSelected, Style:Failed}  = color:red
   ?TestList{PROPSTYLE:BackSelected, Style:Failed}  = color:white
   ?TestList{PROPSTYLE:FontStyle, Style:Failed}     = FONT:Bold


   ?TestList{PROPSTYLE:FontStyle, Style:Bold}     = FONT:Bold
   ?TestList{PROPSTYLE:TextSelected, Style:Bold}  = -1
   ?TestList{PROPSTYLE:BackSelected, Style:Bold}  = -1			

   if command('/run')
      post(event:accepted,?RunAllTests)
   end

SetDirectoryWatcher                                Procedure()
   code
   logger.write('SetDirectoryWatcher routine')
   if RunTestsOnDllChange and exists(TestDllDirectory)
      DirectoryWatcher.Init(TestDllDirectory)
      DirectoryWatcher.noNotifyOnStartup = true
      ListOfDlls.Init(TestDllDirectory)
      ListOfDlls.SetFilter('*.dll')
      ListOfDlls.GetDirectoryListing()
      PreviousDllsChecksum = ListOfDlls.GetChecksum()
   else
      DirectoryWatcher.Kill
   end
	


LoadTests                                          Procedure()
   code
   SetDirectoryWatcher()
   TestListLoader.GetTestProceduresFromDLL(TestDLL,TestProceduresQ)
   logger.Write('Loading tests from ' & TestDllPathAndName)
   str.Assign(TestDllPathAndName)
   TestDllDirectory = str.SubString(1,str.LastIndexOf('\'))
   if not exists(TestDllDirectory)
      message('The test directory "' & TestDllDirectory & '" does not exist')
      return
   end
   setpath(TestDllDirectory)
   TestDllName = str.SubString(str.LastIndexOf('\') + 1,str.Length())
   logger.write('dgh Loading test procedures for ' & TestDllName)
   if not TestDLL.Init(TestDllPathAndName) = Level:Benign
      message('Could not load test DLL ' & TestDllPathAndName)
      return
   end
   TestListLoader.GetTestProceduresFromDLL(TestDLL,TestProceduresQ)

   sort(TestProceduresQ,TestProceduresQ.TestGroupPriority,TestProceduresQ.TestGroupName,TestProceduresQ.TestPriority,TestProceduresQ.TestName)
   loop x = 1 to records(TestProceduresQ)
      get(TestProceduresQ,x)
      IF TestProceduresQ.TestGroupName <> PreviousGroupOrTestName
         PreviousGroupOrTestName = TestProceduresQ.TestGroupName
         CLEAR(TestsQ)
         TestsQ.GroupOrTestName = TestProceduresQ.TestGroupName
         TestsQ.GroupOrTestLevel = 1
         TestsQ.ProcedureQIndex = 0
         TestsQ.GroupOrTestStyle = Style:Bold
         ADD(TestsQ)
      END
      TestsQ.GroupOrTestStyle = Style:Default
      TestsQ.GroupOrTestName = TestProceduresQ.TestName
      TestsQ.GroupOrTestLevel = 2
      TestsQ.ProcedureQIndex = x
      TestsQ.TestResult = ''
      TestsQ.TestResultStyle = Style:NoResult
      TestsQ.Mark = false
      Add(TestsQ)
   END

RunTests                                           Procedure()
   code
   FailedTestCount = 0
   FirstFailedTest = 0
   setcursor(cursor:wait)
   !!dbg.write('RunTests routine is initializing the dll') 
   if TestDLL.Init(TestDllPathAndName) <> Level:Benign
      message('Unable to initialize DLL ' & TestDllName)
      return
   end
   TestListLoader.GetTestProceduresFromDLL(TestDLL,TestProceduresQ)
   TestRunner.SetTestProcedures(TestProceduresQ)
   TestsToRun = 0
   loop x = 1 to records(TestsQ)
      get(TestsQ,x)
      get(TestProceduresQ,TestsQ.ProcedureQIndex)
      if ~errorcode()
         if RunAllTests or TestsQ.Mark = true then TestsToRun += 1.
      end
   end
   CurrentTestIndex = 0
   ?Progress{prop:RangeHigh} = TestsToRun
   if TestDLL.Init(TestDllPathAndName) <> Level:Benign
   end
   loop x = 1 to records(TestsQ)
      get(TestsQ,x)
      if ~RunAllTests and TestsQ.mark = FALSE
         !!!dbg.Message('Skipping this item')
         TestsQ.TestResult = ''
         TestsQ.Mark = False
         PUT(TestsQ)
         CYCLE
      END
      IF TestsQ.ProcedureQIndex = 0 then cycle.
      get(TestProceduresQ,TestsQ.ProcedureQIndex)
      if ~errorcode()
!		!!dbg.write('Got record ' & TestsQ.qPointer & ', test ' & TestProceduresQ.TestName)
!		!!dbg.write('Running test ' & TestProceduresQ.TestName)
         if not ShowUI
            StdOut.Write('##teamcity[testStarted name=<39>' & clip(TestsQ.GroupOrTestName) & '<39>]]')
         end
         TestResult &= TestRunner.RunTestByName(TestDLL,TestsQ.GroupOrTestName)
         CurrentTestIndex += 1
         if ShowUI
            ?Progress{PROP:Progress} = CurrentTestIndex
            display(?Progress)			
         end
         !TestProceduresQ.TestResultStyle = Style:Failed
         if TestResult &= null
            TestsQ.TestDescription = 'Failed: TestResult object was null'
            TestsQ.TestStatus = CML_ClarionTest_Status_Fail
            FailedTestCount += 1
         else                
            TestsQ.TestStatus = TestResult.Status
            if TestResult.Status = CML_ClarionTest_Status_Pass
               TestsQ.TestResult = 'Passed ' & TestResult.Description
               TestsQ.TestResultStyle = Style:Passed
            elsif TestResult.Status = CML_ClarionTest_Status_Ignore
               TestsQ.TestResult = 'Ignored: ' & TestResult.Message
            else
               TestsQ.TestResult = 'Failed: ' & TestResult.Message
               TestsQ.TestResultStyle = Style:Failed
               FailedTestCount += 1 
                        
            END
         END
         PUT(TestsQ)  
         if not ShowUI
            IF TestsQ.TestResultStyle = Style:Failed  
               StdOut.Write('##teamcity[testFailed name=<39>' & clip(TestsQ.GroupOrTestName) & '<39> message=<39>' & clip(TestResult.Message) & '<39> details=<39>' & clip(TestResult.Message) & '<39>]]')
            end  
            StdOut.Write('##teamcity[testFinished name=<39>' & clip(TestsQ.GroupOrTestName) & '<39>]]')
         end
         IF TestsQ.TestResultStyle = Style:Failed |
            AND FirstFailedTest = 0
            FirstFailedTest = x
         END
      END
   END
   TestDLL.Kill()
   if ShowUI
      display()
      setcursor()
      0{prop:text} = 'ClarionTest - ' & FailedTestCount & ' failed tests'
      if FailedTestCount > 0
         beep(BEEP:SystemHand)
         if FailedTestCount = 1
            0{prop:text} = 'ClarionTest - 1 failed test'
         end
         ?TestList{PROP:Selected} = FirstFailedTest
      else
         beep(BEEP:SystemExclamation)
      end
      0{prop:text} = 0{prop:text} & ' at ' & format(clock(),@t6)
   else
      !message('done')
   end

SetTestDllName                                   Procedure()
   code
   settings.Fetch(ProcedureName,window)
   settings.Fetch(ProcedureName,'DelayBeforeAutorun',DelayBeforeAutorun)
   TestDllPathAndName = clip(left(COMMAND(2)))
   !dbg.write('TestDllPathAndName 1 ' & TestDllPathAndName)
   !logger.write('TestDllPathAndName
   if TestDllPathAndName <> ''
      if instring('\',TestDllPathAndName,1,1) = 0
         TestDllPathAndName = longpath() & '\' & TestDllPathAndName 
         !dbg.write('TestDllPathAndName 2 ' & TestDllPathAndName)
      end
   else
      settings.Fetch(ProcedureName,'TestDllPathAndName',TestDllPathAndName)
      !dbg.write('TestDllPathAndName 3 ' & TestDllPathAndName)
   end
   !dbg.write('TestDllPathAndName 4 ' & TestDllPathAndName)

Resizer.Init                                       PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
   CODE
   PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
   SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window
   SELF.SetStrategy(?Progress, Resize:FixLeft+Resize:FixTop, Resize:LockHeight+Resize:Resize) ! Override strategy for ?TestList1
   SELF.SetStrategy(?TestList, Resize:LockXPos+Resize:LockYPos, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?TestList1
   self.SetStrategy(?TestDllPathAndName:Prompt,Resize:FixLeft+Resize:FixTop,Resize:LockSize)
   self.SetStrategy(?TestDllPathAndName,Resize:FixLeft+Resize:FixTop,Resize:LockHeight+resize:resize)
   self.SetParentControl(?LookupTestDllPathAndName,?TestDllPathAndName)

DirectoryWatcher.DoTask                            procedure!,VIRTUAL
   code
   TimeOfLastDirectoryChange = clock()

