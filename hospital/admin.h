#ifndef ADMIN_H
#define ADMIN_H

#include "add.h"
#include "doctor.h"
#include "removeuser.h"

#include <QMainWindow>
#include <QSqlDatabase>
#include <QWidget>

namespace Ui {
class admin;
}

class admin : public QMainWindow
{
    Q_OBJECT

public:
    explicit admin(QSqlDatabase database,QWidget *parent = nullptr);
    ~admin();

private slots:
    void on_task_button_clicked();
    void on_add_button_clicked();
    void on_remove_button_clicked();

private:
    Ui::admin *ui;
    QSqlDatabase db;
    doctor *doct;
    ADD *addu;
    removeUser *rmv;
};

#endif // ADMIN_H
