CC = accel-gcc
CFLAGS = -fopenmp
EXTRAE_LIB = 
EXTRAE_MPI2PRV = 

WRAP_SYMBOLS = -Wl,--wrap=GOMP_parallel
LD_FLAGS = $(EXTRAE_LIB) -l:libomptrace.a $(WRAP_SYMBOLS) -Wl,--allow-multiple-definition
TARGET = example
SRC = example.c

all: $(TARGET)
.PHONY: run

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -foffload="$(LD_FLAGS)" $^ -o $@

run: $(TARGET)
	./$(TARGET)
	./generateTrace.sh $(TARGET) $(EXTRAE_MPI2PRV)


clean:
	rm -rf $(TARGET) ./set-0 $(TARGET).prv $(TARGET).sym $(TARGET).pcf $(TARGET).row $(TARGET).mpits

