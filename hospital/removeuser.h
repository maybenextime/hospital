#ifndef REMOVEUSER_H
#define REMOVEUSER_H

#include <QMainWindow>
#include <QSqlDatabase>
#include <QWidget>

namespace Ui {
class removeUser;
}

class removeUser : public QMainWindow
{
    Q_OBJECT

public:
    explicit removeUser(QSqlDatabase database, QWidget *parent = nullptr);
    ~removeUser();

private slots:
    void on_removebutton_clicked();
private:
    Ui::removeUser *ui;
    QSqlDatabase db;
};

#endif // REMOVEUSER_H
