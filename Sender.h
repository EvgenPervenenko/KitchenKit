#pragma once

#include <QObject>
#include "ListModel.h"

class Sender : public QObject
{
	Q_OBJECT
public:
	Sender(QObject *parent = nullptr);
	
	virtual void timerEvent(QTimerEvent *event);
	
signals:
	void send(ListModel *model);
	
private:
	int _timerId;
};
