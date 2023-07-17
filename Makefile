CC = accel-gcc
CFLAGS = -fopenmp
EXTRAE_LIB = -Wl,-L/work1/amurena/extraeMPPA/ins2/lib
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
	./generateTrace.sh $(TARGET)


clean:
	rm -rf $(TARGET) ./set-0 $(TARGET).prv $(TARGET).sym $(TARGET).pcf $(TARGET).row $(TARGET).mpits

