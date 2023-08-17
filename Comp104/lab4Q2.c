#include<stdio.h>

float average (float arr[ ] , int size);



int main()
{
	int size;
	int i = 0;
	
	printf("Enter array length : \n");
    scanf("%d",&size);
    
    char CharArray[] = {'>', '<', '='};
    float array[size];
    
     printf("Enter array elements:\n");
     for(i = 0; i < size;  i++){
        scanf("%f", &array[i]);
     }
	float Avg = average (array,size);
	printf(" Average of the double-array : %f\n", Avg);
	
	for(i = 0; i < size;  i++){
		if (array[i] > Avg){
			printf("%c", CharArray[0]);
		}else if(array[i] < Avg){
			printf("%c", CharArray[1]);
		
		}else{
			printf("%c", CharArray[2]);
			
		}
	
	}
	
	

	
	
	return 0;
}

float average (float arr[ ], int size){
	float sum = 0.0; 
	int i;
	float avg;
	for(i = 0; i < size; i++){
        
        sum+=arr[i];
	}
	avg = sum/size;
	return avg;
}
