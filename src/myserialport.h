#ifndef MYSERIALPORT_H
#define MYSERIALPORT_H

#include <iostream>      
#include <iterator>      
#include <list>      
#include <QStringList>
#include <QtSerialPort/QtSerialPort>
#include <QObject>
#include <QCloseEvent>
#include <unordered_map>
#include <QDateTime>

#include <QProcess>
#include <QDataStream>
#include <QTime> 
 
#include <QDebug>
#include <QSettings>
#include <QtCore>
#include "wiringPi.h" 
 
#include <iostream>
#include <fstream> 
#include <QCameraInfo>

 
static void myInterrupt41 ();
static int frontRecordPid=0;

class MySerialPort: public QSerialPort
{
     Q_OBJECT
public:
    MySerialPort(QObject *parent);
    QObject *par;
    QString playState;
    QString songArtist;
    QString songTitle;
    QString prevSong="";
    std::unordered_map<std::string,std::string> phoneBook;
    QString tempName;
    bool bleFlag;

    bool isRecording=false;
    bool isSongPlaying =false;
    int screenState = 0; // 0:rear || 1:rear no bar || 2:map
    int isWifiOn=1; // 1 is off
    int isAudioOn=1; // 1 is off
    int ledValue=100;

    int offButton=0;   

    int prevCameraSize=-1;
    bool prevWifiState=false;
    bool callState = false;

    

    QString frontRecordPath_sd = "/mnt/mydisk/frontRecord";
    QString frontRecordPath_flash = "/home/pi/Argon20/frontCamRecordings";

    QString rearRecordPath_sd = "/mnt/mydisk/rearRecord";
    QString rearRecordPath_flash = "/home/pi/Argon20/rearCamRecordings";

    QString frontPicturesPath_sd = "/mnt/mydisk/frontPictures";
    QString frontPicturesPath_flash = "/home/pi/Argon20/frontCamPictures";

    QString frontRecordPath;
    QString rearRecordPath;
    QString frontPicturesPath;

    QString sppAddress;
    QString bleControllerAddress;
    QString bleIosAddress;
    QString bleControllerUUID;

    // Settings
    QString kmOrMiles="km/h";  
    QString speedWarningVal="80";    
    QString imageRes="1080";
    QString videoRes="480";

    QMap<QString, QString> resMap;
    // resMap["480"] = "480x640";
    // resMap["720"] = "1280x720";
    // resMap["1080"] = "1920x1080";


    




signals:
    void cppSend(QString textOut);

public slots:

    void openSerialPort();
    void closeSerialPort();

    void writeData(const QByteArray &data,bool priority=false);
    void readData();

    void handleError(QSerialPort::SerialPortError error);
    void handleCommand(const QString msg);
    void handleMusic(const QString &artist,const QString &song,const bool &activ);
    void resetValues();

    void triggerRear(bool appCall=false);
    void triggerMaps(bool appCall=false);
    void triggerMusic();

    void toggleRecord();
    void toggleFrontRecord(bool start);
    void toggleRearRecord(bool start);
    void takePicture();
    void toggleWifi();
    void toggleAudio();

    void toggleGPIO(int gpioNum,int val);

    void updateBattery();


    void adjustLEDValue(int val);
//    void killVideo(int vid);


    void controllerNextSong();
    void controllerPrevSong();
    void controllerToggleMenu(); 
    void controllerIncreaseBrightness();
    void controllerReduceBrightness();
    void controllerTakePic();    
    void controllerToggleMusic();

    bool hasMedia();
    bool checkCameras();

    QString getVersion();

    // void myInterrupt41();

   

    


private:
    void showStatusMessage(const QString &message);

    QSerialPort *serial;
    QByteArray m_buffer;
    QByteArray m_letter;

    QProcess startFrontRecord;
    QProcess startRearRecord;
    QProcess destroyVideoProcess;
    QProcess takepic;
    QProcess pingvideo1;
    int buffSize;

};

#endif // MYSERIALPORT_H
