/****************************************************************************
** Meta object code from reading C++ file 'myserialport.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../src/myserialport.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'myserialport.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_MySerialPort_t {
    QByteArrayData data[55];
    char stringdata0[664];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MySerialPort_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MySerialPort_t qt_meta_stringdata_MySerialPort = {
    {
QT_MOC_LITERAL(0, 0, 12), // "MySerialPort"
QT_MOC_LITERAL(1, 13, 7), // "cppSend"
QT_MOC_LITERAL(2, 21, 0), // ""
QT_MOC_LITERAL(3, 22, 7), // "textOut"
QT_MOC_LITERAL(4, 30, 14), // "openSerialPort"
QT_MOC_LITERAL(5, 45, 15), // "closeSerialPort"
QT_MOC_LITERAL(6, 61, 9), // "writeData"
QT_MOC_LITERAL(7, 71, 4), // "data"
QT_MOC_LITERAL(8, 76, 8), // "priority"
QT_MOC_LITERAL(9, 85, 8), // "readData"
QT_MOC_LITERAL(10, 94, 11), // "handleError"
QT_MOC_LITERAL(11, 106, 28), // "QSerialPort::SerialPortError"
QT_MOC_LITERAL(12, 135, 5), // "error"
QT_MOC_LITERAL(13, 141, 13), // "handleCommand"
QT_MOC_LITERAL(14, 155, 3), // "msg"
QT_MOC_LITERAL(15, 159, 11), // "handleMusic"
QT_MOC_LITERAL(16, 171, 6), // "artist"
QT_MOC_LITERAL(17, 178, 4), // "song"
QT_MOC_LITERAL(18, 183, 5), // "activ"
QT_MOC_LITERAL(19, 189, 11), // "resetValues"
QT_MOC_LITERAL(20, 201, 11), // "triggerRear"
QT_MOC_LITERAL(21, 213, 7), // "appCall"
QT_MOC_LITERAL(22, 221, 11), // "triggerMaps"
QT_MOC_LITERAL(23, 233, 12), // "triggerMusic"
QT_MOC_LITERAL(24, 246, 12), // "toggleRecord"
QT_MOC_LITERAL(25, 259, 17), // "toggleFrontRecord"
QT_MOC_LITERAL(26, 277, 5), // "start"
QT_MOC_LITERAL(27, 283, 16), // "toggleRearRecord"
QT_MOC_LITERAL(28, 300, 11), // "takePicture"
QT_MOC_LITERAL(29, 312, 10), // "toggleWifi"
QT_MOC_LITERAL(30, 323, 11), // "toggleAudio"
QT_MOC_LITERAL(31, 335, 10), // "toggleGPIO"
QT_MOC_LITERAL(32, 346, 7), // "gpioNum"
QT_MOC_LITERAL(33, 354, 3), // "val"
QT_MOC_LITERAL(34, 358, 13), // "updateBattery"
QT_MOC_LITERAL(35, 372, 14), // "adjustLEDValue"
QT_MOC_LITERAL(36, 387, 18), // "controllerNextSong"
QT_MOC_LITERAL(37, 406, 18), // "controllerPrevSong"
QT_MOC_LITERAL(38, 425, 20), // "controllerToggleMenu"
QT_MOC_LITERAL(39, 446, 28), // "controllerIncreaseBrightness"
QT_MOC_LITERAL(40, 475, 26), // "controllerReduceBrightness"
QT_MOC_LITERAL(41, 502, 17), // "controllerTakePic"
QT_MOC_LITERAL(42, 520, 21), // "controllerToggleMusic"
QT_MOC_LITERAL(43, 542, 8), // "hasMedia"
QT_MOC_LITERAL(44, 551, 12), // "checkCameras"
QT_MOC_LITERAL(45, 564, 10), // "getVersion"
QT_MOC_LITERAL(46, 575, 11), // "sendVersion"
QT_MOC_LITERAL(47, 587, 11), // "sendDelayed"
QT_MOC_LITERAL(48, 599, 1), // "s"
QT_MOC_LITERAL(49, 601, 5), // "delay"
QT_MOC_LITERAL(50, 607, 15), // "setCurrentState"
QT_MOC_LITERAL(51, 623, 7), // "address"
QT_MOC_LITERAL(52, 631, 4), // "link"
QT_MOC_LITERAL(53, 636, 12), // "checkCamWifi"
QT_MOC_LITERAL(54, 649, 14) // "getDeviceState"

    },
    "MySerialPort\0cppSend\0\0textOut\0"
    "openSerialPort\0closeSerialPort\0writeData\0"
    "data\0priority\0readData\0handleError\0"
    "QSerialPort::SerialPortError\0error\0"
    "handleCommand\0msg\0handleMusic\0artist\0"
    "song\0activ\0resetValues\0triggerRear\0"
    "appCall\0triggerMaps\0triggerMusic\0"
    "toggleRecord\0toggleFrontRecord\0start\0"
    "toggleRearRecord\0takePicture\0toggleWifi\0"
    "toggleAudio\0toggleGPIO\0gpioNum\0val\0"
    "updateBattery\0adjustLEDValue\0"
    "controllerNextSong\0controllerPrevSong\0"
    "controllerToggleMenu\0controllerIncreaseBrightness\0"
    "controllerReduceBrightness\0controllerTakePic\0"
    "controllerToggleMusic\0hasMedia\0"
    "checkCameras\0getVersion\0sendVersion\0"
    "sendDelayed\0s\0delay\0setCurrentState\0"
    "address\0link\0checkCamWifi\0getDeviceState"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MySerialPort[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      40,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,  214,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    0,  217,    2, 0x0a /* Public */,
       5,    0,  218,    2, 0x0a /* Public */,
       6,    2,  219,    2, 0x0a /* Public */,
       6,    1,  224,    2, 0x2a /* Public | MethodCloned */,
       9,    0,  227,    2, 0x0a /* Public */,
      10,    1,  228,    2, 0x0a /* Public */,
      13,    1,  231,    2, 0x0a /* Public */,
      15,    3,  234,    2, 0x0a /* Public */,
      19,    0,  241,    2, 0x0a /* Public */,
      20,    1,  242,    2, 0x0a /* Public */,
      20,    0,  245,    2, 0x2a /* Public | MethodCloned */,
      22,    1,  246,    2, 0x0a /* Public */,
      22,    0,  249,    2, 0x2a /* Public | MethodCloned */,
      23,    0,  250,    2, 0x0a /* Public */,
      24,    0,  251,    2, 0x0a /* Public */,
      25,    1,  252,    2, 0x0a /* Public */,
      27,    1,  255,    2, 0x0a /* Public */,
      28,    0,  258,    2, 0x0a /* Public */,
      29,    0,  259,    2, 0x0a /* Public */,
      30,    0,  260,    2, 0x0a /* Public */,
      31,    2,  261,    2, 0x0a /* Public */,
      34,    0,  266,    2, 0x0a /* Public */,
      35,    1,  267,    2, 0x0a /* Public */,
      36,    0,  270,    2, 0x0a /* Public */,
      37,    0,  271,    2, 0x0a /* Public */,
      38,    0,  272,    2, 0x0a /* Public */,
      39,    0,  273,    2, 0x0a /* Public */,
      40,    0,  274,    2, 0x0a /* Public */,
      41,    0,  275,    2, 0x0a /* Public */,
      42,    0,  276,    2, 0x0a /* Public */,
      43,    0,  277,    2, 0x0a /* Public */,
      44,    0,  278,    2, 0x0a /* Public */,
      45,    0,  279,    2, 0x0a /* Public */,
      46,    0,  280,    2, 0x0a /* Public */,
      47,    2,  281,    2, 0x0a /* Public */,
      47,    1,  286,    2, 0x2a /* Public | MethodCloned */,
      50,    2,  289,    2, 0x0a /* Public */,
      53,    0,  294,    2, 0x0a /* Public */,
      54,    0,  295,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QByteArray, QMetaType::Bool,    7,    8,
    QMetaType::Void, QMetaType::QByteArray,    7,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 11,   12,
    QMetaType::Void, QMetaType::QString,   14,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Bool,   16,   17,   18,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   21,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   21,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   26,
    QMetaType::Void, QMetaType::Bool,   26,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   32,   33,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   33,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QByteArray, QMetaType::Int,   48,   49,
    QMetaType::Void, QMetaType::QByteArray,   48,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   51,   52,
    QMetaType::Void,
    QMetaType::QString,

       0        // eod
};

void MySerialPort::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<MySerialPort *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->cppSend((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->openSerialPort(); break;
        case 2: _t->closeSerialPort(); break;
        case 3: _t->writeData((*reinterpret_cast< const QByteArray(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 4: _t->writeData((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 5: _t->readData(); break;
        case 6: _t->handleError((*reinterpret_cast< QSerialPort::SerialPortError(*)>(_a[1]))); break;
        case 7: _t->handleCommand((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 8: _t->handleMusic((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3]))); break;
        case 9: _t->resetValues(); break;
        case 10: _t->triggerRear((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 11: _t->triggerRear(); break;
        case 12: _t->triggerMaps((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 13: _t->triggerMaps(); break;
        case 14: _t->triggerMusic(); break;
        case 15: _t->toggleRecord(); break;
        case 16: _t->toggleFrontRecord((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 17: _t->toggleRearRecord((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 18: _t->takePicture(); break;
        case 19: _t->toggleWifi(); break;
        case 20: _t->toggleAudio(); break;
        case 21: _t->toggleGPIO((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 22: _t->updateBattery(); break;
        case 23: _t->adjustLEDValue((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 24: _t->controllerNextSong(); break;
        case 25: _t->controllerPrevSong(); break;
        case 26: _t->controllerToggleMenu(); break;
        case 27: _t->controllerIncreaseBrightness(); break;
        case 28: _t->controllerReduceBrightness(); break;
        case 29: _t->controllerTakePic(); break;
        case 30: _t->controllerToggleMusic(); break;
        case 31: { bool _r = _t->hasMedia();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 32: { bool _r = _t->checkCameras();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 33: { QString _r = _t->getVersion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 34: _t->sendVersion(); break;
        case 35: _t->sendDelayed((*reinterpret_cast< const QByteArray(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 36: _t->sendDelayed((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 37: _t->setCurrentState((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 38: _t->checkCamWifi(); break;
        case 39: { QString _r = _t->getDeviceState();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (MySerialPort::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&MySerialPort::cppSend)) {
                *result = 0;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject MySerialPort::staticMetaObject = { {
    &QSerialPort::staticMetaObject,
    qt_meta_stringdata_MySerialPort.data,
    qt_meta_data_MySerialPort,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *MySerialPort::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MySerialPort::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_MySerialPort.stringdata0))
        return static_cast<void*>(this);
    return QSerialPort::qt_metacast(_clname);
}

int MySerialPort::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QSerialPort::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 40)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 40;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 40)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 40;
    }
    return _id;
}

// SIGNAL 0
void MySerialPort::cppSend(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
