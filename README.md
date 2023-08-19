# ALU

## Description of Design
The ALU is split into a few different modules
1. cla_32 - This module is a 32 bit carry look ahead adder. It takes in two 32 bit inputs and a carry in bit and outputs a 32 bit sum and a carry out bit. It is also comprised of 4 8 bit carry look ahead adders, and the second level helps to compute the carry out bit for 8, 16, 24, and the 32 carry out bits.

2. Or, Not, And - These are the basic logic gates that are used in the ALU. They are all 32 bit modules that take in two 32 bit inputs and output a 32 bit output. they simply perform the desired logic operation on the two inputs for every bit.

3. SLL - This module is a 32 bit shift left logic module. It takes in a 32 bit input and a 5 bit shift amount and outputs a 32 bit output. It simply shifts the input left by the shift amount and fills the empty bits with 0s. This is done by using a cascading fan out system of 32 1 bit shift left logic modules, and is broken into shifts by 16, 8, 4, 2, and 1. The shift amount is used to determine which shift to use.

4. SRA - This module is a 32 bit shift right arithmetic module. It takes in a 32 bit input and a 5 bit shift amount and outputs a 32 bit output. It simply shifts the input right by the shift amount and fills the empty bits with the sign bit. Similar to the cascading fan out system of the SLL module, this is done by using a cascading fan out system of 32 1 bit shift right arithmetic modules, and is broken into shifts by 16, 8, 4, 2, and 1. The shift amount is used to determine which shift to use.

The overall ALU is comprised of these modules as listed above, the modules pre-calculate all the necessary values for the ALU to perform the desired operation, and a mux_8 is used to determine which value is outputted.

### Misc.
1. Subtraction: In order to perform subtraction, the second input is negated and then added to the first input. A mux outputs which value of the second input to use, controlled by the first bit of the ALU Opcode. If the first bit is 0, the second input is used as is, if the first bit is 1, the second input is negated and then used. Finally the output of this mux is sent to the cla_32 module for the intended operation with the carry in bit determined by the first bit of the ALU Opcode. If the first bit is 0, the carry in bit is 0, if the first bit is 1, the carry in bit is 1 to represent the two's complement negation of the second input.
2. isLessThan: In order to determine if the if the first input is less than the second. This is determined by flipping the MSB of the cla result, and then using a ternary, check if the overflow bit is valid, use the flipped version of the MSB as the result, else just use the MSB as the result.
3. isNotEqual: This is simply determined by ORing every bit of the cla_result, if the cla_result is 0, then the two inputs are equal, else they are not equal and the result of the or will return 1 for any 1 bit that results in the subtraction of unique numbers.

# MultDiv

## Description of Design
The MultDiv overall is split into a few different modules. The easiest way To describe my thought process is to maybe go top down

Starting with the MultDiv, we implements a custom module for multiplier and divider, we keep Dflipflops ready to determine if a mult and div operations is being handled right now, these obviously clear when a new signal comes in which interrupts the mult/div modules and restarts them. We simply assign conditions to output the results of the mult div based on ready conditions, data_ready, and any possible excpetions we occur and feed these into a tristate buffer to send to ouput.

### Multiplier
Modified Booths Algorithm is the general idea of how this multiplier is set up.
#### Multiplicand Register
Simply stores b and the result in a reg32, then gets passed to a shifter determined by the control module if we shift or not

#### Control Booth
Control booth is another module made that follows the conditions of modified booths algorithm (different cases for 000 - 111). These then output signals to perform an add, subtract, nothing, or shift as needed.
A keepalive signal is used to determine whether or not to continue the mult operation due to the introduction of a new mult signal or div signal.

#### Counter Logic
The counter logic is used to determine when to stop the mult operation, this is done by keeping track of the number of shifts that have occured, and then stopping when the number of shifts is equal to the number of bits in the multiplicand. Using the tffe logic learned in class, we simply keep track of the bootup, or first cycle, and the data result ready after 16 cycles. This is then used to determine when to stop the mult operation.

#### CLA Adder
ALU logic is used here by assigning the multiplicand shift result from the multiplicand register and the control booth output. This calue is then passed into the B port of a cla_32 adder and the A port takes in the upper 32 bits from the product register (explained later). The result is then fed into the Product Register

#### Product Register
The product register is a 65 bit register that stores the properties and manipulates the product from itself after the shift. It determiens the ProductIn that goes into it based on if we are doing a mult currently and if the control booth returns "nothing" or not. These cases are then stored in product in and fed into the register.
The output of this register is then repassed back into a wire that stores the Product from the 65 bit register after the shift, and detemrines if a shift is needed, only if we are in the middle of a mult operation.
Once the data result is ready based off the counter, we then output the result of the product register to the output of the multiplier through a tristate buffer.
#### Exceptions
Exceptions here are handled as booths does, we check the upper 32 bits from the output product. If they are all 0, then we are good, if they are all 1, then we are good, else we have an overflow exception.
The overall ALU is comprised of these modules as listed above, the modules pre-calculate all the necessary values for the ALU to perform the desired operation, and a mux_8 is used to determine which value is outputted.



### Divider
The divider is a bit more complicated than the multiplier, but I tried to extrapolate as much as the multplier setup as I could, and implemented a different control modules to handle the ternary logic and sign correction.


#### Make Complements Available
The algorithm only works on positive numbers. It is thus important to have the complements available to us by notting a and b and passing them through a cla_32 with a carry in bit to get the 2s complement.
If any of the numbers is negative, use the 2s complement, else use the number as is.

#### Keep Alive
Same logic as the multiplier, keep alive is used to determine whether or not to continue the div operation due to the introduction of a new mult signal or div signal.

#### Counter Logic
Same logic as the multiplier, slightly different to determine if the data is ready as a div operation takes 32-33 cycles instead of 16.

#### Divisor Register
A simple 32 bit register to hold the value of b, and then sign correct it depending on the sign of the output from the quotient register (explained later).

#### CLA Adder
Same kind of logic as the multiplier, pass in the output from the quotient reg upper 32 bits into a, pass in the divisor from the register into b, and then pass the result into the quotient register. A carry in is determined by the sign of the output from the quotient register.

#### Quotient Register
A 64 bit register to store the properties and manipulate the quotient. The output of this register is then repassed back into a wire that stores the Quotient from the 64 bit register after the shift, and detemrines if a shift is needed, only if we are in the middle of a div operation.

#### Quotient Control Logic
This is the kinda complicated part i had issues with, the control quotient followed the non-restoring tree as it handles the attempts from the trial subtraction within it. It takes in the quotientReg input and ouput as well as the claOutputs and the current clock cycles. It then will alter the output of the quotient register based on the and the input to the quotient register. The former is determined by the raw output of the quotient reg bottom 63 bits and the sign bit of the CLAOut. The quotientRegIn is determined by the initial bootup signal. The upper 32 bits by the claOut and the bottom 32 bits by the current clock cycle and the current a value and bottom 32 bits of the quotient after the shift from the 64 bit register.

#### Sign Correction
As mentioned earlier, this algorithm only works on positive numbers. Thus we need to correct the sign of the output. This is done by checking the sign of the output from the quotient register and we do a negation based on the xor of the sign bits from a and b.

#### Output
The output is determined whether or not we have an overflow exception, and if we are in the middle of a div operation. If we are not in the middle of a div operation, we output the result of the quotient register to the output of the divider through a tristate buffer. For some reason, the output of this must be 0 if an exception were to occur based on the tests (its not like that for mult so why...). So If the final answer is ready and there is no error, we output the result from the sign corrected output, else we output 0. This is handled by a sanity check through a tri-state buffer determined by if the dataResult is ready (33 cycles).

#### Exceptions
Pretty simple, just check if b is 0, because we cant divide by 0

# RegFile

## Description of Design
The Breakdown of the design is as follows:
1. The register32 module takes in 32 dffe modules and pipes them to the output bit. The inputs to this register32 is in, clock, enable, and a reset. The reset is used to reset the register to 0, the enable is used to enable the register, and the clock is used to clock the register. The in is used to set the value of the register, and the output is the value of the register. This is used to store the values of the input into the registers.
2. The decoder takes in a 4 bit select and 1 bit enable and ouputs 32 bits, calculated by shifting the enable bit to the left by the number of select bits. This is used to determine which register to read from.
3. The tristate butter takes in a 32 bit input, a 32 bit output, and a 32 bit enable. The enable is used to determine if the output is the input or the output of the register. This is used to determine if the output of the register is used or the input is used.
   
RegFile Logic:
The overall regfile logic is as follows:
1. the input is read into the register32 module
2. a decoder determines if a write is to be done and on which module
3. a set of and gates determines if a write enable is active and which module is selected to be written to
4. the registers take in the data from the data_writeReg which is only saved in the register if determined by the output of 3. it saves the output of registers into individual wires to be used in the next stage
5. two decoders, corresponding to RS1 and RS2, determine which register to read from
6. a set of tristate buffers halts the output of the register, and only lets the data be written to the RS1Out and RS2Out if enabled by the output of the decoder from 5.




