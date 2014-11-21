   PROGRAM



   INCLUDE('ABASCII.INC'),ONCE
   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABPRHTML.INC'),ONCE
   INCLUDE('ABPRPDF.INC'),ONCE
   INCLUDE('ABQUERY.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABUSERCONTROL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('ABWMFPAR.INC'),ONCE
   INCLUDE('CSIDLFOLDER.INC'),ONCE
   INCLUDE('CLAMAIL.INC'),ONCE
   INCLUDE('CLARUNEXT.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('JSON.INC'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('SPECIALFOLDER.INC'),ONCE
   INCLUDE('ABBREAK.INC'),ONCE
   INCLUDE('ABCPTHD.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABGRID.INC'),ONCE
   INCLUDE('ABPRNAME.INC'),ONCE
   INCLUDE('ABPRTARG.INC'),ONCE
   INCLUDE('ABPRTARY.INC'),ONCE
   INCLUDE('ABPRTEXT.INC'),ONCE
   INCLUDE('ABPRXML.INC'),ONCE
   INCLUDE('ABQEIP.INC'),ONCE
   INCLUDE('ABRPATMG.INC'),ONCE
   INCLUDE('ABRPPSEL.INC'),ONCE
   INCLUDE('ABRULE.INC'),ONCE
   INCLUDE('ABSQL.INC'),ONCE
   INCLUDE('ABVCRFRM.INC'),ONCE
   INCLUDE('CFILTBASE.INC'),ONCE
   INCLUDE('CFILTERLIST.INC'),ONCE
   INCLUDE('CWSYNCHC.INC'),ONCE
   INCLUDE('MDISYNC.INC'),ONCE
   INCLUDE('QPROCESS.INC'),ONCE
   INCLUDE('RTFCTL.INC'),ONCE
   INCLUDE('TRIGGER.INC'),ONCE
   INCLUDE('WINEXT.INC'),ONCE

   MAP
     MODULE('CML_DATA_MANYTOMANYLINKTESTS_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('CML_DATA_MANYTOMANYLINKTESTS001.CLW')
DemonstrationTest_ReturnsTrue FUNCTION(*long addr),long,pascal   !
     END
       include('CML_ClarionTest_GlobalCodeAndData.inc','GlobalMap'),once
ClarionTest_GetListOfTestProcedures PROCEDURE(*LONG Addr),LONG,PASCAL
    ! Declare functions defined in this DLL
CML_Data_ManyToManyLinkTests:Init PROCEDURE(<ErrorClass curGlobalErrors>, <INIClass curINIMgr>)
CML_Data_ManyToManyLinkTests:Kill PROCEDURE
   END

SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
!endregion

  include('CML_ClarionTest_GlobalCodeAndData.inc','GlobalData'),once
  include('CML_ClarionTest_TestProcedures.inc'),once
ClarionTest_ctpl    CML_ClarionTest_TestProcedures

GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons
FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
LocalErrorStatus     ErrorStatusClass,THREAD
LocalErrors          ErrorClass
LocalINIMgr          INIClass
GlobalErrors         &ErrorClass
INIMgr               &INIClass
DLLInitializer       CLASS,TYPE                            ! An object of this type is used to initialize the dll, it is created in the generated bc module
Construct              PROCEDURE
Destruct               PROCEDURE
                     END

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
DLLInitializer.Construct PROCEDURE


  CODE
  LocalErrors.Init(LocalErrorStatus)
  LocalINIMgr.Init('.\CML_Data_ManyToManyLinkTests.INI', NVD_INI) ! Initialize the local INI manager to use windows INI file
  INIMgr &= LocalINIMgr
  IF GlobalErrors &= NULL
    GlobalErrors &= LocalErrors                            ! Assign local managers to global managers
  END
  DctInit
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  
  INCLUDE('CML_ClarionTest_GlobalCodeAndData.inc','ProgramProcedures')
ClarionTest_GetListOfTestProcedures PROCEDURE(*LONG Addr)
    CODE
    Addr = ADDRESS(ClarionTest_ctpl)
    FREE(ClarionTest_ctpl.List)
    ClarionTest_ctpl.List.TestPriority       = 10
    ClarionTest_ctpl.List.TestName       = 'DemonstrationTest_ReturnsTrue'
    ClarionTest_ctpl.List.TestGroupName      = '_000_Default'
    ClarionTest_ctpl.List.TestGroupPriority = 0
    ADD(ClarionTest_ctpl.List)
        
    RETURN 0
!These procedures are used to initialize the DLL. It must be called by the main executable when it starts up
CML_Data_ManyToManyLinkTests:Init PROCEDURE(<ErrorClass curGlobalErrors>, <INIClass curINIMgr>)
CML_Data_ManyToManyLinkTests:Init_Called    BYTE,STATIC

  CODE
  IF CML_Data_ManyToManyLinkTests:Init_Called
     RETURN
  ELSE
     CML_Data_ManyToManyLinkTests:Init_Called = True
  END
  IF ~curGlobalErrors &= NULL
    GlobalErrors &= curGlobalErrors
  END
  IF ~curINIMgr &= NULL
    INIMgr &= curINIMgr
  END

!This procedure is used to shutdown the DLL. It must be called by the main executable before it closes down

CML_Data_ManyToManyLinkTests:Kill PROCEDURE
CML_Data_ManyToManyLinkTests:Kill_Called    BYTE,STATIC

  CODE
  IF CML_Data_ManyToManyLinkTests:Kill_Called
     RETURN
  ELSE
     CML_Data_ManyToManyLinkTests:Kill_Called = True
  END
  

DLLInitializer.Destruct PROCEDURE

  CODE
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher
  LocalINIMgr.Kill                                         ! Kill local managers and assign NULL to global refernces
  INIMgr &= NULL                                           ! It is an error to reference these object after this point
  GlobalErrors &= NULL



Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

