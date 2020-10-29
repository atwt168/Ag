#ifndef SOFTWAREPWM_H
#define SOFTWAREPWM_H
#include <QObject>
#include <wiringPi.h>
#include <stdio.h>
#include <stdlib.h>
class softwarePwm:public QObject
{
    Q_OBJECT
public:
    softwarePwm(QObject *parent);
    QObject *par;
private:
    void initPwm(int PWM_pin);
};

#endif // SOFTWAREPWM_H
