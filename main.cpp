#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "ListElement.h"
#include "ListModel.h"
#include "Sender.h"

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication app(argc, argv);
	
	qmlRegisterType<ListElement>();
	qmlRegisterType<ListModel>();
	Sender sender;
	
	QQmlApplicationEngine engine;
	QQmlContext *context(engine.rootContext());
	context->setContextProperty( "sender", &sender );
	
	engine.load(QUrl(QLatin1String("qrc:/main.qml")));
	
	return app.exec();
}
