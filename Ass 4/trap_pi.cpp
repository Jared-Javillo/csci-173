#include <iostream>
#include <math.h>
#include "mpi.h"

/* Define function here */
#define f(x) 1/sqrt(1-x*x))

using namespace std;
int main(int argc, char *argv[])
{
    //Source: https://www.codesansar.com/numerical-methods/trapezoidal-rule-cpp-output.html

    float lowerLimit = -0.999999; 
    float upperLimit = 0.999999; 
    float result, trapezoidWidth, trapezoidID = 1, k;

    int trapezoidCount, next, prev, rank, size, tag = 201;
    

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    next = (rank + 1) % size;
    prev = (rank + size - 1) % size;
    
    if (0 == rank) {
        cout << "Enter number of Steps: ";
        cin >> trapezoidCount;
        trapezoidWidth = (upperLimit - lowerLimit)/trapezoidCount;
        result = f(lowerLimit) + f(upperLimit);

        printf("Process 0 sending %d to %d, tag %d (%d processes in ring)\n", result, next, tag,
                size);
        MPI_Send(&trapezoidID, 1, MPI_INT, next, tag, MPI_COMM_WORLD);
        MPI_Send(&result, 1, MPI_FLOAT, next, tag, MPI_COMM_WORLD);
        printf("Process 0 sent to %d\n", next);
    }

    while (1)
    {
        MPI_Recv(&trapezoidID, 1, MPI_INT, next, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(&result, 1, MPI_FLOAT, next, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

        if (trapezoidID < trapezoidCount)
        {
            trapezoidID++;
            float k = lowerLimit + trapezoidID * trapezoidWidth;
            result = result + 2 * (f(k));
        }

        if (trapezoidID >= trapezoidCount)
        {
            MPI_Send(&trapezoidID, 1, MPI_INT, next, tag, MPI_COMM_WORLD);
            MPI_Send(&result, 1, MPI_FLOAT, next, tag, MPI_COMM_WORLD);
            printf("Process %d exiting\n", rank);
            break;
        }
    }

    if (0 == rank) {
        MPI_Recv(&trapezoidID, 1, MPI_INT, next, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(&result, 1, MPI_FLOAT, next, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        result = result * trapezoidWidth/2;

        cout<< endl<<"Result is: "<< result;
    }
    
    MPI_Finalize();
    return 0;
}