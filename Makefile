FILES = main.o adc.o eeprom.o gpio.o i2c.o spi.o uart.o 
INCLUDE = include/
MCU = atmega32


all:

test_target:
	avrdude -p m32 -c usbasp

flash: main.hex
	avrdude -p m32 -c usbasp -U flash:w:full.hex:i

main.hex: $(FILES)
	avr-ld  $(FILES) -o full.o
	avr-objcopy -j .text -j .data -O ihex full.o full.hex
	rm *.o
	
# main file
main.o: main.c
	avr-gcc -c $^ -o $@ -mmcu=$(MCU) -O0 -I $(INCLUDE) 
# port modules
adc.o: src/adc.c
	avr-gcc -c $^ -o $@ -mmcu=$(MCU) -O0 -I $(INCLUDE) 

eeprom.o: src/eeprom.c
	avr-gcc -c $^ -o $@ -mmcu=$(MCU) -O0 -I $(INCLUDE) 

gpio.o: src/gpio.c
	avr-gcc -c $^ -o $@ -mmcu=$(MCU) -O0 -I $(INCLUDE) 

i2c.o: src/i2c.c
	avr-gcc -c $^ -o $@ -mmcu=$(MCU) -O0 -I $(INCLUDE) 

spi.o: src/spi.c
	avr-gcc -c $^ -o $@ -mmcu=$(MCU) -O0 -I $(INCLUDE) 

uart.o: src/uart.c
	avr-gcc -c $^ -o $@ -mmcu=$(MCU) -O0 -I $(INCLUDE) 
## TODO : Timer Module

.Phony: clean

clean:
	rm full.o 
	rm full.hex