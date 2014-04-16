! Commonly used Windows constants

! WinHelp constants
CML_API_HELP_COMMAND                        EQUATE(0102h)
CML_API_HELP_CONTEXT                        EQUATE(0001H)  ! Display topic in ulTopic
CML_API_HELP_KEY                            EQUATE(0101h)
CML_API_HELP_PARTIALKEY                     EQUATE(0105h)
CML_API_HELP_QUIT                           EQUATE(0002H)  ! Terminate help
CML_API_HELP_FINDER                         EQUATE(000bH)
CML_API_HELP_HELPONHELP                     EQUATE(0004h)
CML_API_HELP_INDEX                          EQUATE(0003h)
CML_API_WM_HELP                             EQUATE(0053h)

CML_API_ERROR_SUCCESS                       EQUATE(0)
CML_API_ERROR_INVALID_FUNCTION              EQUATE(1)
CML_API_ERROR_FILE_NOT_FOUND                EQUATE(2)
CML_API_ERROR_PATH_NOT_FOUND                EQUATE(3)
CML_API_ERROR_TOO_MANY_OPEN_FILES           EQUATE(4)
CML_API_ERROR_ACCESS_DENIED                 EQUATE(5)
CML_API_ERROR_INVALID_HANDLE                EQUATE(6)
CML_API_ERROR_ARENA_TRASHED                 EQUATE(7)
CML_API_ERROR_NOT_ENOUGH_MEMORY             EQUATE(8)
CML_API_ERROR_INVALID_BLOCK                 EQUATE(9)
CML_API_ERROR_BAD_ENVIRONMENT               EQUATE(10)
CML_API_ERROR_BAD_FORMAT                    EQUATE(11)
CML_API_ERROR_INVALID_ACCESS                EQUATE(12)
CML_API_ERROR_INVALID_DATA                  EQUATE(13)
CML_API_ERROR_OUTOFMEMORY                   EQUATE(14)
CML_API_ERROR_INVALID_DRIVE                 EQUATE(15)
CML_API_ERROR_CURRENT_DIRECTORY             EQUATE(16)
CML_API_ERROR_NOT_SAME_DEVICE               EQUATE(17)
CML_API_ERROR_NO_MORE_FILES                 EQUATE(18)
CML_API_ERROR_WRITE_PROTECT                 EQUATE(19)
CML_API_ERROR_BAD_UNIT                      EQUATE(20)
CML_API_ERROR_NOT_READY                     EQUATE(21)
CML_API_ERROR_BAD_COMMAND                   EQUATE(22)
CML_API_ERROR_CRC                           EQUATE(23)
CML_API_ERROR_BAD_LENGTH                    EQUATE(24)
CML_API_ERROR_SEEK                          EQUATE(25)
CML_API_ERROR_NOT_DOS_DISK                  EQUATE(26)
CML_API_ERROR_SECTOR_NOT_FOUND              EQUATE(27)
CML_API_ERROR_OUT_OF_PAPER                  EQUATE(28)
CML_API_ERROR_WRITE_FAULT                   EQUATE(29)
CML_API_ERROR_READ_FAULT                    EQUATE(30)
CML_API_ERROR_GEN_FAILURE                   EQUATE(31)
CML_API_ERROR_SHARING_VIOLATION             EQUATE(32)
CML_API_ERROR_LOCK_VIOLATION                EQUATE(33)
CML_API_ERROR_WRONG_DISK                    EQUATE(34)
CML_API_ERROR_SHARING_BUFFER_EXCEEDED       EQUATE(36)
CML_API_ERROR_HANDLE_EOF                    EQUATE(38)
CML_API_ERROR_HANDLE_DISK_FULL              EQUATE(39)
CML_API_ERROR_NOT_SUPPORTED                 EQUATE(50)
CML_API_ERROR_REM_NOT_LIST                  EQUATE(51)
CML_API_ERROR_DUP_NAME                      EQUATE(52)
CML_API_ERROR_BAD_NETPATH                   EQUATE(53)
CML_API_ERROR_NETWORK_BUSY                  EQUATE(54)
CML_API_ERROR_DEV_NOT_EXIST                 EQUATE(55)
CML_API_ERROR_TOO_MANY_CMDS                 EQUATE(56)
CML_API_ERROR_ADAP_HDW_ERR                  EQUATE(57)
CML_API_ERROR_BAD_NET_RESP                  EQUATE(58)
CML_API_ERROR_UNEXP_NET_ERR                 EQUATE(59)
CML_API_ERROR_BAD_REM_ADAP                  EQUATE(60)
CML_API_ERROR_PRINTQ_FULL                   EQUATE(61)
CML_API_ERROR_NO_SPOOL_SPACE                EQUATE(62)
CML_API_ERROR_PRINT_CANCELLED               EQUATE(63)
CML_API_ERROR_NETNAME_DELETED               EQUATE(64)
CML_API_ERROR_NETWORK_ACCESS_DENIED         EQUATE(65)
CML_API_ERROR_BAD_DEV_TYPE                  EQUATE(66)
CML_API_ERROR_BAD_NET_NAME                  EQUATE(67)
CML_API_ERROR_TOO_MANY_NAMES                EQUATE(68)
CML_API_ERROR_TOO_MANY_SESS                 EQUATE(69)
CML_API_ERROR_SHARING_PAUSED                EQUATE(70)
CML_API_ERROR_REQ_NOT_ACCEP                 EQUATE(71)
CML_API_ERROR_REDIR_PAUSED                  EQUATE(72)
CML_API_ERROR_FILE_EXISTS                   EQUATE(80)
CML_API_ERROR_CANNOT_MAKE                   EQUATE(82)
CML_API_ERROR_FAIL_I24                      EQUATE(83)
CML_API_ERROR_OUT_OF_STRUCTURES             EQUATE(84)
CML_API_ERROR_ALREADY_ASSIGNED              EQUATE(85)
CML_API_ERROR_INVALID_PASSWORD              EQUATE(86)
CML_API_ERROR_INVALID_PARAMETER             EQUATE(87)
CML_API_ERROR_NET_WRITE_FAULT               EQUATE(88)
CML_API_ERROR_NO_PROC_SLOTS                 EQUATE(89)
CML_API_ERROR_TOO_MANY_SEMAPHORES           EQUATE(100)
CML_API_ERROR_EXCL_SEM_ALREADY_OWNED        EQUATE(101)
CML_API_ERROR_SEM_IS_SET                    EQUATE(102)
CML_API_ERROR_TOO_MANY_SEM_REQUESTS         EQUATE(103)
CML_API_ERROR_INVALID_AT_INTERRUPT_TIME     EQUATE(104)
CML_API_ERROR_SEM_OWNER_DIED                EQUATE(105)
CML_API_ERROR_SEM_USER_LIMIT                EQUATE(106)
CML_API_ERROR_DISK_CHANGE                   EQUATE(107)
CML_API_ERROR_DRIVE_LOCKED                  EQUATE(108)
CML_API_ERROR_BROKEN_PIPE                   EQUATE(109)
CML_API_ERROR_OPEN_FAILED                   EQUATE(110)
CML_API_ERROR_BUFFER_OVERFLOW               EQUATE(111)
CML_API_ERROR_DISK_FULL                     EQUATE(112)
CML_API_ERROR_NO_MORE_SEARCH_HANDLES        EQUATE(113)
CML_API_ERROR_INVALID_TARGET_HANDLE         EQUATE(114)
CML_API_ERROR_INVALID_CATEGORY              EQUATE(117)
CML_API_ERROR_INVALID_VERIFY_SWITCH         EQUATE(118)
CML_API_ERROR_BAD_DRIVER_LEVEL              EQUATE(119)
CML_API_ERROR_CALL_NOT_IMPLEMENTED          EQUATE(120)
CML_API_ERROR_SEM_TIMEOUT                   EQUATE(121)
CML_API_ERROR_INSUFFICIENT_BUFFER           EQUATE(122)
CML_API_ERROR_INVALID_NAME                  EQUATE(123)
CML_API_ERROR_INVALID_LEVEL                 EQUATE(124)
CML_API_ERROR_NO_VOLUME_LABEL               EQUATE(125)
CML_API_ERROR_MOD_NOT_FOUND                 EQUATE(126)
CML_API_ERROR_PROC_NOT_FOUND                EQUATE(127)
CML_API_ERROR_WAIT_NO_CHILDREN              EQUATE(128)
CML_API_ERROR_CHILD_NOT_COMPLETE            EQUATE(129)
CML_API_ERROR_DIRECT_ACCESS_HANDLE          EQUATE(130)
CML_API_ERROR_NEGATIVE_SEEK                 EQUATE(131)
CML_API_ERROR_SEEK_ON_DEVICE                EQUATE(132)
CML_API_ERROR_IS_JOIN_TARGET                EQUATE(133)
CML_API_ERROR_IS_JOINED                     EQUATE(134)
CML_API_ERROR_IS_SUBSTED                    EQUATE(135)
CML_API_ERROR_NOT_JOINED                    EQUATE(136)
CML_API_ERROR_NOT_SUBSTED                   EQUATE(137)
CML_API_ERROR_JOIN_TO_JOIN                  EQUATE(138)
CML_API_ERROR_SUBST_TO_SUBST                EQUATE(139)
CML_API_ERROR_JOIN_TO_SUBST                 EQUATE(140)
CML_API_ERROR_SUBST_TO_JOIN                 EQUATE(141)
CML_API_ERROR_BUSY_DRIVE                    EQUATE(142)
CML_API_ERROR_SAME_DRIVE                    EQUATE(143)
CML_API_ERROR_DIR_NOT_ROOT                  EQUATE(144)
CML_API_ERROR_DIR_NOT_EMPTY                 EQUATE(145)
CML_API_ERROR_IS_SUBST_PATH                 EQUATE(146)
CML_API_ERROR_IS_JOIN_PATH                  EQUATE(147)
CML_API_ERROR_PATH_BUSY                     EQUATE(148)
CML_API_ERROR_IS_SUBST_TARGET               EQUATE(149)
CML_API_ERROR_SYSTEM_TRACE                  EQUATE(150)
CML_API_ERROR_INVALID_EVENT_COUNT           EQUATE(151)
CML_API_ERROR_TOO_MANY_MUXWAITERS           EQUATE(152)
CML_API_ERROR_ALREADY_EXISTS                EQUATE(183)
CML_API_ERROR_NO_MORE_ITEMS                 equate( 259 )

CML_API_FORMAT_MESSAGE_IGNORE_INSERTS       equate(000200h)
CML_API_FORMAT_MESSAGE_FROM_SYSTEM          equate(001000h)
CML_API_FORMAT_MESSAGE_MAX_WIDTH_MASK       EQUATE(000000FFH)
CML_API_LANG_USER_DEFAULT                   EQUATE(400H)

CML_API_S_OK                                EQUATE(0)
CML_API_S_FALSE                             EQUATE(1)

CML_API_FILE_NOTIFY_CHANGE_FILE_NAME        equate(00000001h)
CML_API_FILE_NOTIFY_CHANGE_DIR_NAME         equate(00000002h)
CML_API_FILE_NOTIFY_CHANGE_ATTRIBUTES       equate(00000004h)
CML_API_FILE_NOTIFY_CHANGE_SIZE             equate(00000008h)
CML_API_FILE_NOTIFY_CHANGE_LAST_WRITE       equate(00000010h)
CML_API_FILE_NOTIFY_CHANGE_LAST_ACCESS      equate(00000020h)
CML_API_FILE_NOTIFY_CHANGE_CREATION         equate(00000040h)
CML_API_FILE_NOTIFY_CHANGE_SECURITY         equate(00000100h)
CML_API_Watch_subdirectories                equate(1)
CML_API_Watch_NoSubDirectories              equate(0)
CML_API_Watch_autoreset                     equate(1)
CML_API_Watch_noAutoReset                   equate(0)

!
!Wait object equates
CML_API_MAXIMUM_WAIT_OBJECTS                EQUATE(64)
CML_API_Waitinfinite                        EQUATE(-1)
CML_API_Wait_object_0                       EQUATE(0)
CML_API_Wait_Abandoned_0                    EQUATE(80)
CML_API_WAIT_TIMEOUT                        EQUATE(102)
CML_API_WAIT_FAILED                         EQUATE(-1)

! ShGetFolderLocation equates
CML_API_CSIDL_DESKTOP                       EQUATE(0H)  ! {Desktop}
CML_API_CSIDL_INTERNET                      EQUATE(1H)  ! Internet Explorer Icon on Desktop
CML_API_CSIDL_PROGRAMS                      EQUATE(2H)  ! Start Menu\Programs
CML_API_CSIDL_CONTROLS                      EQUATE(3H)  ! My Computer\Control Panel
CML_API_CSIDL_PRINTERS                      EQUATE(4H)  ! My Computer\Printers
CML_API_CSIDL_PERSONAL                      EQUATE(5H)  ! My Documents
CML_API_CSIDL_FAVORITES                     EQUATE(6H)  ! {User Name}\Favorites
CML_API_CSIDL_STARTUP                       EQUATE(7H)  ! Start Menu\Programs\Startup
CML_API_CSIDL_RECENT                        EQUATE(8H)  ! {User Name}\Recent
CML_API_CSIDL_SENDTO                        EQUATE(9H)  ! {User Name}\SendTo
CML_API_CSIDL_BITBUCKET                     EQUATE(0AH) ! {Desktop}\Recycle Bin
CML_API_CSIDL_STARTMENU                     EQUATE(0BH) ! {User Name}\Start Menu
CML_API_CSIDL_DESKTOPDIRECTORY              EQUATE(10H) ! {User Name}\Desktop
CML_API_CSIDL_DRIVES                        EQUATE(11H) ! My Computer
CML_API_CSIDL_NETWORK                       EQUATE(12H) ! Network Neighborhood
CML_API_CSIDL_NETHOOD                       EQUATE(13H) ! {User Name}\nethood
CML_API_CSIDL_FONTS                         EQUATE(14H) ! Windows\fonts
CML_API_CSIDL_TEMPLATES                     EQUATE(15H)
CML_API_CSIDL_COMMON_STARTMENU              EQUATE(16H) ! All Users\Start Menu
CML_API_CSIDL_COMMON_PROGRAMS               EQUATE(17H) ! All Users\Programs
CML_API_CSIDL_COMMON_STARTUP                EQUATE(18H) ! All Users\Startup
CML_API_CSIDL_COMMON_DESKTOPDIRECTORY       EQUATE(19H) ! All Users\Desktop
CML_API_CSIDL_APPDATA                       EQUATE(1AH) ! {User Name}\Application Data
CML_API_CSIDL_PRINTHOOD                     EQUATE(1BH) ! {User Name}\PrintHood
CML_API_CSIDL_LOCAL_APPDATA                 EQUATE(1CH) ! {User Name}\Local Settings\Application Data (non roaming)
CML_API_CSIDL_ALTSTARTUP                    EQUATE(1DH) ! Non-Localized Startup
CML_API_CSIDL_COMMON_ALTSTARTUP             EQUATE(1EH) ! Non-Localized Common Startup
CML_API_CSIDL_COMMON_FAVORITES              EQUATE(1FH)
CML_API_CSIDL_INTERNET_CACHE                EQUATE(20H)
CML_API_CSIDL_COOKIES                       EQUATE(21H)
CML_API_CSIDL_HISTORY                       EQUATE(22H)
CML_API_CSIDL_COMMON_APPDATA                EQUATE(23H) ! All Users\Application Data
CML_API_CSIDL_WINDOWS                       EQUATE(24H) ! GetWindowsDirectory()
CML_API_CSIDL_SYSTEM                        EQUATE(25H) ! GetSystemDirectory()
CML_API_CSIDL_PROGRAM_FILES                 EQUATE(26H) ! C:\Program Files
CML_API_CSIDL_MYPICTURES                    EQUATE(27H) ! {User Name}\My Documents\My Pictures
CML_API_CSIDL_PROFILE                       EQUATE(28H) ! UserProfile
CML_API_CSIDL_SYSTEMX86                     EQUATE(29H) ! x86 System Directory on RISC
CML_API_CSIDL_PROGRAM_FILESX86              EQUATE(2AH) ! x86 C:\Program Files on RISC
CML_API_CSIDL_PROGRAM_FILES_COMMON          EQUATE(2BH) ! C:\Program Files\Common
CML_API_CSIDL_PROGRAM_FILES_COMMONX86       EQUATE(2CH) ! x86 Program Files\Common on RISC
CML_API_CSIDL_COMMON_TEMPLATES              EQUATE(2DH) ! All Users\Templates
CML_API_CSIDL_COMMON_DOCUMENTS              EQUATE(2EH) ! All Users\Documents
CML_API_CSIDL_COMMON_ADMINTOOLS             EQUATE(2FH) ! All Users\Start Menu\Programs\Administrative Tools
CML_API_CSIDL_ADMINTOOLS                    EQUATE(30H) ! {User Name}\Start Menu\Programs\Administrative Tools

CML_API_CSIDL_FLAG_CREATE                   EQUATE(8000H)  ! Combine with CML_API_CSIDL_ value to force create on ShGetFolderLocation()
CML_API_CSIDL_FLAG_DONT_VERIFY              EQUATE(4000H)  ! Combine with CML_API_CSIDL_ value to force create on ShGetFolderLocation()
CML_API_CSIDL_FLAG_MASK                     EQUATE(0FF00H) ! Mask for all possible flag values

CML_API_SHGFP_TYPE_CURRENT                  EQUATE(0) ! Current value for user; verify it exists
CML_API_SHGFP_TYPE_DEFAULT                  EQUATE(1)

CML_API_SW_NORMAL                           EQUATE(1)
CML_API_SW_MINIMIZE                         EQUATE(6)
CML_API_SW_MAXIMIZE                         EQUATE(3)
CML_API_SW_HIDE                             EQUATE(0)
CML_API_SW_INVALIDATE                       EQUATE(0002h)

CML_API_STARTF_USESHOWWINDOW                EQUATE(00000001H)
CML_API_STARTF_USESTDHANDLES                EQUATE(00000100h)

CML_API_NORMAL_PRIORITY_CLASS               EQUATE(00000020h)
CML_API_CREATE_NEW_CONSOLE                  EQUATE(00000010h)
CML_API_CREATE_DEFAULT_ERROR_MODE           EQUATE(04000000h)

CML_API_HANDLE_FLAG_INHERIT                 EQUATE(00000001H)
CML_API_STD_INPUT_HANDLE                    EQUATE(-10) ! CML_API_Handle to the standard input device.
CML_API_STD_OUTPUT_HANDLE                   EQUATE(-11) ! CML_API_Handle to the standard output device.
CML_API_STD_ERROR_HANDLE                    EQUATE(-12) !CML_API_handle to standard error device

CML_API_INVALID_LONG_VALUE                  EQUATE(4294967295)

CML_API_GENERIC_WRITE                       EQUATE(40000000h)
CML_API_FILE_ATTRIBUTE_NORMAL               EQUATE(00000080h)
CML_API_CREATE_ALWAYS                       EQUATE(2)
CML_API_OPEN_EXISTING                       EQUATE(3)

CML_API_FILE_SHARE_READ                     equate(1)
CML_API_FILE_SHARE_WRITE                    equate(2)
CML_API_FILE_FLAG_RANDOM_ACCESS             equate(10000000H)
CML_API_FILE_FLAG_SEQUENTIAL_SCAN           equate(08000000H)
CML_API_FILE_FLAG_DELETE_ON_CLOSE           equate(04000000H)

CML_API_DUPLICATE_CLOSE_SOURCE              EQUATE(00000001h)! Closes the source CML_API_handle. This occurs regardless of any error status returned.
CML_API_DUPLICATE_SAME_ACCESS               EQUATE(00000002h) !Ignores the dwDesiredAccess parameter. The duplicate CML_API_handle has the same access as the source CML_API_handle.

!
! Windows naming conventions used in Clarion prototypes
!
CML_API_SOCKET                              EQUATE(UNSIGNED)
CML_API_LPBYTE                              EQUATE(ulong)
CML_API_WM_TIMER                            EQUATE(0113h)
CML_API_WM_COMMAND                          EQUATE(0111h)
CML_API_LPDWORD                             EQUATE(ULONG)
CML_API_WM_USER                             EQUATE(400h)

CML_API_HFILE_ERROR                         EQUATE(-1)
CML_API_UINT                                EQUATE(UNSIGNED)
CML_API_FOURCC                              EQUATE(LONG)
CML_API_WCHAR                               EQUATE(BYTE)
CML_API_UCHAR                               EQUATE(BYTE)
CML_API_CHAR                                EQUATE(BYTE)
CML_API_BOOL                                EQUATE(SIGNED)
CML_API_BYTE                                EQUATE(BYTE)
CML_API_WORD                                EQUATE(SIGNED)
CML_API_DWORD                               EQUATE(ULONG)
CML_API_HANDLE                              EQUATE(UNSIGNED)
CML_API_LPVOID                              EQUATE(ULONG)
CML_API_PVOID                               EQUATE(ULONG)
CML_API_FLOAT                               EQUATE(SREAL)
CML_API_LPSTR                               EQUATE(CSTRING)    !Usage:Pass the Label of the LPSTR
CML_API_LPCSTR                              EQUATE(CSTRING)    !Usage:Pass the Label of the LPCSTR
CML_API_MAX_PATH                            EQUATE(260)
CML_API_HWND                                EQUATE(CML_API_HANDLE)
CML_API_HINSTANCE                           EQUATE(CML_API_HANDLE)
CML_API_HMODULE                             EQUATE(CML_API_HINSTANCE)
CML_API_HTASK                               EQUATE(CML_API_HANDLE)
CML_API_HDC                                 EQUATE(CML_API_HANDLE)
CML_API_WPARAM                              EQUATE(CML_API_UINT)
CML_API_LPARAM                              EQUATE(LONG)
CML_API_LRESULT                             EQUATE(LONG)
CML_API_LPBOOL                              EQUATE(ULONG)
CML_API_LPCVOID                             EQUATE(ULONG)

CML_API_HFILE                               EQUATE(CML_API_HANDLE)
CML_API_HDIOBJ                              EQUATE(CML_API_HANDLE)
CML_API_HCOLORSPACE                         EQUATE(CML_API_HANDLE)
CML_API_HRDVR                               EQUATE(CML_API_HANDLE)
CML_API_HWAVEOUT                            EQUATE(CML_API_HANDLE)
CML_API_HWAVEIN                             EQUATE(CML_API_HANDLE)
CML_API_HACCEL                              EQUATE(CML_API_HANDLE)
CML_API_HBITMAP                             EQUATE(CML_API_HANDLE)
CML_API_HPEN                                EQUATE(CML_API_HANDLE)
CML_API_HWINSTA                             EQUATE(CML_API_HANDLE)
CML_API_HBRUSH                              EQUATE(CML_API_HANDLE)
CML_API_HRGN                                EQUATE(CML_API_HANDLE)
CML_API_HKL                                 EQUATE(CML_API_HANDLE)
CML_API_HPALETTE                            EQUATE(CML_API_HANDLE)
CML_API_HFONT                               EQUATE(CML_API_HANDLE)
CML_API_HHOOK                               EQUATE(CML_API_HANDLE)
CML_API_HDRVR                               EQUATE(CML_API_HANDLE)
CML_API_HDWP                                EQUATE(CML_API_HANDLE)
CML_API_HRSRC                               EQUATE(CML_API_HANDLE)
CML_API_HSTR                                EQUATE(CML_API_HANDLE)
CML_API_HCURSOR                             EQUATE(CML_API_HANDLE)
CML_API_HICON                               EQUATE(CML_API_HCURSOR)
CML_API_HGRN                                EQUATE(CML_API_HANDLE)
CML_API_HMENU                               EQUATE(CML_API_HANDLE)
CML_API_SC_HANDLE                           EQUATE(CML_API_HANDLE)
CML_API_HDESK                               EQUATE(CML_API_HANDLE)
CML_API_HENHMETAFILE                        EQUATE(CML_API_HANDLE)
CML_API_HSZ                                 EQUATE(CML_API_WORD)
CML_API_HMETAFILE                           EQUATE(CML_API_HANDLE)
CML_API_HMIDIIN                             EQUATE(CML_API_HANDLE)
CML_API_HMIDIOUT                            EQUATE(CML_API_HANDLE)
CML_API_HMMIO                               EQUATE(CML_API_HANDLE)
CML_API_HFILE                               EQUATE(SIGNED)
CML_API_LUID                                EQUATE(LONG)
CML_API_PLUID                               EQUATE(LONG)
CML_API_HKEY                                EQUATE(CML_API_DWORD)

CML_API_ANYSIZE_ARRAY                       EQUATE(1)
CML_API_PHANDLE                             EQUATE(CML_API_HANDLE)
CML_API_SPHANDLE                            EQUATE(CML_API_HANDLE)
CML_API_LPHANDLE                            EQUATE(CML_API_HANDLE)
CML_API_HGLOBAL                             EQUATE(CML_API_HANDLE)
CML_API_HLOCAL                              EQUATE(CML_API_HANDLE)
CML_API_GLOBALHANDLE                        EQUATE(CML_API_HANDLE)
CML_API_LOCALHANDLE                         EQUATE(CML_API_HANDLE)
CML_API_ATOM                                EQUATE(CML_API_UINT)

CML_API_COLORREF                            EQUATE(CML_API_DWORD)
CML_API_HDDEDATA                            EQUATE(CML_API_DWORD)
CML_API_HCONV                               EQUATE(CML_API_DWORD)
CML_API_HCONVLIST                           EQUATE(CML_API_DWORD)
CML_API_LONGREAL                            EQUATE(REAL)
CML_API_DWORDLONG                           EQUATE(REAL)
CML_API_WORDLONG                            EQUATE(REAL)
CML_API_LARGE_INTEGER                       EQUATE(LONG)
CML_API_ULARGE_INTEGER                      EQUATE(ULONG)
CML_API_BOOLEAN                             EQUATE(BYTE)
CML_API_VERSION                             EQUATE(UNSIGNED)

CML_API_SECURITY_ATTRIBUTES                 GROUP, TYPE
nLength                                     ulong
lpSecurityDescriptor                        ulong
bInheritHandle                              CML_API_bool
										END
CML_API_ProcessInformation                  GROUP,TYPE
hProcess                                    CML_API_HANDLE
hThread                                     CML_API_HANDLE
dwProcessId                                 CML_API_DWORD
dwThreadId                                  CML_API_DWORD
										END

CML_API_StartupInfo                         GROUP,TYPE
cb                                          CML_API_DWORD
lpReserved                                  ULONG
lpDesktop                                   ULONG
lpTitle                                     ULONG
dwX                                         CML_API_DWORD
dwY                                         CML_API_DWORD
dwXSize                                     CML_API_DWORD
dwYSize                                     CML_API_DWORD
dwXCountChars                               CML_API_DWORD
dwYCountChars                               CML_API_DWORD
dwFillAttribute                             CML_API_DWORD
dwFlags                                     CML_API_DWORD
wShowWindow                                 USHORT
cbReserved2                                 USHORT
lpReserved2                                 ULONG
hStdInput                                   CML_API_HANDLE
hStdOutput                                  CML_API_HANDLE
hStdError                                   CML_API_HANDLE
										END

CML_API_FILETIMEType                        GROUP,TYPE
dwLowDateTime                               CML_API_DWORD
dwHighDateTime                              CML_API_DWORD 
										END

CML_API_SYSTEMTIME                          GROUP,TYPE
wYear                                       USHORT
wMonth                                      USHORT
wDayOfWeek                                  USHORT
wDay                                        USHORT
wHour                                       USHORT
wMinute                                     USHORT
wSecond                                     USHORT
wMilliseconds                               USHORT
										END
CML_API_WIN32_FIND_DATA                     GROUP,TYPE
dwFileAttributes                            ULONG
ftCreationTime                              GROUP(CML_API_FILETIMEType).
ftLastAccessTime                            GROUP(CML_API_FILETIMEType).
ftLastWriteTime                             GROUP(CML_API_FILETIMEType).
nFileSizeHigh                               ULONG
nFileSizeLow                                ULONG
dwReserved0                                 ULONG
dwReserved1                                 ULONG
cFileName                                   CSTRING( FILE:MaxFilePath )
cAlternateFileName                          CSTRING( 14 )
										END
 
!//////////////////////////////////////////////////////////////////////
!                                                                     //
!                Registry API Constants                                //
!                                                                     //
! //////////////////////////////////////////////////////////////////////

CML_API_HKEY_CLASSES_ROOT                   EQUATE(80000000h)
CML_API_HKEY_CURRENT_USER                   EQUATE(80000001h)
CML_API_HKEY_LOCAL_MACHINE                  EQUATE(80000002h)
CML_API_HKEY_USERS                          EQUATE(80000003h)
CML_API_HKEY_PERFORMANCE_DATA               EQUATE(80000004h)
CML_API_HKEY_CURRENT_CONFIG                 EQUATE(80000005h)
CML_API_HKEY_DYN_DATA                       EQUATE(80000006h)

! Reg Create Type Values...
CML_API_REG_OPTION_RESERVED                 EQUATE(0)           ! Parameter is reserved
CML_API_REG_OPTION_NON_VOLATILE             EQUATE(0)       ! Key is preserved when system is rebooted
CML_API_REG_OPTION_VOLATILE                 EQUATE(1)           ! Key is not preserved when system is rebooted
CML_API_REG_OPTION_CREATE_LINK              EQUATE(2)        ! Created key is a symbolic link
CML_API_REG_OPTION_BACKUP_RESTORE           EQUATE(4)     ! open for backup or restore

! Reg Data Types...
CML_API_REG_NONE                            EQUATE(0)                       ! No value type
CML_API_REG_SZ                              EQUATE(1)                         ! Unicode nul terminated string
CML_API_REG_EXPAND_SZ                       EQUATE(2)                  ! Unicode nul terminated string
CML_API_REG_BINARY                          EQUATE(3)                     ! Free form binary
CML_API_REG_DWORD                           EQUATE(4)                      ! 32-bit number
CML_API_REG_DWORD_LITTLE_ENDIAN             EQUATE(4)        ! 32-bit number (same as REG_DWORD)
CML_API_REG_DWORD_BIG_ENDIAN                EQUATE(5)           ! 32-bit number
CML_API_REG_LINK                            EQUATE(6)                       ! Symbolic Link (unicode)
CML_API_REG_MULTI_SZ                        EQUATE(7)                   ! Multiple Unicode strings
CML_API_REG_RESOURCE_LIST                   EQUATE(8)              ! Resource list in the resource map
CML_API_REG_FULL_RESOURCE_DESCRIPTOR        EQUATE(9)   ! Resource list in the hardware description
CML_API_REG_RESOURCE_REQUIREMENTS_LIST      EQUATE(10)
CML_API_REG_CREATED_NEW_KEY                 EQUATE(1h)                      ! New Registry Key created
CML_API_REG_OPENED_EXISTING_KEY             EQUATE(2h)                      ! Existing Key opened
CML_API_REG_WHOLE_HIVE_VOLATILE             EQUATE(1h)                      ! Restore whole hive volatile
CML_API_REG_REFRESH_HIVE                    EQUATE(2h)                      ! Unwind changes to last flush
CML_API_REG_NOTIFY_CHANGE_NAME              EQUATE(1h)                      ! Create or delete (child)
CML_API_REG_NOTIFY_CHANGE_ATTRIBUTES        EQUATE(2h)
CML_API_REG_NOTIFY_CHANGE_LAST_SET          EQUATE(4h)                      ! Time stamp
CML_API_REG_NOTIFY_CHANGE_SECURITY          EQUATE(8h)
CML_API_REG_LEGAL_CHANGE_FILTER             EQUATE(0Fh)
CML_API_REG_LEGAL_OPTION                    EQUATE(7h)

! Reg Key Security Options
CML_API_READ_CONTROL                        EQUATE(20000h)
CML_API_KEY_QUERY_VALUE                     EQUATE(1h)
CML_API_KEY_SET_VALUE                       EQUATE(2h)
CML_API_KEY_CREATE_SUB_KEY                  EQUATE(4h)
CML_API_KEY_ENUMERATE_SUB_KEYS              EQUATE(8h)
CML_API_KEY_NOTIFY                          EQUATE(10h)
CML_API_KEY_CREATE_LINK                     EQUATE(20h)
CML_API_KEY_READ                            EQUATE(20009h)
CML_API_KEY_WRITE                           EQUATE(20009h)
CML_API_KEY_EXECUTE                         EQUATE(CML_API_KEY_READ)
CML_API_KEY_ALL_ACCESS                      EQUATE(CML_API_KEY_WRITE)
CML_API_STANDARD_RIGHTS_READ                EQUATE(CML_API_READ_CONTROL)
CML_API_STANDARD_RIGHTS_WRITE               EQUATE(CML_API_READ_CONTROL)

