#!*****************************************************************************
#!*****************************************************************************
#TEMPLATE(ClarionTest, 'Clarion Unit Testing - ABC Template Chain'),FAMILY('ABC')
#INCLUDE('CML_ClarionTest.tpw')
#!*****************************************************************************
#!*****************************************************************************
#PROCEDURE(GroupProcedure, 'Group Procedure (DO NOT USE - select Group Procedure from the Default tab, not from here)'), PARENT(Source(ABC))
#DEFAULT
NAME DefaultTestGroupProcedureABC
GLOBAL
CATEGORY 'Group procedures'
PROTOTYPE ''
[COMMON]
DESCRIPTION 'Group Procedure'
FROM ABC Source
#ENDDEFAULT
#!*****************************************************************************
#!*****************************************************************************
#PROCEDURE(TestProcedure, 'Test Procedure')
#!-----------------------------------------------------------------------
#COMMENT(60)
#PROMPT('Address var',@s50),%AddressVar,Default('lpTestResults')
#PROMPT('Generate Open/Close Files Routines',CHECK),%GenerateOpenClose,DEFAULT(%False),AT(10)
#Prompt('Generate helpful comments',Check),%ShowHelpComments
#ENABLE(%GenerateOpenClose=1),CLEAR
  #PROMPT('Generate Save/Restore Files Routines',CHECK),%GenerateSaveRestore,DEFAULT(%False),AT(10)
#ENDENABLE
#DISPLAY('You can enter an expression to be tested here, or you can use the embeditor.'),AT(10,,180,20)
#DISPLAY('You should probably review the embeditor view first as it contains instructions on the test syntax'),AT(10,,180,32)
#PROMPT('Test Code',EDIT),%TestCode
#Display('')
#Boxed('Execution flags')
   #Display('')
   #Display('If the Ignore flag is set the test will not be executed')
   #Display('when run as part of an automated build process or when')
   #Display('Run All is executed in the ClarionTest app')
   #Prompt('Ignore',Check),%TestIsIgnored,At(10,,180)
   #Enable(%TestIsIgnored = 0)
      #Display('')
      #Display('If the Incomplete flag is set the test will not be executed')
      #Display('when run as part of an automated build process')
      #Prompt('Incomplete',Check),%TestIsIncomplete,At(10,,180)
      #Display('')
   #EndEnable
#EndBoxed   
#IF(%ProcedureDescription)
!!! %ProcedureDescription
#ENDIF
#IF(%ProcedureLongDescription)
#CALL(%SVInsertMultiLineSymbolPrefix,%ProcedureLongDescription)
#ENDIF
#Prototype('(*long testResultAddress),long,pascal')
%[20]Procedure PROCEDURE  %Parameters                           #<! Declare Procedure
#EMBED(%GatherSymbols,'Gather Template Symbols'),HIDE
#INSERT(%FileControlInitialize(ABC))
#EMBED(%DataSection,'Data Section'),DATA          #! Embedded Source Code
  CODE
  testResultAddress = address(UnitTestResult)
  BeginUnitTest('%Procedure')
   #If(%TestIsIgnored)
  SetUnitTestIgnored('Flagged as Ignored in the procedure template')
  do ProcedureReturn
   #Else
      #If(%TestIsIncomplete)
  SetUnitTestIncomplete('Flagged as Incomplete in the procedure template')
  do ProcedureReturn
      #EndIf
   #EndIf
      #IF(%ShowHelpComments)
!-------------------------------------------------------------------
! Write your code to test for a result, using the AssertThat syntax.
! At present there are two different assertions you can use, IsEqualto
! and IsNotEqualTo. You can pass in any data type that Clarion can
! automatically convert to a string. 
! 
!   AssertThat('a',IsEqualTo('a'),'this is an optional extra message')
!	  AssertThat(1,IsNotEqualTo(2))
!
! As soon as an Assert statement fails there remaining tests will
! not be executed. 
!-------------------------------------------------------------------
      #ENDIF
   #IF(%TestCode)
  %TestCode
   #ENDIF
#EMBED(%ProcessedCode,'Processed Code'),DATA,LABEL,TREE('Processed Code{{PRIORITY(2000)}')     #! Embedded Source Code

#EMBED(%ProcedureRoutines,'Procedure Routines'),DATA,LABEL,TREE('Procedure Routines{{PRIORITY(3000)}')

#EMBED(%LocalProcedures,'Local Procedures'),DATA,LABEL,TREE('Local Procedures{{PRIORITY(4000)}')
#!
#EMBED(%LocalDataClasses),LABEL,HIDE
#EMBED(%LocalDataAfterClasses,'Local Data After Object Declarations'),LABEL,DATA,TREE('Other Declarations{{PRIORITY(1000)}')
#!
#!
#EMBED(%AfterAPPENDStatement),LABEL,HIDE
#INSERT(%LocalMapCheck(ABC))
#!
#AT(%CustomGlobalDeclarations)
  #INSERT(%FileControlSetFlags(ABC))
#ENDAT
#!
#AT(%DataSection),PRIORITY(2500)
   #FOR(%LocalData)
      #IF(LEFT(%LocalDataStatement,6)='&CLASS')
         #SET(%ValueConstruct,EXTRACT(%LocalDataStatement,'&CLASS',1))
         #IF(NOT %ValueConstruct)
            #SET(%ValueConstruct,'CLASS')
         #ENDIF
%[20]LocalData &%ValueConstruct #<!%LocalDataDescription
      #ELSE
%[20]LocalData %LocalDataStatement #<!%LocalDataDescription
      #ENDIF
   #ENDFOR
#EMBED(%LocalDataClassData),LABEL,HIDE
#ENDAT
#!
#AT(%DataSection),WHERE(%GenerateOpenClose)
FilesOpened     BYTE(0)
#ENDAT
#AT(%DataSection),WHERE(%GenerateSaveRestore)
  #FOR(%OtherFiles)
%OtherFiles::State  USHORT
  #ENDFOR
#ENDAT
#AT(%ProcedureRoutines),WHERE(%GenerateSaveRestore)
SaveFiles  ROUTINE
   #MESSAGE('File Control Save Code',3)
#EMBED(%BeforeFileSave,'SaveFiles ROUTINE, Before Saving Files'),TREE('SaveFiles ROUTINE, Before Saving Files{{PRIORITY(3500)}')
   #FOR(%OtherFiles)
   %OtherFiles::State = Access:%OtherFiles.SaveFile()            #<! Save File referenced in 'Other Files' so need to inform its FileManager
   #ENDFOR
#EMBED(%AfterFileSave,'SaveFiles ROUTINE, After Saving Files'),TREE('SaveFiles ROUTINE, After Saving Files{{PRIORITY(3600)}')
RestoreFiles  ROUTINE
   #MESSAGE('File Control Restore Code',3)
#EMBED(%BeforeFileRestore,'RestoreFiles ROUTINE, Before Restoring Files'),TREE('RestoreFiles ROUTINE, Before Restoring Files{{PRIORITY(3700)}')
   #FOR(%OtherFiles)
   IF %OtherFiles::State <> 0
      Access:%OtherFiles.RestoreFile(%OtherFiles::State)            #<! Restore File referenced in 'Other Files' so need to inform its FileManager
   END
   #ENDFOR
#EMBED(%AfterFileRestore,'RestoreFiles ROUTINE, After Restoring Files'),TREE('RestoreFiles ROUTINE, After Restoring Files{{PRIORITY(3800)}')
#ENDAT
#AT(%ProcedureRoutines),WHERE(%GenerateOpenClose)
!--------------------------------------
OpenFiles  ROUTINE
   #MESSAGE('File Control Open Code',3)
#EMBED(%BeforeFileOpen,'OpenFiles ROUTINE, Before Opening Files'),TREE('OpenFiles ROUTINE, Before Opening Files{{PRIORITY(3850)}')
   #FOR(%OtherFiles)
  Access:%OtherFiles.Open                                         #<! Open File referenced in 'Other Files' so need to inform its FileManager
  Access:%OtherFiles.UseFile                                      #<! Use File referenced in 'Other Files' so need to inform its FileManager
   #ENDFOR
  FilesOpened = True
#EMBED(%AfterFileOpen,'OpenFiles ROUTINE, After Opening Files'),TREE('OpenFiles ROUTINE, After Opening Files{{PRIORITY(3860)}')
!--------------------------------------
CloseFiles ROUTINE
   #EMBED(%BeforeFileClose,'CloseFiles ROUTINE, Before Closing Files'),TREE('CloseFiles ROUTINE, Before Closing Files{{PRIORITY(3900)}')
   IF FilesOpened THEN
#FOR(%OtherFiles)
      Access:%OtherFiles.Close
#ENDFOR
      FilesOpened = False
   END
   #EMBED(%AfterFileClose,'CloseFiles ROUTINE, After Closing Files'),TREE('CloseFiles ROUTINE, After Closing Files{{PRIORITY(3950)}')
#ENDAT














#!#DEFAULT
#!NAME TestProcedure
#!PROTOTYPE '(*long addr),long,pascal'
#![COMMON]
#!DESCRIPTION 'Test Procedure'
#!FROM ClarionTest TestProcedure
#!#ENDDEFAULT

#!#DEFAULT
#!NAME DefaultTestProcedureABC
#!GLOBAL
#!CATEGORY 'Test procedures'
#!PROTOTYPE '(*long addr),long,pascal'
#![COMMON]
#!DESCRIPTION 'Test Procedure'
#!FROM ABC Source
#![PROMPTS]
#!%Parameters DEFAULT  ('(*long addr)')
#![ADDITION]
#!NAME ClarionTest TestSupport
#![INSTANCE]
#!INSTANCE 1
#![WINDOW]
#!Window WINDOW('Dummy')
#!       END
#!#ENDDEFAULT
#!*****************************************************************************
#!*****************************************************************************
#UTILITY(CreateATestDLLFromTXA,'Create a ')
#! #PROMPT('File to import',@s64),%TestDllTXA
#Display('Run this utility on a new, empty DLL')
#Display('APP to make it into a unit test APP.')
#Display('')
#Display('This will add the necessary global ')
#Display('extension, one test procedure and a')
#Display('reference to CMagLib.lib')
#Display('(just in case you need any functionality')
#Display('contained in the library).')
#Display('')
#Display('IMPORTANT!')
#Display('')
#Display('When you create a DLL app the project')
#Display('Output Type defaults to EXE. You will ')
#Display('need to go to Project | Project Options')
#Display('and change the Output Type to DLL.')
#Display('')
#Display('Once you have successfully built your')
#Display('test DLL, run ClarionTest.exe, point it')
#Display('at your DLL, and run your tests.')
#Display('')
#Import('CML_TestDll.txa')
#PROJECT('CMagLib.lib')
#!*****************************************************************************