#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//I defined two methods, first one is area equation, second one is Golden Search algorithm.
double area(double x);
double gss(double (*f)(double));

int main ()
{	
	printf("Large area is : %f", gss(area));
	return 0;
}

double gss(double (*area)(double)){
	double x1, x2; //
	double Xlower = 0; //Lower Boundry
	double Xupper = 2;  // Upper Boundry
	double GoldenSection = 0.5 * (sqrt(5) - 1) ; //Golden Section equation
	
	//we compute area of xLower and Xupper and store at F1 and F2 values
	double F1 = (*area)(Xlower);
	double F2 = (*area)(Xupper);

	while(F1 != F2)//if F1 != F2, while loop will work
	{
	
		x1 = Xlower + GoldenSection*(Xupper-Xlower);//Xlower - d. d comes from GoldenSection*(Xupper-Xlower)
		x2 = Xupper - GoldenSection*(Xupper-Xlower);	
			
	
		if (F1 > F2) //to find maximum area, we have to write F1 > F2
		{
			Xupper = x1; //exchange values and compute new area
			F2 = (*area)(Xupper);	
		}
		
		else
		{
			Xlower = x2;
			F1 = (*area)(Xlower);
		}
		
	}
	
	return F1;

	
}
double area(double x){
	return (2 + x) * sqrt(1 - (x * x) / 4) * 3;
}
