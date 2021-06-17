#include <stdio.h>

#include <conio.h>

#include <iostream>

extern "C"

{

	void FileWriting(char* fileName, char* fileText, int length);

	char* FileReading(char* diskName, int shift);

}

using namespace std;

int main()

{
	char diskName[] = "\\\\.\\PhysicalDrive0";
	char fileName[] = "report.txt";
	char* mbr = new char[512];
	char* gpt = new char[512];

	mbr = FileReading(diskName, 0);
	for (int i = 0; i < 512; i++)

	{
		printf(" %08X ", *mbr);
		mbr++;
	}

	printf("\n\n");
	gpt = FileReading(diskName, 512);

	for (int i = 0; i < 512; i++)
	{
		printf("%c", *gpt);
		gpt++;
	}
	return 0;
}