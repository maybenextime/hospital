#include "doctor.h"
#include "ui_doctor.h"

#include <QMessageBox>

doctor::doctor(QSqlDatabase database, QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::doctor)
{
    ui->setupUi(this);
    db=database;
}

doctor::~doctor()
{
    delete ui;
}

void doctor:: on_patients_button_clicked(){
    tab= new table(db,"PEOPLE");
    tab->show();
}

void doctor:: on_diagnosis_button_clicked(){
    tab= new table(db,"DIAGNOSIS");
    tab->show();
}

void doctor:: on_room_button_clicked(){
    tab= new table(db,"ROOMS");
    tab->show();
}

void doctor:: on_show_patient_clicked(){
    QSqlQueryModel *model = new QSqlQueryModel();
    QSqlQuery *qry = new QSqlQuery(db);
    qry->prepare("select * from SHOW_PATIENTS;");
    qry->exec();
    model->setQuery(*qry);
    ui->tableView->setModel(model);
    ui->tableView->resizeColumnsToContents();
};
void doctor:: on_show_room_clicked(){
    QSqlQueryModel *model = new QSqlQueryModel();
    QSqlQuery *qry = new QSqlQuery(db);
    qry->prepare("select * from SHOW_ROOMS;");
    qry->exec();
    model->setQuery(*qry);
    ui->tableView->setModel(model);
    ui->tableView->resizeColumnsToContents();
}

void doctor:: on_show_diag_clicked(){
    QSqlQueryModel *model = new QSqlQueryModel();
    QSqlQuery *qry = new QSqlQuery(db);
    qry->prepare("select * from SHOW_DIAGNOSIS;");
    qry->exec();
    model->setQuery(*qry);
    ui->tableView->setModel(model);
    ui->tableView->resizeColumnsToContents();
}

void doctor:: on_analys_button_clicked(){
    QString sample = ui->ratio_text->text();
    QRegExp reg("([0-9]*[.])?[0-9]*");
    if (reg.exactMatch(sample)) {
        int ratio1 = sample.toInt();
        if (ratio1 < 0)
            QMessageBox::warning(this, "Incorrect input", "RATIO CANT BE NEGATIVE");
        else {

            QSqlQuery query_nuke(db);
            query_nuke.exec("truncate table ANALRESULT;");

            QSqlQuery query(db);
            query.prepare("declare"
                          " ratio1 number;"
                          "begin"
                          " ratio1 := :a;"
                          " ANALYSTIC_DIAG("
                          "  ratio1 => ratio1"
                          " );"
                          "end;");
            query.bindValue(":a", ratio1);
            query.exec();

            QSqlQueryModel *model = new QSqlQueryModel();
            QSqlQuery *qry = new QSqlQuery(db);
            qry->prepare("select * from ANALRESULT;");
            qry->exec();
            model->setQuery(*qry);
            ui->tableView->setModel(model);
            ui->tableView->resizeColumnsToContents();

        }
    }
    else
        QMessageBox::warning(this, "Incorrect sample input", "Only ratio numbers allowed!");
}

