#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QSettings>
#include "defaultsettings.h"
#include "serialport.h"

void first_run()
{
    QSettings settings;
    QStringList keys = settings.allKeys();
    //settings.setValue("darkTheme","true");
    //settings.sync();
    if (keys.size() == 0)
    {
        settings.setValue("darkTheme","true");
        settings.sync();
    }
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("HosseinHokmabadiCo");
    QCoreApplication::setOrganizationDomain("hossein.hokmabadi.com");
    QCoreApplication::setApplicationName("ROBOT_GUI");
    first_run();
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    qmlRegisterType<defaultsettings>("DefaultSettings", 1, 0, "DefaultSettings");
    qmlRegisterType<serialport>("SerialPort", 1, 0, "SerialPort");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}


