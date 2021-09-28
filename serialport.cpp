#include "serialport.h"


using namespace std;


serialport::serialport(QObject *parent) : QObject(parent)
{
    _serialport = new QSerialPort(this);
}

QStringList serialport::getSerialPortsList() const
{
    /**
     *  Getter function for _serial_ports_list. Read available serial
     * port list from _serial_ports_list property and copy them to
     * device_list var for show in QML ComboBox
     *
     * @param   --
     *
     * @return  Available serial port list.
     *
     * @throws  --
     */

    QStringList device_list; // Model for QML ComboBox
    foreach (QSerialPortInfo serialPortInfo, _serial_ports_list) {
        // Fill the model
        device_list.append(serialPortInfo.description() + " "
                           + serialPortInfo.manufacturer() + " ("
                           + serialPortInfo.portName() + ")");
    }
//    for(int i=0;i<4;i++)
//        device_list.append(QString::number(i));
    return device_list;
}

void serialport::open_port()
{
//    const QSerialPortInfo *my = new QSerialPortInfo();
//    my-> = "ttyUSB0";
    _serialport->setBaudRate(250000);
    _serialport->setPortName("ttyUSB0");
    if(_serialport->open(QIODevice::ReadWrite)) {
            _serialport->clear();
            emit portOpenSignal();
        } else {
            qCritical() << "Serial port ERROR!";
            emit portNotOpenSignal();
        }
}

void serialport::close_open_door(bool val)
{

    bool res=writeDate("G01 X10 F1000\n");
    if(res)
    {
        qDebug() << "operation is Done!";
        emit dataSent();
    }

    if(val)
        qDebug() << "open door!";
    else
        qDebug() << "close door!";
}

bool serialport::writeDate(QString val)
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
