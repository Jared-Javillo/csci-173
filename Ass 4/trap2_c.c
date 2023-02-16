/*
 * Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
 *                         University Research and Technology
 *                         Corporation.  All rights reserved.
 * Copyright (c) 2006      Cisco Systems, Inc.  All rights reserved.
 *
 * Simple ring test program in C.
 */

#include "mpi.h"
#include <stdio.h>
#include <math.h>

#define f(x) 1/sqrt(1 - pow(x,2))
#define NUM_TRAPEZOIDS 100000
int main(int argc, char *argv[])
{
    int rank, size, next, prev, message, tag = 201;

    float lower = -0.999999;
    float upper =  0.999999;
    float result = 0.0f;
    float k;
    float stepSize = ((upper - lower)/NUM_TRAPEZOIDS);

    /* Start up MPI */

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);		
    
    /* Calculate the rank of the next process in the ring.  Use the
       modulus operator so that the last process "wraps around" to
       rank zero. */

    next = (rank + 1) % size;
    prev = (rank + size - 1) % size;

    /* If we are the "manager" process (i.e., MPI_COMM_WORLD rank 0),
       put the number of times to go around the ring in the
       message. */

    if (0 == rank) {
        message = NUM_TRAPEZOIDS - 1;
	result = f(lower) + f(upper);
        printf("\nProcess 0 sending %d and %f to %d, tag %d (%d processes in ring)\n", 
            message,result, next, tag,size);
        
	MPI_Send(&message, 1, MPI_INT, next, tag, MPI_COMM_WORLD);
	MPI_Send(&result,1, MPI_FLOAT, next, tag, MPI_COMM_WORLD);
        printf("\nProcess 0 sent to %d\n", next);
    }

    /* Pass the message around the ring.  The exit mechanism works as
       follows: the message (a positive integer) is passed around the
       ring.  Each time it passes rank 0, it is decremented.  When
       each processes receives a message containing a 0 value, it
       passes the message on to the next process and then quits.  By
       passing the 0 message first, every process gets the 0 message
       and can quit normally. */

    while (1) {
        MPI_Recv(&message, 1, MPI_INT, prev, tag, MPI_COMM_WORLD,
                 MPI_STATUS_IGNORE);
	MPI_Recv(&result, 1, MPI_FLOAT, prev, tag, MPI_COMM_WORLD,
		 MPI_STATUS_IGNORE);
        if (message > 0 ) {
	    k = lower + (NUM_TRAPEZOIDS - message) * stepSize;
	    result = result + 2 *f(k);
	    --message;
            printf("\nProcess %d decremented value: %d and result is: %f\n",
	        rank ,message,result);
	}

        MPI_Send(&message, 1, MPI_INT, next, tag, MPI_COMM_WORLD);
        MPI_Send(&result, 1, MPI_FLOAT, next, tag, MPI_COMM_WORLD);
        if (0 == message) {
            MPI_Send(&message, 1, MPI_INT, 0, tag, MPI_COMM_WORLD);
	    MPI_Send(&result,1, MPI_FLOAT, 0, tag, MPI_COMM_WORLD);            
	    printf("\nProcess %d exiting\n", rank);
            break;
        } 
    }

    /* The last process does one extra send to process 0, which needs
       to be received before the program can exit */

    if (0 == rank) {
        MPI_Recv(&message, 1, MPI_INT, prev, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
	MPI_Recv(&result, 1, MPI_FLOAT, prev, tag, MPI_COMM_WORLD,
                 MPI_STATUS_IGNORE);
	result = result * stepSize/2;
	printf("\nResult: %f\n", result);    
    }

    /* All done */

    MPI_Finalize();
    return 0;
}
