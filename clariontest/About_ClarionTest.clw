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


										MEMBER('ClarionTest.clw')                               ! This is a MEMBER module


About                                   PROCEDURE 

Window                                      WINDOW('About ClarionTest'),AT(,,285,153),FONT('Microsoft Sans Serif',10,,FONT:regular,CHARSET:DEFAULT), |
												CENTER,GRAY,SYSTEM
												PANEL,AT(10,11,264,131),USE(?PANEL1),BEVEL(1)
												PROMPT('ClarionTest'),AT(20,22),USE(?PROMPT1)
												STRING('Concept By: Dave Harms'),AT(24,34,81,11),USE(?STRING1)
												STRING('Programming By:'),AT(24,48),USE(?STRING2)
												STRING('Dave Harms'),AT(42,64),USE(?STRING3)
												STRING('John Hickey'),AT(42,77),USE(?STRING4)
												STRING('Robert Paresi'),AT(42,90),USE(?STRING5)
												STRING('John Dunn'),AT(42,103),USE(?STRING6)
												STRING('Version .04'),AT(232,126),USE(?STRING7)
											END

!ThisWindow                                  CLASS(WindowManager)
!Init                                            PROCEDURE(),BYTE,PROC,DERIVED
!Kill                                            PROCEDURE(),BYTE,PROC,DERIVED
!											END
!
!Toolbar                                     ToolbarClass

	CODE
!	GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop
!
!!---------------------------------------------------------------------------
!DefineListboxStyle                      ROUTINE
!!|
!!| This routine create all the styles to be shared in this window
!!| It`s called after the window open
!!|
!!---------------------------------------------------------------------------
!
!ThisWindow.Init                         PROCEDURE
!
!ReturnValue                                 BYTE,AUTO
!
!	CODE
!	GlobalErrors.SetProcedureName('About')
!	SELF.Request = GlobalRequest                             ! Store the incoming request
!	ReturnValue = PARENT.Init()
!	IF ReturnValue THEN RETURN ReturnValue.
!	SELF.FirstField = ?PANEL1
!	SELF.VCRRequest &= VCRRequest
!	SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
!	SELF.AddItem(Toolbar)
!	CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
!	CLEAR(GlobalResponse)
!	SELF.Open(Window)                                        ! Open window
!	!WinAlert(WE::WM_QueryEndSession,,Return1+PostUser)
!	Do DefineListboxStyle
!	INIMgr.Fetch('About',Window)                             ! Restore window settings from non-volatile store
!	!ds_VisibleOnDesktop()
!	SELF.SetAlerts()
!	RETURN ReturnValue
!
!
!ThisWindow.Kill                         PROCEDURE
!
!ReturnValue                                 BYTE,AUTO
!
!	CODE
!	!If self.opened Then WinAlert().
!	ReturnValue = PARENT.Kill()
!	IF ReturnValue THEN RETURN ReturnValue.
!	IF SELF.Opened
!		INIMgr.Update('About',Window)                          ! Save window data to non-volatile store
!	END
!	GlobalErrors.SetProcedureName
!	RETURN ReturnValue
!
