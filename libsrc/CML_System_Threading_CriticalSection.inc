	include('CML_IncludeInAllClassHeaderFiles.inc'),once
	include('CML_System_Threading_ICriticalSection.inc'),once

CML_System_Threading_CriticalSection    CLASS,MODULE('CML_System_Threading_CriticalSection.CLW'),LINK('CML_System_Threading_CriticalSection.CLW',_CML_Classes_LinkMode_),DLL(_CML_Classes_DllMode_),type
CriticalSection                             &CML_System_Threading_ICriticalSection,PRIVATE
Construct                                   PROCEDURE()
Destruct                                    PROCEDURE()
GetCriticalSection                          PROCEDURE(),*CML_System_Threading_ICriticalSection
Release                                     PROCEDURE()
Wait                                        PROCEDURE()
										END
