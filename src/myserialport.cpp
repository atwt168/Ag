#include "myserialport.h"



/*Scripts
 * scanWifi.sh
 * connectWifi.sh
 * pwm.sh
 * runFrontRecording.sh
*/ 
 
// Constructor for serial port
MySerialPort::MySerialPort(QObject* parent)
{

    this->par = parent;


    serial = new QSerialPort(this);

    connect(serial, SIGNAL(readyRead()), this, SLOT(readData()));
//    openSerialPort();
    resMap.insert("480", "640x480");
    resMap.insert("720", "1280x720");
    resMap.insert("1080", "1920x1080");

    // MyGPIO *mygpio = MyGPIO::getInstance();
    wiringPiSetup () ;
    wiringPiISR (43, INT_EDGE_FALLING, &myInterrupt41);    
    


    QDir dir(frontRecordPath);

    if(hasMedia()){
        qDebug()<<"SD DETECTED";
        frontRecordPath = frontRecordPath_sd;
        rearRecordPath = rearRecordPath_sd;
        frontPicturesPath = frontPicturesPath_sd;


    }else{
        qDebug()<<"WARNING: NO SD DETECTED ";
        frontRecordPath = frontRecordPath_flash;
        rearRecordPath = rearRecordPath_flash;
        frontPicturesPath = frontPicturesPath_flash;      

    }

    QProcess dir1;
    dir1.start(QString("sudo mkdir %1 %2 %3").arg(frontRecordPath).arg(rearRecordPath).arg(frontPicturesPath));
    dir1.waitForStarted();
    dir1.waitForFinished();

    if(hasMedia()){
        QProcess trfFlashtoSD;        
        qDebug()<<"transferring flash to sd " << frontRecordPid;        
        
        trfFlashtoSD.start("sh /home/pi/Argon20/scripts/trfFlashtoSD.sh");
        trfFlashtoSD.waitForFinished();
        trfFlashtoSD.close();
    }
 
 
}


static void myInterrupt41 () {
    
    if(digitalRead(43)==0){
        qDebug()<<"Off button pressed ";

        QProcess killvideo1;        
        qDebug()<<"kill video " << frontRecordPid;
        
        // killvideo1.startDetached("bash /home/pi/Argon20/scripts/killvideo1.sh");

        int blinkCounter = 6 ?frontRecordPid<0:20;       

        QProcess turnOff;
        // turnOff.start(QString("bash /home/pi/Argon20/scripts/killvideo1.sh %1 %2").arg(frontRecordPid,6));     
        turnOff.startDetached(QString("bash /home/pi/Argon20/scripts/killvideo1.sh %1 %2").arg(frontRecordPid).arg(blinkCounter));    
        turnOff.waitForFinished();


       // pinMode (40, OUTPUT) ;
       // digitalWrite (40, HIGH);

    }


}

QString MySerialPort::getDeviceState(){

    QStringList state = {"0" , "0", "0" ,"0"};
    
    if(prevCameraSize==2){
        state[0] = "1";
    }
    if(sppAddress != NULL){
        state[1] = "1";
    }

    if(bleControllerUUID != NULL){
        state[2] = "1";
    }

    if(wifiOutput.length() != 0){
        state[3] = "1";

    }

    qDebug() << "STATE: " << state.join(""); 
    return state.join("");

}

QString MySerialPort::getVersion(){

    QProcess gerVers;
    gerVers.start(QString("cat /home/pi/Argon20/VERSION"));
    gerVers.waitForFinished();
    QString vers = gerVers.readAllStandardOutput().trimmed();

    qDebug() << "VERSION: " << vers;
    return vers;

}

bool MySerialPort::checkCameras(){
    const QList<QCameraInfo> cameras = QCameraInfo::availableCameras();
  
    if(prevCameraSize!=cameras.size()){
        prevCameraSize=cameras.size();
        if(cameras.size()==2){
            if(sppAddress!=NULL){
                writeData(QString("SEND %1 FRONT_CAMERA_CONNECTED\r").arg(sppAddress).toLatin1());
            }   
            
            
        }else{
            if(sppAddress!=NULL){
                writeData(QString("SEND %1 FRONT_CAMERA_DISCONNECTED\r").arg(sppAddress).toLatin1());
            }          
        }
    }

    //     if(sppAddress!=NULL){
    //     prevCameraSize=cameras.size();
    //     if(cameras.size()==2){
    //         writeData(QString("SEND %1 FRONT_CAMERA_CONNECTED\r").arg(sppAddress).toLatin1());
            
    //     }else{
    //         writeData(QString("SEND %1 FRONT_CAMERA_DISCONNECTED\r").arg(sppAddress).toLatin1());            
    //     }
    // }

    return cameras.size()==2;

}

bool MySerialPort::hasMedia(){
 
    std::ifstream fsize("/sys/block/mmcblk1/size");     
    unsigned long long size;
    return (fsize >> size) && (size > 0);
}

// Initialize configuration for serial port
void MySerialPort::openSerialPort()
{

    serial->setPortName("ttyAMA0");
    serial->setBaudRate(QSerialPort::Baud9600);
    serial->setDataBits(QSerialPort::Data8);
    serial->setParity(QSerialPort::NoParity);
    serial->setStopBits(QSerialPort::OneStop);
    serial->setFlowControl(QSerialPort::SoftwareControl);


    if (serial->open(QIODevice::ReadWrite)) {

        showStatusMessage("Open Success");
//        qDebug() << "Connectedd" ;
        serial->setReadBufferSize(32);

        // Default set batt to 2 bar
        QMetaObject::invokeMethod(this->par, "updateBattery",Q_ARG(QVariant, 3700));
        writeData(QString("SET MUSIC_META_DATA=ON\r").toLatin1());
        writeData(QString("ADVERTISING ON\r").toLatin1());
        
        // Initial Battery Read
        QTimer::singleShot(30000, this, &MySerialPort::updateBattery);
         

        // Get initial Addresses
        writeData("STATUS\r");
 
        // For battery
        QTimer *timerBattery = new QTimer(this);
        QTimer *cameraWifiStatus = new QTimer(this);
        connect(timerBattery, SIGNAL(timeout()), this, SLOT(updateBattery()));
        connect(cameraWifiStatus, SIGNAL(timeout()), this, SLOT(checkCamWifi()));
        timerBattery->start(600000);
        cameraWifiStatus->start(10000);
        

        // Scan for BLE controller
        writeData(QString("SCAN 10\r").toLatin1());

    } else {
        showStatusMessage(tr("Open error"));
    }
}

 

void MySerialPort::updateBattery(){
    writeData(QString("BATTERY_STATUS\r").toLatin1());
    

}

void MySerialPort::checkCamWifi(){
        // Indicate to UI if front cam is connected properly
    QMetaObject::invokeMethod(this->par, "displayFrontCamIcon",Q_ARG(QVariant,checkCameras()));


    QString command = QString("sudo lsof -t /dev/video1");
    // qDebug() << command;
    pingvideo1.start(command);
    pingvideo1.waitForFinished();
    QString output(pingvideo1.readAllStandardOutput());

    qDebug() << "Output of ping process "<< output.length();

    if (output.length()==0 && isRecording && !isTakingPic){
        qDebug() << "shit got fked. Restarting front cam record";
        toggleFrontRecord(true);

    }


    // PING WIFI CHECK
    QProcess checkWifi;
    command = QString("iwconfig 2>&1 | grep ESSID");
    // qDebug() << command;
    checkWifi.start("bash",QStringList() << "-c" << "iwconfig 2>&1 | grep ESSID");
    checkWifi.waitForFinished();

    //Global variable
    wifiOutput = checkWifi.readAllStandardOutput();
    // qDebug() << "Output of wifi process "<< wifiOutput;
    
    if(sppAddress!=NULL && prevWifiState!=(wifiOutput.length()!=0)){
        prevWifiState = wifiOutput.length()!=0;
        if(wifiOutput.length()==0){
            writeData(QString("SEND %1 WIFI_DISCONNECTED\r").arg(sppAddress).toLatin1());
        }else{
            writeData(QString("SEND %1 WIFI_CONNECTED\r").arg(sppAddress).toLatin1());
        }
    }
    
}

// Actions to be executed prior to closing serial port
void MySerialPort::closeSerialPort()
{
    resetValues();
    if (serial->isOpen())
        serial->close();


    showStatusMessage(tr("Disconnected"));
}




// Write data to serial port device to be evaluated by BC127
void MySerialPort::writeData(const QByteArray &data, bool priority)
{
    if(bleFlag && !priority){
        return;
    }
    else{
        qDebug() << "writing " << data;
        serial->write(data);
        serial->waitForBytesWritten(-1);

    }


}

// Data received by serial ie BC127 and messages from app to BC127
void MySerialPort::readData(){


          while(serial->bytesAvailable()){

            m_letter=serial->read(1);
//            qDebug() << "letter" << m_letter;
            m_buffer+=m_letter;
            if(m_letter=="\r" || m_letter=="\n" || m_letter =="\\"){

                handleCommand(QString::fromStdString(m_buffer.toStdString()).trimmed());
                m_buffer.clear();
                break;
            }
          }
//          qDebug()<< m_buffer;




}

// Reset UI variables to initial state
void MySerialPort::resetValues(){
    QString empty = "";
    QMetaObject::invokeMethod(this->par, "setInfoBarInstruction",Q_ARG(QVariant, empty));
    QMetaObject::invokeMethod(this->par, "setInfoBarDistance",Q_ARG(QVariant, empty));
    QMetaObject::invokeMethod(this->par, "setSpeed",Q_ARG(QVariant, "0"));
}


// Error handling for serial port
void MySerialPort::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        closeSerialPort();
    }
}

// Custom print function
void MySerialPort::showStatusMessage(const QString &message)
{
    qDebug() << message;
}

// Kill video process
//void MySerialPort::killVideo(int vid){
//    QString command = QString("kill -9 $(lsof -t /dev/video%1)").arg(vid);
//    destroyVideoProcess.start(command);
//    destroyVideoProcess.waitForFinished();
//}

// Music Handler
void MySerialPort::handleMusic(const QString &artist,const QString &song,const bool &active){     
    if(artist.length()==0 || song.length()==0) return;
   
    QMetaObject::invokeMethod(this->par, "showMusic",Q_ARG(QVariant, songArtist),Q_ARG(QVariant, songTitle),Q_ARG(QVariant, active));
    this->prevSong = song;
}

void MySerialPort::triggerRear(bool appCall){
    QMetaObject::invokeMethod(this->par, "showRear");
    screenState=(screenState+1)%3;
    if(appCall){
         screenState=std::min(screenState,1);
    }
    QProcess getIP;
    getIP.start("hostname -I");
    getIP.waitForFinished();
    QString output = getIP.readAllStandardOutput();
    output = output.split(" ").at(0);
    // writeData(QString("SEND %1 IP "+output+"\r").arg(sppAddress).toLatin1());
}

void MySerialPort::triggerMaps(bool appCall){
    if(appCall){
        if(screenState!=2){
            screenState=(screenState+1)%3;
        }
    }else{
        screenState=(screenState+1)%3;
    }
    QMetaObject::invokeMethod(this->par, "showMap");
}

void MySerialPort::toggleRecord(){
    QString recordStatus = isRecording ? "Recording Stopped" : "Recording Started";
    qDebug() << recordStatus ;

    toggleFrontRecord(!isRecording);
    toggleRearRecord(!isRecording);

    isRecording = !isRecording;
    QMetaObject::invokeMethod(this->par, "startRecord",Q_ARG(QVariant, isRecording));
}

void MySerialPort::toggleFrontRecord(bool start){
    if(!start){
        qDebug() << "Stop Front Recording" ;  
        startFrontRecord.terminate();      
        // startFrontRecord.kill();
        startFrontRecord.waitForFinished();
 

    }else{

        QString timestamp = QDateTime::currentDateTime().toString("yyyy-MM-dd__HH_mm_ss");
       // QString command = QString("ffmpeg -f v4l2 -s 1280x720 -r 30 -input_format mjpeg -i /dev/video1 -vcodec libx265 -crf 24 -c:v copy ./frontCamRecordings/%1.mp4").arg(timestamp);
        //QString command  = QString("sh ~/Argon20/runFrontRecording.sh");
        // QString frontRecordCommand = QString("ffmpeg -f v4l2 -s 640x480 -r 30 -input_format mjpeg -i /dev/video1 -vcodec libx265 -crf 18 -c:v copy -segment_time 60 -f segment -segment_wrap 24 -reset_timestamps 1 /home/pi/Argon20/frontCamRecordings/%1_\%03d.mp4").arg(timestamp);
        QString frontRecordCommand = QString("ffmpeg -f v4l2 -s %1 ").arg(resMap[videoRes]);
        frontRecordCommand += QString("-r 30 -input_format mjpeg -i /dev/video1 -vcodec libx265 -crf 18 -c:v copy -segment_time 300 -f segment -segment_wrap 24 -reset_timestamps 1 %1/%2_\%03d.mp4").arg(frontRecordPath, timestamp);  
        // QString frontRecordCommand = QString("ffmpeg -f v4l2 -s %1 -r 30 -input_format mjpeg -i /dev/video1 -vcodec libx265 -crf 18 -c:v copy -segment_time 300 -f segment -segment_wrap 24 -reset_timestamps 1 %2/%3_\%03d.mp4").arg(resMap[videoRes], frontRecordPath, timestamp);              

        qDebug() << frontRecordCommand ;
        // startFrontRecord.startDetached("sleep 2");
        // startFrontRecord.waitForFinished();
        // startFrontRecord.terminate();

        startFrontRecord.start(frontRecordCommand); 

        frontRecordPid = startFrontRecord.pid();
        qDebug() << "start front recording " << frontRecordPid;        
        startFrontRecord.waitForStarted();


    }



}

void MySerialPort::toggleRearRecord(bool start){
    if(!start){
        qDebug() << "stop rear recording" ;
        qDebug()<< startRearRecord.readAllStandardOutput();
        startRearRecord.terminate();
        // startRearRecord.kill();
        startRearRecord.waitForFinished();
//        killVideo(0);

    }else{

        QString timestamp = QDateTime::currentDateTime().toString("yyyy-MM-dd__HH_mm_ss");
       // QString command = QString("ffmpeg -f v4l2 -s 1280x720 -r 30 -input_format mjpeg -i /dev/video1 -vcodec libx265 -crf 24 -c:v copy ./frontCamRecordings/%1.mp4").arg(timestamp);
        //QString command  = QString("sh ~/Argon20/runFrontRecording.sh");
        // QString rearRecordCommand = QString("ffmpeg -f v4l2 -s 640x480 -r 30 -input_format mjpeg -i /dev/video0 -vcodec libx265 -crf 18 -c:v copy -segment_time 60 -f segment -segment_wrap 24 -reset_timestamps 1 /home/pi/Argon20/rearCamRecordings/%1_\%03d.mp4").arg(timestamp);
        QString rearRecordCommand = QString("ffmpeg -f v4l2 -s 640x480 ");
        rearRecordCommand += QString("-r 30 -input_format mjpeg -i /dev/video0 -vcodec libx265 -crf 18 -c:v copy -segment_time 300 -f segment -segment_wrap 24 -reset_timestamps 1 %1/%2_\%03d.mp4").arg(rearRecordPath,timestamp);
        // QString rearRecordCommand = QString("ffmpeg -f v4l2 -s %1 -r 30 -input_format mjpeg -i /dev/video0 -vcodec libx265 -crf 18 -c:v copy -segment_time 300 -f segment -segment_wrap 24 -reset_timestamps 1 %2/%3_\%03d.mp4").arg(resMap[videoRes], rearRecordPath,timestamp);
//        QString frontRecordCommand = QString("bash ~/Argon20/scripts/recordOnly.sh");
        qDebug() << "start rear recording " ;
        qDebug() << rearRecordCommand;
//        startRearRecord.startDetached("sleep 2");
//        startRearRecord.waitForFinished();
//        startRearRecord.kill();

        startRearRecord.start(rearRecordCommand);
        qDebug()<< "reading" << startRearRecord.readAllStandardOutput();
        startRearRecord.waitForStarted();


    }


}



void MySerialPort::takePicture(){

    if(!isRecording){

        isTakingPic = true;
        QString timestamp = QDateTime::currentDateTime().toString("yyyy-MM-dd__HH_mm_ss");
    
        // QString command = QString("ffmpeg -f v4l2 -i /dev/video1 -vframes 1 -s 1920x1080 -input_format mjpeg %1/img_%2.jpeg").arg(frontPicturesPath, timestamp);
        QString command = QString("ffmpeg -f v4l2 -i /dev/video1 -vframes 1 -s %1 -input_format mjpeg %2/img_%3.jpeg").arg(resMap[imageRes], frontPicturesPath, timestamp);
        QProcess killvideo1;
        killvideo1.start("sudo kill -9 $(sudo lsof -t /dev/video1)");
        killvideo1.waitForFinished();

        takepic.start("sleep 1.5");
        takepic.waitForFinished();

        takepic.startDetached(command);
        takepic.waitForStarted();
        qDebug() << QString("Saved img_%1.jpeg to frontCamPictures").arg(timestamp) ;
    //    qDebug() << command;
        takepic.kill();
        isTakingPic = false;

    }


}

void MySerialPort::toggleGPIO(int gpioNum,int val){
    QString gpioToggleCommand = QString("gpio write %2 %3").arg(gpioNum).arg(val);
    qDebug() << gpioToggleCommand;
    QProcess toggleGpio;
    toggleGpio.start(gpioToggleCommand);
    toggleGpio.waitForFinished();
    toggleGpio.close();
}

void MySerialPort::toggleWifi(){
    if(isWifiOn==0){
        isWifiOn = 1;
    }else{
        isWifiOn = 0;
    }

    toggleGPIO(44,isWifiOn);
}

void MySerialPort::toggleAudio(){
    if(isAudioOn==0){
        isAudioOn = 1;
    }else{
        isAudioOn = 0;
    }
    toggleGPIO(0,isAudioOn);
}

void MySerialPort::setCurrentState(QString address, QString link){
    if(link=="A2DP"){
        a2dpAddress = address;

    }else if (link == "AVRCP"){
        avrcpAddress = address;

    }else if (link == "HFP"){
        hfpAddress = address;

    }else if (link =="SPP"){
        sppAddress = address;

    }

}


// DEPRECATED
void MySerialPort::triggerMusic(){
    QProcess getIP;
    getIP.start("hostname -I");
    // getIP.start("hostname -I | awk '{ print $1 }'");
    // getIP.start("bash", QStringList() << "-c" << "hostname -I | { read -a array ; echo ${array[0]} ; }");
    getIP.waitForFinished();
    QString output = getIP.readAllStandardOutput();
    output = output.split(" ").at(0);
 
    writeData(("SEND %1 IP "+output+"\r").arg(sppAddress).toLatin1());
    qDebug() << "TRIGGERED";
    if(songArtist.size()>0) handleMusic(songArtist,songTitle,true);
    // isSongPlaying = !isSongPlaying;
}

void MySerialPort::adjustLEDValue(int val){
    QProcess adjustLED;
    adjustLED.start(QString("gpio pwm 45 %1").arg(val));
    adjustLED.waitForFinished();
}



//Controller Functions

void MySerialPort::controllerNextSong(){

}

void MySerialPort::controllerPrevSong(){

}

void MySerialPort::controllerToggleMusic(){
    showStatusMessage("MUSIC");
    
    if(isSongPlaying){
        if(avrcpAddress!=NULL){
            writeData(QString("MUSIC %1 PAUSE\r").arg(avrcpAddress).toLatin1());
        }
    
    }else{
        if(avrcpAddress!=NULL){
            writeData(QString("MUSIC %1 PLAY\r").arg(avrcpAddress).toLatin1());
        }
 
        
    }
     
     
}

void MySerialPort::controllerToggleMenu(){
    showStatusMessage("SCREEN CHANGE");
    if((screenState+1)%3==2){
        triggerMaps();
    }
    else{
        triggerRear();
    }
    showStatusMessage(QString(screenState));
}

void MySerialPort::controllerIncreaseBrightness(){
    // ledValue +=10;
    ledValue = std::min(100,ledValue+10);
    adjustLEDValue(ledValue);
    showStatusMessage("RIGHT");
}

void MySerialPort::controllerReduceBrightness(){
    // ledValue -=10;
    ledValue = std::max(0,ledValue-10);
    adjustLEDValue(ledValue);
    showStatusMessage("LEFT");
}

void MySerialPort::controllerTakePic(){
    showStatusMessage("PIC");
    // if(isRecording){
    //     toggleFrontRecord(false);
    //     takePicture();
    //     toggleFrontRecord(true);

    // }else{
    //     takePicture();
    // }
    if(!isRecording){
        takePicture();
    }
}

void MySerialPort::sendVersion(){
    if(sppAddress!=NULL){
        writeData(QString("SEND %1 VERSION %2\r").arg(sppAddress).arg(getVersion()).toLatin1());
    }    
}

void MySerialPort::sendDelayed(const QByteArray &s, int delay){
    QTimer::singleShot(delay, [this,s]() { writeData(s); } );
}


// Command Handler
void MySerialPort::handleCommand(const QString msg){
    qDebug() << msg;
    QStringList msgSplit = msg.split(" ");

    /*
    * First digit represents which device connected first || Same ffor HFP,A2dp ...
    * 15 or 25 for SPP
    * 14 or 24 for BLE
    */


    if(msgSplit[0]=="OPEN_OK"){

        // Est connection between App and Device
        if (msgSplit[1]=="15" || msgSplit[1]=="25"){
            sppAddress = msgSplit[1];
            sendVersion();
            
            QString deviceAddress = msgSplit[3]; 
            QMetaObject::invokeMethod(this->par, "connected");

            // Off advertising when spp connected
            writeData(QString("ADVERTISING OFF\r").toLatin1());
            
            // Scan for BLE devices if not connected
            // if(bleControllerAddress==NULL){
            //     writeData(QString("SCAN 10\r").toLatin1());
            // }else{
            //     writeData(QString("SEND %1 CONTROLLER_CONNECTED\r").arg(sppAddress).toLatin1());
            // }

            // if(bleControllerUUID!=NULL && sppAddress!=NULL){
            //     writeData(QString("SEND %1 CONTROLLER_CONNECTED\r").arg(sppAddress).toLatin1());
            // }

            if(sppAddress!=NULL){
                writeData(QString("SEND %1 DEVICE_STATE %2\r").arg(sppAddress).arg(getDeviceState()).toLatin1());
            }
            
            toggleAudio();

        }

        else if (msgSplit[1].at(1)=="0"){
            a2dpAddress = msgSplit[1];
        }


        else if (msgSplit[1].at(1)=="1"){
            avrcpAddress = msgSplit[1];
            writeData(QString("MUSIC %1 STOP\r").arg(avrcpAddress).toLatin1());
            // writeData("MUSIC 11 STOP\r");
        }

        else if (msgSplit[1].at(1)=="3"){
            hfpAddress = msgSplit[1];
        }

        //Est connection between BLE controller and Device
        // else if (msgSplit[1]=="14" || msgSplit[1]=="24"){
        else if (msgSplit[1].at(1)=="4"){
            QString deviceAddress = msgSplit[3];

            if(bleControllerUUID == msgSplit[3]){
                
                if(sppAddress!=NULL){
                    writeData(QString("SEND %1 CONTROLLER_CONNECTED\r").arg(sppAddress).toLatin1());
                }
                
                writeData(QString("BLE_WRITE %1 002D 2\r").arg(msgSplit[1]).toLatin1()); 
                bleFlag = true;
                // bleControllerAddress = msgSplit[1];
                // writeData(QString("SEND %1 CONTROLLER_CONNECTED\r").arg(sppAddress).toLatin1());
                
                //QTimer::singleShot(8000, this,[this]() { QMetaObject::invokeMethod(this->par, "showBleController",Q_ARG(QVariant, true)); } );
                QMetaObject::invokeMethod(this->par, "showBleController",Q_ARG(QVariant, true));
 

            }else{
                //iOS device
                bleIosAddress = msgSplit[1];
                if(sppAddress==NULL){
                    sppAddress = msgSplit[1];
                }

                // writeData(QString("SEND %1 VERSION %2\r").arg(sppAddress).arg(getVersion()).toLatin1());

                // QTimer::singleShot(2000, this, &MySerialPort::sendVersion);
                sendDelayed(QString("SEND %1 VERSION %2\r").arg(sppAddress).arg(getVersion()).toLatin1());

                if(sppAddress!=NULL ){
                    sendDelayed(QString("SEND %1 DEVICE_STATE %2\r").arg(sppAddress).arg(getDeviceState()).toLatin1());
                    // writeData(QString("SEND %1 CONTROLLER_CONNECTED\r").arg(sppAddress).toLatin1());
                    
                }

            

                toggleAudio();

                
            }
 

            
        }


    }

    else if (msgSplit[0]=="LINK"){
        if(msgSplit.size()>3){
            setCurrentState(msgSplit[1],msgSplit[3]);
        }

        if(msgSplit[3]=="AVRCP"){

            if(msgSplit[5]=="PAUSED"){
                isSongPlaying = false;
            }else{
                isSongPlaying = true;
            }

        }
        
    }

    else if (msgSplit[0]=="CLOSE_OK"){
        // if (msgSplit[1]=="14" || msgSplit[1]=="24" ){
        if (msgSplit[1].at(1)=="4"){
            QMetaObject::invokeMethod(this->par, "showBleController",Q_ARG(QVariant, false));
            writeData(QString("ADVERTISING ON\r").toLatin1());
            if(msgSplit[3]==bleControllerUUID){
                writeData(QString("SEND %1 CONTROLLER_DISCONNECTED\r").arg(sppAddress).toLatin1());
                bleControllerUUID = nullptr;
            }else{
                // iosDevice disconnected
            }

            
            
        } else if(msgSplit[1]=="15" || msgSplit[1]=="25"){
            sppAddress = nullptr;
            // toggleAudio();
        }

        else if (msgSplit[1].at(1)=="0"){
            //A2dp
            a2dpAddress = nullptr; 

        }

        else if (msgSplit[1].at(1)=="1"){
            // Avrcp
            avrcpAddress = nullptr;
            
        }

        else if (msgSplit[1].at(1)=="3"){
            //HFP
            hfpAddress = nullptr;
            
        }
    }

    else if(msgSplit[0]=="PENDING" && bleFlag){        
        QByteArray data;
        data.append((char)0x01);
        data.append((char)0x00);
        data.append((char)0x0D);
        writeData(data,true);
        bleFlag = false;
 
        // writeData(QString("SEND %1 CONTROLLER_CONNECTED\r").arg(sppAddress).toLatin1());

    }

    else if(msgSplit[0]=="AVRCP_MEDIA"){
        if(msgSplit[2] =="TITLE:"){
             songTitle = msg.mid(22);
             qDebug()<< "songtit" << songTitle;
        }
        else if(msgSplit[2] =="ARTIST:"){
            songArtist = msg.mid(23);
            if(songTitle.size()>0)handleMusic(songArtist,songTitle,true);
            qDebug()<< "songArt" << songArtist;
        }


    }

    else if (msgSplit[0]=="SCAN"){
        if(msgSplit[3].contains("Argon-Controller") && bleControllerUUID == NULL ){
                bleControllerUUID = msgSplit[1];
                writeData(QString("OPEN %1 BLE 0\r").arg(msgSplit[1]).toLatin1());
                QMetaObject::invokeMethod(this->par, "showBleController",Q_ARG(QVariant, true));

        }
    }

    // else if (msgSplit[0]=="SCAN_OK" && bleControllerUUID!=NULL){        
    //     writeData(QString("open %1 ble 0\r").arg(bleControllerUUID).toLatin1());        
        
    // }

    else if(msgSplit[0]=="AVRCP_PLAY"){
        handleMusic(songArtist,songTitle,true);         
        isSongPlaying = true;

    }else if(msgSplit[0]=="AVRCP_PAUSE"){
        handleMusic(songArtist,songTitle,false);         
        isSongPlaying = false;
    }


    //BLE Commands
    else if (msgSplit[0]=="BLE_NOTIFICATION"){
        QMetaObject::invokeMethod(this->par, "showBleController",Q_ARG(QVariant, true));
//        if msgSplit[4]
        /*
            up:4
            down:3
            left:2
            right:8
            recording:7
            photo:6
            menu:1
            -brightness:0A
            +brightness:9
            music:5
        */
        QString bleButton = msgSplit[4];
        // bleControllerAddress = msgSplit[1];

        // Increase volume
        if(bleButton=="04"){
            showStatusMessage("UP");
            if(a2dpAddress!=NULL){
                writeData(QString("VOLUME %1 UP\r").arg(a2dpAddress).toLatin1());
            }

            if(hfpAddress!=NULL){
                writeData(QString("VOLUME %1 UP\r").arg(hfpAddress).toLatin1());
            }
 

       
        }
        // Increase Led brightness
        else if(bleButton=="09"){
            if(callTriggeredState){
                // Ans CALL
                showStatusMessage("ANSCALL");
                if(hfpAddress!=NULL){
                    writeData(QString("CALL %1 ANSWER\r").arg(hfpAddress).toLatin1());
                }
         
            }
            controllerIncreaseBrightness();
        }

        // Reduce volume
        else if(bleButton=="03"){
            showStatusMessage("DOWN");
            if(a2dpAddress!=NULL){
                writeData(QString("VOLUME %1 DOWN\r").arg(a2dpAddress).toLatin1());
            }

            if(hfpAddress!=NULL){
                writeData(QString("VOLUME %1 DOWN\r").arg(hfpAddress).toLatin1());
            }
        
 


        }

        // Reduce Led brightness
        else if(bleButton=="0A"){
            if(callTriggeredState){
                showStatusMessage("ENDCALL");

                if(hfpAddress!=NULL){
                    if(callActiveState){
                        
                        writeData(QString("CALL %1 END\r").arg(hfpAddress).toLatin1());
                    }else{
                        writeData(QString("CALL %1 REJECT\r").arg(hfpAddress).toLatin1());
                    }    
                }         
 
            }
            controllerReduceBrightness();
        }

        // Change screen state
        else if(bleButton=="01"){
            controllerToggleMenu();

        }

        // Take picture
        /*
         * If recording, kill process, take pic and restart record process
        */
        else if(bleButton=="06"){
            controllerTakePic();
        }

        else if(bleButton=="08"){
            if(avrcpAddress != NULL){
                writeData(QString("MUSIC %1 FORWARD\r").arg(avrcpAddress).toLatin1());
            }
            
            // writeData("MUSIC 21 FORWARD\r");
        }

        else if(bleButton=="02"){
            if(avrcpAddress != NULL){
                writeData(QString("MUSIC %1 BACKWARD\r").arg(avrcpAddress).toLatin1());
            }
            // writeData("MUSIC 21 BACKWARD\r");

        }

 

        // Toggle Record
        else if(bleButton=="07"){
            toggleRecord();
            showStatusMessage("CAMERA");
        }

        // Toggle play/pause music
        else if(bleButton=="05"){
            controllerToggleMusic();
        }

    }


    else if (msgSplit[0]=="RECV"){

            // if(msgSplit[1].at(1)=="5"){
            //     sppAddress = msgSplit[1]
            // } 

            //Deprecated
            if(msgSplit[3]=="REAR"){
                triggerRear(true);

            }
            
            //DEPRECATED
            else if(msgSplit[3]=="MAPS"){
                triggerMaps(true);
            }
            

            else if(msgSplit[3]=="INSTRUCTION"){
                QString instr = msg.mid(23);
                    qDebug()<< "recevieved instruction: " << instr;
                QMetaObject::invokeMethod(this->par, "setInfoBarInstruction",Q_ARG(QVariant, instr));
                
                

            }

            else if(msgSplit[3]=="EXIT"){          
               
                QMetaObject::invokeMethod(this->par, "setExit",Q_ARG(QVariant, msgSplit[4]));                
                

            }


            else if(msgSplit[3]=="DISTANCE"){
                QString dist = msgSplit[4];
 
                if(kmOrMiles=="km/h"){
                    dist = dist+" m";
                }
                else{
                    // convert dist to miles/feet
                    int distMeters = dist.toInt();
                     
                    if(dist<300){
                        //Convert to foot
                        int distFoot = (int)((((3.28084*distMeters - 1) / 50 + 1) * 50)); 
                        dist = QString("%1 ft").arg(distFoot);

                    }else{
                        //Convert to miles                        
                        int distMiles = (int)((((0.000621371*distMeters - 1) / 50 + 1) * 50)); 
                        dist = QString("%1 mi").arg(distMiles);

                    }
                }

                //qDebug()<< "recevieved dist: " << dist;
                QMetaObject::invokeMethod(this->par, "setInfoBarDistance",Q_ARG(QVariant, dist));
            }

            else if(msgSplit[3]=="SPEED"){
                QString speed = msgSplit[4];
 
                QMetaObject::invokeMethod(this->par, "setSpeed",Q_ARG(QVariant, speed));
            }

            else if(msgSplit[3]=="ARROW"){
                QString arrow = msg.mid(17);
 
                QMetaObject::invokeMethod(this->par, "setArrow",Q_ARG(QVariant, arrow));
            }

            else if(msgSplit[3]=="STOPRIDE"){
                resetValues();
            }

 
            else if (msgSplit[3]=="CONNECT_WIFI"){
                QProcess connectWifi;
                // QString command = QString("sh /home/pi/Argon20/scripts/connectWifi.sh '\%1\' '\%2\' ").arg(msgSplit[4],msgSplit[5]);
                QStringList ssid;
                QString psk = msgSplit.takeLast();
                for(int i=4;i<msgSplit.size();i++){
                    ssid << msgSplit[i];
                } 

                QString command = QString("bash /home/pi/Argon20/scripts/addAndConnectWifi.sh \"%1\" \"%2\"").arg(ssid.join(" "),psk);
                // QString command = QString("bash /home/pi/Argon20/scripts/addAndConnectWifi.sh");                 
                // qDebug() << command ;
                connectWifi.startDetached(command);
                connectWifi.waitForFinished();
                if(sppAddress != NULL){
                    if(wifiOutput.length()==0){
                        writeData(QString("SEND %1 WIFI_DISCONNECTED\r").arg(sppAddress).toLatin1());
                    }else{
                        writeData(QString("SEND %1 WIFI_CONNECTED\r").arg(sppAddress).toLatin1());
                    }
                }

            }

            else if (msgSplit[3]=="CAMCONTROL"){
                QProcess setv4l2;
                QString command = QString("v4l2-ctl -d /dev/video0 --set-ctrl %1").arg(msgSplit[4]);
//                qDebug() << command ;
                setv4l2.start(command);
                setv4l2.waitForFinished();
            }

            else if (msgSplit[3]=="SET_BRIGHTNESS"){
                QProcess setBrightness;
                QString command = QString("sh /home/pi/Argon20/scripts/pwm.sh %1").arg(msgSplit[4]);
//                qDebug() << command ;
                setBrightness.start(command);
                setBrightness.waitForFinished();
            }


            else if (msgSplit[3]=="TOGGLE_WIFI"){
                //TODO
                toggleWifi();
            }

            else if (msgSplit[3]=="TOGGLE_AUDIO"){
                //TODO
                toggleAudio();
            }

            else if (msgSplit[3]=="SERIAL_WRITE"){
                QString toWrite = msg.mid(24)+"\r";
                if(msg.mid(24)=="showpb"){
 
                    for (auto pair: phoneBook) {
                        QString pfirst = QString::fromUtf8(pair.first.c_str());
                        QString psec = QString::fromUtf8(pair.second.c_str());
                        qDebug() << "{" << pfirst << ": " <<psec << "}\n";
                    }
                }
                writeData(toWrite.toLatin1());


            }

             


            else if (msgSplit[3] == "INCOMING_CALL"){
                callTriggeredState = true;
                if(msgSplit.size()>5){                    
                    qDebug()<< msgSplit[4] << msgSplit[5] <<" calling...";
                    QMetaObject::invokeMethod(this->par, "showCall",Q_ARG(QVariant, msgSplit[4]),Q_ARG(QVariant, msgSplit[5]),Q_ARG(QVariant, true));
                }

                else{
                    QMetaObject::invokeMethod(this->par, "showCall",Q_ARG(QVariant, msgSplit[4]),Q_ARG(QVariant, ""),Q_ARG(QVariant, true));             
                }
            }

            else if (msgSplit[3]=="DATETIME"){
                try{
                    QString datecommand = QString("sudo date -s \"%1 %2\" ").arg(msgSplit[4]).arg(msgSplit[5]);
                    QProcess setDate;
                    setDate.startDetached(datecommand);

                }catch(int e){
                    qDebug() <<"Error setting date";
                }


            }

            // SETTINGS
            else if(msgSplit[3]=="SETTINGS_NAV"){
                kmOrMiles = msgSplit[4];
                speedWarningVal = msgSplit[5];                
                QMetaObject::invokeMethod(this->par, "setUnits", Q_ARG(QVariant, kmOrMiles));         
                QMetaObject::invokeMethod(this->par, "setSpeedLimit", Q_ARG(QVariant, speedWarningVal)); 
         

            }


            else if(msgSplit[3]=="SETTINGS_CAM"){

                if(msgSplit.size()>5){
                    imageRes = msgSplit[4];
                    videoRes = msgSplit[5];

                    QProcess camSettings;
                    camSettings.startDetached(QString("v4l2-ctl -d /dev/video0 --set-ctrl brightness=%1").arg(msgSplit[6]));
                    camSettings.waitForFinished();

                    camSettings.startDetached(QString("v4l2-ctl -d /dev/video0 --set-ctrl contrast=%1").arg(msgSplit[7]));
                    camSettings.waitForFinished();

                    camSettings.startDetached(QString("v4l2-ctl -d /dev/video0 --set-ctrl saturation=%1").arg(msgSplit[8]));
                    camSettings.waitForFinished();

                    camSettings.startDetached(QString("v4l2-ctl -d /dev/video0 --set-ctrl color_effects=%1").arg(msgSplit[9]));
                    camSettings.waitForFinished();
                }
                
            }

             else if(msgSplit[3]=="SETTINGS_CAM_RES"){
                   if(msgSplit.size()>5){
                    imageRes = msgSplit[4];
                    videoRes = msgSplit[5];
                   }

             }

             else if (msgSplit[3]=="GET_SSID"){
                    QProcess getSSID;
                    QString ssid = "" ;
                    getSSID.start("bash",QStringList() << "-c" << "sudo iwlist wlan0 scan | grep ESSID | xargs");
                    getSSID.waitForFinished();

                    ssid += getSSID.readAllStandardOutput().trimmed();

                    QStringList ls = ssid.split("ESSID:");
                    ls << "TERMINATE";
                    // writeData(QString("SEND %1 RECEIVE_SSID %2\r").arg(sppAddress).arg(ls.join(" ")).toLatin1());             
                    // qDebug() << "WIFILIST "<< ls.join(" "); 
                    int ctr = 0;
                    for(int i=0;i<ls.size();++i){
                        if(ctr>5) break;
                        if(ls.at(i).length()>0){
                            if(sppAddress != NULL){
                                writeData(QString("SEND %1 SSID %2 \r").arg(sppAddress).arg(ls.at(i).trimmed()).toLatin1()); 
                            }
                            
                            ctr++;
                        }
                        
                    }

             }

             else if (msgSplit[3]=="ON_WIFI"){
                QProcess onWifi;
                onWifi.start("bash",QStringList() << "-c" << "gpio mode 44 output && gpio write 44 0");
                onWifi.waitForFinished();

             }

            else if (msgSplit[3]=="OFF_WIFI"){
                QProcess offWifi;
                offWifi.start("bash",QStringList() << "-c" << "gpio mode 44 output && gpio write 44 1");
                offWifi.waitForFinished();
             }

            else if (msgSplit[3]=="START_UPDATE"){
                QProcess updateProcess;

                if(msgSplit.size()>4){
                    updateProcess.start(QString("sudo bash /home/pi/Argon20/scripts/update.sh \"%1\"").arg(msgSplit[4]).toLatin1());
                    // Callback for update Process
                    connect(&updateProcess, static_cast<void(QProcess::*)(int, QProcess::ExitStatus)>(&QProcess::finished),
                    [=]  (int exitCode, QProcess::ExitStatus exitStatus) 
                    {
                            qDebug() << "UPDATE DONE -- EXITCODE: " << exitCode; 
                            if(exitCode==0){
                                // Update Success
                                if(sppAddress != NULL){
                                    writeData(QString("SEND %1 UPDATE_SUCCESS\r").arg(sppAddress).toLatin1());
                                }
                                
                                // Restart
                                QProcess restart;
                                restart.start("sleep 5");
                                restart.waitForFinished();
                                restart.start("sudo reboot");
                                restart.waitForFinished();

                            }else{
                                // Update Failed
                                if(sppAddress != NULL){
                                    writeData(QString("SEND %1 UPDATE_FAILED\r").arg(sppAddress).toLatin1());
                                }
                            }
                    }

                    );     
                    // Run for 5 mins 
                    updateProcess.waitForFinished(300000);    
                    sendDelayed(QString("SEND %1 UPDATE_FAILED\r").arg(sppAddress).toLatin1(),300000);

                    // If after 10 mins send failed
                    // if(sppAddress != NULL){
                    //     writeData(QString("SEND %1 UPDATE_FAILED\r").arg(sppAddress).toLatin1());
                    // }           
                }

                // qDebug() << "Update Code: " << updateProcess.exitCode();
                


             }

            // ***** CONTROLLER COMMANDS *****//

            //TODO: CHANGE TO RECORD
            else if(msgSplit[3]=="GPIO"){
                toggleRecord();
            }
            
            else if(msgSplit[3]=="MENU"){
                controllerToggleMenu();
            }

            else if(msgSplit[3]=="MUSIC"){
                // triggerMusic();
                controllerToggleMusic();
            }

            else if (msgSplit[3]=="REDBRIGHT"){
                controllerReduceBrightness();

            }

            else if (msgSplit[3]=="INCBRIGHT"){
                controllerIncreaseBrightness();

            }

            else if (msgSplit[3]=="TAKEPIC"){
                controllerTakePic();
            }

            else if (msgSplit[3]=="NEXTSONG"){
                if(avrcpAddress != NULL){
                    writeData(QString("MUSIC %1 FORWARD\r").arg(avrcpAddress).toLatin1());
                }
                
                
            }

            else if (msgSplit[3]=="PREVSONG"){                
                
                if(avrcpAddress != NULL){
                    writeData(QString("MUSIC %1 BACKWARD\r").arg(avrcpAddress).toLatin1());
                }
            }   

            else if (msgSplit[3]=="CONNECT_CONTROLLER"){
                writeData(QString("SCAN 5\r").toLatin1());
                if(bleControllerUUID!=NULL && sppAddress!=NULL){
                    sendDelayed(QString("SEND %1 CONTROLLER_CONNECTED\r").arg(sppAddress).toLatin1());
                    
                    // writeData(QString("SEND %1 CONTROLLER_CONNECTED\r").arg(sppAddress).toLatin1());
                }
            }           

    }
 

    else if (msgSplit[0] == "CALL_ACTIVE"){
        callActiveState = true;
    }

    else if (msgSplit[0] == "SCO_CLOSE"){
        callActiveState = false;
        callTriggeredState = false;
    }

    else if (msgSplit[0] == "CALL_END"){
        callActiveState = false;
        callTriggeredState = false;
        qDebug() << "ending call... ";
        QMetaObject::invokeMethod(this->par, "showCall",Q_ARG(QVariant, ""),Q_ARG(QVariant, ""),Q_ARG(QVariant, false));

    }

    else if (msgSplit[0].split(":")[0]=="FN"){
        tempName = msg.mid(3);
    }

    //Depreccated?
    else if (msgSplit[0].split(":")[0]=="TEL;CELL"){
        //qDebug() <<"Saving "<<msgSplit[0].split(":")[1]<<" for "<<tempName;
        QString phoneNumber =  msgSplit[0].split(":")[1];
        if(phoneNumber[0]=="+"){
            QProcess parseNumber;
            QString command = QString("python3 parseNumber.py %1").arg(phoneNumber);
//                qDebug() << command ;
            parseNumber.start(command);
            parseNumber.waitForFinished();
            phoneNumber = parseNumber.readAllStandardOutput();\

            phoneNumber = phoneNumber.simplified();
        }
        qDebug() <<"Saving "<<phoneNumber<<" for "<<tempName;
        phoneBook[phoneNumber.toStdString()] = tempName.toStdString();

    }

    else if(msgSplit[0]=="BATTERY_STATUS" && msgSplit[1]=="DISABLED"){
        QString timestamp = QDateTime::currentDateTime().toString("yyyy-MM-dd__HH_mm_ss");
        // QString appendVoltageFile = QString("sudo sh /home/pi/Argon20/scripts/logVoltage.sh %1 %2").arg(timestamp).arg(msgSplit[2]);
        // qDebug() << appendVoltageFile;
        // QProcess appendvoltage;
        // appendvoltage.start(appendVoltageFile);
        // appendvoltage.waitForFinished();
        // appendvoltage.close();
        QMetaObject::invokeMethod(this->par, "updateBattery",Q_ARG(QVariant, msgSplit[2]));
    }

    else if(msgSplit[0]=="CALLER_NUMBER"){
        if(sppAddress != NULL){
            writeData(QString("SEND %1 CALLER_NUMBER %2\r").arg(sppAddress).arg(msgSplit[2]).toLatin1());
        }
        
    }




}





