#include <stdio.h>
#include <stdlib.h>

void externalCall() __attribute__((weak));
void prueba() __attribute__((weak));
void Extrae_init() __attribute__((weak));
void Extrae_fini() __attribute__((weak));
int mppa_cos_get_thread_id() __attribute__((weak));

void initExtrae(){
        setenv("EXTRAE___GOMP_version","4.5",0);
        setenv("EXTRAE_ON","1" , 0);
        setenv("EXTRAE_FINAL_DIR","." , 0);
        /*MPPA Env Variables*/
        // Support multi cluster mode
        setenv("EXTRAE_MPPA_ENABLE_MULTIPLE_CLUSTERS","1" , 0);
        // Trace HWC in cluster 3
	setenv("EXTRAE_MPPA_CLUSTER_HWC","3" , 0);

        setenv("EXTRAE_BUFFER_SIZE","100000" , 0);
        setenv("EXTRAE_PROGRAM_NAME","example" , 0);
        setenv("EXTRAE_TRACE_TYPE","Paraver" , 0);
        setenv("EXTRAE_OMP_COUNTERS_ON","1" , 0);
        setenv("EXTRAE_COUNTERS","PAPI_TOT_INS, PAPI_TOT_CYC", 0);
        setenv("EXTRAE_OPENMP_HELPERS","1000", 0);
        Extrae_init();
}


int main(){
	int a,b,c;
	#pragma omp target
	{
		initExtrae();
                #pragma omp parallel num_threads(4)
                printf("TID 0 %d \n", mppa_cos_get_thread_id());	}

	#pragma omp target nowait depend(out:a)
	{
                #pragma omp parallel num_threads(8)
                printf("TID 1 %d \n", mppa_cos_get_thread_id());
	}

        #pragma omp target nowait depend(out:b)
        {
                #pragma omp parallel num_threads(12)
                printf("TID 2 %d \n", mppa_cos_get_thread_id());
        }

	#pragma omp target nowait depend(out:c)
        {
                #pragma omp parallel num_threads(16)
                printf("TID 3 %d \n", mppa_cos_get_thread_id());
        }
	#pragma omp target nowait depend(in:a,b,c)
	{
		Extrae_fini();
	}

        //Wait for all tasks to finish!
        #pragma omp taskwait
	return 0;
}
