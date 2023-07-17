# Extrae example

Make sure to set correct EXTRAE_LIB path inside the Makefile and Kalray tools are in PATH.

To compile

```console
$make
```

To run the example and generate Extrae traces:

```console
$make run
```

To enable multi cluster support these environment variables have been included:

- setenv("EXTRAE_MPPA_ENABLE_MULTIPLE_CLUSTERS","1" , 0): this environment variable specifies that we want to trace multiple clusters. Default value is disabled.
- setenv("EXTRAE_MPPA_CLUSTER_HWC","3" , 0):  this environment variable specifies that we want to trace Hardware Counters in cluster 3. Defualt value is 0.

Due to PAPI and KVX PMC hardware limitation only one cluster can measure hardware counters at a time.
