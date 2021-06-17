.686
.model flat, C
option casemap : none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
includelib kernel32.lib

BUFFER_SIZE = 512

.data
hndFile DWORD ?
bytesWritten DWORD ?
bytesRead DWORD ?
buffer DWORD BUFFER_SIZE DUP (' '), 0 ; αστεπ
.code

FileWriting Proc C fName: DWORD, fText: DWORD, textLen: DWORD
mov eax, fName
invoke CreateFile, eax, GENERIC_WRITE, NULL, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
mov hndFile, eax
mov ebx, fText
invoke WriteFile, hndFile, ebx, textLen, ADDR bytesWritten, 0
invoke CloseHandle, hndFile
RET

FileWriting EndP
FileReading Proc C diskName: DWORD, shift: DWORD
mov eax, diskName
invoke CreateFile, eax, GENERIC_READ, FILE_SHARE_READ+FILE_SHARE_WRITE, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
mov hndFile, eax
invoke SetFilePointer, hndFile, shift, 0, FILE_BEGIN
invoke ReadFile, hndFile, ADDR buffer, BUFFER_SIZE, ADDR bytesRead, 0
invoke CloseHandle, hndFile
mov eax, offset buffer
RET
FileReading EndP
END