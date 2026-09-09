#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QScreen>
#include <QProcess>
#include <LayerShellQt/window.h>
#include <QQmlContext>

class SysUtils : public QObject {
    Q_OBJECT
public:
    Q_INVOKABLE void runCmd(const QString &command) {
        if (!command.isEmpty()) {
            QProcess::startDetached("sh", QStringList{"-c", command});
        }
    }
};

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    app.setApplicationName("sleex-welcome-screen");
    app.setOrganizationName("Sleex");

    QProcess::startDetached("hyprctl", QStringList{"eval", "hl.layer_rule({match = { namespace = 'welcome-screen' }, blur = false })"});

    QQmlApplicationEngine engine;
    
    SysUtils sysUtils;
    engine.rootContext()->setContextProperty("SysUtils", &sysUtils);
    
    engine.addImportPath("/usr/lib/qt6/qml");
    engine.addImportPath("/home/ardox/Documents/axos/sleex-ui-kit/src/build/qml");

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [](QObject *obj, const QUrl &) {
        if (auto window = qobject_cast<QQuickWindow*>(obj)) {
            auto lsw = LayerShellQt::Window::get(window);
            if (lsw) {
                lsw->setLayer(LayerShellQt::Window::LayerOverlay);
                lsw->setKeyboardInteractivity(LayerShellQt::Window::KeyboardInteractivityExclusive);
                lsw->setExclusiveZone(-1);
                lsw->setScope("welcome-screen");
                lsw->setAnchors(LayerShellQt::Window::Anchors(
                    LayerShellQt::Window::AnchorTop |
                    LayerShellQt::Window::AnchorBottom |
                    LayerShellQt::Window::AnchorLeft |
                    LayerShellQt::Window::AnchorRight
                ));
            }
            window->setVisible(true);
        }
    }, Qt::DirectConnection);

    const QUrl url(QStringLiteral("qrc:/SleexWelcomeScreen/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}

#include "main.moc"
