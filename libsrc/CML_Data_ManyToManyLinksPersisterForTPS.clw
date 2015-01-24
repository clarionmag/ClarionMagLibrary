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


LinksDataFile                                   file,driver('TOPSPEED'),pre(links),create,thread
kLeftRight                                          key(Links:LeftRecordID,Links:RightRecordID)
kRightLeft                                          key(Links:RightRecordID,Links:LeftRecordID)
record                                              record
LeftRecordID                                            long
RightRecordID                                           long
                                                    end
                                                end


    Include('CML_Data_ManyToManyLinksPersisterForTPS.inc'),Once
    include('CML_System_Diagnostics_Logger.inc'),once

dbg                                     CML_System_Diagnostics_Logger

CML_Data_ManyToManyLinksPersisterForTPS.Construct                     Procedure()
    code
    self.DataFile &= LinksDataFile

CML_Data_ManyToManyLinksPersisterForTPS.Destruct                      Procedure()
    code

CML_Data_ManyToManyLinksPersisterForTPS.AddLinkRecord        procedure(long leftRecordID,long rightRecordID)!,derived
    code
    dbg.write('AddLinkRecord(' & leftRecordID & ',' & rightRecordID & ')')
    clear(Links:Record)
    Links:LeftRecordID = LeftRecordID
    Links:RightRecordID = rightRecordID
    add(LinksDataFile)
    if errorcode() 
        dbg.write('Error adding record: ' & error())
        return false
    else
        dbg.write('Success adding record')
    end
    return true
    
CML_Data_ManyToManyLinksPersisterForTPS.CloseDataFile procedure
    code
    if not self.DataFile &= null
        close(self.DataFile)
        if errorcode() then return false.
    end
    return true
    
CML_Data_ManyToManyLinksPersisterForTPS.LoadAllLinkingData    procedure(long leftRecordID,CML_Data_ManyToManyLinksDataQ linksDataQ)
    code
    free(linksDataQ)
    if self.OpenDataFile()
        clear(Links:Record)
        Links:LeftRecordID = LeftRecordID
        set(Links:kLeftRight,Links:kLeftRight)
        loop
            next(LinksDataFile)
            if errorcode() or Links:LeftRecordID <> LeftRecordID then break.
            clear(linksDataQ)
            linksDataQ.LeftRecordID = Links:LeftRecordID
            linksDataQ.rightRecordID = Links:RightRecordID
            linksDataQ.IsPersisted = true
            linksDataQ.IsLinked = true
            add(linksDataQ)
        end
        return self.CloseDataFile()
    end
    return false
    
CML_Data_ManyToManyLinksPersisterForTPS.OpenDataFile  procedure!,bool
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
    
CML_Data_ManyToManyLinksPersisterForTPS.RemoveLinkRecord     procedure(long leftRecordID,long rightRecordID)!,derived
    code    
    dbg.write('RemoveLinkRecord(' & leftRecordID & ',' & rightRecordID & ')')
    clear(Links:Record)
    Links:LeftRecordID  = LeftRecordID
    Links:RightRecordID = rightRecordID
    get(LinksDataFile,Links:kLeftRight)
    if not errorcode()
        dbg.write('deleting record')
        delete(LinksDataFile)
        if errorcode() then return false.
    end
    return true

CML_Data_ManyToManyLinksPersisterForTPS.SetFilename     procedure(string filename)   
    code
    self.Filename = Filename    
    LinksDataFile{prop:name} = self.Filename
    dbg.write('LinksDataFile{{prop:name} ' & LinksDataFile{prop:name})
    
    