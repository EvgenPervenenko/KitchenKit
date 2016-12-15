#pragma once

#include <QObject>
#include <QQmlListProperty>
#include "ListElement.h"

class ListModel : public QObject
{
	Q_OBJECT
	Q_PROPERTY(QQmlListProperty<ListElement> data READ data NOTIFY dataChanged)
public:
	ListModel(QObject *parent = nullptr);
	~ListModel();
	
	QQmlListProperty<ListElement> data();
	
	void AddElement(ListElement *);
	
signals:
	void dataChanged();
	
private:
	static void appendData(QQmlListProperty<ListElement> *list, ListElement *value);
	static int countData(QQmlListProperty<ListElement> *list);
	static ListElement *atData(QQmlListProperty<ListElement> *list, int index);
	static void clearData(QQmlListProperty<ListElement> *list);
	
private:
	QList<ListElement *> m_data;
};
