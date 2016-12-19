#pragma once

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QVariant>
#include <QVariantMap>

class TCPServer : public QObject
{
    Q_OBJECT
public:
    explicit TCPServer(QObject *parent = 0);

Q_SIGNALS:
    void newOrderContentTask(QVariantMap orderItem);
signals:

public slots:
    void onNewConnection();
    //void onMessage();
    void slotReadClient();
	
private:
    QTcpServer *server;
    QTcpSocket *activeSocket;
};
