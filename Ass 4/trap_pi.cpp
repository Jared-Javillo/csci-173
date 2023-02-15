#include<iostream>
#include<math.h>

/* Define function here */
#define f(x) 1/sqrt(1-pow(x,2))

using namespace std;
int main()
{
//Source: https://www.codesansar.com/numerical-methods/trapezoidal-rule-cpp-output.html

 float lowerLimit = -0.999999; 
 float upperLimit = 0.999999; 
 float result, trapezoidWidth, k;

 int i, trapezoidCount;

 cout<<"Enter number of Steps: ";
 cin>>trapezoidCount;

 trapezoidWidth = (upperLimit - lowerLimit)/trapezoidCount;

 result = f(lowerLimit) + f(upperLimit);

 for(i=1; i < trapezoidCount; i++)
 {
  k = lowerLimit + i * trapezoidWidth;
  result = result + 2 * (f(k));
 }

 result = result * trapezoidWidth/2;

 cout<< endl<<"Result is: "<< result;

 return 0;
}