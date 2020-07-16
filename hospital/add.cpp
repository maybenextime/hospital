#include "add.h"
#include "ui_add.h"

#include <QMessageBox>

ADD::ADD(QSqlDatabase database, QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ADD)
{
    ui->setupUi(this);
    db=database;
}

ADD::~ADD()
{
    delete ui;
}

void ADD::on_add_button_clicked(){

    QString password = ui->pass_text->text();
    QString user = ui->nuser_text->text();
    QString randomPass = user;
    QString hashie = QString("%1").arg(QString(QCryptographicHash::hash((randomPass + password).toUtf8(), QCryptographicHash::Sha256).toHex()));

    if (user == "" || password == "") QMessageBox::warning(this, "FAILED", "FIELD CAN NOT BE EMPTY");

    else {
        QSqlQuery qry(db);
        int count = 0;
        qry.exec("SELECT * from USERS where Login='"+user+"';");
        while (qry.next())
            count++;
        if (count >= 1)
            QMessageBox::warning(this, "FAILED", "Username already exist");
        else {
            QSqlQuery query(db);
            query.prepare("insert into USERS (LOGIN,PASS,ROLE) VALUES ('"+user+"','"+hashie+"','doctor');");
            if (query.exec())
                QMessageBox::information(this, "SUCCESS", "ADDED NEW USER '"+user+"'");
            }
    }
}
