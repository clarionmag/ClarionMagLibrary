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



    Include('CML_Data_ManyToManyLinksPersister.inc'),Once
    include('CML_System_Diagnostics_Logger.inc'),once

dbg                                     CML_System_Diagnostics_Logger

CML_Data_ManyToManyLinksPersister.Construct                     Procedure()
    code
    !self.Errors &= new CML_System_ErrorManager


CML_Data_ManyToManyLinksPersister.Destruct                      Procedure()
    code
    !dispose(self.Errors)

CML_Data_ManyToManyLinksPersister.CloseDataFile procedure
    code
    if not self.DataFile &= null
        close(self.DataFile)
    end
    
CML_Data_ManyToManyLinksPersister.Load          procedure(long leftRecordID,CML_Data_ManyToManyLinksData linksData)
    code
    
CML_Data_ManyToManyLinksPersister.OpenDataFile  procedure!,bool
    code
    dbg.write('CML_Data_ManyToManyLinksPersister.OpenDataFile')
    self.CloseDataFile()
    if not self.DataFile &= null
        share(self.DataFile)
        if errorcode()
            create(self.DataFile)
            if errorcode()
                message('Unable to create data file ' & self.DataFile{prop:name} & ' ' & error())
                return false
            end
            share(self.DataFile)
            if errorcode()
                message('Unable to open data file ' & self.DataFile{prop:name} & ' ' & error())
                return false
            end
        end
    end
    dbg.write('returning true')
    return true

CML_Data_ManyToManyLinksPersister.Save          procedure(long leftRecordID,CML_Data_ManyToManyLinksData linksData)
    code
    dbg.write('CML_Data_ManyToManyLinksPersister.Save')



