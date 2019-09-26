#define _CRT_SECURE_NO_WARNINGS  
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

FILE *in, *out;
char inChar[200] = "\0";
char word[6] = "\0";
char temp;

int inCharLength;
int currentPosition = 0;
int currentWord = 0;
char outWord[33] = "\0";
char outNumber[23] = "\0";
int outNumberLength = 0;
int line = 1;

char* changeToByte(int totalNum)
{
	while (!isdigit(inChar[currentPosition]))
	{
		currentPosition++;
	}
	while (isdigit(inChar[currentPosition]))
	{
		outNumber[outNumberLength++] = inChar[currentPosition++];
	}
	int num = atoi(outNumber);
	char* num2 = (char *)calloc(totalNum + 1, sizeof(char));
	_itoa(num, num2, 2);
	int num2Len = strlen(num2);
	char* outnum = (char *)calloc(totalNum + 1, sizeof(char));
	//sprintf(outnum, "%05s", num2);
	memset(outnum, '0', totalNum);
	for (int i = 1; i <= num2Len; i++)
	{
		outnum[totalNum - 1 + i - num2Len] = num2[i - 1];
	}
	memset(outNumber, 0, sizeof(outNumber));
	outNumberLength = 0;
	return outnum;
}

void outPut()
{
	printf("%s\n", outWord);
	char outChar[14] = "\0";
	strcat(outChar, "32'h");
	for (int i = 0; i <= 7; i++)
	{
		char store[5] = "\0";
		memcpy(store, outWord + 4 * i, 4);
		int total = 0;
		for (int j = 0; j < 4; j++)
		{
			total += int(store[3 - j] - '0') * (int)pow(2, j);
		}
		sprintf(store, "%x", total);
		strcat(outChar, store);
	}
	strcat(outChar, ";");
	fputs(outChar, out);
	fputc('\n', out);
	memset(word, 0, sizeof(word));
	memset(outWord, 0, sizeof(outWord));
	currentWord = 0;
	while (inChar[currentPosition] != '\n' && currentPosition < inCharLength)
	{
		currentPosition++;
	}
}

void RInstruction()
{
	strcat(outWord, changeToByte(5));
	strcat(outWord, changeToByte(5));
	strcat(outWord, changeToByte(5));
	outPut();
}

void LogicInstruction()
{
	char store1[6] = "\0";
	char store2[6] = "\0";
	char store3[6] = "\0";
	strcat(store1, changeToByte(5));
	strcat(store2, changeToByte(5));
	strcat(store3, changeToByte(5));
	strcat(outWord, store3);
	strcat(outWord, store1);
	strcat(outWord, "00000");
	strcat(outWord, store2);
	outPut();
}

void IInstruction()
{
	char store1[6] = "\0";
	char store2[6] = "\0";
	char store3[17] = "\0";
	strcat(store1, changeToByte(5));
	strcat(store2, changeToByte(5));
	strcat(store3, changeToByte(16));
	strcat(outWord, store3);
	strcat(outWord, store2);
	strcat(outWord, store1);
	outPut();
}

void LSInstruction()
{
	char store1[6] = "\0";
	char store2[17] = "\0";
	char store3[6] = "\0";
	strcat(store1, changeToByte(5));
	strcat(store2, changeToByte(16));
	strcat(store3, changeToByte(5));
	strcat(outWord, store2);
	strcat(outWord, store3);
	strcat(outWord, store1);
	outPut();
}

void JInstruction()
{
	strcat(outWord, changeToByte(26));
	outPut();
}

int main()
{
	in = fopen("C:\\Users\\Administrator\\Desktop\\系统结构汇编器\\Test.txt", "r");
	out = fopen("C:\\Users\\Administrator\\Desktop\\系统结构汇编器\\TestOut.txt", "w+");
	for (int i = 0; i < 300; i++)
	{
		char temp = fgetc(in);
		if (temp != EOF)
		{
			inCharLength++;
			inChar[i] = temp;
		}
		else break;
	}
	fclose(in);
	while (currentPosition < inCharLength)
	{
		if (isalpha(inChar[currentPosition]))
		{
			while (isalpha(inChar[currentPosition]))
			{
				word[currentWord++] = inChar[currentPosition++];
			}
			if (strcmp(word, "add") == 0)
			{
				strcat(outWord, "00000000000100000");
				RInstruction();
			}
			else if (strcmp(word, "and") == 0)
			{
				strcat(outWord, "00000100000100000");
				RInstruction();
			}
			else if (strcmp(word, "or") == 0)
			{
				strcat(outWord, "00000100001000000");
				RInstruction();
			}
			else if (strcmp(word, "xor") == 0)
			{
				strcat(outWord, "00000100010000000");
				RInstruction();
			}
			else if (strcmp(word, "sra") == 0)
			{
				strcat(outWord, "000010000001");
				LogicInstruction();
			}
			else if (strcmp(word, "srl") == 0)
			{
				strcat(outWord, "000010000010");
				LogicInstruction();
			}
			else if (strcmp(word, "sll") == 0)
			{
				strcat(outWord, "000010000011");
				LogicInstruction();
			}
			else if (strcmp(word, "addi") == 0)
			{
				strcat(outWord, "000101");
				IInstruction();
			}
			else if (strcmp(word, "andi") == 0)
			{
				strcat(outWord, "001001");
				IInstruction();
			}
			else if (strcmp(word, "ori") == 0)
			{
				strcat(outWord, "001010");
				IInstruction();
			}
			else if (strcmp(word, "xori") == 0)
			{
				strcat(outWord, "001100");
				IInstruction();
			}
			else if (strcmp(word, "load") == 0)
			{
				strcat(outWord, "001101");
				LSInstruction();
			}
			else if (strcmp(word, "store") == 0)
			{
				strcat(outWord, "001110");
				LSInstruction();
			}
			else if (strcmp(word, "beq") == 0)
			{
				strcat(outWord, "001111");
				IInstruction();
			}
			else if (strcmp(word, "bne") == 0)
			{
				strcat(outWord, "010000");
				IInstruction();
			}
			else if (strcmp(word, "jump") == 0)
			{
				strcat(outWord, "010010");
				JInstruction();
			}
		}
		else if (inChar[currentPosition] == '\n')
		{
			currentPosition++;
			line++;
		}
	}
	getchar();
	return 0;
}