#ifdef QT_WIDGETS_LIB
#include <QApplication>
#else
#include <QGuiApplication>
#endif

#include <QIcon>
#include <QQmlApplicationEngine>
#include <qqml.h>

#include "qcheapruler.hpp"
#include <QQuickItem>

#include <QtBluetooth/qlowenergyadvertisingdata.h>
#include "process.h"
#include <QGeoPositionInfoSource>


#include <QtSerialPort/QtSerialPort>
#include "myserialport.h"
#include <QProcess> 
#include <QCloseEvent>
#include <QtCore>
 


int main(int argc, char *argv[]){
    qputenv("QT_QUICK_CONTROLS_STYLE", "material");
    qputenv("QT_QUICK_CONTROLS_MATERIAL_THEME", "Dark");
    qputenv("QT_QUICK_CONTROLS_MATERIAL_ACCENT", "White");
    qputenv("QT_DEBUG_PLUGINS", "0");
    qputenv("QT_NO_DEBUG", "1");
    qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH","640");
    qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT","480");

    QProcess camSettings;
    // Front camera exposure settings
    camSettings.startDetached("v4l2-ctl -d /dev/video1 --set-ctrl exposure_auto=3"); 
    camSettings.waitForFinished();

    camSettings.startDetached("v4l2-ctl -d /dev/video0 --set-ctrl brightness=70");
    camSettings.waitForFinished();

    camSettings.startDetached("v4l2-ctl -d /dev/video0 --set-ctrl contrast=50");
    camSettings.waitForFinished();

    camSettings.startDetached("v4l2-ctl -d /dev/video0 --set-ctrl color_effects=14");
    camSettings.waitForFinished();

    camSettings.startDetached("v4l2-ctl -d /dev/video0 --set-ctrl exposure_dynamic_framerate=1");
    camSettings.waitForFinished();

    camSettings.startDetached("v4l2-ctl -d /dev/video0 --set-ctrl auto_exposure_bias=5");
    camSettings.waitForFinished();

    camSettings.close();

#ifdef QT_WIDGETS_LIB
    QApplication app(argc, argv);
#else
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
#endif


    // app.setWindowIcon(QIcon(":icon.png"));

    qmlRegisterType<QCheapRuler>("com.mapbox.cheap_ruler", 1, 0, "CheapRuler");
    qmlRegisterType<Process>("Process", 1, 0, "Process");
//    qmlRegisterType<QlChannelSerial>("QlChannelSerial", 1,0, "QlChannelSerial");
//    qmlRegisterType<MySerialPort>("MySerialPort", 1,0, "MySerialPort");
    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:qml/Window1.qml")));

    QQmlComponent component(&engine, "qrc:qml/Main.qml");
    QObject *object = component.create();

    MySerialPort iSerialPort(object);
    iSerialPort.openSerialPort();
    return app.exec();
}


