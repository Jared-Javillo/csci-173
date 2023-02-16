//Source: https://rookiehpc.org/mpi/docs/mpi_comm_spawn/index.html
#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>


int main(int argc, char* argv[])
{
    setbuf(stdout,NULL);
    int rank, result;
    int value = 1;
    MPI_Init(&argc, &argv);
	
    MPI_Comm parent;
    MPI_Comm_get_parent(&parent);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    if(parent == MPI_COMM_NULL)
    {
	result = 0;
        MPI_Comm child;
        int spawn_error, spawnCount;

        printf("We are processes spawned directly by you, we now spawn a new instance of an MPI application.\n");
	printf("How many should I spawn: ");
	scanf("%d", &spawnCount);

        MPI_Comm_spawn(argv[0], MPI_ARGV_NULL, spawnCount, MPI_INFO_NULL, 0, MPI_COMM_WORLD, &child, &spawn_error);
	
    }
    else
    {
        // We have been spawned by another MPI process
        printf("\nI have been spawned by MPI processes.\n");
	//MPI_Reduce(&value, &result, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
    }

    MPI_Reduce(&value, &result, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);	
    
    if(rank == 0 )
    {
	printf("result is: %d", result);
    }
    
    MPI_Finalize();

    return EXIT_SUCCESS;
}

