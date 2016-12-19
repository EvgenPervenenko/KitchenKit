#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include "TCPServer.h"

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication app(argc, argv);
	
	QQuickStyle::setStyle("Material");
	
	QQmlApplicationEngine engine;
	
	auto tcpServer = QSharedPointer<TCPServer>::create();
	engine.rootContext()->setContextProperty("tcpServer", tcpServer.data());
	
	engine.load(QUrl(QLatin1String("qrc:/KitchenKit.qml")));
	
	return app.exec();
}
