#ifndef MYTHREAD_H
#define MYTHREAD_H

#include <QObject>
#include <QDebug>
#include <QSerialPort>

class mythread : public QObject
{
    Q_OBJECT
public:
    explicit mythread(QList<QString> *,QSerialPort *,QObject *parent = nullptr);

signals:

private:
    QSerialPort *_serialport;
    QList<QString> *_final_Generated_Gcodes;

public slots:
    void writeSerialData();
    bool writeDate(QString val);

};

#endif // MYTHREAD_H
