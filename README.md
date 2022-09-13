# Alarm-Clock-on-FPGA
The simple alarm clock is shown in the following figure. The alarm clock outputs a real-time clock with a 24-hour format and also provides an alarm feature. Users also can set the clock time through switches. 

# Introduction:-
The purpose of this design is to include the Verilog language
into the creation of a straightforward digital alarm clock
mechanism.
With this particular digital clock implementation,
you may reset the time, set an alarm for a given time, and also
stop the alarm when it goes off.

# Block Diagram for Alarm Clock
A module called aclock uses the suggested design as its
implementation. The clock offers the following options: reset
using the reset input, set time - using LD time input, set an
alarm – using LD alarm input, signal to call alarm – using
AL ON input, stop the alarm – using STOP al input. Features
of the Clock- Alarm – Goes to high if alarm time equals current time, H out1 – Most significant digit of hours, H out0
– Least significant digit of hours, M out1 – Most significant
digit of minutes, M out0 – Least significant digit of minutes,
S out1 – Most significant digit of seconds, S out0 – Least
significant digit of seconds.


![Block Diagram](https://user-images.githubusercontent.com/100370090/183949671-76d2c1e5-6aa6-401f-98a2-7602aa75eacc.png)

The hours, minutes, and seconds
from reset/set are tracked by a series of count variables, whose
values are continuously read by the output variables in an
always loop to keep the time updated. The testbench creates a
clock variable with a 10 Hz frequency to keep time. In order
for the temporary variables to keep up with the passing of time,
this clock updates the 1-second clock. By routinely monitoring
the AL ON input and setting the Alarm register high if it is
high, the alarm functionality is satisfied. Additionally, the alert
is deactivated if the system afterwards receives the STOP al
signal. This code is run and tested using the Icarus Verilog
compiler and the plots w.r.t time are obtained using GTKWave


# Instructions for Tool Installation
## IcarusVerilog and GTKWave
### For Ubuntu

```
$   sudo apt-get update
$   sudo apt-get install iverilog gtkwave

```
## Instructions to run
```
$   sudo apt install -y git
$   git clone (https://github.com/PrabalMahajan11/iiitb_clockfpga)
$   cd iiitb_clockfpga
$   iverilog iiitb_clockfpga.v iiitb_clockfpga_tb.v
$   ./a.out
$   gtkwave test.vcd
```


# Functional Charateristics 

An Under Unit Test (UUT) is created in the testbench file,
and variables for input and output are given to the test module.
The frequency of the clock variable is 10 Hz. The test is
conducted as follows: The time is initially set to 10: 14. An
alarm is set for the time 10: 20 after 1 second. The alarm
sounds at the predetermined time of 10:20, as seen in figure
2. The clock is then reset to 04:45 and the alarm is turned
off after 1 second. Another alarm is then set for 04:55, and it
goes off as planned.

![Graph 1](https://user-images.githubusercontent.com/100370090/187265025-ee01baf9-0665-4490-b308-d6e12d953cfd.png)



# Synthesis of Verilog
Synthesis is a process by which an abstract specification of desired circuit behavior, typically at register transfer level (RTL), is turned into a design implementation in terms of logic gates, typically by a computer program called a synthesis tool. The program we use is called Yosys.

## About Yosys
Yosys is an open-source Verilog synthesis framework. It presently offers a fundamental set of synthesis algorithms for numerous application domains and has extensive Verilog-2005 support. By combining the existing passes (algorithms) using synthesis scripts and adding other passes as necessary by extending the Yosys C++ code base, Yosys may be modified to carry out any synthesis job.

To install Yosys, follow the instructions given in the refered GitHub repository: https://github.com/YosysHQ/yosys

## Instructions for Synthesis 
Create a Yosys script yosys_run.sh in the cloned /iiitb_clockfpga directory and type in the following code into it:

```
# read design

read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog iiitb_clockfpga.v

# generic synthesis
synth -top iiitb_clockfpga

# mapping to mycells.lib
dfflibmap -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib

clean
flatten

# write synthesized design
write_verilog -noattr iiitb_clockfpga_synth.v

stat
show

```

Then run the above script by typing the following command into the terminal:

```
$  yosys -s yosys_run.sh
```

As the schematic is very detailed no image could be included to represent it accurately, therefore, the file output.dot is provided along with the code and can be viewed with the Dot Viewer.


# Gate Level Simulation (GLS)

Gate level Simulation(GLS) is done at the late level of Design cycle. This is run after the RTL code is synthesized into Netlist. Netlist is translation from RTL into Gates and connection wirings with full functional and timing behaviour.

Run the following commands in the terminal to do a gate level simulation of the design:

```
$ iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 ./verilog_model/primitives.v ./verilog_model/sky130_fd_sc_hd.v iiitb_clockfpga_synth.v iiitb_clockfpga_tb.v
$ ./a.out
$ gtkwave test.vcd

```

![Graph 2](https://user-images.githubusercontent.com/100370090/187267277-bfbcd180-8f50-413e-a874-0ad739152142.png)


# Process of Layout begins from here.

## Python Installation 
```
$   sudo apt install -y build-essential python3 python3-venv python3-pip

```

## Docker Installation
~~~
$   sudo apt-get update

$   sudo apt-get install docker docker-compose

$   sudo systemctl start docker

$   sudo docker run hello-world

~~~

If docker is successfully installed, you will get a sucess message here
![1](https://user-images.githubusercontent.com/100370090/189886080-5e0db723-dcbb-4bba-9463-89abdf9ff7dc.png)

## OpenLane Installation

OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

To run this design as per screenshots go to your design folder and perform the cloning process, else go to home directory and perform the commands nothing will change except the paths in the magic commandline.

~~~
$   git clone https://github.com/The-OpenROAD-Project/OpenLane.git

$   cd OpenLane/

$   make

$   make test

~~~

After 43 steps, if it ended with saying Basic test passed then open lane installed successfully

![2](https://user-images.githubusercontent.com/100370090/189886636-c772031a-d10c-41c7-8d67-f2bfdabf2e24.png)


## Magic Installation

We need to download few softwares first in order for magic to be installed and work properly.

~~~
$   sudo apt-get install m4 

$   sudo apt-get install tcsh

$   sudo apt-get install csh

$   sudo apt-get install libx11-dev

$   sudo apt-get install tcl-dev tk-dev

$   sudo apt-get install libcairo2-dev

$   sudo apt-get install mesa-common-dev libglu1-mesa-dev

$   sudo apt-get install libncurses-dev

~~~

Installng Magic now

```
$   git clone https://github.com/RTimothyEdwards/magic

$   cd magic

$   ./configure

$   make

$   make install
```











# Contributors
* Prabal Mahajan
* Kunal Ghosh


# Acknowledgment
* Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.


# Contact Information 
* Prabal Mahajan (IMT2020514) . International Institute of Information Technology, Bangalore . Prabal.Mahajan@iiitb.ac.in
* Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com

# References

https://www.fpga4student.com/2016/11/verilog-code-for-alarm-clock-on-fpga.html

