#ifndef TABLE_H
#define TABLE_H

#include <QWidget>
#include <QtSql>

namespace Ui {
class table;
}

class table : public QWidget
{
    Q_OBJECT

public:
    explicit table(QSqlDatabase database, const QString &tableName, QWidget *parent = nullptr);
    ~table();
private slots:
    void on_add_button_clicked();
    void on_remove_button_clicked();
    void on_commit_button_clicked();


private:
    Ui::table *ui;
    QSqlTableModel *model;

};

#endif // TABLE_H
