#include "mainwindow.h"
#include "table.h"
#include "ui_mainwindow.h"

#include <QMainWindow>
#include <QCryptographicHash>
#include <QSqlDatabase>
#include <QMessageBox>


MainWindow::MainWindow(QSqlDatabase database, QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    db = database;


}

MainWindow::~MainWindow()
{
    delete ui;
    qDebug() << "Closing database ...";
    db.close();

}


void MainWindow::on_sign_button_clicked()
{

    QString password = ui->pass_text->text();
    QString user = ui->login_text->text();
    QString randomPass = user;
    QString hashie = QString("%1").arg(QString(QCryptographicHash::hash((randomPass + password).toUtf8(), QCryptographicHash::Sha256).toHex()));
   // QString hashie = "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92";
    QSqlQuery qry(db);
    qry.prepare("select * from USERS where LOGIN='"+user+"' and PASS='"+hashie+"';");
    qry.exec();

    int count = 0;
    QString loginRole;
    while (qry.next()) {
        count++;
        loginRole = qry.value(2).toString();
    }
    if (count >=1){
       if (loginRole == "admin") {
                    this->close();
                    adm = new admin(db);
                    adm->show();
                }
       else if (loginRole == "doctor") {
           QMessageBox::information(this, "Login", "Successfully login as Doctor.");
           this->close();
           doct = new doctor(db);
           doct->show();
       }
    }
    else
        QMessageBox::warning(this, "Login", "Username or password is incorrect.");



}
