#ifndef DOCTOR_H
#define DOCTOR_H

#include "table.h"

#include <QMainWindow>
#include <QSqlDatabase>
#include <QWidget>

namespace Ui {
class doctor;
}

class doctor : public QMainWindow
{
    Q_OBJECT
public:
explicit doctor(QSqlDatabase database, QWidget *parent = nullptr);
    ~doctor();

private slots:
    void on_patients_button_clicked();

    void on_diagnosis_button_clicked();

    void on_room_button_clicked();

    void on_show_patient_clicked();

    void on_show_room_clicked();

    void on_show_diag_clicked();

    void on_analys_button_clicked();



private:
    Ui::doctor *ui;
    QSqlDatabase db;
    table *tab;
};

#endif // DOCTOR_H
