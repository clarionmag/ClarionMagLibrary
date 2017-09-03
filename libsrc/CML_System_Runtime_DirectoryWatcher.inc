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
	!include('CML_IncludeInAllClassHeaderFiles.inc'),once

!--------------------------------------------------------------------
!endregion

!Equates - will be seen by using program
NC_FILE_NOTIFY_CHANGE_FILE_NAME         EQUATE(1)
NC_FILE_NOTIFY_CHANGE_Dir_name          equate(2)
NC_FILE_NOTIFY_CHANGE_SIZE              EQUATE(8)
NC_FILE_NOTIFY_CHANGE_ATTRIBUTES        EQUATE(4)
NC_FILE_NOTIFY_CHANGE_LAST_WRITE        EQUATE(10H)
NC_FILE_NOTIFY_CHANGE_Last_Access       equate(20H)
NC_FILE_NOTIFY_CHANGE_CREATION          Equate(40H)
NC_FILE_NOTIFY_CHANGE_SECURITY          Equate(100H)
NC_FILE_NOTIFY_Change_Any               equate(8+10H+20H)
Watch_subdirectories                    equate(1)
Watch_NoSubDirectories                  equate(0)
Watch_autoreset                         equate(1)
Watch_noAutoReset                       equate(0)

!--------------------------------------------------------------------
! MTChgNotifyClass
!--------------------------------------------------------------------

CML_System_Runtime_DirectoryWatcher     CLASS,TYPE,MODULE('CML_System_Runtime_DirectoryWatcher.clw'),LINK('CML_System_Runtime_DirectoryWatcher.clw')!,_CML_Classes_LinkMode_),DLL(_CML_Classes_DllMode_)
WaitStruct                                  Group
NotifHandle                                     long  !these handles must be in this position in the group in this order
hEvent                                          long  !event which signals waiting thread to close
											end
AutoReset                                   long
!DiscardEventsWindow                         long
MonitorThread                               signed
NotifyCode                                  unsigned
NotifyParameter                             long
WaitThread                                  signed
noNotifyOnStartup                           byte    !set to TRUE to not send a notification on startup
debugMode                                   byte  !set to TRUE to receive debug output
!DebugString                                 procedure(string p:text)
Construct                                   procedure()        
Destruct                                    procedure()        
DoTask                                      procedure,virtual
Init                                        Procedure(string DirectoryToWatch),long,proc
Init                                        Procedure(string DirectoryToWatch, long MonitorThread, long NotifyCode, long NotifyParameter,long NotificationType, long WatchSubtree=0, long AutoReset=1),long,proc
Kill                                        procedure()
Reset                                       Procedure()
TakeEvent                                   procedure
										END ! CLASS: MTChgNotifyClass
                     
!    USAGE:
!    !------------ Data ------------
!    eMyNotifyCode  equate(222)
!    eMyNotifyParam equate(0)
!    myChg       MTChgNotifyClass
!    notifyCode  unsigned
!    notifyParam long
!    !------------ OpenWindow ------------
!      myChg.Init( '.\trigger', thread(), eMyNotifyCode, eMyNotifyParam, NC_FILE_NOTIFY_CHANGE_LAST_WRITE, Watch_NoSubDirectories,Watch_autoreset)
!    !------------ TakeEvent ------------
!      if event() = event:notify
!        if notification(notifyCode, , notifyParam)
!          if notifyCode = eMyNotifyCode !notifyParam=0
!            !processing here of the .\trigger folder
!          end
!        end
!      end 
!    !------------ Kill ------------
!      myChg.kill()

    
