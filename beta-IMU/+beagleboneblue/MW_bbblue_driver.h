/* Copyright 2017 The MathWorks, Inc. */

#ifndef MW_DRIVER_BBBLUE_H
#define MW_DRIVER_BBBLUE_H

#if ( defined(MATLAB_MEX_FILE) || defined(RSIM_PARAMETER_LOADING) ||  defined(RSIM_WITH_SL_SOLVER) )
/* This will be run in Rapid Accelerator Mode */

// /* Button */
#define rc_get_mode_button() (0)
#define rc_get_pause_button(a,b,c) (0)

/*LED*/
#define rc_set_led(a,b)(0)

/* Encoder */
#define getEncoderValue(a,b,c) (0)

/*Motors*/
#define MW_set_motor(a,b,c) (0)
#define MW_terminate_motor(a) (0)

/*Servo*/
#define rc_send_servo_pulse_normalized(a,b) (0)

/*ADC*/
#define rc_adc_raw(a) (0)
#define rc_adc_volt(a) (0)
#define rc_battery_voltage() (0)
#define rc_dc_jack_voltage() (0)

#else

#include "roboticscape.h"
#include "rtwtypes.h"

/* Button*/
extern rc_button_state_t rc_get_mode_button();
extern rc_button_state_t rc_get_mode_button();

/*LED*/
extern int rc_set_led(rc_led_t led, int state);

/* Encoder */
int32_T getEncoderValue(uint8_T portNumber, uint8_T mode, int8_T in);

/*Motors*/
void MW_set_motor(uint8_T index, int8_T duty, uint8_T stopAction);
void MW_terminate_motor(uint8_T stopAction);

/*ADC*/
extern int rc_adc_raw(int ch);
extern float rc_adc_volt(int ch);
extern float rc_battery_voltage();
extern float rc_dc_jack_voltage();

#endif


#endif
