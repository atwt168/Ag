#include "softwarepwm.h"
#include <wiringPi.h>

#include <stdio.h>
#include <stdlib.h>

softwarePwm::softwarePwm(QObject* parent)
{
    this->par = parent;
    this->initPwm(36);
}

void softwarePwm::initPwm(int PWM_pin){
        int intensity;
        wiringPiSetup();		/* initialize wiringPi setup */
        pinMode(PWM_pin,OUTPUT);	/* set GPIO as output */
        softPwmCreate(PWM_pin,1,100);	/* set PWM channel along with range*/
        while (1)
          {
            for (intensity = 0; intensity < 101; intensity++)
            {
              softPwmWrite (PWM_pin, intensity); /* change the value of PWM */
              delay (10) ;
            }
            delay(1);

            for (intensity = 100; intensity >= 0; intensity--)
            {
              softPwmWrite (PWM_pin, intensity);
              delay (10);
            }
            delay(1);

        }
}
