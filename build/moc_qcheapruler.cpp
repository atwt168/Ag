/****************************************************************************
** Meta object code from reading C++ file 'qcheapruler.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../src/qcheapruler.hpp"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qcheapruler.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QCheapRuler_t {
    QByteArrayData data[14];
    char stringdata0[190];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QCheapRuler_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QCheapRuler_t qt_meta_stringdata_QCheapRuler = {
    {
QT_MOC_LITERAL(0, 0, 11), // "QCheapRuler"
QT_MOC_LITERAL(1, 12, 15), // "distanceChanged"
QT_MOC_LITERAL(2, 28, 0), // ""
QT_MOC_LITERAL(3, 29, 22), // "currentDistanceChanged"
QT_MOC_LITERAL(4, 52, 22), // "currentPositionChanged"
QT_MOC_LITERAL(5, 75, 19), // "segmentIndexChanged"
QT_MOC_LITERAL(6, 95, 11), // "pathChanged"
QT_MOC_LITERAL(7, 107, 8), // "distance"
QT_MOC_LITERAL(8, 116, 15), // "currentDistance"
QT_MOC_LITERAL(9, 132, 12), // "segmentIndex"
QT_MOC_LITERAL(10, 145, 15), // "currentPosition"
QT_MOC_LITERAL(11, 161, 14), // "QGeoCoordinate"
QT_MOC_LITERAL(12, 176, 4), // "path"
QT_MOC_LITERAL(13, 181, 8) // "QJSValue"

    },
    "QCheapRuler\0distanceChanged\0\0"
    "currentDistanceChanged\0currentPositionChanged\0"
    "segmentIndexChanged\0pathChanged\0"
    "distance\0currentDistance\0segmentIndex\0"
    "currentPosition\0QGeoCoordinate\0path\0"
    "QJSValue"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QCheapRuler[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       5,   44, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   39,    2, 0x06 /* Public */,
       3,    0,   40,    2, 0x06 /* Public */,
       4,    0,   41,    2, 0x06 /* Public */,
       5,    0,   42,    2, 0x06 /* Public */,
       6,    0,   43,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       7, QMetaType::Double, 0x00495001,
       8, QMetaType::Double, 0x00495103,
       9, QMetaType::UInt, 0x00495001,
      10, 0x80000000 | 11, 0x00495009,
      12, 0x80000000 | 13, 0x0049510b,

 // properties: notify_signal_id
       0,
       1,
       3,
       2,
       4,

       0        // eod
};

void QCheapRuler::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<QCheapRuler *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->distanceChanged(); break;
        case 1: _t->currentDistanceChanged(); break;
        case 2: _t->currentPositionChanged(); break;
        case 3: _t->segmentIndexChanged(); break;
        case 4: _t->pathChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (QCheapRuler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QCheapRuler::distanceChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (QCheapRuler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QCheapRuler::currentDistanceChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (QCheapRuler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QCheapRuler::currentPositionChanged)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (QCheapRuler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QCheapRuler::segmentIndexChanged)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (QCheapRuler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QCheapRuler::pathChanged)) {
                *result = 4;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 3:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QGeoCoordinate >(); break;
        case 4:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<QCheapRuler *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< double*>(_v) = _t->distance(); break;
        case 1: *reinterpret_cast< double*>(_v) = _t->currentDistance(); break;
        case 2: *reinterpret_cast< uint*>(_v) = _t->segmentIndex(); break;
        case 3: *reinterpret_cast< QGeoCoordinate*>(_v) = _t->currentPosition(); break;
        case 4: *reinterpret_cast< QJSValue*>(_v) = _t->path(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<QCheapRuler *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 1: _t->setCurrentDistance(*reinterpret_cast< double*>(_v)); break;
        case 4: _t->setPath(*reinterpret_cast< QJSValue*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject QCheapRuler::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_QCheapRuler.data,
    qt_meta_data_QCheapRuler,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *QCheapRuler::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QCheapRuler::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_QCheapRuler.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int QCheapRuler::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 5;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QCheapRuler::distanceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void QCheapRuler::currentDistanceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void QCheapRuler::currentPositionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void QCheapRuler::segmentIndexChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void QCheapRuler::pathChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
