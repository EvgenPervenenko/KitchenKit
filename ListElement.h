#pragma once

#include <QObject>

class ListElement : public QObject
{
	Q_OBJECT
	Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
	Q_PROPERTY(QString picture READ picture WRITE setPicture NOTIFY pictureChanged)
	Q_PROPERTY(QString ingredients READ ingredients WRITE setIngredients NOTIFY ingredientsChanged)
	Q_PROPERTY(QString method READ method WRITE setMethod NOTIFY methodChanged)
	Q_PROPERTY(int cookingTime READ cookingTime WRITE setCookingTime NOTIFY cookingTimeChanged)
	Q_PROPERTY(QString mass READ mass WRITE setMass NOTIFY massChanged)
	Q_PROPERTY(QString startTime READ startTime WRITE setStartTime NOTIFY startTimeChanged)
	Q_PROPERTY(int count READ count WRITE setCount NOTIFY countChanged)
	
public:
	ListElement(QObject *parent = nullptr);
	ListElement(const ListElement &other);
	
	const ListElement &operator=( const ListElement & );
	
	QString title() const;
	void setTitle(const QString &title);
	
	QString picture() const;
	void setPicture(const QString &picture);
	
	QString ingredients() const;
	void setIngredients(const QString &ingredients);
	
	QString method() const;
	void setMethod(const QString &method);
	
	int cookingTime() const;
	void setCookingTime(int cookingTime);
	
	QString mass() const;
	void setMass(const QString &mass);
	
	QString startTime() const;
	void setStartTime(const QString &startTime);
	
	int count() const;
	void setCount(int count);
	
signals:
	void titleChanged(QString title);
	void pictureChanged(QString picture);
	void ingredientsChanged(QString ingredients);
	void methodChanged(QString method);
	void cookingTimeChanged(int cookingTime);
	void massChanged(QString mass);
	void startTimeChanged(QString startTime);
	void countChanged(int count);
	
private:
	QString m_title;
	QString m_picture;
	QString m_ingredients;
	QString m_method;
	int m_cookingTime;
	QString m_mass;
	QString m_startTime;
	int m_count;
};
