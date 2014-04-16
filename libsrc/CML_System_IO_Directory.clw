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



										member()


										MAP
											include('cwutil.inc')
											MODULE('Windows.lib')
												SHFileOperation(LONG pSHFILEOPgroup), LONG, PASCAL,RAW, DLL,NAME('SHFileOperationA')
											END
										END

	include('CML_System_IO_Directory.inc'),once
	include('CML_System_Diagnostics_Logger.inc')
	include('CML_System_IO_CaptureStdOutput.inc')
!
! Shell File Operations
!
FO_MOVE                                 EQUATE(0001h)
FO_COPY                                 EQUATE(0002h)
FO_DELETE                               EQUATE(0003h)
FO_RENAME                               EQUATE(0004h)

FOF_MULTIDESTFILES                      EQUATE(0001h)
FOF_CONFIRMMOUSE                        EQUATE(0002h)
FOF_SILENT                              EQUATE(0004h)  ! don't create progress/report
FOF_RENAMEONCOLLISION                   EQUATE(0008h)
FOF_NOCONFIRMATION                      EQUATE(0010h)  ! Don't prompt the user.

! Fill in SHFILEOPSTRUCT.hNameMappings
! Must be freed using SHFreeNameMappings
FOF_WANTMAPPINGHANDLE                   EQUATE(0020h)
FOF_ALLOWUNDO                           EQUATE(0040h)
FOF_FILESONLY                           EQUATE(0080h)  ! on *.*, do only files
FOF_SIMPLEPROGRESS                      EQUATE(0100h)  ! means don't show names of files
! don't confirm making any needed dirs
FOF_NOCONFIRMMKDIR                      EQUATE(0200h)
FOF_NOERRORUI                           EQUATE(0400h)  ! don't put up error UI
! dont copy NT file Security Attributes
FOF_NOCOPYSECURITYATTRIBS               EQUATE(0800h)
FOF_NORECURSION                         EQUATE(1000h)  ! don't recurse into directories.
! don't operate on connected elements.
FOF_NO_CONNECTED_ELEMENTS               EQUATE(2000h)
! during delete operation, warn if nuking instead of recycling
! (partially overrides FOF_NOCONFIRMATION)
FOF_WANTNUKEWARNING                     EQUATE(4000h)

SHFILEOPgroup                           GROUP, TYPE
hwnd                                        UNSIGNED
wFunc                                       UNSIGNED
pFrom                                       LONG
pTo                                         LONG
fFlags                                      USHORT
fAnyOperationsAborted                       LONG
hNameMappings                               LONG
lpszProgressTitle                           LONG
										END


!dbg                                     CML_System_Diagnostics_Logger

SHFileOp                                LIKE(SHFILEOPgroup)
Source                                  CSTRING(256)
Destination                             CSTRING(256)

	
CML_System_IO_Directory.Construct       procedure
	code
	self.useRmDir = true
	!dbg.SetPrefix('CML_System_IO_Directory')
	self.FilesQ &= new CML_System_IO_DirectoryFilesQueue
	
CML_System_IO_Directory.Destruct        procedure
	code
	free(self.FilesQ)
	dispose(self.FilesQ)
	
	

	
CML_System_IO_Directory.CreateDirectory procedure(byte force=false)
	code
	if force
		self.RemoveDirectory()
	END
	CreateDirectory(self.Path)
	

CML_System_IO_Directory.FileCount       procedure !,long
	CODE
	if self.RefreshNeeded
		self.GetDirectoryListing()
	END
	return records(self.FilesQ)
	
CML_System_IO_Directory.GetChecksum     procedure!,real
Checksum                                    REAL
x                                           long
	CODE
	loop x = 1 to records(self.FilesQ)
		get(self.FilesQ,x)
		checksum += self.FilesQ.date
		checksum += self.FilesQ.time / 10000000
		checksum += self.FilesQ.attrib
	END
	return checksum
	

CML_System_IO_Directory.GetDirectoryListing     procedure	
!Files                                               QUEUE(File:queue),PRE(FIL)    !Inherit exact declaration of File:queue
!													END
x                                                   long
	CODE
!	loop x = 1 to records(self.FilesQ)
!		get(self.FilesQ,x)
!		dispose(self.FilesQ.CML_System_IO_FileInfo)
!	END
	free(self.FilesQ)
	!dbg.Write('Looking in path ' & self.Path & self.Filter)
	DIRECTORY(self.FilesQ,self.Path & self.Filter, ff_:Normal)  
	!dbg.Write(records(self.FilesQ) & ' directory items found')
!	loop x = 1 to records(Files)
!		get(Files,x)
!		if (self.MaxDaysOld > 0)
!			if files.Date < today() and (files.Date + self.MaxDaysOld) < today()
!				CYCLE
!			end
!		end
!		clear(self.FilesQ)
!		self.FilesQ.CML_System_IO_FileInfo &= new CML_System_IO_FileInfo()
!		self.FilesQ.CML_System_IO_FileInfo.FileName = files.Name
!		!dbg.Write('added self.FilesQ.CML_System_IO_FileInfo.filename ' & self.FilesQ.CML_System_IO_FileInfo.FileName)
!		add(self.FilesQ)
!	end


CML_System_IO_Directory.Init            procedure(string dirname)
	CODE
	self.Path = dirname
	if self.Path[len(self.Path)] <> '\'
		self.Path = self.Path & '\'
	end
	self.RefreshNeeded = true
	
!CML_System_IO_Directory.LoadFilenamesQueue      procedure(*CML_System_IO_DirectoryQueue q)
!x                                                   long
!	CODE
!	if self.RefreshNeeded
!		self.GetDirectoryListing()
!	END
!	loop x = 1 to records(self.FilesQ)
!		get(self.FilesQ,x)
!		q.FilePath = self.Path	
!		q.FileName = self.FilesQ.CML_System_IO_FileInfo.FileName
!		add(q)
!	end

	
CML_System_IO_Directory.RemoveDirectory procedure(byte OnlyIfEmpty=false)	
shfop                                       LIKE(SHFILEOPgroup)
err                                         long
dirname                                     cstring(500)
stdout                                      CML_System_IO_CaptureStdOutput
	code
	if self.UseRmDir
		if OnlyIfEmpty
			stdout.Run('rmdir "' & clip(self.path) & '"')
		ELSE
			stdout.run('rmdir "' & clip(self.path) & '" /q /s')
		END
	ELSE
		!dbg.SetPrefix('CML_System_IO_Directory.RemoveDirectory')
		if OnlyIfEmpty
			!dbg.write('calling Clarion RemoveDirectory function')
			RemoveDirectory(self.Path)
		ELSE
			dirname = clip(self.Path) & '<0><0>' ! Needed for Win7 and maybe Vista
			CLEAR(shfop)
			shfop.wFunc  = FO_DELETE
			shfop.pFROM  = ADDRESS(dirname)
			shfop.fFlags = FOF_NOCONFIRMATION + FOF_NOCONFIRMMKDIR
			!dbg.write('calling SHFileOperation to delete ' & self.Path)
			err = SHFileOperation(ADDRESS(shfop))
			!dbg.write('return: ' & err)
		end
	END
	
	

	
CML_System_IO_Directory.SetFilesOnly    procedure(byte flag)
	CODE
	self.RefreshNeeded = true
	
CML_System_IO_Directory.SetFilter       procedure(string filter)
	CODE
	self.RefreshNeeded = true
	self.filter = filter
	!dbg.Write('Filter: ' & self.filter)

CML_System_IO_Directory.SetMaxDaysOld   procedure(long maxDays)
	CODE
	self.MaxDaysOld = maxDays



	