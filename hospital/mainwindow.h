#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include "admin.h"

#include <QMainWindow>

#include <QtSql>
#include <QCryptographicHash>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QSqlDatabase database, QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void on_sign_button_clicked();

private:
    Ui::MainWindow *ui;
    QSqlDatabase db;
    doctor *doct;
    admin *adm;

};
#endif // MAINWINDOW_H
