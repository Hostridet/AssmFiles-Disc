#include <stdio.h>
#include <conio.h>
#include <iostream>

extern "C"
{
	void FileWriting(char* fileName, char* fileText, int length);
	char* FileReading(char* fileName);
}

using namespace std;

int main()
{
	char fileName[] = "report.txt";
	cout << "Input the text:\n";
	char* fileText = new char[512];
	cin.getline(fileText, 512);
	FileWriting(fileName, fileText, strlen(fileText));
	cout << FileReading(fileName) << "\n";

	return 0;
}
