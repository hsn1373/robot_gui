#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QDomDocument>
#include <QtXml>
#include "mythread.h"
#include <QMutex>

class serialport : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList serial_ports_list READ getSerialPortsList NOTIFY serialPortsListChanged)
    Q_PROPERTY(int sourceCurrentRow READ sourceCurrentRow WRITE setSourceCurrentRow NOTIFY sourceCurrentRowChanged)
    Q_PROPERTY(int sourceCurrentCol READ sourceCurrentCol WRITE setSourceCurrentCol NOTIFY sourceCurrentColChanged)
    Q_PROPERTY(int targetCurrentRow READ targetCurrentRow WRITE setTargetCurrentRow NOTIFY targetCurrentRowChanged)
    Q_PROPERTY(int targetCurrentCol READ targetCurrentCol WRITE setTargetCurrentCol NOTIFY targetCurrentColChanged)
    Q_PROPERTY(bool isCurrentMoveHaveSource READ isCurrentMoveHaveSource WRITE setIsCurrentMoveHaveSource NOTIFY isCurrentMoveHaveSourceChanged)
    Q_PROPERTY(bool isCurrentMoveHaveTarget READ isCurrentMoveHaveTarget WRITE setIsCurrentMoveHaveTarget NOTIFY isCurrentMoveHaveTargetChanged)


private:
    QSerialPort *_serialport;            // Object for communicate with serial port
    QSerialPortInfo _serial_ports_info;         // Object for get available serial devices
    QList<QSerialPortInfo> _serial_ports_list;  // Object for list all available devices in GUI
    QStringList _baud_rate_list;                // Object for list all available devices in GUI

    QThread workerThread;
    mythread *worker;

    // Serial Port config
    qint32 _baud_rate;
    QSerialPort::DataBits _data_bits;
    QSerialPort::Parity _parity;
    QSerialPort::StopBits _stop_bits;
    QSerialPort::Direction _direction;
    QSerialPort::FlowControl _flow_control;
    QList<QObject*> movementList;


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

    void thread_config();
    QStringList getSerialPortsList() const;
    void generate_initial_gcodes();
    void generate_select_sampler_gcode(int sampler_type);
    void generate_pickup_sampler_routine_gcode();
    void generate_pick_tip_gcode(int count);
    void generate_go_to_source_type1_gcode(int count,int start_row,int start_column,double source_liq_height,double sampler_liq_volume);
    void generate_go_to_source_type2_gcode(int source_num,double sampler_liq_volume);
    void generate_go_to_source_out_gcode(double sampler_liq_volume);
    void generate_go_to_target_type1_gcode(int count,int start_row,int start_column,double sampler_liq_volume);
    void generate_go_to_target_out_gcode(double sampler_liq_volume);
    void generate_discharge_gcode();
    void generate_pick_down_sampler_gcode(int sampler_type);
    void generate_go_home_gcodes();
    void delay();
    void readSerialPort();

    //QWriteLocker _lock_write_data;
    QList<QString> Final_Generated_Gcodes;
    QList<int> source_active_pos_rows;
    QList<int> source_active_pos_cols;
    QList<bool> is_moves_have_source_status;
    QList<int> target_active_pos_rows;
    QList<int> target_active_pos_cols;
    QList<bool> is_moves_have_target_status;

signals:
    void serialPortsListChanged();
    void portOpenSignal();
    void portNotOpenSignal();
    void dataSent();
    void doWriteSerialData();
    void finishSendData();
    void finishOneMove();
    void stopSerialSendData();
    void sourceCurrentRowChanged();
    void sourceCurrentColChanged();
    void targetCurrentRowChanged();
    void targetCurrentColChanged();
    void isCurrentMoveHaveSourceChanged();
    void isCurrentMoveHaveTargetChanged();


public slots:
    int sourceCurrentRow();
    void setSourceCurrentRow(int value);
    int sourceCurrentCol();
    void setSourceCurrentCol(int value);
    int targetCurrentRow();
    void setTargetCurrentRow(int value);
    int targetCurrentCol();
    void setTargetCurrentCol(int value);
    bool isCurrentMoveHaveSource();
    void setIsCurrentMoveHaveSource(bool value);
    bool isCurrentMoveHaveTarget();
    void setIsCurrentMoveHaveTarget(bool value);
    void open_port();
    void close_open_door();
    void in_out_workspace();
    void set_moves_relative();
    void set_moves_absolut();
    void relative_move(int axis,double value);
    void home_axis(int axis);
    bool writeAlgorithmDate();
    bool writeDate(QString val);
    void add_new_move(int source_type,int source_start_point_row_lbl,int source_start_point_col_lbl
                      ,double source_liq_height,int source2_number,int target_type
                      ,int target_start_point_row_lbl,int target_start_point_col_lbl
                      ,int number_of_units,double sampler_liq_volume);
    void start_algorithm();
    void load_backend_params();
    void clear_moves();
    void run_next_step();
    void sendDataDoneSlot();
    void oneMoveDoneSlot();
    void stop_send_data();
    void home_all_axises();
    void wash_reader_routine();
    void start_demo_movement();

private:
    bool _stop_send_data_flag;
    bool _is_door_close;
    bool _is_workspace_in;
    double _source_x_position;
    double _source_y_position;
    double _source_z_position;
    double _source_x_distance;
    double _source_y_distance;
    double _source_z_max;
    double _source2_kit1_x_position;
    double _source2_kit1_y_position;
    double _source2_kit2_x_position;
    double _source2_kit2_y_position;
    double _source2_kit3_x_position;
    double _source2_kit3_y_position;
    double _source2_kit4_x_position;
    double _source2_kit4_y_position;
    double _source2_kit5_x_position;
    double _source2_kit5_y_position;
    double _source2_kit6_x_position;
    double _source2_kit6_y_position;
    double _source2_kit7_x_position;
    double _source2_kit7_y_position;
    double _source2_kit8_x_position;
    double _source2_kit8_y_position;
    double _source2_kit9_x_position;
    double _source2_kit9_y_position;
    double _source2_kit10_x_position;
    double _source2_kit10_y_position;
    double _source2_kit11_x_position;
    double _source2_kit11_y_position;
    double _source2_kit12_x_position;
    double _source2_kit12_y_position;
    double _source2_kit13_x_position;
    double _source2_kit13_y_position;
    double _source2_type1_z_position;
    double _source2_type2_z_position;
    double _source2_type3_z_position;
    double _target_x_position;
    double _target_y_position;
    double _target_z_position;
    double _target_x_distance;
    double _target_y_distance;
    double _tip_type1_x_position;
    double _tip_type1_y_position;
    double _tip_type1_z_position;
    double _tip_type1_x_distance;
    double _tip_type1_y_distance;
    double _tip_type2_x_position;
    double _tip_type2_y_position;
    double _tip_type2_z_position;
    double _tip_type2_x_distance;
    double _tip_type2_y_distance;
    double _tip_type3_x_position;
    double _tip_type3_y_position;
    double _tip_type3_z_position;
    double _tip_type3_x_distance;
    double _tip_type3_y_distance;
    double _discharge_x_position;
    double _discharge_y_position;
    double _discharge_z_position;
    double _discharge_u_position;
    double _x_axis_speed;
    double _y_axis_speed;
    double _z_axis_speed;
    double _u_axis_speed;
    double _v_axis_speed;
    double _w_axis_speed;
    double _sampler1_x_position;
    double _sampler1_y_position;
    double _sampler1_z_position;
    double _sampler1_height_press;
    double _sampler1_height_release;
    double _sampler2_x_position;
    double _sampler2_y_position;
    double _sampler2_z_position;
    double _sampler2_height_press;
    double _sampler2_height_release;
    double _sampler3_x_position;
    double _sampler3_y_position;
    double _sampler3_z_position;
    double _sampler3_height_press;
    double _sampler3_height_release;
    double _z_axis_offset;
    double _open_door_value;
    double _out_workspace_value;
    QString _pick_sampler_routine;
    int _dwell;
    double _serial_delay;
    int _step_counter;
    int _tip_counter;
    int _source_current_row;
    int _source_current_col;
    int _target_current_row;
    int _target_current_col;
    bool _is_current_move_have_source;
    bool _is_current_move_have_target;
    int _move_counter;
};

#endif // SERIALPORT_H
