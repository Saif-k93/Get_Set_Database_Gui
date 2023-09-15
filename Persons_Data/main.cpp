#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QIcon>
#include <QQmlContext>
#include "database.h"


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/img/icon.ico"));

    QQmlApplicationEngine engine;

    qmlRegisterType<DataBase>("DataBase.h", 1, 0, "DataBase");

    const QUrl url(u"qrc:/Persons_Data/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);



    return app.exec();
}
