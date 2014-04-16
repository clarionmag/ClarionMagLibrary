										member()
	
	include('CML_System_Threading_CriticalSection.inc'),once


										MAP
											module('')
												NewCriticalSection(),*CML_System_Threading_ICriticalSection,C,NAME('NewCriticalSection')
											end
										end




CML_System_Threading_CriticalSection.Construct  PROCEDURE()
	CODE
	self.CriticalSection &= NewCriticalSection()
	RETURN
  
CML_System_Threading_CriticalSection.Destruct   PROCEDURE()
	CODE
	self.CriticalSection.Kill()
	RETURN
  
  
  
CML_System_Threading_CriticalSection.GetCriticalSection PROCEDURE()
	CODE
	RETURN self.CriticalSection
	
CML_System_Threading_CriticalSection.Release    PROCEDURE()
	CODE
	self.CriticalSection.Release()
	RETURN

CML_System_Threading_CriticalSection.Wait       PROCEDURE()
	CODE
	self.CriticalSection.Wait()
	RETURN
