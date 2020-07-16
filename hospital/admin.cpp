#include "admin.h"
#include "ui_admin.h"

admin::admin(QSqlDatabase database, QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::admin)
{
    ui->setupUi(this);
    db=database;
}

admin::~admin()
{
    delete ui;
}
void admin::on_task_button_clicked()
{
    doct =new doctor(db);
    doct->show();
}
void admin::on_add_button_clicked(){
    addu =new ADD(db);
    addu->show();
}
void admin::on_remove_button_clicked(){
    rmv= new removeUser(db);
    rmv->show();
}

