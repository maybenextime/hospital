#include "removeuser.h"
#include "ui_removeuser.h"

#include <QMessageBox>
#include <QSqlQuery>
#include <QSqlQueryModel>

removeUser::removeUser(QSqlDatabase database, QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::removeUser)
{
    ui->setupUi(this);
    db = database;

    QSqlQueryModel *model = new QSqlQueryModel();
    QSqlQuery *qry = new QSqlQuery(db);
    qry->prepare("select LOGIN from USERS where ROLE <> 'admin';");
    qry->exec();
    model->setQuery(*qry);
    ui->comboBox->setModel(model);
}

removeUser::~removeUser()
{
    delete ui;
}
void removeUser::on_removebutton_clicked()
{
    QString user = ui->comboBox->currentText();
    if (user == "") {
        QMessageBox::warning(this, "Stop", "There is no more user to delete.");
    }
    else {
        QSqlQuery query(db);
        query.prepare("delete from USERS where LOGIN = '"+user+"';");
        if (query.exec()) {
            QMessageBox::information(this, "Delete confirmed", "1 doctor got deleted out of the database.");
            QSqlQueryModel *model = new QSqlQueryModel();
            QSqlQuery *qry = new QSqlQuery(db);
            qry->prepare("select LOGIN from USERS where ROLE <> 'admin';");
            qry->exec();
            model->setQuery(*qry);
            ui->comboBox->setModel(model);
        }
    }
}
