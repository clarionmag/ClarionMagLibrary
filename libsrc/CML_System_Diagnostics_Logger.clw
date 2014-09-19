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
                    member()

	! Do NOT remove the following line. It turns off profiling for this
	! module and is needed by CML_System_Diagnostics_Profiler
	pragma('define(profile=>off)')

                    MAP
                        MODULE('Winapi')
   OutputDebugSTRING(*CSTRING),PASCAL,RAW,NAME('OutputDebugStringA'),DLL(_CML_Classes_DllMode_)
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
    
    
    
                    


    