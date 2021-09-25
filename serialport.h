#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>

class serialport : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList serial_ports_list READ getSerialPortsList NOTIFY serialPortsListChanged)

private:
    QSerialPort *_serialport;            // Object for communicate with serial port
    QSerialPortInfo _serial_ports_info;         // Object for get available serial devices
    QList<QSerialPortInfo> _serial_ports_list;  // Object for list all available devices in GUI
    QStringList _baud_rate_list;                // Object for list all available devices in GUI

    // Serial Port config
    qint32 _baud_rate;
    QSerialPort::DataBits _data_bits;
    QSerialPort::Parity _parity;
    QSerialPort::StopBits _stop_bits;
    QSerialPort::Direction _direction;
    QSerialPort::FlowControl _flow_control;


    // Speed
    enum class Speed
    {
        _1KHz = 1000,
        _2KHz = 2000,
        _4KHz = 4000,
        _600Hz = 600,
        _1200Hz = 1200,
        _2400Hz = 2400,
        _4800Hz = 4800,
    };
    Speed _speed;
    Speed _all_speed[7] = { Speed::_4KHz, Speed::_2KHz, Speed::_1KHz, Speed::_4800Hz, Speed::_2400Hz, Speed::_1200Hz, Speed::_600Hz };

public:
    explicit serialport(QObject *parent = nullptr);

    QStringList getSerialPortsList() const;

signals:
    void serialPortsListChanged();

public slots:
    void close_open_door(bool val);
    bool writeDate(QString val);

};

#endif // SERIALPORT_H
