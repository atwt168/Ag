TARGET = qmapboxglapp
TEMPLATE = app

QT += qml network quick positioning location sql widgets core bluetooth serialport multimedia

CONFIG += c++14
CONFIG(release):DEFINES += QT_NO_DEBUG_OUTPUT

ios|android {
    QT -= widgets
}

SOURCES += \
    src/qmapboxglapp.cpp \
    src/qcheapruler.cpp \
    src/myserialport.cpp



HEADERS += \
    src/qcheapruler.hpp \
    src/process.h \
    src/myserialport.h



INCLUDEPATH += \
    include \
    WiringPi-Qt

OTHER_FILES += \
    src/qmapboxlgapp.qml

RESOURCES += \
    assets/assets.qrc \
    src/qmapboxglapp.qrc

LIBS += -lwiringPi
