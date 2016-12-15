#include "ListModel.h"

ListModel::ListModel(QObject *parent): 
    QObject(parent)
{
	
}

ListModel::~ListModel()
{
	for( auto *data : m_data )
	{
		delete data;
	}
}

QQmlListProperty<ListElement> ListModel::data()
{
	return QQmlListProperty<ListElement>(static_cast<QObject *>(this), static_cast<void *>(&m_data),
	                                     &ListModel::appendData, &ListModel::countData,
	                                     &ListModel::atData, &ListModel::clearData);
}

void ListModel::AddElement(ListElement *elem)
{
	if( elem )
		m_data.append( elem );
}

void ListModel::appendData(QQmlListProperty<ListElement> *list, ListElement *value)
{
    QList<ListElement*> *data = static_cast<QList<ListElement*> *>(list->data);
    data->append(value);
}

int ListModel::countData(QQmlListProperty<ListElement> *list)
{
    QList<ListElement*> *data = static_cast<QList<ListElement*> *>(list->data);
    return data->size();
}

ListElement *ListModel::atData(QQmlListProperty<ListElement> *list, int index)
{
    QList<ListElement*> *data = static_cast<QList<ListElement*> *>(list->data);
    return data->at(index);
}

void ListModel::clearData(QQmlListProperty<ListElement> *list)
{
    QList<ListElement*> *data = static_cast<QList<ListElement*> *>(list->data);
    qDeleteAll(data->begin(), data->end());
    data->clear();
}
