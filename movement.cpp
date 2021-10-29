#include "movement.h"

movement::movement(QObject *parent) : QObject(parent)
{

}

movement::movement(int source_type,int source_start_point_row, int source_start_point_col,int source2_number,
                   int target_start_point_row,int target_start_point_col,
                   int numbrer_of_units, int sampler_type, QObject *parent)
    : QObject(parent)
{
    _source_type=source_type;
    _source_start_point_row = source_start_point_row;
    _source_start_point_col=source_start_point_col;
    _source2_number=source2_number;
    _target_start_point_row=target_start_point_row;
    _target_start_point_col=target_start_point_col;
    _numbrer_of_units=numbrer_of_units;
    _sampler_type=sampler_type;
}

int movement::sourceType()
{
    return _source_type;
}

void movement::setSourceType(int value)
{
    _source_type=value;
}

int movement::sourceStartPointRow()
{
    return _source_start_point_row;
}

void movement::setSourceStartPointRow(int value)
{
    _source_start_point_row=value;
}

int movement::sourceStartPointCol()
{
    return _source_start_point_col;
}

void movement::setSourceStartPointCol(int value)
{
    _source_start_point_col=value;
}

int movement::source2Number()
{
    return _source2_number;
}

void movement::setSource2Number(int value)
{
    _source2_number=value;
}

int movement::targetStartPointRow()
{
    return _target_start_point_row;
}

void movement::setTargetStartPointRow(int value)
{
    _target_start_point_row=value;
}

int movement::targetStartPointCol()
{
    return _target_start_point_col;
}

void movement::setTargetStartPointCol(int value)
{
    _target_start_point_col=value;
}

int movement::numbrerOfUnits()
{
    return _numbrer_of_units;
}

void movement::setNumbrerOfUnits(int value)
{
    _numbrer_of_units=value;
}

int movement::samplerType()
{
    return _sampler_type;
}

void movement::setSamplerType(int value)
{
    _sampler_type=value;
}
