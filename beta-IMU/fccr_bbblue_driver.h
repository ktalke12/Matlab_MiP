/* Copyright 2017 The MathWorks, Inc. */

#ifndef FCCR_DRIVER_BBBLUE_H
#define FCCR_DRIVER_BBBLUE_H

#if ( defined(MATLAB_MEX_FILE) || defined(RSIM_PARAMETER_LOADING) ||  defined(RSIM_WITH_SL_SOLVER) )
/* This will be run in Rapid Accelerator Mode */

/* IMU */
#define fccr_initialize_imu() (0)
#define fccr_read_accel_x() (0)
#define fccr_read_accel_y() (0)
#define fccr_read_accel_z() (0)
#define fccr_read_gyro_x() (0)
#define fccr_read_gyro_y() (0)
#define fccr_read_gyro_z() (0)
#define rc_mpu_power_off() (0)

/* Barometer */
// #define rc_bmp_init(a,b) (0)
// #define rc_bmp_power_off() (0)
// #define rc_bmp_read() (0)

#else

#include "roboticscape.h"
#include "rtwtypes.h"

/* IMU */
int fccr_initialize_imu();
float fccr_read_accel_x();
float fccr_read_accel_y();
float fccr_read_accel_z();
float fccr_read_gyro_x();
float fccr_read_gyro_y();
float fccr_read_gyro_z();
extern int rc_mpu_power_off() ;

/* Barometer */
// extern int rc_bmp_init(rc_bmp_oversample_t oversample, rc_bmp_filter_t filter);
// extern int rc_bmp_power_off();
// extern int rc_bmp_read();

#endif

#endif
