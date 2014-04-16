!---------------------------------------------------------------------------------------------!
! Copyright (c) 2012-2014, CoveComm Inc.
! All rights reserved.
! 
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
                                            Member
                                            Map
                                            End



    Include('CML_System_Class.inc'),Once
    include('CML_System_String.inc'),once
    include('CML_System_Diagnostics_Logger.inc'),once
    include('CML_System_Mangle.inc'),once

dbg                                     CML_System_Diagnostics_Logger

CML_System_Class.Construct                     Procedure()
    code
    !self.Errors &= new CML_System_ErrorManager
    self.MethodQ &= new CML_System_Class_MethodQueue


CML_System_Class.Destruct                      Procedure()
    code
    !dispose(self.Errors)
    self.Reset()
    Dispose(self.MethodQ)



CML_System_Class.AddMethod                  procedure(string declaration)
str                                             CML_System_String
paramStr                                        CML_System_String
typeStr                                         CML_System_String
pos                                             long
pos2                                            long
x                                               long
parenthesesFound                                bool
    code
    !dbg.write('Declaration: ' & declaration)
    pos = INSTRING(' PROCEDURE',UPPER(declaration),1,1)
    if pos > 0
        pos2 = pos + 10
    else
        pos = INSTRING(' FUNCTION',UPPER(declaration),1,1)
        pos2 = pos + 9
    end
    if pos > 0
        CLEAR(self.MethodQ)
        str.Assign(UPPER(sub(declaration,1,pos)))
        str.Trim()
        if str.BeginsWith('!') then return.
        self.MethodQ.Name = str.Get()
        self.MethodQ.ParameterQ &= new CML_System_Class_ParameterQueue
        !dbg.write('Method: ' & self.MethodQ.Name)
        str.Assign(sub(declaration,pos2,len(declaration)))
        str.Trim()
        !dbg.write('Parameters: ' & str.Get())
        if str.EndsWith(',PRIVATE') or str.Contains(',PRIVATE,') then return.
        ADD(self.MethodQ)
        if str.BeginsWith('(')
            str.Assign(str.SubString(2,str.Length()))
        end
        if str.Contains(')') 
            parenthesesFound = true
            str.Assign(str.SubString(1,str.IndexOf(')')-1))
        end 
        if str.BeginsWith(',') then return. ! No parameters, just attributes
        !dbg.write('Parameters: ' & str.Get())
        str.Split(',')
        !dbg.write('******* ' & str.Records() & ' parameters ')
        loop x = 1 to str.Records()
            CLEAR(self.MethodQ.ParameterQ)
            !dbg.write('Parameter: ' & str.GetLine(x))
            paramStr.Assign(str.GetLine(x))
            paramStr.Replace('* ','*',10) ! Remove any spaces after * characters
            paramStr.Trim()
            if paramStr.Contains('=')
                !self.MethodQ.ParameterQ.Omittable = true
                paramStr.Split('=')
                paramStr.Assign(paramStr.GetLine(1))
            end
            if paramStr.BeginsWith('<<')
                self.MethodQ.ParameterQ.Omittable = true
                paramStr.Assign(paramStr.SubString(2,paramStr.Length()-1))
                !paramStr.Assign(paramStr.SubString(1,paramStr.Length()-1))
            end
            paramStr.Split(' ')
            typeStr.Assign(paramStr.GetLine(1))
            if typeStr.BeginsWith('*')
                self.MethodQ.ParameterQ.ByAddress = true
                typeStr.Assign(typeStr.SubString(2,typeStr.Length()))
            end
            self.MethodQ.ParameterQ.Type = typeStr.Get()
            if paramStr.Records() = 2
                self.MethodQ.ParameterQ.Name = paramStr.GetLine(2)
            end
            ADD(self.MethodQ.ParameterQ)
        end
    end
        
CML_System_Class.Debug                      procedure
x                                               long
y                                               long
    code
    !dbg.write('CML_System_Class.Debug')
    !dbg.write('Class name: ' & self.Name)
    loop x = 1 to RECORDS(self.MethodQ)
        GET(self.MethodQ,x)
        !dbg.write('  Method: ' & self.MethodQ.Name)
        loop y = 1 to RECORDS(self.MethodQ.ParameterQ)
            GET(self.MethodQ.ParameterQ,y)
            !dbg.write('    Parameter: ' & self.MethodQ.ParameterQ.Type & ' ' & self.MethodQ.ParameterQ.Name & ' ' & choose(self.methodq.ParameterQ.Omittable,'Omittable','') & ' ' & choose(self.methodq.ParameterQ.ByAddress,'ByAddress',''))
        end
    end
    
CML_System_Class.GetExports                 procedure(*queue q,*? qField,BOOL freeQueue=true)
x                                               long    
y                                               long
str                                             CML_System_String
mangler                                         CML_System_Mangle
    code
    if freeQueue then FREE(q).
    qfield = '  TYPE$' & CLIP(UPPER(self.Name)) & ' @?'
    ADD(q)
    qField = '  VMT$' & CLIP(UPPER(self.Name)) & ' @?'         
    ADD(q)
    loop x = 1 to RECORDS(self.MethodQ)
        GET(self.MethodQ,x)
        str.Reset()
        str.Assign('  ' & UPPER(self.MethodQ.Name) & '@F' & LEN(self.Name) & UPPER(self.Name))
        loop y = 1 to RECORDS(self.MethodQ.ParameterQ)
            GET(self.MethodQ.ParameterQ,y)
            str.Append(mangler.GetExportSymbol(self.MethodQ.ParameterQ.Type,self.MethodQ.ParameterQ.Omittable,self.MethodQ.ParameterQ.ByAddress) )
        end 
        str.Append(' @?')
        !dbg.write(str.Get())
        qField =  str.Get()
        ADD(q)
    end
    
            
        

        
    
    

CML_System_Class.MethodCount                Procedure!,long
    code
    return RECORDS(self.MethodQ)
    
    
    
    
CML_System_Class.Reset                      procedure
x                                               long
    code
    loop x = 1 to RECORDS(self.MethodQ)
        GET(self.MethodQ,x)
        FREE(self.MethodQ.ParameterQ)
        dispose(self.MethodQ.ParameterQ)
    end
    FREE(self.MethodQ)
        
    
    



