#ifndef MYTHREAD_H
#define MYTHREAD_H

#include <QObject>
#include <QDebug>
#include <QSerialPort>
#include <QThread>

class mythread : public QObject
{
    Q_OBJECT
public:
    explicit mythread(QList<QString> *,QSerialPort *,QObject *parent = nullptr);
    void delay();

signals:
    void sendDataDone();

private:
    bool _stop_send_data_flag;
    QSerialPort *_serialport;
    QList<QString> *_final_Generated_Gcodes;

public slots:
    void writeSerialData();
    void stopWriteSerialData();
    bool writeDate(QString val);

};

#endif // MYTHREAD_H
