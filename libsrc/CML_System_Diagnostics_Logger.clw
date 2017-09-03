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

                    member()

	! Do NOT remove the following line. It turns off profiling for this
	! module and is needed by CML_System_Diagnostics_Profiler
	pragma('define(profile=>off)')

                    MAP
                        MODULE('Winapi')
   OutputDebugSTRING(*CSTRING),PASCAL,RAW,NAME('OutputDebugStringA'),DLL(1) !Carl add DLL(1)
        !For DLL(1) see _declspec(dllimport) at http://support.microsoft.com/kb/132044/en-us
                        END
                    END

    include('CML_System_Diagnostics_Logger.inc'),once
    include('CML_System_StringUtility.inc'),once

StringUtil                              CML_System_StringUtility

        
CML_System_Diagnostics_Logger._CompareGroup   procedure(*group g1,*group g2,bool compareStructure, bool compareContent, bool write=false)
x                                                   long
ref1                                                any
ref2                                                any
blankCount                                          long
    code
    if write 
        !self.write('CML_System_Diagnostics_Logger._CompareGroup ================================================')
    end
    x = 0
    loop 5000 times ! Just to guard against an infinite loop
        x += 1
        if who(g1,x) = '' and who(g2,x) = ''
            blankCount += 1
            if blankCount > 10 then break.
            cycle
        else
            blankCount = 0
        end
        if compareStructure
            if write 
                self.write('Comparing label ' & who(g1,x) & ' to label ' & who(g2,x))
            end
            if who(g1,x) <> who(g2,x) 
                if write 
                    self.write('Mismatched labels!')
                end
                return x
            end
        end
        if compareContent
            if who(g1,x) = ''
                if write 
                    self.write('Compare error: left side label is blank on line ' & x)
                end
                return x
            end
            if who(g2,x) = ''
                if write 
                    self.write('Compare error: right side label is blank on line ' & x)
                end
                return x
            end
            ref1 &= what(g1,x)
            ref2 &= what(g2,x)
            if write 
                !self.write('Comparing ' & StringUtil.GetPaddedString(who(g1,x),30) & ' to ' & StringUtil.GetPaddedString(who(g2,x),30) & ' = ' & ref1)
            end
            if ref1 <> ref2
                if write 
                    self.write('Comparing ' & StringUtil.GetPaddedString(who(g1,x),30) & ' to ' & StringUtil.GetPaddedString(who(g2,x),30) & ' = ' & ref1)
                    self.write('Mismatched content on line ' & x & ' = ' & ref2)
                end
                return x
            end
        end
    end
    return 0
    
CML_System_Diagnostics_Logger.CompareGroupContent   procedure(*group g1,*group g2,bool write=false)
x                                                           long
!ref                                                             any
    code
    return self._CompareGroup(g1,g2,false,true,write)

CML_System_Diagnostics_Logger.CompareGroupStructures   procedure(*group g1,*group g2,bool write=false)
x                                                           long
!ref                                                             any
    code
    return self._CompareGroup(g1,g2,true,false,write)
    
    
CML_System_Diagnostics_Logger.SetPrefix        procedure(string prefix)
    CODE
!!  self.Prefix = prefix  !Carl; I would append the ': ' here rather than every .Write
    self.Prefix = clip(sub(prefix,1,SIZE(self.Prefix)-2)) &': '  !Truncate passed prefix at 50 so : fits
    RETURN                                    
    
CML_System_Diagnostics_Logger.Write     procedure(string msg)
cstr                      &cstring 
cLen                      long,auto  !prefix & msg could be blank
    CODE
!!    cstr &= new cstring(len(self.prefix) + len(clip(msg))+3)
!!    cstr = self.prefix & ': ' & msg  !Carl: was clip(msg) but CSTR is exact right size so no need to clip?
    cLen=val(self.prefix[0]) + len(clip(msg)) + 1    !Prefix is Pstring with Len in [0]
    if cLen > 1 then                                 !is Prefix+Msg not blank
       cstr &= new cstring(cLen)
       cstr = self.prefix & msg         !Carl: was clip(msg) but CSTR is exact right size so no need to clip?
       OutputDebugSTRING(cstr)
       dispose(cStr)                    !Carl added DISPOSE or memory leak                          
    end
    RETURN                           !Carl explicit return always a good idea, see Cmag Gordon Smith
    
CML_System_Diagnostics_Logger.WriteProperties  procedure(*Group g)    
x                                                   long,auto !Carl +auto
ref                                                 any
    code
    !carl x = 0
    loop x = 1 to 500   !carl 500 times
        !carl x += 1
        if who(g,x) = '' then cycle.
        ref &= what(g,x)
        self.Write(who(g,x) & ' ' & ref)
    end
    !Carl ? Do you need to check for DIM and skip those?
    
    
    
                    


    