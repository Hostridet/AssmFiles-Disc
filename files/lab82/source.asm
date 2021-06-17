.686
.model flat, C
option casemap : none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc

includelib kernel32.lib

BUFFER_SIZE = 512

.data
hndFile			DWORD ?
bytesWritten	DWORD ?
bytesRead		DWORD ?
buffer			DWORD BUFFER_SIZE DUP (' '), 0	; буфер

.code
FileWriting Proc C fName: DWORD, fText: DWORD, textLen: DWORD
	mov eax, fName
	invoke CreateFile, eax, GENERIC_WRITE, NULL, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
	mov hndFile, eax
	
	invoke SetFilePointer, hndFile, 0, 0, FILE_END

	mov ebx, fText
	invoke WriteFile, hndFile, ebx, textLen, ADDR bytesWritten, 0
	invoke CloseHandle, hndFile	; Закрываем файл с дескриптором
	RET
FileWriting EndP

FileReading Proc C fName: DWORD
	mov eax, fName
	invoke CreateFile, eax, GENERIC_READ, NULL, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
	mov hndFile, eax
	invoke ReadFile, hndFile, ADDR buffer, BUFFER_SIZE, ADDR bytesRead, 0
	invoke CloseHandle, hndFile

	mov eax, offset buffer
	RET
FileReading EndP

END
