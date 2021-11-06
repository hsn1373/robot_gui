#ifndef MYTHREAD_H
#define MYTHREAD_H

#include <QObject>
#include <QDebug>
#include <QSerialPort>
#include <QThread>
#include <string>
#include <QMutex>
#include <QFile>

using namespace std;

class mythread : public QObject
{
    Q_OBJECT
public:
    explicit mythread(QList<QString> *,QSerialPort *,double *,QObject *parent = nullptr);
    void delay();

signals:
    void sendDataDone();

private:
    bool _stop_send_data_flag;
    double *_serial_delay;
    QSerialPort *_serialport;
    QList<QString> *_final_Generated_Gcodes;
    QMutex m_mutex;


public slots:
    void writeSerialData();
    void stopWriteSerialData();
    bool writeDate(QString val);
    void readSerialPort();

};

#endif // MYTHREAD_H
