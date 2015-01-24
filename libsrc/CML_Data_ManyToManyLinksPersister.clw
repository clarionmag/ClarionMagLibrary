!---------------------------------------------------------------------------------------------!
! Copyright (c) 2014,2015 CoveComm Inc.
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



    Include('CML_Data_ManyToManyLinksPersister.inc'),Once
    include('CML_System_Diagnostics_Logger.inc'),once

dbg                                                     CML_System_Diagnostics_Logger

CML_Data_ManyToManyLinksPersister.Construct             Procedure()
    code

CML_Data_ManyToManyLinksPersister.Destruct              Procedure()
    code

CML_Data_ManyToManyLinksPersister.AddLinkRecord         procedure(long leftRecordID,long rightRecordID)!,bool,proc,virtual
    code
    return false
    
CML_Data_ManyToManyLinksPersister.CloseDataFile         procedure!,bool,proc,virtual
    code
    return false
    
CML_Data_ManyToManyLinksPersister.LoadAllLinkingData    procedure(long leftRecordID,CML_Data_ManyToManyLinksDataQ linksDataQ)!,bool,proc,virtual
    code
    return false
    
CML_Data_ManyToManyLinksPersister.OpenDataFile          procedure!,bool,proc,virtual
    code
    return false

CML_Data_ManyToManyLinksPersister.RemoveLinkRecord      procedure(long leftRecordID,long rightRecordID)!,bool,proc,virtual
    code
    return false

CML_Data_ManyToManyLinksPersister.Save                  procedure(long leftRecordID,CML_Data_ManyToManyLinksDataQ linksDataQ)!,bool,proc,virtual
x                                                   long
    code
    if self.OpenDataFile()
        !dbg.write('CML_Data_ManyToManyLinksPersister.Save')
        loop x = 1 to records(linksDataQ)
            get(LinksDataQ,x)
            !dbg.write('Got LinksDataQ record ' & x)
            !dbg.write('LinksDataQ.IsLinked ' & LinksDataQ.IsLinked)
            !dbg.write('LinksDataQ.IsPersisted ' & LinksDataQ.IsPersisted)
            if LinksDataQ.IsLinked and not LinksDataQ.IsPersisted
                self.AddLinkRecord(LinksDataQ.LeftRecordID,LinksDataQ.RightRecordID)
                LinksDataQ.IsPersisted = true
                put(linksDataQ)
            elsif not LinksDataQ.IsLinked and LinksDataQ.IsPersisted
                self.RemoveLinkRecord(LinksDataQ.LeftRecordID,LinksDataQ.RightRecordID)
                LinksDataQ.IsPersisted = false
                put(linksDataQ)
            end
        end
        return self.CloseDataFile()
    end
    return false
    
    



