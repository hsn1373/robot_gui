#include "mythread.h"

using namespace std;

mythread::mythread(QList<QString> *final_Generated_Gcodes,QSerialPort *serialport,QObject *parent) : QObject(parent)
{
    this->_final_Generated_Gcodes=final_Generated_Gcodes;
    this->_serialport=serialport;
    _stop_send_data_flag=false;
}

void mythread::delay()
{
    QThread::msleep(500);
}

void mythread::writeSerialData()
{
    for(int i=0;i<_final_Generated_Gcodes->length();i++)
    {
        if(_stop_send_data_flag)
        {
            emit sendDataDone();
            break;
        }
        else
        {
            qDebug() << _final_Generated_Gcodes->at(i);
            delay();
        }
    }

    //bool res=writeDate(_final_Generated_Gcodes->at(2));
    //qDebug() << res;

    emit sendDataDone();
}

void mythread::stopWriteSerialData()
{
    _stop_send_data_flag=true;
}

bool mythread::writeDate(QString val)
{
    try
    {
        _serialport->write(val.toUtf8());
        return true;
    }
    catch (exception ex)
    {
        qDebug() << "error write date:" << ex.what();
        return false;
    }
}
