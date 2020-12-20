#include<stdio.h>
#include<stdlib.h>
#include<string.h>

//this function returns the decimal value of a binary string
long long int bin_to_dec(char bin[])
{
	long long int x = 1, result = 0;//x keeps in check the powers of 2 while result stores the decimal value of binary string
	int bin_len = strlen(bin), temp, i;
	char *ptr, bin_copy[bin_len + 1];
	strcpy(bin_copy, bin);//creating a copy of the original string to avoid and changes being done to it
	ptr = bin_copy + bin_len;//pointing ptr to the end of the string bin_copy
	
	//this loop changes each character of bin_copy to integer and then perform corresponding operations, finally storing it in result
	for(i = 0; i < bin_len; i++)
	{
		ptr--;
		temp = atoi(ptr);//taking the substrings of length 1 from back and changing them to integer for operation
		result += temp * x;//updating result 
		x = x * 2;//updating x after each loop
		*ptr = '\0';
	}
	return result;
}

//this function helps in setting the limit(upper bound) to the no. of times a loop should run when taking n characters from a string at a time 
int len_div_n(char arr[], int *ptr, int n)
{
	int len = strlen(arr), limit;
	*ptr = len % n;
	if(*ptr == 0)
		limit = len / n;
	else
		limit = (len / n) + 1;
	return limit;
}

//this function removes the unnecessary number of zeros in a string. For ex if a string is 0001 then it converts it to 1.  
void return_after_zero(char str[])
{
	char *ptr, arr[strlen(str)];
	ptr = str;
	for(int i = 0; i < strlen(str); i++)
	{
		if(str[i] != '0')
		{
			strcpy(arr, ptr);
			break;
		}
		else if(i == (strlen(str) - 1) && *ptr == '0')
		{
			strcpy(arr, ptr);
			break;
		}

		else
			ptr++;
	}
	strcpy(str, arr);
}

//converts binary to octal, finally storing it as a string in octal character array
void bin_to_octal(char bin[], char octal[])
{
	int bin_len = strlen(bin), limit, rem, i, temp;
	char *ptr, bin_copy[bin_len + 1];
	limit = len_div_n(bin, &rem, 3);//setting an upper bound for the following for-loop
	strcpy(bin_copy, bin);//creating a copy of the original string to avoid any changes being done to it
	ptr = bin_copy + bin_len;//pointing ptr to the end of the string bin_copy

	for(i = 0; i < limit; i++)
	{
		//taking 3 characters substring at a time and then perform corresponding operations
		if(i == limit - 1 && rem != 0)
			ptr -= rem;
		else
			ptr -= 3;

		temp = bin_to_dec(ptr);//converting the 3 characters substring to integer using bin_to dec function
		octal[limit - 1 - i] = temp + '0';
		*ptr = '\0';
	}
	octal[limit] = '\0';
	return_after_zero(octal);//removing unnecessary zeros if any
}

//converts binary to hexadecimal, finally storing it as a string in hexadecimal character array
void bin_to_hexadecimal(char bin[], char hexadecimal[])
{
	int bin_len = strlen(bin), limit, rem, i, temp;
	char *ptr, bin_copy[bin_len + 1];
	limit = len_div_n(bin, &rem, 4);//setting an upper bound for the following for-loop
	strcpy(bin_copy, bin);//creating a copy of the original string to avoid any changes being done to it
	ptr = bin_copy + bin_len;//pointing ptr to the end of the string bin_copy
	for(i = 0; i < limit; i++)
	{
		//taking 4 characters substring at a time and then perform corresponding operations
		if(i == limit - 1 && rem != 0)
			ptr -= rem;
		else
			ptr -= 4;

		temp = bin_to_dec(ptr);//converting the 4 characters substring to integer using bin_to dec function
		
		//storing the result in hexadecimal array
		if(temp <= 9)
			hexadecimal[limit - 1 - i] = temp + '0';
		else
			hexadecimal[limit - 1 - i] = temp - 10 + 'A';
		*ptr = '\0';
	}
	hexadecimal[limit] = '\0';
	return_after_zero(hexadecimal);//removing unnecessary zeros if any
}

int main()
{
	long long int result;
	int bin_len;
	scanf("%d", &bin_len);//taking length of binary string as input
	char bin[bin_len + 1], octal[(bin_len / 3) + 5], hexadecimal[(bin_len / 4) + 5];
	scanf("%s", bin);//taking binary string as input
	result = bin_to_dec(bin);//converting binary to decimal
	bin_to_octal(bin, octal);//converting binary to octal
	bin_to_hexadecimal(bin, hexadecimal);//converting binary to hexadecimal
	printf("%lld,%s,%s ", result, octal, hexadecimal);
	return 0;
}