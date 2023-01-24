#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QApplication>

int main(int argc, char *argv[])
{
//    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
//        QApplication app(argc, argv);
//        QQmlApplicationEngine engine;
//        engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//        return app.exec();
//#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
//    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
//#endif
//    QGuiApplication app(argc, argv);
//    QQuickStyle::setStyle("Material");

//    QQmlApplicationEngine engine;
//    const QUrl url(QStringLiteral("qrc:/main.qml"));
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);

//    return app.exec();
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

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
//QCoreApplication* createApplication(int &argc, char *argv[])
//{
//    for (int i = 1; i < argc; ++i) {
//        if (!qstrcmp(argv[i], "-no-gui"))
//            return new QCoreApplication(argc, argv);
//    }
//    return new QApplication(argc, argv);
//}

//int main(int argc, char* argv[])
//{
//    QScopedPointer<QCoreApplication> app(createApplication(argc, argv));

//    if (qobject_cast<QApplication *>(app.data())) {
//       // start GUI version...
//    } else {
//       // start non-GUI version...
//    }

//    return app->exec();
//}
