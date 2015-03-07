#!*****************************************************************************
#TEMPLATE(ClarionMag,'Clarion Magazine Templates'),FAMILY('ABC')
#!*****************************************************************************
#!
#EXTENSION(ProcIniPreserve,'Procedure level INI save/restore v1.0'),WINDOW

#!====== Template Prompts =======
#BOXED('Template options')
  #DISPLAY('Clarion Mag Procedure Level INI Preserve')
  #DISPLAY('Template version: 1.0')
  #DISPLAY('Last updated by Tom H. on 12-10-00')
  #DISPLAY(' ')
  #DISPLAY('This template will save/restore all variables')
  #DISPLAY('on the list, using the following section.')
  #DISPLAY(' ')
  #PROMPT('INI Section (no brackets):',@S25),%PreserveSection,DEFAULT('Preference')
  #DISPLAY(' ')
  #PROMPT('Restore only on Insert',CHECK),%PreserveOnInsert
  #DISPLAY(' ')
  #DISPLAY('Local Variable - Default Value')
  #BUTTON ('Variables to preserve'), MULTI(%PreserveVars, %PreserveVar & ' - ' & %PreserveDefault), INLINE
    #PROMPT('Variable Name:',FIELD),%PreserveVar
    #PROMPT('Default Value:',@S45),%PreserveDefault
    #DISPLAY(' ')
    #DISPLAY('NOTE: Use quotes for string values.')
  #ENDBUTTON
#ENDBOXED

#!----------------------------------------------------------------------------
#AT( %WindowManagerMethodCodeSection, 'Init', '(),BYTE'),PRIORITY(2001),WHERE(~%PreserveOnInsert)
#FOR(%PreserveVars)
#IF( %PreserveDefault )
%PreserveVar = %PreserveDefault
IniMgr.Fetch('%PreserveSection','%PreserveVar',%PreserveVar)
#ELSE
%PreserveVar = IniMgr.TryFetch('%PreserveSection','%PreserveVar')
#ENDIF
#ENDFOR
#ENDAT

#!----------------------------------------------------------------------------
#AT( %WindowManagerMethodCodeSection, 'PrimeFields'),PRIORITY(6001),WHERE(%PreserveOnInsert)
#FOR(%PreserveVars)
#IF( %PreserveDefault )
%PreserveVar = %PreserveDefault
IniMgr.Fetch('%PreserveSection','%PreserveVar',%PreserveVar)
#ELSE
%PreserveVar = IniMgr.TryFetch('%PreserveSection','%PreserveVar')
#ENDIF
#ENDFOR
#ENDAT

#!----------------------------------------------------------------------------
#AT( %WindowManagerMethodCodeSection, 'Kill', '(),BYTE'),PRIORITY(2001)
If Self.Response = RequestCompleted
	update()
#FOR(%PreserveVars)
   IniMgr.Update('%PreserveSection','%PreserveVar',%PreserveVar)
#ENDFOR
End
#ENDAT
#!----------------------------------------------------------------------------
#Extension(ManyToManyCheckboxForABCBrowse,'Many-to-many checkboxes for an ABC browse'),REQ(BrowseBox(ABC)),PROCEDURE,WINDOW
#Prompt('Class name',@s40),%M2MClassInstanceName,Default('M2MCheckboxList')
#Boxed('"Left file"')
    #Prompt('File',FILE),%LeftFile
    #Prompt('Unique ID field',FIELD),%LeftFileUniqueField
    #Prompt('Browse box',CONTROL),%LeftBrowseBox
#EndBoxed
#Boxed('"Right file"')
    #Prompt('File',FILE),%RightFile
    #Prompt('Unique ID field',FIELD),%RightFileUniqueField
#EndBoxed
#Boxed('Many-to-many linking file')
    #Prompt('File',FILE),%LinkingFile
    #Prompt('"Left" field',FIELD),%LinkingFileLeftField
    #Prompt('"Right" field',FIELD),%LinkingFileRightField
#EndBoxed
#Boxed('Other settings')
    #Prompt('Icon field',FIELD),%IconField
#EndBoxed
#Boxed('Hidden fields'),HIDE
    #Prompt('Left browse instance',@s100),%LeftBrowseInstanceName
    #Prompt('Right browse instance',@s100),%RightBrowseInstanceName
#EndBoxed
#PREPARE
#!    #Declare(%LeftBrowseInstanceName)
    #Set(%LeftBrowseInstanceName,%GetBrowseManagerName(%LeftBrowseBox))
    #Set(%RightBrowseInstanceName,%GetBrowseManagerName(%ControlInstance))
#ENDPREPARE
#At(%DataSection),Priority(3100)
%M2MClassInstanceName        class
ListCheckbox            &CML_UI_ListCheckbox
Persister               &CML_Data_ManyToManyLinksPersisterForABC
Links                   &CML_Data_ManyToManyLinks
Construct               procedure
Destruct                procedure
DisplayCheckboxData     procedure
Init                    procedure
LoadEnrollmentData      procedure
SaveEnrollmentData      procedure
SetCheckboxIcon         procedure
                    end
#EndAt
#At(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(7900),DESCRIPTION('Initialize M2MCheckboxList')
%M2MClassInstanceName.Init()
#EndAt
#At(%WindowManagerMethodCodeSection,'Run',''),PRIORITY(7900),DESCRIPTION('Initialize M2MCheckboxList')
%M2MClassInstanceName.SaveEnrollmentData()
#EndAt
#AT(%BrowserMethodCodeSection,%ActiveTemplateParentInstance,'TakeNewSelection','()'),PRIORITY(3500)
%M2MClassInstanceName.LoadEnrollmentData()
#EndAt
#AT(%BrowserMethodCodeSection,%ActiveTemplateParentInstance,'SetQueueRecord','()'),PRIORITY(3500)
%M2MClassInstanceName.SetCheckboxIcon()
#EndAt
#AT(%BrowserMethodCodeSection,%ActiveTemplateParentInstance,'TakeNewSelection','()'),PRIORITY(3500)
%M2MClassInstanceName.SetCheckboxIcon()
#EndAt
#At(%LocalProcedures),Priority(9999)
    #! #FIND(%ControlInstance, %ActiveTemplateParentInstance, %Control)
    #! #FIND(%ControlInstance, %ActiveTemplateInstance, %Control)
    #!    #EQUATE(%BrowseObjectName, %GetObjectName('Default', %ActiveTemplateParentInstance))
    #!! BrowseObjectName: %BrowseObjectName
    ! Left browse instance : %LeftBrowseInstanceName
    ! Right browse instance: %RightBrowseInstanceName
    ! Linking file: %LinkingFile
    ! Linking FileManager: Access:%LinkingFile
    ! Queue: %ListQueue

%M2MClassInstanceName.Construct                           procedure
    code
    self.ListCheckbox &= new CML_UI_ListCheckbox
    self.Persister    &= new CML_Data_ManyToManyLinksPersisterForABC
    self.Links        &= new CML_Data_ManyToManyLinks
    
%M2MClassInstanceName.Destruct                            procedure
    code
    dispose(self.ListCheckbox)
    dispose(self.Persister)
    dispose(self.Links)
    
%M2MClassInstanceName.DisplayCheckboxData                 procedure
    code
    self.ListCheckbox.LoadDisplayableCheckboxData()      
    
%M2MClassInstanceName.Init                                procedure
    code
    self.Persister.Init(Access:Enrollment,ENR:kStudentIDCourseInstanceID,|
        ENR:StudentID,ENR:CourseInstanceID)
    self.Links.SetPersister(self.Persister)
    self.ListCheckbox.Initialize(Queue:Browse,Queue:Browse.InClass_Icon,|
        Queue:Browse.CLA:CourseInstanceID,?List:Enrollment,,self.Links)
    
%M2MClassInstanceName.LoadEnrollmentData                  procedure
    code
    log.write('%M2MClassInstanceName.LoadEnrollmentData')
    self.SaveEnrollmentData()
    StudentBrowse.UpdateBuffer()
    self.links.LeftRecordID = STU:StudentID
    self.Links.LoadAllLinkingData()
    self.ListCheckbox.LoadDisplayableCheckboxData()    
    display(?List:Enrollment)
    
%M2MClassInstanceName.SaveEnrollmentData                  procedure
    code
    log.write('%M2MClassInstanceName.SaveEnrollmentData')
    log.write('self.links.leftrecordid ' & self.links.LeftRecordID)
    self.Links.SaveAllLinkingData()
    
%M2MClassInstanceName.SetCheckboxIcon                    procedure
    code
    log.write('STU:StudentID ' & STU:StudentID)
    log.write('CLA:CourseInstanceID ' & CLA:CourseInstanceID)
    if self.links.IsLinkBetween(self.Links.LeftRecordID,self.ListCheckbox.ListQRightRecordID)
        self.ListCheckbox.ListQIconField = CML_UI_ListCheckbox_TrueValue
    else
        self.ListCheckbox.ListQIconField = CML_UI_ListCheckbox_FalseValue
        !queue:browse.InClass_Icon = CML_UI_ListCheckbox_FalseValue
    end
    log.write('queue:browse.InClass_Icon ' & queue:browse.InClass_Icon)    
              
#EndAt
#!----------------------------------------------------------------------------
#GROUP(%GetBrowseManagerName,%BrowseControl),PRESERVE
    #FIX(%Control, %BrowseControl)
    #CONTEXT(%Procedure, %ControlInstance)
        #RETURN(%ManagerName)
    #ENDCONTEXT