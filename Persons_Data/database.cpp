#include "database.h"

DataBase::DataBase(QObject *parent)
    : QObject{parent}
{

}

bool DataBase::connect(QString plugin, QString database, QString hostname, qint16 port, QString username, QString password )
{

    db = QSqlDatabase::addDatabase(plugin);
    db.setDatabaseName( database );
    db.setHostName( hostname );
    db.setPort( port );
    db.setUserName( username );
    db.setPassword( password );

    bool ok = db.open();

    if(!ok) {
        m_sql_error = db.lastError().text();
        emit sql_ErrorChanged();
        qInfo() << "Error: " << m_sql_error;
        return false;
    }
    q = QSqlQuery(db);
    return true;
}

void DataBase::disconnect()
{
    if(db.isOpen()) {
        db.close();
        qInfo() << "connections to the Database has been closed!!!";
    }
    else
        qInfo() << "No Database connections open to close!!!";
}

bool DataBase::setData(QString fname, QString sname, qint8 age, QString address, QString phone)
{
    q.prepare("INSERT INTO " + m_table_name + "(first_name, last_name, age, address, phone_number) "
              " VALUES (?, ?, ?, ?, ?)");
    q.addBindValue(fname);
    q.addBindValue(sname);
    q.addBindValue(age);
    q.addBindValue(address);
    q.addBindValue(phone);

    if(!q.exec()) {
        m_query_error = "\nQuery Error: " + q.lastError().text();
        emit query_ErrorChanged();
        qCritical() << q.lastError().text();
        return false;
    }
    else
        qInfo() << "Inserted New Data InTo: " + m_table_name;
    return true;
}

QVector<QString> DataBase::get_first_name()
{
    QVector<QString> v_fname;
    q.exec("SELECT first_name FROM " + m_table_name);
    while (q.next()) {
        QString fname = q.value(0).toString();
        v_fname.push_back(fname);
    }
    return v_fname;
}

QVector<QString> DataBase::get_last_name()
{
    QVector<QString> v_lname;
    q.exec("SELECT last_name FROM " + m_table_name);
    while (q.next()) {
        QString lname = q.value(0).toString();
        v_lname.push_back(lname);
    }
    return v_lname;
}

QVector<qint8> DataBase::get_age()
{
    QVector<qint8> v_age;
    q.exec("SELECT age FROM " + m_table_name);
    while (q.next()) {
        qint8 age = q.value(0).toInt();
        v_age.push_back(age);
    }
    return v_age;
}

QVector<QString> DataBase::get_address()
{
    QVector<QString> v_address;
    q.exec("SELECT address FROM " + m_table_name);
    while (q.next()) {
        QString address = q.value(0).toString();
        v_address.push_back(address);
    }
    return v_address;
}

QVector<QString> DataBase::get_phone_number()
{
    QVector<QString> v_phone;
    q.exec("SELECT phone_number FROM " + m_table_name);
    while (q.next()) {
        QString phone = q.value(0).toString();
        v_phone.push_back(phone);
    }
    return v_phone;
}
