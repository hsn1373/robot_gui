#include "mythread.h"

using namespace std;

mythread::mythread(QList<QString> *final_Generated_Gcodes,QSerialPort *serialport,int *serial_delay,QObject *parent) : QObject(parent)
{
    m_mutex.lock();
    this->_final_Generated_Gcodes=final_Generated_Gcodes;
    this->_serialport=serialport;
    this->_serial_delay=serial_delay;
    qDebug() << "delaaaay" <<this->_serial_delay;
    _stop_send_data_flag=false;
    m_mutex.unlock();

}

void mythread::delay()
{
    QThread::msleep(500);
}

void mythread::writeSerialData()
{
    bool res=false;

//    QFile file("output.txt");
//    if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
//        qDebug() << "Can not open file!";
//    QTextStream out(&file);

    for(int i=0;i<_final_Generated_Gcodes->length();i++)
    {
//        if(_stop_send_data_flag)
//        {
//            emit sendDataDone();
//            break;
//        }
//        else
//        {
//            res=writeDate(_final_Generated_Gcodes->at(i));
//            qDebug() << _final_Generated_Gcodes->at(i);
//            qDebug() << res;
//            delay();
//        }
       // std::string str=_final_Generated_Gcodes->at(i).toStdString();
       //const char *p=str.c_str();
        //res=writeDate(p);
        //m_mutex.lock();
        res=writeDate(_final_Generated_Gcodes->at(i));
        qDebug() << _final_Generated_Gcodes->at(i);
        //out << _final_Generated_Gcodes->at(i);
        //qDebug() << res;
        delay();
        //m_mutex.unlock();
        //readSerialPort();
    }

//    res=writeDate("G28 WVZXY\n");
//    qDebug() << "G28 WVZXY\n";
//    qDebug() << res;

    //bool res=writeDate(_final_Generated_Gcodes->at(2));
    //qDebug() << res;
    //file.close();
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
        _serialport->flush();
        return true;
    }
    catch (exception ex)
    {
        qDebug() << "error write date:" << ex.what();
        return false;
    }
}

void mythread::readSerialPort()
{
    _serialport->readAll();
}
