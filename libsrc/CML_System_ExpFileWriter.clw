!---------------------------------------------------------------------------------------------!
! Copyright (c) 2012, 2013 CoveComm Inc.
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



	Include('CML_System_ExpFileWriter.inc'),Once
	include('CML_System_String.inc'),once
	include('CML_System_Class.inc'),once
	include('CML_System_ClassParser.inc'),once
	INCLUDE('CML_System_IO_AsciiFile.inc'),ONCE
	include('CML_System_Diagnostics_Logger.inc'),once

dbg                                     CML_System_Diagnostics_Logger

CML_System_ExpFileWriter.Construct      Procedure()
	code
	!self.Errors &= new CML_System_ErrorManager
	self.ClassHeaderQ &= new CML_System_ExpFileWriter_HeaderFileQueue
	self.CustomExportStatementQ &= new CML_System_ExpFileWriter_ExportStatementQueue


CML_System_ExpFileWriter.Destruct       Procedure()
	code
	!dispose(self.Errors)
	FREE(self.ClassHeaderQ)
	dispose(self.ClassHeaderQ)
	FREE(self.CustomExportStatementQ)
	dispose(self.CustomExportStatementQ)

CML_System_ExpFileWriter.AddClassHeaderFile     procedure(string filename)
	code
	CLEAR(self.ClassHeaderQ)
	self.ClassHeaderQ.Filename = filename
	ADD(self.ClassHeaderQ)

CML_System_ExpFileWriter.AddCustomExportStatement     procedure(string statement)
	code
	CLEAR(self.CustomExportStatementQ)
	self.CustomExportStatementQ.ExportStatement = statement
	ADD(self.CustomExportStatementQ)
	
CML_System_ExpFileWriter.WriteExpFile   procedure(string appname,<string directoryname>)
ExportsQ                                    queue
Txt                                             cstring(500)
											end
cls                                         &CML_System_Class
parser                                      CML_System_ClassParser
x                                           long
y                                           long
str                                         CML_System_String
!FileMgr                                     CML_System_IO_AsciiFileManager
ExpFile                                     CML_System_IO_AsciiFile
    code
    dbg.write('CML_System_ExpFileWriter.WriteExpFile')
    dbg.write(RECORDS(self.classheaderq) & ' class header records')
	loop x = 1 to RECORDS(self.classheaderq)
		GET(self.classheaderq,x)
		parser.Reset()
        parser.Parse(self.ClassHeaderQ.Filename)
        dbg.write('parser found ' & parser.ClassCount() & ' classes')
		loop y = 1 to parser.ClassCount()
			cls &= parser.GetClass(y)
			if not cls &= null
				cls.GetExports(ExportsQ,ExportsQ.Txt,FALSE)
			end
		end
	end
	if not omitted(directoryname)
		str.Assign(directoryname)
	else
		str.Assign(LONGPATH())
	end
	if ~str.EndsWith('\') then str.Append('\').
	str.Append(CLIP(appname) & '.EXP')
	!ExpFile &= FileMgr.GetAsciiFileInstance(1)
	if ExpFile.CreateFile(str.Get()) = Level:Benign
		ExpFile.Write('LIBRARY ''' & CLIP(appname) & ''' GUI')
		Expfile.Write('EXPORTS')
		loop x = 1 to RECORDS(ExportsQ)
			GET(exportsq,x)
			ExpFile.Write(ExportsQ.Txt)
			!dbg.write(ExportsQ.txt)
		end
	end
	loop x = 1 to records(self.CustomExportStatementQ)
		get(self.CustomExportStatementQ,x)
		ExpFile.Write(self.CustomExportStatementQ.ExportStatement)
	END
	ExpFile.CloseFile()   	


