#include "chat.h"

#include "chatserver.h"
#include "chatclient.h"

#include <qbluetoothuuid.h>
#include <qbluetoothserver.h>
#include <qbluetoothservicediscoveryagent.h>
#include <qbluetoothdeviceinfo.h>
#include <qbluetoothlocaldevice.h>

#include <QTimer>

#include <QDebug>
#include <QBuffer>
#include <qquickview.h>

#include <iostream>
#include <vector>
#include <regex>

static const QLatin1String serviceUuid("e8e10f95-1a70-4b27-9ccf-02010264e9c8");

Chat::Chat(QObject *parent)
{


    //! [Create Chat Server]
    server = new ChatServer(this);
    connect(server, SIGNAL(clientConnected(QString)), this, SLOT(clientConnected(QString)));
    connect(server, SIGNAL(clientDisconnected(QString)), this, SLOT(clientDisconnected(QString)));
    connect(server, SIGNAL(messageReceived(QString,QString)), this, SLOT(showMessage(QString,QString)));
    connect(this, SIGNAL(sendMessage(QString)), server, SLOT(sendMessage(QString)));
    server->startServer();
    //! [Create Chat Server]

    //! [Get local device name]
    localName = QBluetoothLocalDevice().name();
    //! [Get local device name]

    this->par = parent;
    //QMetaObject::invokeMethod(this->par, "invertView");
    //QMetaObject::invokeMethod(this->par, "startNavigation",1.3413,103.9638,1.2941,103.8578);
    //QMetaObject::invokeMethod(this->par, "startNavigation",Q_ARG(QVariant, 1.3413),Q_ARG(QVariant, 103.9638),Q_ARG(QVariant, 1.2941),Q_ARG(QVariant, 103.8578));




}

Chat::~Chat()
{
    qDeleteAll(clients);
    delete server;
}


std::vector<std::string> split(const std::string & stringToSplit,const std::string & regexString)
{
    std::regex regexToSplitWith {regexString};
    //create a ForwardIterator of submatches for the regex regexToSplitWith
    std::sregex_token_iterator wordsIterator {stringToSplit.begin(),stringToSplit.end(),regexToSplitWith,-1};
   //return rvalue vector to utilize vector move semantics to avoid copy
    return {wordsIterator,std::sregex_token_iterator{}};
}



//! [clientConnected clientDisconnected]
void Chat::clientConnected(const QString &name)
{
    //ui->chat->insertPlainText(QString::fromLatin1("%1 has joined chat.\n").arg(name));
    qDebug() << QString::fromLatin1("%1 has joined \n").arg(name) ;
    QMetaObject::invokeMethod(this->par, "connected");
}

void Chat::clientDisconnected(const QString &name)
{
    //ui->chat->insertPlainText(QString::fromLatin1("%1 has left.\n").arg(name));
    qDebug() << QString::fromLatin1("%1 has left.\n").arg(name) ;
    QMetaObject::invokeMethod(this->par, "disconnected");
}
//! [clientConnected clientDisconnected]

//! [connected]
void Chat::connected(const QString &name)
{
    //ui->chat->insertPlainText(QString::fromLatin1("Joined chat with %1.\n").arg(name));
    qDebug() << QString::fromLatin1("Joined chat with %1.\n").arg(name);
}


//! [connected]

//! [clientDisconnected]
void Chat::clientDisconnected()
{
    ChatClient *client = qobject_cast<ChatClient *>(sender());
    if (client) {
        clients.removeOne(client);
        client->deleteLater();
    }
}
//! [clientDisconnected]



//! [showMessage]
//! Handle message stuff hereee
void Chat::showMessage(const QString &sender, const QString &message)
{

    qDebug() << "Message: " << message;
    if(message == "r"){
//        rearView->setSource(QUrl::fromLocalFile("src/qml/RearView.qml")) ;
        QMetaObject::invokeMethod(this->par, "invertView");


    }
    std::vector<std::string> msgVector = split(message.toUtf8().constData(),"\\s+");
    //qDebug() << "Message: " << QString::fromStdString(msgVector.at(0));
    std::string indicator = msgVector.at(0);


    if (indicator=="ZOOM"){
        QVariant zoomLevel = QString::fromStdString(msgVector.at(1).c_str());
        QMetaObject::invokeMethod(this->par, "setZoom",Q_ARG(QVariant, zoomLevel));

    }
    if (indicator=="STARTRIDE"){
//        double startlat = ::atof(msgVector.at(1).c_str());
//        double startlng = ::atof(msgVector.at(2).c_str());
//        double endlat = ::atof(msgVector.at(3).c_str());
//        double endlng = ::atof(msgVector.at(4).c_str());

        QVariant startlat = QString::fromStdString(msgVector.at(1).c_str());
        QVariant startlng = QString::fromStdString(msgVector.at(2).c_str());
        QVariant endlat = QString::fromStdString(msgVector.at(3).c_str());
        QVariant endlng = QString::fromStdString(msgVector.at(4).c_str());

        //QMetaObject::invokeMethod(this->par, "showMap");
        QMetaObject::invokeMethod(this->par, "startNavigation",Q_ARG(QVariant, startlat),Q_ARG(QVariant, startlng),Q_ARG(QVariant, endlat),Q_ARG(QVariant, endlng));

    }

    if(indicator =="STOPRIDE"){
        //QMetaObject::invokeMethod(this->par, "showCamera");
        QMetaObject::invokeMethod(this->par, "stopNavigation");

    }

    if(indicator =="REAR"){
        QMetaObject::invokeMethod(this->par, "showCamera");
    }

    if(indicator =="MAPS"){
        QMetaObject::invokeMethod(this->par, "showMap");
    }

    if(indicator=="SNAP"){
        server->sendMessage("HELLO");
        QImage image;        // See the documentation on how to use QImage objects
        image.load("~/Pictures/IMG_00000001.jpg", "JPG");
        QByteArray ba;              // Construct a QByteArray object
        QBuffer buffer(&ba);        // Construct a QBuffer object using the QbyteArray
        image.save(&buffer, "PNG"); // Save the QImage data into the QBuffer
        server->sendMessageBytes(buffer.data());
         qDebug() << "SENT IMAGE: " ;
    }

}
