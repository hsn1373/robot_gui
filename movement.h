#ifndef MOVEMENT_H
#define MOVEMENT_H

#include <QObject>

class movement : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int sourceType READ sourceType WRITE setSourceType NOTIFY sourceTypeChanged)
    Q_PROPERTY(int sourceStartPointRow READ sourceStartPointRow WRITE setSourceStartPointRow NOTIFY sourceStartPointRowChanged)
    Q_PROPERTY(int sourceStartPointCol READ sourceStartPointCol WRITE setSourceStartPointCol NOTIFY sourceStartPointColChanged)
    Q_PROPERTY(double sourceLiqHeight READ sourceLiqHeight WRITE setSourceLiqHeight NOTIFY sourceLiqHeightChanged)
    Q_PROPERTY(int source2Number READ source2Number WRITE setSource2Number NOTIFY source2NumberChanged)
    Q_PROPERTY(int targetType READ targetType WRITE setTargetType NOTIFY targetTypeChanged)
    Q_PROPERTY(int targetStartPointRow READ targetStartPointRow WRITE setTargetStartPointRow NOTIFY targetStartPointRowChanged)
    Q_PROPERTY(int targetStartPointCol READ targetStartPointCol WRITE setTargetStartPointCol NOTIFY targetStartPointColChanged)
    Q_PROPERTY(int numbrerOfUnits READ numbrerOfUnits WRITE setNumbrerOfUnits NOTIFY numbrerOfUnitsChanged)
    Q_PROPERTY(double samplerLiqVolume READ samplerLiqVolume WRITE setSamplerLiqVolume NOTIFY samplerLiqVolumeChanged)

public:
    explicit movement(QObject *parent = nullptr);
    movement(int source_type,int source_start_point_row, int source_start_point_col,double source_liq_height,int source2_number,int target_type,int target_start_point_row,int target_start_point_col,int numbrer_of_units,double sampler_liq_volume, QObject *parent=0);

Q_SIGNALS:
    void sourceTypeChanged();
    void sourceStartPointRowChanged();
    void sourceStartPointColChanged();
    void sourceLiqHeightChanged();
    void source2NumberChanged();
    void targetTypeChanged();
    void targetStartPointRowChanged();
    void targetStartPointColChanged();
    void numbrerOfUnitsChanged();
    void samplerLiqVolumeChanged();

public Q_SLOTS:
    int sourceType();
    void setSourceType(int value);
    int sourceStartPointRow();
    void setSourceStartPointRow(int value);
    int sourceStartPointCol();
    void setSourceStartPointCol(int value);
    double sourceLiqHeight();
    void setSourceLiqHeight(double value);
    int source2Number();
    void setSource2Number(int value);
    int targetType();
    void setTargetType(int value);
    int targetStartPointRow();
    void setTargetStartPointRow(int value);
    int targetStartPointCol();
    void setTargetStartPointCol(int value);
    int numbrerOfUnits();
    void setNumbrerOfUnits(int value);
    double samplerLiqVolume();
    void setSamplerLiqVolume(double value);

signals:

private:

    int _source_type;
    int _source_start_point_row;
    int _source_start_point_col;
    double _source_liq_height;
    int _source2_number;
    int _target_type;
    int _target_start_point_row;
    int _target_start_point_col;
    int _numbrer_of_units;
    double _sampler_liq_volume;

};

#endif // MOVEMENT_H
