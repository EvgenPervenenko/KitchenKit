#include "Sender.h"

#include "ListElement.h"

Sender::Sender(QObject *parent) :
    QObject(parent)
{
	_timerId = startTimer( 1000 );
}

void Sender::timerEvent(QTimerEvent *)
{
	killTimer(_timerId);
	
	ListModel *model(new ListModel(this));
	ListElement *elem(new ListElement(model));
	ListElement *elem2(new ListElement(model));
	ListElement *elem3(new ListElement(model));
	model->AddElement(elem);
	model->AddElement(elem2);
	model->AddElement(elem3);
	
	emit send( model );
}
