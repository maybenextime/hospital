#include "table.h"
#include "ui_table.h"

#include <QMessageBox>
table::table(QSqlDatabase database, const QString &tableName, QWidget *parent) :
    QWidget(parent),
    ui(new Ui::table)
{
    ui->setupUi(this);
    model = new QSqlTableModel(this,database);
    model->setTable(tableName);
    model->setEditStrategy(QSqlTableModel::OnManualSubmit);
    model->select();

    ui->tableview->setModel(model);
    ui->tableview->resizeColumnsToContents();
    ui->tableview->sortByColumn(0, Qt::SortOrder::AscendingOrder);
    this->setWindowTitle(tableName);
}

table::~table()
{
    delete ui;
}

void table:: on_add_button_clicked(){
    model->insertRow(model->rowCount(QModelIndex()));
}

void table:: on_remove_button_clicked(){
    QItemSelectionModel *select= ui->tableview->selectionModel();
    if (select->hasSelection()){
        QModelIndexList selection = select->selectedRows();
        for (int i=0;i<selection.count();i++){
            model->removeRow(selection.at(i).row());}

        QMessageBox::information(this, "REMOVE confirm", "press COMMIT to save changes");
    }
    else
        QMessageBox::information(this, "Delete failed", "NO row was selected");
}

void table:: on_commit_button_clicked(){
    model->database().transaction();
    if (model->submitAll()){
        model->database().commit();
        QMessageBox::information(this, "COMMITED", "Changes are saved.");
    }
    else{
        model->database().rollback();
        QMessageBox::warning(this, "Commit error", model->lastError().databaseText());

    }
}
