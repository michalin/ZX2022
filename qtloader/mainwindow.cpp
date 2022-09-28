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
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QMenu>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    imgFileName = p_settings->value(FNAME_KEY).toString();
    if(imgFileName == ""){
        setWindowTitle(PROGNAME + tr(" - No .img file"));
    }
    else
        setRomFiles(imgFileName);

    promFileName = p_settings->value(PNAME_KEY).toString();
    if(promFileName != "")
    {
        setRomFiles(promFileName);
    }

    on_timer();
    ui->portSelector->setCurrentText(p_settings->value(COMPORT_KEY).toString());
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(on_timer()));
    timer->start(1000);
    p_serial->setBaudRate(Z80BDRATE); //Clock frequency/32
    connect(p_serial, SIGNAL(errorOccurred(QSerialPort::SerialPortError)), this, SLOT(on_serialError(QSerialPort::SerialPortError)));
    connect(p_serial, SIGNAL(readyRead()), this, SLOT(on_RxData()));
    //connect(p_serial, SIGNAL(bytesWritten(qint64)), this, SLOT(on_TxData(qint64)));
    connect(p_serial, SIGNAL(aboutToClose()), this, SLOT(on_SerialClose()));
    connect(p_serdisk, SIGNAL(on_activeA(int)), ui->progressBarA, SLOT(setValue(int)));
    connect(p_serdisk, SIGNAL(message(QString)), this, SLOT(on_message(QString)));
    connect(this, SIGNAL(command(QByteArray)), p_serdisk, SLOT(on_command(QByteArray)));
    connect(p_imgFileWatcher, SIGNAL(fileChanged(const QString&)), ui->pButtonLDimg, SLOT(click()));
    connect(p_promFileWatcher, SIGNAL(fileChanged(const QString&)), ui->pButtonLDfile, SLOT(click()));
    p_serdisk->reload();
}

void MainWindow::setRomFiles(QString newName){
    if(newName.endsWith(".img"))
    {
        //ui->pButtonLDimg->setEnabled(true);
        p_imgFileWatcher->removePath(imgFileName);
        p_imgFileWatcher->addPath(newName);
        imgFileName = newName;
        p_settings->setValue(FNAME_KEY, imgFileName);
    }
    else
    {
        //ui->pButtonLDfile->setEnabled(true);
        p_promFileWatcher->removePath(promFileName);
        p_promFileWatcher->addPath(newName);
        promFileName = newName;
        p_settings->setValue(PNAME_KEY, promFileName);
    }
    setWindowTitle(PROGNAME + QString(" - %0, %1").arg(imgFileName.section("/", -1)).arg(promFileName.section("/", -1)));
}

/*
 * Handler function for received serial data
 * Decide here what to do
 */
void MainWindow::on_RxData()
{
    QByteArray rx = p_serial->readAll();
    static int chunk = 0;
    //static int numChunks;

    rxData.append(rx); //Handle debug messages
    //qDebug() << rxData;
    if(rxData.contains("</DBG>")){  //Comments from Arduino
        int start = rxData.indexOf("<DBG>"); //Start index of payload data
        int end = rxData.indexOf("</DBG>"); //end index of payload data
        ui->debug->insertPlainText(rxData.mid(start+5, (end-start-5)));
        rxData.remove(start, end-start+6); //remove the <data>...</data> from data array
    }

    if(rxData.contains("</$>")){ //A message from the Arduino or Z80
        int start = rxData.indexOf("<$>"); //Start index of message
        int end = rxData.indexOf("</$>"); //end index of message
        QByteArray cmd = rxData.mid(start+3, (end-start-3));
        rxData.remove(start, end-start+4); //remove the <$>command</$> from data array

        if(cmd == "ready") { //Arduino setup() finished
            ui->progressBarA->setValue(0);
            ui->progressBarB->setValue(0);
            chunk = 0;
            switch(todo)
            {
            case TODO::LDIMG:
                startUpload(imgFileName, 0);
                todo = TODO::RESET;
                break;
            case TODO::LDFILE:
                startUpload(promFileName, PROMFSBASE+0x400);
                todo = TODO::MKDSK;
                break;
            case TODO::RESET:
                p_File->close();
                p_serial->write("@start:reset@");
                todo = TODO::SERDSK;
                break;
            case TODO::MKDSK:
                p_serial->write("@mkdsk@");
                todo = TODO::RESET;
            }
        }  else if(cmd == "started"){ //Kernel loaded or reset
            p_serial->setBaudRate(Z80BDRATE);
        } else if(cmd == "rqchunk") {
            ui->statusbar->showMessage(tr("Sending Chunk %1").arg(chunk++));
            ui->progressBarB->setValue(chunk & 1);
            QByteArray chunk = p_File->read(32);
            p_serial->write(chunk);
            //p_serial->waitForBytesWritten();
        } else if(cmd == "error"){
            chunk = 0;
        }

         //Serial disk
        else if(cmd.startsWith("wrsec")) {
            ui->statusbar->showMessage(tr("Written: track: %1, sector: %2").arg((uint8_t)cmd[6]).arg((uint8_t)cmd[7]));
        } else if((int)cmd.startsWith("R:") | cmd.startsWith("W:")) {
            static uint8_t p;
            ui->progressBarA->setValue(p++ & 1);
        } else if(cmd == "error"){
            ui->statusbar->showMessage("Error");
            ui->pButtonLDimg->setEnabled(true);
        }
        emit command(cmd); //Forward command to connected classes
    }
}


void MainWindow::on_TxData(qint64 nbytes)
{
    qDebug() << "Written: " << nbytes;
}

//Sets start address and the number of bytes and initiates the upload to EEprom
void MainWindow::startUpload(QString name, uint16_t base){
    //qDebug() << "Start Upload";
    p_File->setFileName(name);
    p_File->open(QIODevice::ReadOnly);
    QByteArray cmd = "@load@";
    cmd.append((uint8_t)base); //Base addr Lo Byte
    cmd.append((uint8_t)(base >> 8)); //Base addr Hi Byte
    cmd.append((uint8_t)p_File->size());
    cmd.append((uint8_t)(p_File->size() >> 8));
    cmd.append((char) 0); //reserved
    QByteArray fname = name.section("/",-1).toUpper().toUtf8();
    cmd.append(fname.split('.')[0].append(7, ' ').first(8)); //Name
    cmd.append(fname.split('.')[1].append(2, ' ').first(3)); //Extension
    p_serial->write(cmd); //Send Base address and size of image
}

/* Button handlers */
void MainWindow::on_pButtonLDimg_clicked()
{
    //qDebug()<<"Load";
    if(imgFileName == "")
        on_actionSet_Image_File_triggered();
    ui->checkConnect->setChecked(false);
    p_serial->setBaudRate(BAUDRATE);
    todo = TODO::LDIMG;
    //p_serdisk->reload();
    ui->checkConnect->setChecked(true); //Open serial port in slot function*/
    p_imgFileWatcher->removePath(imgFileName);
    p_imgFileWatcher->addPath(imgFileName);
    p_serial->setDataTerminalReady(true);
    p_serial->setDataTerminalReady(false);
}

void MainWindow::on_pButtonLDfile_clicked()
{
    //qDebug()<<"Promdisk";
    if(promFileName == "")
        on_actionSet_Prom_File_triggered();
    ui->checkConnect->setChecked(false);
    p_serial->setBaudRate(BAUDRATE);
    todo = TODO::LDFILE;
    ui->checkConnect->setChecked(true); //Open serial port in slot function
    p_promFileWatcher->removePath(promFileName);
    p_promFileWatcher->addPath(promFileName);
    p_serial->setDataTerminalReady(true);
    p_serial->setDataTerminalReady(false);
}

void MainWindow::on_pushButtonReload_clicked()
{
    //ui->debug->clear();
    p_serdisk->reload();
    p_serial->setBaudRate(Z80BDRATE);
    ui->checkConnect->setChecked(true);
}

void MainWindow::on_pButtonReset_clicked()
{
    ui->checkConnect->setChecked(false);
    p_serial->setBaudRate(BAUDRATE);
    todo = TODO::RESET;
    ui->checkConnect->setChecked(true); //Open serial port in slot function
    p_serial->setDataTerminalReady(true);
    p_serial->setDataTerminalReady(false);
}

/* Menu handlers */
void MainWindow::on_actionSet_Image_File_triggered()
{
    QString fileName = QFileDialog::getOpenFileName(this,
                                               tr("Open Image File"), imgFileName, tr("Rom Files (*.img)"));
    if (QFile(fileName).size() >= PROMFSBASE)
    {
        QMessageBox::critical(this, "Error", "Error: Image file exceeds 16 kilobyte");
        return;
    }
    setRomFiles(fileName);
}

void MainWindow::on_actionSet_Prom_File_triggered()
{
    QString fileName = QFileDialog::getOpenFileName(this,
                                               tr("Open Autostart File"), imgFileName, tr("CP/M executables (*.com)"));
    if (QFile(fileName).size() >= 0x8000-PROMFSBASE)
    {
        QMessageBox::critical(this, "Error", "Error: File exceeds 16 kilobyte");
        return;
    }
    setRomFiles(fileName);
}

void MainWindow::on_actionErase_Prom_FS_triggered()
{
    setRomFiles("");
    ui->checkConnect->setChecked(false);
    p_serial->setBaudRate(BAUDRATE);
    todo = TODO::MKDSK;
    ui->checkConnect->setChecked(true); //Open serial port in slot function*/
    p_serial->setDataTerminalReady(true);
    p_serial->setDataTerminalReady(false);
}


void MainWindow::on_actionAbout_triggered()
{
    QFile lic(":/resources/license.txt");
    lic.open(QIODevice::ReadOnly);
    QMessageBox::about(this, "About", lic.readAll());
    lic.close();
}


//Debug and status messages
void MainWindow::on_message(const QString msg){
    ui->debug->ensureCursorVisible();
    ui->debug->append(msg);
}

/* Checkbox handler */
void MainWindow::on_checkConnect_stateChanged(int check)
{
    //qDebug("Check: %d", check);
    QString portname = ui->portSelector->itemText(ui->portSelector->currentIndex());
    QString port = portname.left(portname.indexOf(":"));
    p_serial->setPortName(port);
    if((check == 2) && (p_serial->open(QIODevice::ReadWrite))) //Open serial port
    {
        ui->debug->clear();
        ui->statusbar->showMessage(tr("%1 %2").arg(p_serial->portName(), "connected"));
    } else
    {
        p_serial->close();
        ui->statusbar->showMessage(tr("%1 %2").arg(p_serial->portName(), "not connected"));
    }
}

/* Serial communication error handler */
void MainWindow::on_serialError(QSerialPort::SerialPortError status){
    if(status == QSerialPort::SerialPortError::NoError)
        return;
    ui->statusbar->showMessage(tr("%1 %2").arg(p_serial->portName(), "not connected"));
    ui->progressBarA->setValue(0);
    ui->pButtonLDimg->setEnabled(true);
    ui->checkConnect->setChecked(false);
    if(p_serial->isOpen()){
        p_serial->close();
    }
    QString statusString;
    switch(status){
    case QSerialPort::SerialPortError::DeviceNotFoundError:
        statusString = "No COM Port found";
        break;
    case QSerialPort::SerialPortError::WriteError:
        statusString = "WriteError";
        break;
    case QSerialPort::SerialPortError::OpenError:
        statusString = "Cannot open port";
        break;
    case QSerialPort::SerialPortError::PermissionError:
        statusString = "Serial connection lost";
        break;
    case QSerialPort::SerialPortError::ResourceError:
        statusString = "Port connection lost";
        break;
    case QSerialPort::SerialPortError::NotOpenError:
        statusString = "Port not open";
        return;
    default:
        statusString = tr("Unknown error: %1").arg(status);
    }
    //qDebug("Serial Port Error: %s", errorString.toLocal8Bit().data());
    if(status != QSerialPort::SerialPortError::ResourceError)
        QMessageBox::warning(this, "Communication Error", statusString);
}

void MainWindow::on_timer(){
    static qint16 numPorts;
    //Poll for changes in serial port configuration. There seems to be no signal for this
    QList<QString>freePortNames;

    QList<QSerialPortInfo> ports = QSerialPortInfo::availablePorts();
    for(QList<QSerialPortInfo>::iterator i=ports.begin(); i<ports.end(); i++)
    {
        if(!i->isNull())
            freePortNames.append(i->portName() + ": " + i->description());   //List with available ports
    }

    if(freePortNames.size()!=numPorts && !p_serial->isOpen())
    {
        ui->portSelector->clear();
        ui->portSelector->addItems(freePortNames);
    }

    numPorts = freePortNames.size();
}

void MainWindow::on_SerialClose()
{
    //qDebug("Serial close");
}

void MainWindow::on_portSelector_textActivated(const QString &portname)
{
    p_settings->setValue(COMPORT_KEY, portname);
}

MainWindow::~MainWindow()
{
    qDebug("MainWindow closed");
    delete ui;
}


