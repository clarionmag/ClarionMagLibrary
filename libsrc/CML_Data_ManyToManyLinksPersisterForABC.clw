!---------------------------------------------------------------------------------------------!
! Copyright (c) 2015 CoveComm Inc.
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


    Include('CML_Data_ManyToManyLinksPersisterForABC.inc'),Once
    include('CML_System_Diagnostics_Logger.inc'),once

dbg                                     CML_System_Diagnostics_Logger

CML_Data_ManyToManyLinksPersisterForABC.Construct                     Procedure()
    code
    self.Initialized = false
    self.ManageFileOpenAndClose = false

CML_Data_ManyToManyLinksPersisterForABC.Destruct                      Procedure()
    code

CML_Data_ManyToManyLinksPersisterForABC.AddLinkRecord        procedure(long leftIDField,long rightIDField)!,derived
    code
    if not self.Initialized then return false.
    clear(self.LinkFileManager.File)
    self.LinkFileLeftIDField = LeftIDField
    self.LinkFileRightIDField = rightIDField
    if self.LinkFileManager.Insert() = Level:Benign then return true.
    return false
    
CML_Data_ManyToManyLinksPersisterForABC.CloseDataFile procedure
    code
    if not self.Initialized then return false.
    if self.ManageFileOpenAndClose
        if self.LinkFileManager.Close() = level:benign then return true.
        return false
    end
    return true
    
CML_Data_ManyToManyLinksPersisterForABC.Init                                                procedure(FileManager linkFileManager,*key LinkFileKey,*? LinkFileLeftIDField, *? LinkFileRightIDField)
    code
    self.LinkFileKey          &= LinkFileKey             
    self.LinkFileLeftIDField  &= LinkFileLeftIDField     
    self.LinkFileManager      &= LinkFileManager         
    self.LinkFileRightIDField &= LinkFileRightIDField    
    if not self.LinkFileKey                &= null |
        and not self.LinkFileLeftIDField   &= null |
        and not self.LinkFileManager       &= null |
        and not self.LinkFileRightIDField  &= null  
        self.Initialized = true
    end
    
CML_Data_ManyToManyLinksPersisterForABC.LoadAllLinkingData    procedure(long leftIDField,CML_Data_ManyToManyLinksDataQ linksDataQ)
    code
    if not self.Initialized then return false.
    free(linksDataQ)
    if self.OpenDataFile()
        clear(self.LinkFileManager.File)
        self.LinkFileLeftIDField = LeftIDField
        set(self.LinkFileKey,self.LinkFileKey)
        loop
            next(self.LinkFileManager.File)
            if errorcode() or self.LinkFileLeftIDField <> LeftIDField then break.
            clear(linksDataQ)
            linksDataQ.LeftRecordID = self.LinkFileLeftIDField
            linksDataQ.RightRecordID = self.LinkFileRightIDField
            linksDataQ.IsPersisted = true
            linksDataQ.IsLinked = true
            add(linksDataQ)
        end
        return self.CloseDataFile()
    end
    return false
    
CML_Data_ManyToManyLinksPersisterForABC.OpenDataFile  procedure!,bool
    code
    if not self.Initialized then return false.
    if self.ManageFileOpenAndClose
        if self.LinkFileManager.Open() = Level:Benign 
            self.LinkFileManager.UseFile
            return true
        end
        return false
    end
    return true
    
CML_Data_ManyToManyLinksPersisterForABC.RemoveLinkRecord     procedure(long leftIDField,long rightIDField)!,derived
    code    
    if not self.Initialized then return false.
    clear(self.LinkFileManager.File)
    self.LinkFileLeftIDField  = LeftIDField
    self.LinkFileRightIDField = rightIDField
    get(self.LinkFileManager.File,self.LinkFileKey)
    if not errorcode()
        if self.LinkFileManager.DeleteRecord(0) = Level:Benign then return true.
    end
    return false

    