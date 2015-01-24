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

    Include('CML_Data_ManyToManyLinks.inc'),Once
    include('CML_System_Diagnostics_Logger.inc'),once

dbg                                             CML_System_Diagnostics_Logger

CML_Data_ManyToManyLinks.Construct              Procedure()
    code
    self.LinksDataQ               &= new CML_Data_ManyToManyLinksDataQ
    
CML_Data_ManyToManyLinks.Destruct               Procedure()
    code
    free(self.LinksDataQ)
    dispose(self.LinksDataQ)

CML_Data_ManyToManyLinks.ClearLinkTo            procedure(long rightRecordID)
    code
    self.ClearLinkBetween(self.LeftRecordID,rightRecordID)

CML_Data_ManyToManyLinks.ClearLinkBetween       procedure(long leftRecordID,long rightRecordID)
    code
    if self.GetLinkRecord(leftRecordID,rightRecordID)
        self.LinksDataQ.IsLinked      = FALSE
        put(self.LinksDataQ)
    end
    
CML_Data_ManyToManyLinks.GetLinkRecord          procedure(long leftRecordID,long rightRecordID)!,bool
    code
    clear(self.LinksDataQ)
    self.LinksDataQ.LeftRecordID  = LeftRecordID
    self.LinksDataQ.RightRecordID = rightRecordID
    get(self.LinksDataQ,self.LinksDataQ.LeftRecordID,self.LinksDataQ.RightRecordID)    
    if not errorcode() then return true.
    return false
    
CML_Data_ManyToManyLinks.IsLinkedTo             procedure(long rightRecordID)!,bool
    code
    return self.IsLinkBetween(self.LeftRecordID,rightRecordID)
    
CML_Data_ManyToManyLinks.IsLinkBetween          procedure(long leftRecordID,long rightRecordID)!,bool
    code
    if self.GetLinkRecord(LeftRecordID,RightRecordID)
        if self.LinksDataQ.IsLinked then return true.
    end
    return false
    
CML_Data_ManyToManyLinks.LoadAllLinkingData     procedure(long leftRecordID=0)
    code
    if not self.Persister &= null
        if leftRecordID = 0 then leftRecordID = self.LeftRecordID.
        if leftRecordID
            dbg.write('Loading linking data for leftRecordID ' & leftRecordID)
            self.Persister.LoadAllLinkingData(leftRecordID,self.LinksDataQ)
        end
    end
    
CML_Data_ManyToManyLinks.Reset                  procedure
    code
    free(self.LinksDataQ)
    
CML_Data_ManyToManyLinks.SaveAllLinkingData     procedure(long leftRecordID=0)
    code    
    !dbg.write('CML_Data_ManyToManyLinks.Save')
    if not self.Persister &= null
        if leftRecordID = 0 then leftRecordID = self.LeftRecordID.
        if leftRecordID
            dbg.write('Saving linking data for leftRecordID ' & leftRecordID)
            self.Persister.Save(leftRecordID,self.LinksDataQ)
        end
    end

CML_Data_ManyToManyLinks.SetLinkTo              procedure(long rightRecordID)
    code
    self.SetLinkBetween(self.LeftRecordID,rightRecordID)

CML_Data_ManyToManyLinks.SetLinkBetween         procedure(long leftRecordID,long rightRecordID)
    code
    if not self.GetLinkRecord(LeftRecordID,RightRecordID)
        clear(self.LinksDataQ)
        self.LinksDataQ.LeftRecordID  = LeftRecordID
        self.LinksDataQ.RightRecordID = rightRecordID
        self.LinksDataQ.IsLinked      = true
        add(self.LinksDataQ)
    else
        self.LinksDataQ.IsLinked      = true
        put(self.LinksDataQ)
    end

CML_Data_ManyToManyLinks.SetPersister           procedure(CML_Data_ManyToManyLinksPersister persister)
    code
    self.Persister                &= Persister

        