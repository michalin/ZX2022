#ifndef UNISTD_H
#define UNISTD_H

int msleep(int milliseconds); //Implemented msleep instead of usleep, because Z80 is too slow for this
int sleep(int seconds);

#endif