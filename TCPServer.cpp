#include <QTcpServer>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QVariant>
#include <QVariantMap>
#include <QException>
#include <QDateTime>
#include "TCPServer.h"

TCPServer::TCPServer(QObject *parent) : 
    QObject(parent), 
    activeSocket(nullptr)
{
    server = new QTcpServer(this);

    connect(server, SIGNAL(newConnection()), this, SLOT(onNewConnection()));
    if (!server->listen(QHostAddress::Any, 9122)) {
        qDebug() <<  QObject::tr("Unable to start the server: %1.").arg(server->errorString());
    } else {
        //server_status=1;
        qDebug() << QString::fromUtf8("Сервер запущен!");
    }
}

void TCPServer::onNewConnection()
{
    qDebug() << "new connection!";
    activeSocket = server->nextPendingConnection();
    connect(activeSocket, SIGNAL(readyRead()), this, SLOT(slotReadClient()));
	connect(activeSocket, SIGNAL(disconnected()), activeSocket, SLOT(deleteLater()));
}

void TCPServer::slotReadClient()
{
    qDebug() << "read data";
    QByteArray data;
    QJsonDocument jsonDoc;
    QVariantMap orderContent, oc;
    QJsonParseError jpe;
    data = activeSocket->readAll();
    try {
        jsonDoc = QJsonDocument::fromJson(data, &jpe);
//        qDebug() << "jsonDoc: " << jsonDoc;
//        qDebug() << "jsonParseError: " << jpe.errorString();
        if(jpe.error == QJsonParseError::NoError) {
            orderContent = qvariant_cast<QVariantMap>(QJsonDocument::fromJson( data ).object());
//            qDebug() << "orderContent: " << orderContent;
            if(orderContent.contains("title") && orderContent.contains("qty") && orderContent.contains("comment")) {
                oc.clear();
                oc["title"] = orderContent["title"].toString();
                oc["time"] = QDateTime::currentDateTime().toString("HH:mm:ss");
                oc["qty"] = orderContent["qty"].toString();
                oc["comment"] = orderContent["comment"].toString();
                oc["order_number"] = orderContent["order_number"].toString();
                oc["hall_name"] = orderContent["hall_name"].toString();
                oc["table_number"] = orderContent["table_number"].toString();
				oc["ingredients"] = orderContent["ingredients"].toString();
				oc["method"] = orderContent["method"].toString();
				oc["cookingTime"] = orderContent["cookingTime"].toInt();
				oc["mass"] = orderContent["mass"].toString();
				oc["startTime"] = orderContent["startTime"].toString();
				oc["count"] = orderContent["count"].toInt();
				oc["picture"] = orderContent["picture"].toString();
                emit newOrderContentTask(oc);
            }
        }
    } catch (QJsonParseError *e) {
        qDebug() << "json parse exception: " << e->errorString();
    } catch (QException *qe){
        qDebug() << "some exception";
    }

//    qDebug() << "getted data: " << data;
}
