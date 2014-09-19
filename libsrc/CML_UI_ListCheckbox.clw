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
    !include('CML_System_Diagnostics_Logger.inc'),once
    include('keycodes.clw'),once


!dbg                                             CML_System_Diagnostics_Logger
TrueValue                                       equate(1)
FalseValue                                      equate(2)
ToggleValue                                     equate(3)

CML_UI_ListCheckbox.CheckAll                    procedure
x                                                   long
    code
    self.SetAll(TrueValue)
    
CML_UI_ListCheckbox.SetAll                    procedure(bool flag)
x                                                   long
    code
    loop x = 1 to records(self.ListQ)
        get(self.ListQ,x)
        if flag = ToggleValue
            self.ToggleValue(self.ListQIconField)
            else
            self.ListQIconField = flag
        end
        put(self.ListQ)
    end
    
CML_UI_ListCheckbox.UncheckAll                  procedure
    code
    self.SetAll(FalseValue)
    
CML_UI_ListCheckbox.ToggleAll                  procedure
    code
    self.SetAll(ToggleValue)
    

CML_UI_ListCheckbox.Initialize                  procedure(*Queue listQ,*long listQIconField,long listFEQ,long listQCheckboxFieldNumber=1)
    code
    self.ListQ &= listQ
    self.ListFEQ = ListFeq
    self.ListQCheckboxFieldNumber = listQCheckboxFieldNumber
    self.ListQIconField &= listQIconField
    self.ListFEQ{PROPLIST:Icon,self.ListQCheckboxFieldNumber} = FalseValue
    self.ListFEQ{PROP:IconList,TrueValue} = '~CML_Checked.ico'
    self.ListFEQ{PROP:IconList,FalseValue} = '~CML_UnChecked.ico'  
    self.ListFEQ{PROPLIST:Picture,self.ListQCheckboxFieldNumber} = '@p p'
    pragma('link (CML_UnChecked.ico)')
    pragma('link (CML_Checked.ico)')
    register(Event:accepted,address(self.TakeMouseClick),address(self))
    
CML_UI_ListCheckbox.TakeMouseClick              procedure
    code
    if field() = self.ListFEQ
        if keycode() = MouseLeft |
            and self.ListFEQ{proplist:mouseuprow} = self.ListFEQ{proplist:mousedownrow} |
            and self.ListFEQ{proplist:mouseupfield} = self.ListFEQ{proplist:mousedownfield} |
            and self.ListFEQ{proplist:mousedownfield} = self.ListQCheckboxFieldNumber
            get(self.ListQ,choice(self.ListFEQ))
            self.ListQIconField = choose(self.ListQIconField=TrueValue,FalseValue,TrueValue)
            put(self.ListQ)
        end
    end
    
    
    


