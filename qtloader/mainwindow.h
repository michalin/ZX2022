/* Copyright (C) 2020  Doctor Volt

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

*/

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSerialPort>
#include <QSettings>
#include <QDir>
#include <QFile>
#include <QStringList>
#include <QLineEdit>
#include <QFileDialog>
#include <QMessageBox>
#include <QSerialPortInfo>
#include <QTimer>
#include <QDebug>
#include <QThread>
#include <QMenu>

//#include "loader.h"
#include "serialdisk.h"

#define PROGNAME "ZX-2022 Loader"
#define NEWFILENAME "untitled"
#define FNAME_KEY   "imgFileName"
#define PNAME_KEY   "promFileName"
#define COMPORT_KEY "Port"
#define VERSION     "1.0"

#define BAUDRATE (int)115200//(int)1000*CLOCK/32
#define Z80BDRATE (int)187500
#define PROMFSBASE 0x4000 //Start of EEPROM file system

enum TODO
{
    IDLE,LDIMG,LDFILE,RESET,MKDSK,SERDSK
};

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void on_pButtonLDimg_clicked();
    void on_serialError(QSerialPort::SerialPortError);
    void on_message(const QString);
    void on_timer();
    void on_actionSet_Image_File_triggered();
    void on_actionAbout_triggered();
    void on_RxData();
    void on_TxData(qint64);
    void on_SerialClose();
    void on_checkConnect_stateChanged(int arg1);
    void on_pushButtonReload_clicked();
    void on_pButtonReset_clicked();
    void on_pButtonLDfile_clicked();
    void on_actionSet_Prom_File_triggered();
    void on_portSelector_textActivated(const QString &arg1);
    void on_actionErase_Prom_FS_triggered();

signals:
    void command(const QByteArray);
    void message(const QString);

private:
    Ui::MainWindow *ui;
    QString imgFileName,promFileName;
    QFile *p_File = new QFile();
    QByteArray rxData;
    QSerialPort *p_serial = new QSerialPort(this);
    QSettings *p_settings = new QSettings("Doctor Volt", PROGNAME);
    Serialdisk *p_serdisk = new Serialdisk(p_serial, &imgFileName, this);
    QLineEdit *p_address;
    QFileSystemWatcher *p_imgFileWatcher = new QFileSystemWatcher(this);
    QFileSystemWatcher *p_promFileWatcher = new QFileSystemWatcher(this);
    QMenu *p_load_button_menu = new QMenu();

    int todo = TODO::IDLE;
    void setRomFiles(QString);
    void startUpload(QString, uint16_t);
};
#endif // MAINWINDOW_H
