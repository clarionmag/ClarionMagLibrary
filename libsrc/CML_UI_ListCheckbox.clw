!---------------------------------------------------------------------------------------------!
! Copyright (c) 2014, CoveComm Inc.
! All rights reserved.
!---------------------------------------------------------------------------------------------!
!region
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

                                            Member
                                            Map
                                            End


    Include('CML_UI_ListCheckbox.inc'),Once
    include('CML_System_Diagnostics_Logger.inc'),once
    include('keycodes.clw'),once


dbg                                             CML_System_Diagnostics_Logger
ToggleValue                                     equate(-1)

CML_UI_ListCheckbox.CheckAll                    procedure
x                                                   long
    code
    self.SetAll(CML_UI_ListCheckbox_TrueValue)

CML_UI_ListCheckbox.Initialize                  procedure(*Queue listQ,*long listQIconField,long listFEQ,long listQCheckboxFieldNumber=1)
    code
    self.ListQ &= listQ
    self.ListFEQ = ListFeq
    self.ListQCheckboxFieldNumber = listQCheckboxFieldNumber
    self.ListQIconField &= listQIconField
    self.ListFEQ{PROPLIST:Icon,self.ListQCheckboxFieldNumber} = CML_UI_ListCheckbox_FalseValue
    self.ListFEQ{PROP:IconList,CML_UI_ListCheckbox_TrueValue} = '~CML_Checked.ico'
    self.ListFEQ{PROP:IconList,CML_UI_ListCheckbox_FalseValue} = '~CML_UnChecked.ico'  
    self.ListFEQ{PROPLIST:Picture,self.ListQCheckboxFieldNumber} = '@p p'
    pragma('link (CML_UnChecked.ico)')
    pragma('link (CML_Checked.ico)')
    register(Event:accepted,address(self.TakeMouseClick),address(self),,self.ListFEQ)
    if self.ToggleAndAdvanceWithSpaceKey
        self.ListFEQ{PROP:Alrt} = SpaceKey
        register(EVENT:AlertKey,address(self.TakeSpaceKey),address(self),,self.ListFEQ)
    end
    
CML_UI_ListCheckbox.Initialize                  procedure(*Queue listQ,*long listQIconField,*long listQRightRecordID,long listFEQ,long listQCheckboxFieldNumber=1,CML_Data_ManyToManyLinks ManyToManyLinks)
    code
    self.Initialize(listQ,ListQIconField,ListFEQ,ListQCheckboxFieldNumber)
    self.ListQRightRecordID &= ListQRightRecordID
    self.ManyToManyLinks &= ManyToManyLinks                                                    
    
CML_UI_ListCheckbox.LoadDisplayableCheckboxData procedure
x                                                   long
    code
    dbg.write('CML_UI_ListCheckbox.LoadDisplayableCheckboxData')
    if not self.ManyToManyLinks &= null
        dbg.write('records(self.ListQ)')
        loop x = 1 to records(self.ListQ)
            get(self.ListQ,x)
            dbg.write('self.ListQRightRecordID ' & self.ListQRightRecordID)
            if self.ManyToManyLinks.IsLinkedTo(self.ListQRightRecordID)
                self.ListQIconField = CML_UI_ListCheckbox_TrueValue
                dbg.write('record is linked')
            else
                self.ListQIconField = CML_UI_ListCheckbox_FalseValue
                dbg.write('record is not linked')
            end
            put(self.ListQ)
        end
    end

CML_UI_ListCheckbox.SetAll                      procedure(bool flag)
x                                                   long
    code
    loop x = 1 to records(self.ListQ)
        get(self.ListQ,x)
        if flag = ToggleValue
            self.ToggleCurrentCheckbox()
        else
            self.ListQIconField = flag
        end
        put(self.ListQ)
        self.SetManyToManyLinkForCurrentQRecord()
    end
    
CML_UI_ListCheckbox.SetManyToManyLinkForCurrentQRecord  procedure
    code
    if not self.ManyToManyLinks &= NULL
        if self.ListQIconField = CML_UI_ListCheckbox_TrueValue
            self.ManyToManyLinks.SetLinkTo(self.ListQRightRecordID)
        else
            self.ManyToManyLinks.ClearLinkTo(self.ListQRightRecordID)
        end
    end
    
        

CML_UI_ListCheckbox.TakeMouseClick              procedure!,byte
    code
    if keycode() = MouseLeft |
        and self.ListFEQ{PROPLIST:MouseUpZone} = LISTZONE:icon | ! Contributed by Mike Hanson
        and self.ListFEQ{PROPLIST:MouseDownZone} = LISTZONE:icon | ! Contributed by Mike Hanson
        and self.ListFEQ{PROPLIST:MouseUpRow} = self.ListFEQ{PROPLIST:MouseDownRow} |
        and self.ListFEQ{PROPLIST:MouseUpField} = self.ListFEQ{PROPLIST:MouseDownField} |
        and self.ListFEQ{PROPLIST:MouseDownField} = self.ListQCheckboxFieldNumber                 
        get(self.ListQ,choice(self.ListFEQ))
        self.ToggleCurrentCheckbox()
        put(self.ListQ)
        self.SetManyToManyLinkForCurrentQRecord()
    end
    return Level:Benign

CML_UI_ListCheckbox.TakeSpaceKey                procedure!,byte
    code
    !dbg.write('CML_UI_ListCheckbox.TakeSpaceKey')
    if keycode() = SpaceKey
        get(self.ListQ,choice(self.ListFEQ))
        self.ToggleCurrentCheckbox()
        put(self.ListQ)
        self.SetManyToManyLinkForCurrentQRecord()
        if pointer(self.ListQ) < records(self.ListQ)
            select(self.ListFEQ,choice(self.ListFEQ)+1)
        end
    end
    return Level:Benign
    
CML_UI_ListCheckbox.ToggleCurrentCheckbox       procedure
    code
    !dbg.write('CML_UI_ListCheckbox.ToggleCurrentCheckbox')
    !dbg.write(format(pointer(self.ListQ),@n02) & ' self.ListQIconField was ' & self.ListQIconField)
    !dbg.write('self.ListQIconField was ' & self.ListQIconField)
    self.ListQIconField = choose(self.ListQIconField=CML_UI_ListCheckbox_TrueValue,CML_UI_ListCheckbox_FalseValue,CML_UI_ListCheckbox_TrueValue)
    !dbg.write('self.ListQIconField is  ' & self.ListQIconField)
    !dbg.write(                                 '                           set to ' & self.ListQIconField)
    
CML_UI_ListCheckbox.ToggleAll                   procedure
    code
    self.SetAll(ToggleValue)

CML_UI_ListCheckbox.UncheckAll                  procedure
    code
    self.SetAll(CML_UI_ListCheckbox_FalseValue)
    

