/*******************************************************************************
* fccr_imu.c
*
* This serves as an example of how to read the IMU with direct reads to the
* sensor registers.
*******************************************************************************/

#include "MW_bbblue_driver.h"
#include "fccr_bbblue_driver.h"
#include <stddef.h>

rc_mpu_data_t data; //struct to hold new data
rc_mpu_config_t conf;

int fccr_initialize_imu(){
	//rc_imu_data_t data; //struct to hold new data

	// use defaults for now, except also enable magnetometer.
	conf = rc_mpu_default_config();

	rc_mpu_initialize(&data, conf);
}

float fccr_read_accel_x(){
	rc_mpu_read_accel(&data);
	return data.accel[0];
}

float fccr_read_accel_y(){
	//rc_read_accel_data(&data);
	return data.accel[1];
}

float fccr_read_accel_z(){
	//rc_read_accel_data(&data);
	return data.accel[2];
}

float fccr_read_gyro_x(){
	rc_mpu_read_gyro(&data);
	return data.gyro[0];
}

float fccr_read_gyro_y(){
	//rc_read_gyro_data(&data);
	return data.gyro[1];
}

float fccr_read_gyro_z(){
	//rc_read_gyro_data(&data);
	return data.gyro[2];
}
