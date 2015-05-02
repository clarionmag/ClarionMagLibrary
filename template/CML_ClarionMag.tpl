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
#Extension(ManyToManyCheckboxForABCBrowse,'Many-to-many checkboxes for an ABC browse'),REQ(BrowseBox(ABC)),PROCEDURE
#Prompt('Class name',@s40),%M2MClassInstanceName,Default('M2MCheckboxList')
#Boxed('"Left file"')
    #Prompt('File',FILE),%LeftFile
    #Prompt('Unique ID field',FIELD),%LeftFileUniqueField
    #Prompt('Left side is a browse',CHECK),%LeftFileIsInBrowse,Default(%True)
    #Enable(%LeftFileIsInBrowse)
        #Prompt('Browse box',CONTROL),%LeftBrowseControl
    #EndEnable
#EndBoxed
#Boxed('"Right file"')
    #Prompt('File',FILE),%RightFile
    #Prompt('Unique ID field',FIELD),%RightFileUniqueField
    #Prompt('Browse box',CONTROL),%RightBrowseControl
#EndBoxed
#Boxed('Many-to-many linking file')
    #Prompt('File',FILE),%LinkingFile
    #Prompt('Key',KEY),%LinkingFileKey
    #Prompt('"Left" field',FIELD),%LinkingFileLeftField
    #Prompt('"Right" field',FIELD),%LinkingFileRightField
#EndBoxed
#Boxed('Other settings')
    #Prompt('Icon field',FIELD),%IconField
#EndBoxed
#AtStart
    #Declare(%LeftBrowseControlInstance)
    #Declare(%RightBrowseControlInstance)
    #Declare(%LeftBrowseControlName)
#!    #Declare(%RightBrowseControlName)
    #Set(%RightBrowseControlInstance,%GetTemplateInstanceForControl(%RightBrowseControl))
    #Set(%LeftBrowseControlInstance,%GetTemplateInstanceForControl(%LeftBrowseControl))
    #If(%LeftFileIsInBrowse)
        #Set(%LeftBrowseControlName,%GetBrowseManagerName(%LeftBrowseControl))
    #EndIf
#!    #Set(%RightBrowseControlName,%GetBrowseManagerName(%RightBrowseControl))   
#EndAt
#At(%DataSection),Priority(3100)
%[20]M2MClassInstanceName class
ListCheckbox           &CML_UI_ListCheckbox
Persister              &CML_Data_ManyToManyLinksPersisterForABC
Links                  &CML_Data_ManyToManyLinks
Construct              procedure
Destruct               procedure
DisplayCheckboxData    procedure
Init                   procedure
LoadEnrollmentData     procedure
SaveEnrollmentData     procedure
SetCheckboxIcon        procedure
                     end                   
#EndAt
#At(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(8005),DESCRIPTION('Initialize M2MCheckboxList')
%M2MClassInstanceName.Init()
    #If(not %LeftFileIsInBrowse)
%M2MClassInstanceName.LoadEnrollmentData()  
    #EndIf
#EndAt
#At(%WindowManagerMethodCodeSection,'Kill','(),BYTE'),PRIORITY(1100),DESCRIPTION('Initialize M2MCheckboxList')
%M2MClassInstanceName.SaveEnrollmentData()
#EndAt
#AT(%BrowserMethodCodeSection,,'TakeNewSelection','()'),PRIORITY(9000)
    #If(%LeftFileIsInBrowse)
        #If(%ControlInstance = %LeftBrowseControlInstance)
%M2MClassInstanceName.LoadEnrollmentData()  
        #EndIf
    #EndIf
    #If(%ControlInstance = %RightBrowseControlInstance)
%M2MClassInstanceName.DisplayCheckboxData()
    #EndIf
#EndAt
#AT(%BrowserMethodCodeSection,%ActiveTemplateParentInstance,'SetQueueRecord','()'),PRIORITY(9500)
#! #AT(%BrowserMethodCodeSection,,'SetQueueRecord','()'),PRIORITY(9500)
%M2MClassInstanceName.SetCheckboxIcon()
#EndAt
#At(%LocalProcedures),Priority(9999)

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
    self.Persister.Init(Access:%LinkingFile,%LinkingFileKey,|
        %LinkingFileLeftField,%LinkingFileRightField)
    self.Links.SetPersister(self.Persister)
    self.ListCheckbox.Initialize(%ListQueue,%ListQueue.%(%IconField & '_Icon'),|
        %ListQueue.%RightFileUniqueField,%RightBrowseControl,,self.Links)
    
%M2MClassInstanceName.LoadEnrollmentData                  procedure
    code
    #If(%LeftFileIsInBrowse)
    self.SaveEnrollmentData()
    %LeftBrowseControlName.UpdateBuffer()
    #EndIf
    self.links.LeftRecordID = %LeftFileUniqueField
    self.Links.LoadAllLinkingData()
    self.ListCheckbox.LoadDisplayableCheckboxData()    
    display(%RightBrowseControl)
    
%M2MClassInstanceName.SaveEnrollmentData                  procedure
    code
    self.Links.SaveAllLinkingData()
    
%M2MClassInstanceName.SetCheckboxIcon                    procedure
    code
    if self.links.IsLinkBetween(self.Links.LeftRecordID,self.ListCheckbox.ListQRightRecordID)
        self.ListCheckbox.ListQIconField = CML_UI_ListCheckbox_TrueValue
    else
        self.ListCheckbox.ListQIconField = CML_UI_ListCheckbox_FalseValue
    end
#EndAt
#!----------------------------------------------------------------------------
#GROUP(%GetTemplateInstanceForControl,%pControl),PRESERVE
    #FIX(%Control, %pControl)
    #Return(%ControlInstance)
#!----------------------------------------------------------------------------
#GROUP(%GetBrowseManagerName,%pControl),PRESERVE
    #CONTEXT(%Procedure, %GetTemplateInstanceForControl(%pControl))
        #RETURN(%ManagerName)
    #ENDCONTEXT
#!----------------------------------------------------------------------------
#!#GROUP(%GetBrowseManagerName,%pControl),PRESERVE
#!    #FIX(%Control, %pControl)
#!    #CONTEXT(%Procedure, %ControlInstance)
#!        #RETURN(%ManagerName)
#!    #ENDCONTEXT
    