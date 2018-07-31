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
#define rc_power_off_imu() (0)

/* Barometer */
#define rc_initialize_barometer(a,b) (0)
#define rc_power_off_barometer() (0)
#define rc_read_barometer() (0)
#define rc_bmp_get_temperature() (0)
#define rc_bmp_get_pressure_pa() (0)
#define rc_bmp_get_altitude_m() (0)

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
extern int rc_power_off_imu() ;

/* Barometer */
extern int rc_initialize_barometer(rc_bmp_oversample_t oversample, rc_bmp_filter_t filter);
extern int rc_power_off_barometer();
extern int rc_read_barometer();
extern float rc_bmp_get_temperature();
extern float rc_bmp_get_pressure_pa();
extern float rc_bmp_get_altitude_m();

#endif

#endif
