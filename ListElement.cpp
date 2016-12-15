#include "ListElement.h"

ListElement::ListElement(QObject *parent): 
    QObject(parent), 
    m_title("title"),
	m_picture("qrc:/pics/fruit-salad.jpg"),
    m_ingredients("{\"* ingredients\" : \"\"}"),
	m_method("m_method"),
	m_cookingTime(60),
	m_mass("m_mass"),
	m_startTime("12:45"),
	m_count(1)
{
	
}

ListElement::ListElement(const ListElement &other):
    QObject(nullptr), 
    m_title(other.m_title),
	m_picture(other.m_picture),
	m_ingredients(other.m_ingredients),
	m_method(other.m_method),
	m_cookingTime(other.m_cookingTime),
	m_mass(other.m_mass),
	m_startTime(other.m_startTime),
	m_count(other.m_count)
{
}

const ListElement &ListElement::operator=(const ListElement &other)
{
	if ( &other != this )
	{
		m_title = other.m_title;
		m_picture = other.m_picture;
		m_ingredients = other.m_ingredients;
		m_method = other.m_method;
		m_cookingTime = other.m_cookingTime;
		m_mass = other.m_mass;
		m_startTime = other.m_startTime;
		m_count = other.m_count;
	}
	
	return *this;
}

QString ListElement::title() const
{
	return m_title;
}

void ListElement::setTitle(const QString &title)
{
	if( m_title != title )
	{
		m_title = title;
		emit titleChanged( title );
	}
}

QString ListElement::picture() const
{
	return m_picture;
}

void ListElement::setPicture(const QString &picture)
{
	if( m_picture != picture )
	{
		m_picture = picture;
		emit pictureChanged( picture );
	}
}

QString ListElement::ingredients() const
{
	return m_ingredients;
}

void ListElement::setIngredients(const QString &ingredients)
{
	if( m_ingredients != ingredients )
	{
		m_ingredients = ingredients;
		emit ingredientsChanged(ingredients);
	}
}

QString ListElement::method() const
{
	return m_method;
}

void ListElement::setMethod(const QString &method)
{
	if( m_method != method )
	{
		m_method = method;
		emit methodChanged(method);
	}
}

int ListElement::cookingTime() const
{
	return m_cookingTime;
}

void ListElement::setCookingTime(int cookingTime)
{
	if( m_cookingTime != cookingTime )
	{
		m_cookingTime = cookingTime;
		emit cookingTimeChanged(cookingTime);
	}
}

QString ListElement::mass() const
{
	return m_mass;
}

void ListElement::setMass(const QString &mass)
{
	if( m_mass != mass )
	{
		m_mass = mass;
		emit massChanged(mass);
	}
}

QString ListElement::startTime() const
{
	return m_startTime;
}

void ListElement::setStartTime(const QString &startTime)
{
	if( m_startTime != startTime )
	{
		m_startTime = startTime;
		emit startTimeChanged(startTime);
	}
}

int ListElement::count() const
{
	return m_count;
}

void ListElement::setCount(int count)
{
	if( m_count != count )
	{
		m_count = count;
		emit countChanged(count);
	}
}
