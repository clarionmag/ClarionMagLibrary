!---------------------------------------------------------------------------------------------!
! Copyright (c) 2013, CoveComm Inc.
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


    Include('CML_UI_BackgroundProgressDisplay.inc'),Once
    !include('CML_System_Diagnostics_Logger.inc'),once

!dbg                                     CML_System_Diagnostics_Logger

CML_UI_BackgroundProgressDisplay.Construct  Procedure()
    code
    !self.Errors &= new CML_System_ErrorManager
    self.CriticalSection &= new CML_System_Threading_CriticalSection
    self.NotifyCode = 9867 ! Some random number unlikely to be used by anyone else
    clear(self.ProgressControlPreviousValue,-1)
    self.ListQueueLastRecordCount = 0

CML_UI_BackgroundProgressDisplay.Destruct   Procedure()
    code
    !dispose(self.Errors)
    dispose(self.CriticalSection)
    self.DisposeStringControlText()
    
CML_UI_BackgroundProgressDisplay.AddListValue       procedure(string s)
    code
    self.CriticalSection.Wait()
    if not self.ListQueue &= null and not self.ListQueueField &= NULL
        clear(self.ListQueue)
        self.ListQueueField  = s
        add(self.ListQueue)
        notify(self.notifyCode,self.UIthread)
    end
    self.CriticalSection.Release()
    
CML_UI_BackgroundProgressDisplay.DisposeStringControlText   procedure
    code
    if not self.StringControlValue &= null
        dispose(self.StringControlvalue)
    end

CML_UI_BackgroundProgressDisplay.Enable     procedure
    code
    self.UIThread = thread()
    register(event:notify,address(self.TakeEvent),address(self))
    
CML_UI_BackgroundProgressDisplay.PostToUIThread     procedure(long event=event:user)
    code
    post(event,,self.UIThread)

CML_UI_BackgroundProgressDisplay.SetListControl     procedure(long ListControlFEQ,*Queue q,*? qField)
    code
    self.ListControlFEQ = ListControlFEQ
    self.ListQueue &= q
    self.ListQueueField &= qField
    
CML_UI_BackgroundProgressDisplay.SetStringControlFEQ        procedure(long StringControlFEQ)
    code
    self.StringControlFEQ = StringControlFEQ

CML_UI_BackgroundProgressDisplay.SetStringControlValue      procedure(string StringControlValue)
    code
    self.CriticalSection.Wait()
    self.DisposeStringControlText()
    self.StringControlValue &= new string(len(clip(StringControlValue)))
    self.StringControlValue = StringControlValue
    notify(self.notifyCode,self.UIthread)
    self.CriticalSection.Release()
        
CML_UI_BackgroundProgressDisplay.SetProgressControlFEQ      procedure(long ProgressBarControlFEQ,<long rangeLow>,<long rangeHigh>)
    code
    self.ProgressControlFEQ = progressBarControlFEQ
    if not omitted(rangeLow)
        self.ProgressControlFEQ{prop:rangelow} = rangeLow
    end
    if not omitted(rangeHigh)
        self.ProgressControlFEQ{prop:rangeHigh} = rangeHigh
    end
    
CML_UI_BackgroundProgressDisplay.SetProgressControlValue    procedure(long ProgressControlValue)
    code
    ! probably atomic, but just in case... 
    self.CriticalSection.Wait()
    self.ProgressControlValue = ProgressControlValue
    notify(self.notifyCode,self.UIthread)
    self.CriticalSection.Release()    
    
CML_UI_BackgroundProgressDisplay.TakeEvent  procedure
    code
    if NOTIFICATION(self.notifyCode)
        self.CriticalSection.Wait()
        if self.ProgressControlFEQ <> 0  and self.ProgressControlValue <> self.ProgressControlPreviousValue
            self.ProgressControlFEQ{Prop:Progress} = self.ProgressControlValue
            display(self.ProgressControlFEQ)
            self.ProgressControlPreviousValue = self.ProgressControlValue
        end
        if self.StringControlFEQ <> 0
            self.StringControlFEQ{prop:text} = self.StringControlValue
            display(self.StringControlFEQ)
        end
        if self.ListControlFEQ <> 0 and not self.ListQueue &= null and records(self.ListQueue) <> self.ListQueueLastRecordCount
            ! Issuing a select to go to the last record messes up the event handling.
            !select(self.ListControlFEQ,records(self.ListQueue))
            self.ListQueueLastRecordCount = records(self.ListQueue)
        end
        self.CriticalSection.Release()    
    end
    return Level:Benign
    

    

    

