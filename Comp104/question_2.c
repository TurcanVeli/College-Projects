#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#define MAX 4
#include <stdbool.h>
int main() {
	
	srand(time(NULL));
	int KEYNUMBER = rand() % (9999 + 1 - 1000) + 1000; //Generate random numebers between 1000-9999.

	char KEYNUMBERarray[MAX];//MAX defined begining of code. 
	bool control = false;//when we find actual key number, control will be true and while loop ends.
	while (true){
		
	
    	int  r;
		sprintf((char*)KEYNUMBERarray,"%u",KEYNUMBER);//keynumber integer value's digits adding to KEYNUMBERarray 
    	
		if (control == true){
			break;
			}
		int i,j;
		for (i = 0; i<4; i++){
			for (j = i+1; j<4; j++){
				if (KEYNUMBERarray[i] == KEYNUMBERarray[j]){ //if there are same digits, generate new number. 
					srand(time(NULL));
					KEYNUMBER = rand() % (9999 + 1 - 1000) + 1000;
					char KEYNUMBERarray[MAX];
					control = false;
					break;
					
				}else {
					control = true;
					}
			}
			if (control == false){
				break;
			}
		}
	
	}
	
	printf("Key Number :");
	int c;
	for ( c = 0; c < 4; c++){
		printf("%c", KEYNUMBERarray[c]);
	}
	printf("\n");

	int i = 0;
	while (i < 4){
	
	int userNUMBER;
	char userNumberArray[4];
	i = 0;
	printf("What is your answer : ");
	scanf("%d", &userNUMBER); 
	int digit =  floor (log10 (abs (userNUMBER))) + 1;//determining the number of digits entered by the user
	// digits count is different from 4, ERROR.
	if (digit != 4){
		printf("%s","error");
	}
	else{
		sprintf((char*)userNumberArray,"%u",userNUMBER); //usernumber integer value's digits adding to userNumberArray
		
		//below codes, I am controlling digits by index and if they are equal then printing +, otherwise -.
		if (userNumberArray[0] == KEYNUMBERarray[0]){
			i++;
			printf("+");
			}else{
				printf("-");
			}
			
		if (userNumberArray[1] == KEYNUMBERarray[1]){
			i++;
			printf("+");
			
			}else{
				printf("-");
			}
		if (userNumberArray[2] == KEYNUMBERarray[2]){
			i++;
			printf("+");
			}else{
				printf("-");
			}
		if (userNumberArray[3] == KEYNUMBERarray[3]){
			i++;
			printf("+");
			}else{
				printf("-\n");
			}
		
		printf("\n");
		}
		
	
	}
		


	

	return 0;
}
