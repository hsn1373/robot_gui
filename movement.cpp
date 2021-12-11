#include "movement.h"

movement::movement(QObject *parent) : QObject(parent)
{

}

movement::movement(int source_type,int source_start_point_row, int source_start_point_col,double source_liq_height,
                   int source2_number,int target_type,int target_start_point_row,int target_start_point_col,
                   int numbrer_of_units,double sampler_liq_volume, QObject *parent)
    : QObject(parent)
{
    _source_type=source_type;
    _source_start_point_row = source_start_point_row;
    _source_start_point_col=source_start_point_col;
    _source_liq_height=source_liq_height;
    _source2_number=source2_number;
    _target_type=target_type;
    _target_start_point_row=target_start_point_row;
    _target_start_point_col=target_start_point_col;
    _numbrer_of_units=numbrer_of_units;
    _sampler_liq_volume=sampler_liq_volume;
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

double movement::sourceLiqHeight()
{
    return _source_liq_height;
}

void movement::setSourceLiqHeight(double value)
{
    _source_liq_height=value;
}

int movement::source2Number()
{
    return _source2_number;
}

void movement::setSource2Number(int value)
{
    _source2_number=value;
}

int movement::targetType()
{
    return _target_type;
}

void movement::setTargetType(int value)
{
    _target_type=value;
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

double movement::samplerLiqVolume()
{
    return _sampler_liq_volume;
}

void movement::setSamplerLiqVolume(double value)
{
    _sampler_liq_volume=value;
}
