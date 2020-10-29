#include <QDialog>

#include <qbluetoothserviceinfo.h>
#include <qbluetoothsocket.h>
#include <qbluetoothhostinfo.h>

#include <QDebug>
#include <qquickview.h>

QT_USE_NAMESPACE

class ChatServer;
class ChatClient;

//! [declaration]
class Chat : public QObject
{
    Q_OBJECT

public:
    explicit Chat(QObject *parent);
    ~Chat();
    QObject *par;

signals:
    void sendMessage(const QString &message);

private slots:

    void showMessage(const QString &sender, const QString &message);

    void clientConnected(const QString &name);
    void clientDisconnected(const QString &name);
    void clientDisconnected();
    void connected(const QString &name);



private:



    ChatServer *server;
    QList<ChatClient *> clients;
    QList<QBluetoothHostInfo> localAdapters;

    QString localName;
};
//! [declaration]

