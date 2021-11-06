#include "serialport.h"
#include "movement.h"
#include <QDomDocument>

using namespace std;


serialport::serialport(QObject *parent) : QObject(parent)
{
    _serialport = new QSerialPort(this);

    _step_counter=0;
    _tip_counter=0;
    _stop_send_data_flag=false;

    _is_door_close=false;
    _is_workspace_in=true;

    load_backend_params();

    thread_config();
}

void serialport::thread_config()
{
    worker = new mythread(&Final_Generated_Gcodes,_serialport,&_serial_delay);
    worker->moveToThread(&workerThread);
    connect(&workerThread, &QThread::finished, worker, &QObject::deleteLater);
    connect(this, &serialport::doWriteSerialData, worker, &mythread::writeSerialData);
    connect(this, &serialport::stopSerialSendData, worker, &mythread::stopWriteSerialData);
    connect(worker, &mythread::sendDataDone, this, &serialport::sendDataDoneSlot);
    workerThread.start();
}

void serialport::home_all_axises()
{
    delay();
    bool res=writeDate("G28 WVZXY\n");
    qDebug() << res;
}

void serialport::load_backend_params()
{
    bool ok = false;
    QDomDocument xmlBOM;
    QFile f("backend_params.xml");
    if (!f.open(QIODevice::ReadOnly ))
    {
        // Error while loading file
        qDebug() << "File Dose Not Exist";
        return;
    }
    xmlBOM.setContent(&f);
    f.close();

    QDomElement root=xmlBOM.documentElement();

    QDomElement sourceTag=root.firstChild().toElement();

    QDomElement firstlevelchildTag=sourceTag.firstChild().toElement();
    _source_x_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _source_y_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _source_z_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _source_x_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _source_y_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _source_z_max=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);


    QDomElement source2Tag=sourceTag.nextSibling().toElement();

    firstlevelchildTag=source2Tag.firstChild().toElement();
    QDomElement secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit1_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit1_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit2_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit2_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit3_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit3_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit4_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit4_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit5_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit5_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit6_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit6_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit7_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit7_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit8_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit8_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit9_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit9_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit10_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit10_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit11_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit11_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit12_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit12_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_kit13_x_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_kit13_y_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);

    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    secondlevelchildTag=firstlevelchildTag.firstChild().toElement();
    _source2_type1_z_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_type2_z_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);
    secondlevelchildTag=secondlevelchildTag.nextSibling().toElement();
    _source2_type3_z_position=secondlevelchildTag.firstChild().toText().data().toDouble(&ok);


    QDomElement targetTag=source2Tag.nextSibling().toElement();

    firstlevelchildTag=targetTag.firstChild().toElement();
    _target_x_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _target_y_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _target_z_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _target_x_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _target_y_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);

    QDomElement tipType1Tag=targetTag.nextSibling().toElement();

    firstlevelchildTag=tipType1Tag.firstChild().toElement();
    _tip_type1_x_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type1_y_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type1_z_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type1_x_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type1_y_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);

    QDomElement tipType2Tag=tipType1Tag.nextSibling().toElement();

    firstlevelchildTag=tipType2Tag.firstChild().toElement();
    _tip_type2_x_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type2_y_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type2_z_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type2_x_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type2_y_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);

    QDomElement tipType3Tag=tipType2Tag.nextSibling().toElement();

    firstlevelchildTag=tipType3Tag.firstChild().toElement();
    _tip_type3_x_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type3_y_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type3_z_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type3_x_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _tip_type3_y_distance=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);

    QDomElement dischargeTag=tipType3Tag.nextSibling().toElement();

    firstlevelchildTag=dischargeTag.firstChild().toElement();
    _discharge_x_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _discharge_y_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _discharge_z_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _discharge_u_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);

    QDomElement speedTag=dischargeTag.nextSibling().toElement();

    firstlevelchildTag=speedTag.firstChild().toElement();
    _x_axis_speed=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _y_axis_speed=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _z_axis_speed=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _u_axis_speed=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _v_axis_speed=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _w_axis_speed=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);

    QDomElement sampler1Tag=speedTag.nextSibling().toElement();

    firstlevelchildTag=sampler1Tag.firstChild().toElement();
    _sampler1_x_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler1_y_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler1_z_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler1_height_press=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler1_height_release=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);

    QDomElement sampler2Tag=sampler1Tag.nextSibling().toElement();

    firstlevelchildTag=sampler2Tag.firstChild().toElement();
    _sampler2_x_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler2_y_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler2_z_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler2_height_press=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler2_height_release=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);

    QDomElement sampler3Tag=sampler2Tag.nextSibling().toElement();

    firstlevelchildTag=sampler3Tag.firstChild().toElement();
    _sampler3_x_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler3_y_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler3_z_position=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler3_height_press=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _sampler3_height_release=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);

    QDomElement mainParamsTag=sampler3Tag.nextSibling().toElement();

    firstlevelchildTag=mainParamsTag.firstChild().toElement();
    _z_axis_offset=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _open_door_value=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _out_workspace_value=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _pick_sampler_routine=firstlevelchildTag.firstChild().toText().data();
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _serial_delay=firstlevelchildTag.firstChild().toText().data().toDouble(&ok);
    firstlevelchildTag=firstlevelchildTag.nextSibling().toElement();
    _dwell=firstlevelchildTag.firstChild().toText().data().toInt(&ok);
}

QStringList serialport::getSerialPortsList() const
{
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

void serialport::close_open_door()
{

    bool res;

    if(_is_door_close)
    {
        res=writeDate("G01 V2 F"+QString::number(_v_axis_speed)+"\n");
        _is_door_close=!_is_door_close;
    }
    else
    {
        res=writeDate("G01 V"+QString::number(_open_door_value)+" F"+QString::number(_v_axis_speed)+"\n");
        _is_door_close=!_is_door_close;
    }
    qDebug() << res;
}

void serialport::in_out_workspace()
{
    bool res;

    if(_is_workspace_in)
    {
        res=writeDate("G01 V2 F"+QString::number(_v_axis_speed)+"\n");
        _is_door_close=!_is_door_close;
        res=writeDate("G01 W"+QString::number(_out_workspace_value)+" F"+QString::number(_w_axis_speed)+"\n");
        _is_workspace_in=!_is_workspace_in;
    }
    else
    {
        res=writeDate("G28 W\n");
        _is_workspace_in=!_is_workspace_in;
        res=writeDate("G01 V"+QString::number(_open_door_value)+" F"+QString::number(_v_axis_speed)+"\n");
        _is_door_close=!_is_door_close;
    }
    qDebug() << res;
}

void serialport::set_moves_relative()
{
    bool res=writeDate("G91 \n");
    qDebug() << res;
}

void serialport::set_moves_absolut()
{
    bool res=writeDate("G90 \n");
    qDebug() << res;
}

void serialport::relative_move(int axis,double value)
{
    //***********************************************
    //
    // X --> 1
    // Y --> 2
    // Z --> 3
    // U --> 4
    //
    //***********************************************

    bool res=false;
    switch(axis)
    {
        case 1:
            res=writeDate("G01 X"+QString::number(value)+" F"+QString::number(_x_axis_speed)+"\n");
        break;
        case 2:
            res=writeDate("G01 Y"+QString::number(value)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
        case 3:
            res=writeDate("G01 Z"+QString::number(value)+" F"+QString::number(_z_axis_speed)+"\n");
        break;
        case 4:
            res=writeDate("G01 U"+QString::number(value)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    }
    qDebug() << res;
}

void serialport::home_axis(int axis)
{

    //***********************************************
    //
    // X --> 1
    // Y --> 2
    // Z --> 3
    // U --> 4
    //
    //***********************************************

    bool res=false;
    switch(axis)
    {
        case 1:
            res=writeDate("G28 X\n");
        break;
        case 2:
            res=writeDate("G28 Y\n");
        break;
        case 3:
            res=writeDate("G28 Z\n");
        break;
        case 4:
            res=writeDate("G28 U\n");
        break;
    }
    qDebug() << res;
}

bool serialport::writeAlgorithmDate()
{
    bool res=false;
    for(int i=0;i<Final_Generated_Gcodes.length();i++)
    {
//        if(_stop_send_data_flag)
//        {
//            emit finishSendData();
//            break;
//        }
//        else
//        {
//            res=writeDate(Final_Generated_Gcodes.at(i));
//            qDebug() << Final_Generated_Gcodes.at(i);
//            qDebug() << res;
//            delay();
//        }

        //res=writeDate(Final_Generated_Gcodes.at(i));
        _serialport->write(Final_Generated_Gcodes.at(i).toUtf8());
        qDebug() << Final_Generated_Gcodes.at(i);
        qDebug() << res;
        delay();
        readSerialPort();
    }
    emit finishSendData();
}

bool serialport::writeDate(QString val)
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

void serialport::add_new_move(int source_type, int source_start_point_row_lbl, int source_start_point_col_lbl,double source_liq_height,int source2_number, int target_start_point_row_lbl, int target_start_point_col_lbl, int number_of_units, int sampler_type)
{
    movement *new_movement = new movement(source_type,
                                          source_start_point_row_lbl,
                                          source_start_point_col_lbl,
                                          source_liq_height,
                                          source2_number,
                                          target_start_point_row_lbl,
                                          target_start_point_col_lbl,
                                          number_of_units,
                                          sampler_type);
    movementList.push_back(new_movement);
}

void serialport::clear_moves()
{
    movementList.clear();
    Final_Generated_Gcodes.clear();
    _step_counter=0;
}

void serialport::run_next_step()
{
    if(_step_counter<Final_Generated_Gcodes.length())
    {
        bool res=writeDate(Final_Generated_Gcodes[_step_counter]);
        qDebug() << Final_Generated_Gcodes[_step_counter];
        qDebug() << res;
        _step_counter++;
    }
    else
        qDebug() << "finish";

}

void serialport::sendDataDoneSlot()
{
    emit finishSendData();
}

void serialport::stop_send_data()
{
    //emit stopSerialSendData();
    _stop_send_data_flag=true;
}

void serialport::start_algorithm()
{
    //initial gcode
    generate_initial_gcodes();

    for(int i=0;i<movementList.length();i++)
    {
        movement *m = dynamic_cast<movement *>(movementList.at(i));


        // go to pick sampler
        //generate_select_sampler_gcode(m->samplerType());

        //pick up sampler routine
        //generate_pickup_sampler_routine_gcode();


        for(int j=0;j<m->numbrerOfUnits();j++)
        {
            // go to pick tip
            generate_pick_tip_gcode(m->samplerType(),_tip_counter+j);

            if(m->sourceType()==1)
                // go to source 1
                generate_go_to_source_type1_gcode(j,m->sourceStartPointRow(),m->sourceStartPointCol(),m->sourceLiqHeight(),m->samplerType());
            else
                // go to source 2
                generate_go_to_source_type2_gcode(m->source2Number(),m->samplerType());


            // go to target
            generate_go_to_target_gcode(j,m->targetStartPointRow(),m->targetStartPointCol(),m->samplerType());

            // go to discharge
            generate_discharge_gcode();

        }
        _tip_counter+=m->numbrerOfUnits();

        // go to pick down sampler
        //generate_pick_down_sampler_gcode(m->samplerType());
    }

    generate_go_home_gcodes();

    emit doWriteSerialData();
    //writeAlgorithmDate();
}

void serialport::generate_initial_gcodes()
{
    Final_Generated_Gcodes.append("G28 W\n");
    Final_Generated_Gcodes.append("G01 V"+QString::number(_open_door_value)+" F"+QString::number(_v_axis_speed)+"\n");
    Final_Generated_Gcodes.append("G28 ZXYU\n");
    Final_Generated_Gcodes.append("M280 P0 S0\n");
    Final_Generated_Gcodes.append("G90\n");
}

void serialport::generate_select_sampler_gcode(int sampler_type)
{
    Final_Generated_Gcodes.append("G01 Z"+QString::number(_z_axis_offset)+" F"+QString::number(_z_axis_speed)+"\n");
    switch(sampler_type)
    {
    case 1:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_sampler1_x_position)+" Y"+QString::number(_sampler1_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        Final_Generated_Gcodes.append("G01 Z"+QString::number(_sampler1_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        break;
    case 2:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_sampler2_x_position)+" Y"+QString::number(_sampler2_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        Final_Generated_Gcodes.append("G01 Z"+QString::number(_sampler2_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        break;
    case 3:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_sampler3_x_position)+" Y"+QString::number(_sampler3_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        Final_Generated_Gcodes.append("G01 Z"+QString::number(_sampler3_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        break;
    }
    Final_Generated_Gcodes.append("G01 Z"+QString::number(_z_axis_offset)+" F"+QString::number(_z_axis_speed)+"\n");
}

void serialport::generate_pickup_sampler_routine_gcode()
{
    Final_Generated_Gcodes.append(_pick_sampler_routine);
}

void serialport::generate_pick_tip_gcode(int sampler_type, int count)
{
    switch(sampler_type)
    {
    case 1:
        if(count%12!=0)
        {
            Final_Generated_Gcodes.append("G01 X"+QString::number(_tip_type1_x_position-((count%12)*_tip_type1_x_distance))+" Y"+QString::number(_tip_type1_y_position+((count/12)*_tip_type1_y_distance))+" F"+QString::number(_y_axis_speed)+"\n");
            Final_Generated_Gcodes.append("G01 Z"+QString::number(_tip_type1_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        }
        else
        {
            Final_Generated_Gcodes.append("G01 X"+QString::number(_tip_type1_x_position)+" Y"+QString::number(_tip_type1_y_position+((count/12)*_tip_type1_y_distance))+" F"+QString::number(_y_axis_speed)+"\n");
            Final_Generated_Gcodes.append("G01 Z"+QString::number(_tip_type1_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        }
        break;
    case 2:
        if(count%8!=0)
        {
            Final_Generated_Gcodes.append("G01 X"+QString::number(_tip_type2_x_position-((count%8)*_tip_type2_x_distance))+" Y"+QString::number(_tip_type2_y_position+((count/8)*_tip_type2_y_distance))+" F"+QString::number(_y_axis_speed)+"\n");
            Final_Generated_Gcodes.append("G01 Z"+QString::number(_tip_type2_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        }
        else
        {
            Final_Generated_Gcodes.append("G01 X"+QString::number(_tip_type2_x_position)+" Y"+QString::number(_tip_type2_y_position+((count/8)*_tip_type2_y_distance))+" F"+QString::number(_y_axis_speed)+"\n");
            Final_Generated_Gcodes.append("G01 Z"+QString::number(_tip_type2_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        }
        break;
    case 3:
        if(count%6!=0)
        {
            Final_Generated_Gcodes.append("G01 X"+QString::number(_tip_type3_x_position-((count%6)*_tip_type3_x_distance))+" Y"+QString::number(_tip_type3_y_position+((count/6)*_tip_type3_y_distance))+" F"+QString::number(_y_axis_speed)+"\n");
            Final_Generated_Gcodes.append("G01 Z"+QString::number(_tip_type3_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        }
        else
        {
            Final_Generated_Gcodes.append("G01 X"+QString::number(_tip_type3_x_position)+" Y"+QString::number(_tip_type3_y_position+((count/6)*_tip_type3_y_distance))+" F"+QString::number(_y_axis_speed)+"\n");
            Final_Generated_Gcodes.append("G01 Z"+QString::number(_tip_type3_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        }
        break;
    }
    Final_Generated_Gcodes.append("G01 Z"+QString::number(_z_axis_offset)+" F"+QString::number(_z_axis_speed)+"\n");
}

void serialport::generate_go_to_source_type1_gcode(int count, int start_row, int start_column,double source_liq_height,int sampler_type)
{
    if((count+start_column-1)%8!=0)
    {
        Final_Generated_Gcodes.append
                ("G01 X"+QString::number(_source_x_position-(((count+start_column-1)%8)*_source_x_distance))+
                 " Y"+QString::number(_source_y_position+(((count+start_column-1)/8)*_source_y_distance)+((start_row-1)*_source_y_distance))+
                 " F"+QString::number(_y_axis_speed)+"\n");
    }
    else
    {
        Final_Generated_Gcodes.append
                ("G01 X"+QString::number(_source_x_position)+
                 " Y"+QString::number(_source_y_position+(((count+start_column-1)/8)*_source_y_distance)+((start_row-1)*_source_y_distance))+
                 " F"+QString::number(_y_axis_speed)+"\n");
    }

    switch(sampler_type)
    {
    case 1:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler1_height_press)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 2:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler2_height_press)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 3:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler3_height_press)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    }

    Final_Generated_Gcodes.append("G01 Z"+QString::number(_source_z_max-source_liq_height)+" F"+QString::number(_z_axis_speed)+"\n");
    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");

    switch(sampler_type)
    {
    case 1:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler1_height_release)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 2:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler2_height_release)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 3:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler3_height_release)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    }


    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");
    Final_Generated_Gcodes.append("G01 Z"+QString::number(_z_axis_offset)+" F"+QString::number(_z_axis_speed)+"\n");
}

void serialport::generate_go_to_source_type2_gcode(int source_num,int sampler_type)
{
    switch(source_num)
    {
    case 1:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit1_x_position)+" Y"+QString::number(_source2_kit1_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 2:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit2_x_position)+" Y"+QString::number(_source2_kit2_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 3:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit3_x_position)+" Y"+QString::number(_source2_kit3_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 4:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit4_x_position)+" Y"+QString::number(_source2_kit4_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 5:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit5_x_position)+" Y"+QString::number(_source2_kit5_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 6:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit6_x_position)+" Y"+QString::number(_source2_kit6_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 7:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit7_x_position)+" Y"+QString::number(_source2_kit7_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 8:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit8_x_position)+" Y"+QString::number(_source2_kit8_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 9:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit9_x_position)+" Y"+QString::number(_source2_kit9_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 10:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit10_x_position)+" Y"+QString::number(_source2_kit10_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 11:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit11_x_position)+" Y"+QString::number(_source2_kit11_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 12:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit12_x_position)+" Y"+QString::number(_source2_kit12_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    case 13:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_source2_kit13_x_position)+" Y"+QString::number(_source2_kit13_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        break;
    }

    switch(sampler_type)
    {
    case 1:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler1_height_press)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 2:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler2_height_press)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 3:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler3_height_press)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    }

    switch(source_num)
    {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
            Final_Generated_Gcodes.append("G01 Z"+QString::number(_source2_type1_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
            break;
        case 9:
        case 10:
        case 11:
        case 12:
            Final_Generated_Gcodes.append("G01 Z"+QString::number(_source2_type2_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
            break;
        case 13:
            Final_Generated_Gcodes.append("G01 Z"+QString::number(_source2_type3_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
            break;
    }
    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");

    switch(sampler_type)
    {
    case 1:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler1_height_release)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 2:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler2_height_release)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 3:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler3_height_release)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    }
    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");

    Final_Generated_Gcodes.append("G01 Z"+QString::number(_z_axis_offset)+" F"+QString::number(_z_axis_speed)+"\n");
}

void serialport::generate_go_to_target_gcode(int count, int start_row, int start_column,int sampler_type)
{
    if((count+start_column-1)%12!=0)
    {
        Final_Generated_Gcodes.append
                ("G01 X"+QString::number(_target_x_position-(((count+start_column-1)%12)*_target_x_distance))+" Y"+QString::number(_target_y_position+(((count+start_column-1)/12)*_target_y_distance)+((start_row-1)*_target_y_distance))+" F"+QString::number(_y_axis_speed)+"\n");
        Final_Generated_Gcodes.append("G01 Z"+QString::number(_target_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
    }
    else
    {
        Final_Generated_Gcodes.append("G01 X"+QString::number(_target_x_position)+" Y"+QString::number(_target_y_position+((count+start_column-1)/12*_target_y_distance)+((start_row-1)*_target_y_distance))+" F"+QString::number(_y_axis_speed)+"\n");
        Final_Generated_Gcodes.append("G01 Z"+QString::number(_target_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
    }
    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");

    switch(sampler_type)
    {
    case 1:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler1_height_press)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 2:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler2_height_press)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 3:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler3_height_press)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    }

    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");
    Final_Generated_Gcodes.append("G01 Z"+QString::number(_z_axis_offset)+" F"+QString::number(_z_axis_speed)+"\n");

    switch(sampler_type)
    {
    case 1:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler1_height_release)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 2:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler2_height_release)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    case 3:
        Final_Generated_Gcodes.append("G01 U"+QString::number(_sampler3_height_release)+" F"+QString::number(_u_axis_speed)+"\n");
        break;
    }
}

void serialport::generate_discharge_gcode()
{
    Final_Generated_Gcodes.append("G01 X"+QString::number(_discharge_x_position)+" Y"+QString::number(_discharge_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
    Final_Generated_Gcodes.append("G01 Z"+QString::number(_discharge_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");

    Final_Generated_Gcodes.append("G01 U1 F"+QString::number(_u_axis_speed)+"\n");
    Final_Generated_Gcodes.append("M280 P0 S90\n");
    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");
    Final_Generated_Gcodes.append("G01 U"+QString::number(_discharge_u_position)+" F"+QString::number(_u_axis_speed)+"\n");
    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");
    Final_Generated_Gcodes.append("G01 U1 F"+QString::number(_u_axis_speed)+"\n");
    Final_Generated_Gcodes.append("M280 P0 S0\n");
    Final_Generated_Gcodes.append("G04 P"+QString::number(_dwell)+"\n");

    Final_Generated_Gcodes.append("G01 Z"+QString::number(_z_axis_offset)+" F"+QString::number(_z_axis_speed)+"\n");
}

void serialport::generate_pick_down_sampler_gcode(int sampler_type)
{
    switch(sampler_type)
    {
    case 1:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_sampler1_x_position)+" Y"+QString::number(_sampler1_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        Final_Generated_Gcodes.append("G01 Z"+QString::number(_sampler1_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        break;
    case 2:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_sampler2_x_position)+" Y"+QString::number(_sampler2_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        Final_Generated_Gcodes.append("G01 Z"+QString::number(_sampler2_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        break;
    case 3:
        Final_Generated_Gcodes.append("G01 X"+QString::number(_sampler3_x_position)+" Y"+QString::number(_sampler3_y_position)+" F"+QString::number(_y_axis_speed)+"\n");
        Final_Generated_Gcodes.append("G01 Z"+QString::number(_sampler3_z_position)+" F"+QString::number(_z_axis_speed)+"\n");
        break;
    }
}

void serialport::generate_go_home_gcodes()
{
    //go home
    Final_Generated_Gcodes.append("G28 ZXY\n");
}

void serialport::delay()
{
    QThread::msleep(_serial_delay);
}

void serialport::readSerialPort()
{
    _serialport->readAll();
}
