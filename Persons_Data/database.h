#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QDebug>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlDriver>
#include <QSqlQuery>
#include <QSqlError>
#include <QVariant>
#include <QString>
#include <QVector>


class DataBase : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString table_name MEMBER m_table_name)
    Q_PROPERTY(QString sql_error MEMBER m_sql_error NOTIFY sql_ErrorChanged FINAL)
    Q_PROPERTY(QString query_error MEMBER m_query_error NOTIFY query_ErrorChanged FINAL)
public:
    explicit DataBase(QObject *parent = nullptr);

signals:

    void sql_ErrorChanged();
    void query_ErrorChanged();

public slots:

    bool connect( QString, QString, QString, qint16, QString, QString );
    void disconnect();
    bool setData( QString, QString, qint8, QString, QString );
    QVector<QString> get_first_name();
    QVector<QString> get_last_name();
    QVector<qint8> get_age();
    QVector<QString> get_address();
    QVector<QString> get_phone_number();


private:
    QSqlDatabase db;
    QSqlQuery q;    
    QString m_table_name;
    QString m_sql_error;
    QString m_query_error;
};

#endif // DATABASE_H
