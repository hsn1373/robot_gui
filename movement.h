#ifndef MOVEMENT_H
#define MOVEMENT_H

#include <QObject>

class movement : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int sourceType READ sourceType WRITE setSourceType NOTIFY sourceTypeChanged)
    Q_PROPERTY(int sourceStartPointRow READ sourceStartPointRow WRITE setSourceStartPointRow NOTIFY sourceStartPointRowChanged)
    Q_PROPERTY(int sourceStartPointCol READ sourceStartPointCol WRITE setSourceStartPointCol NOTIFY sourceStartPointColChanged)
    Q_PROPERTY(int source2Number READ source2Number WRITE setSource2Number NOTIFY source2NumberChanged)
    Q_PROPERTY(int targetStartPointRow READ targetStartPointRow WRITE setTargetStartPointRow NOTIFY targetStartPointRowChanged)
    Q_PROPERTY(int targetStartPointCol READ targetStartPointCol WRITE setTargetStartPointCol NOTIFY targetStartPointColChanged)
    Q_PROPERTY(int numbrerOfUnits READ numbrerOfUnits WRITE setNumbrerOfUnits NOTIFY numbrerOfUnitsChanged)
    Q_PROPERTY(int samplerType READ samplerType WRITE setSamplerType NOTIFY samplerTypeChanged)

public:
    explicit movement(QObject *parent = nullptr);
    movement(int source_type,int source_start_point_row, int source_start_point_col,int source2_number,int target_start_point_row,int target_start_point_col,int numbrer_of_units, int sampler_type, QObject *parent=0);

Q_SIGNALS:
    void sourceTypeChanged();
    void sourceStartPointRowChanged();
    void sourceStartPointColChanged();
    void source2NumberChanged();
    void targetStartPointRowChanged();
    void targetStartPointColChanged();
    void numbrerOfUnitsChanged();
    void samplerTypeChanged();

public Q_SLOTS:
    int sourceType();
    void setSourceType(int value);
    int sourceStartPointRow();
    void setSourceStartPointRow(int value);
    int sourceStartPointCol();
    void setSourceStartPointCol(int value);
    int source2Number();
    void setSource2Number(int value);
    int targetStartPointRow();
    void setTargetStartPointRow(int value);
    int targetStartPointCol();
    void setTargetStartPointCol(int value);
    int numbrerOfUnits();
    void setNumbrerOfUnits(int value);
    int samplerType();
    void setSamplerType(int value);

signals:

private:

    int _source_type;
    int _source_start_point_row;
    int _source_start_point_col;
    int _source2_number;
    int _target_start_point_row;
    int _target_start_point_col;
    int _numbrer_of_units;
    int _sampler_type;

};

#endif // MOVEMENT_H
