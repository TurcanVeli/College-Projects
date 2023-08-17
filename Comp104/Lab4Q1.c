#include<stdio.h>

int sumofdigits(int n);
int maxsumofdigits(int array[], int (*FindSum)(int), int size);


int main()
{
	int size;
	int i = 0;
	
	printf("Enter array length : \n");
    scanf("%d",&size);
    
    int array[size];
    
    
    srand(time(NULL));
     for(i = 0; i < size;  i++){
     	
        array[i] = rand() % (999 + 1 - 100) + 100;
        printf("%d\n", array[i]);
     }
	int result =  maxsumofdigits(array,sumofdigits,size );
	printf("Max : %d", result);
	return 0;
}

int maxsumofdigits(int array[], int (*FindSum)(int), int size)
{

	int Sumarray[size];
	int i =0 ;
	for(i = 0; i < size;  i++){
       Sumarray[i]  = (*FindSum) (array[i]);
       
     }
     int max= Sumarray[0];
	 for(i = 0; i < size; i++){
		if(Sumarray[i] > max){
            max = Sumarray[i];
        }
	}
	
	return max;
	
}
int sumofdigits(int n)
{
	int Sum = 0, Reminder = 0;
	
	 while(n > 0)
  	{
     Reminder = n % 10;
     Sum = Sum+ Reminder;
     n = n / 10;
  	}
	return Sum;

}
