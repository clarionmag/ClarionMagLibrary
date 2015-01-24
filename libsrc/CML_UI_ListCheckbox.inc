!---------------------------------------------------------------------------------------------!
! Copyright (c) 2014, CoveComm Inc.
! All rights reserved.
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

    include('CML_IncludeInAllClassHeaderFiles.inc'),once
    Include('CML_Data_ManyToManyLinks.inc'),Once


CML_UI_ListCheckbox                             Class,Type,Module('CML_UI_ListCheckbox.CLW'),Link('CML_UI_ListCheckbox.CLW',_CML_Classes_LinkMode_),Dll(_CML_Classes_DllMode_)
ToggleAndAdvanceWithSpaceKey                        bool
ListFEQ                                             long
ListQ                                               &queue
ListQCheckboxFieldNumber                            long
ListQIconField                                      &long
ListQRightRecordID                                  &long
ManyToManyLinks                                     &CML_Data_ManyToManyLinks,protected
Initialized                                         bool,private
CheckAll                                            procedure
Initialize                                          procedure(*Queue listQ,*long listQIconField,long listFEQ,long listQCheckboxFieldNumber=1)
Initialize                                          procedure(*Queue listQ,*long listQIconField,*long listQRightRecordID, long listFEQ,long listQCheckboxFieldNumber=1,CML_Data_ManyToManyLinks ManyToManyLinks)
LoadDisplayableCheckboxData                         procedure
SetAll                                              procedure(bool flag)
SetManyToManyLinkForCurrentQRecord                  procedure
TakeMouseClick                                      procedure,byte
TakeSpaceKey                                        procedure,byte
ToggleAll                                           procedure
ToggleCurrentCheckbox                               procedure,private
UncheckAll                                          procedure
                                                End

CML_UI_ListCheckbox_TrueValue                   equate(1)
CML_UI_ListCheckbox_FalseValue                  equate(2)

