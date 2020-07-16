#include "mainwindow.h"
#include <QSqlDatabase>
#include <QApplication>
#include <QDebug>
#include <QSqlError>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QSqlDatabase db = QSqlDatabase::addDatabase("QODBC", "OracleODBC-19");

    if (db.open()) {
         qDebug() << "Open database successfully!";
     }
     else {
         qDebug() << "Can't open database! Error = " << db.lastError().text();
     }

    MainWindow w(db);
    w.show();
    return a.exec();
}
