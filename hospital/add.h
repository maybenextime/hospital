#ifndef ADD_H
#define ADD_H
#include <QMainWindow>
#include <QtSql>
#include <QCryptographicHash>
namespace Ui {
class ADD;
}

class ADD : public QMainWindow
{
    Q_OBJECT

public:
    explicit ADD(QSqlDatabase database, QWidget *parent = nullptr);
    ~ADD();
private slots:
    void on_add_button_clicked();
private:
    Ui::ADD *ui;
    QSqlDatabase db;
};


#endif // ADD_H
