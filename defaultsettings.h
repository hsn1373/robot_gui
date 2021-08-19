#ifndef DEFAULTSETTINGS_H
#define DEFAULTSETTINGS_H

#include <QObject>

class defaultsettings : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(QString darkMode READ getDarkMode WRITE setDarkMode)
public:
    explicit defaultsettings(QObject *parent = nullptr);

//    QString getDarkMode();
//    void setDarkMode(QString value);
signals:

private:
//    QString _darkMode;

public slots:
};

#endif // DEFAULTSETTINGS_H
