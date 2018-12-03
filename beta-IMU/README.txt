README.TXT

To test the FCCR BeagleBone Blue driver blocks, perform the following tasks

1) Install R2018b MATLAB (or newer if available) and Simulink. Make sure to Install Embedded coder.
2) Install Simulink Coder Support Package for BeagleBone Blue Hardware.
3) Upon Installing the BBBlue support package, execute the following command in the MATLAB command prompt to get the location of the support package.
	>> location = codertarget.bbblue.internal.getSpPkgRootDir
4) cd to 'location'
5) copy the following files
	1) Add the contents of +beagleboneblue folder to 'location/+beagleboneblue'
	2) Copy the .h files to 'location/include'
	3) Copy the .c files to 'location/src'
6) In the MATLAB command line execute
	>> rehash toolboxcache
7) To view the Mathworks bbblue library blocks, type 'beaglebonebluelib' in command line to open the lib.
8) To use the blocks, create a simulink model for BeagleBone Blue, provide the IP address, Username and Password of your BeagleBone Blue.
9) Add the required blocks from +beagleboneblue by creating a MATLAB System and filling in System object name with the block name from +beagleboneblue.
10) Press Deploy to hardware to get the model built and downloaded onto you BeagleBone Blue.
11) Try the provided test_models.
