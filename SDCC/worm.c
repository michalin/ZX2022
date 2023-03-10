/*
Copyright (C) 2023  Doctor Volt
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
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>

#define WIDTH 40
#define HEIGHT 15
#define MAXLEN 100

enum Direction
{
    UP,
    DOWN,
    LEFT,
    RIGHT
};

struct Point
{
    int x;
    int y;
};

struct Worm
{
    struct Point head;
    struct Point tail[MAXLEN];
    enum Direction direction;
    int length;
};

_Bool gameover = 0;

int contains(struct Worm *worm, int x, int y)
{
    for (int i = 0; i < worm->length; i++)
    {
        if (worm->tail[i].x == x && worm->tail[i].y == y)
            return 1;
    }
    return 0;
}

void display_grid(struct Worm *worm, struct Point *apple)
{
    for (int i = 0; i < HEIGHT; i++)
    {
        for (int j = 0; j < WIDTH; j++)
        {
            if (i == 0 || i == HEIGHT - 1)
            {
                putchar('-');
            }
            else if (j == 0 || j == WIDTH - 1)
            {
                putchar('|');
            }
            else if (j == worm->head.x && i == worm->head.y)
            {
                putchar('@');
            }
            else if (contains(worm, j, i))
            {
                putchar('#');
            }
            else if (j == apple->x && i == apple->y)
            {
                putchar('*');
            }
            else
            {
                putchar(' ');
            }
        }
        printf("\r\n");
    }
    putchar(27);
    puts("[H");
}

void update_worm(struct Worm *worm, struct Point *apple)
{
    struct Point prev_head;
    prev_head = worm->head;
    switch (worm->direction)
    {
    case UP:
        worm->head.y--;
        break;
    case DOWN:
        worm->head.y++;
        break;
    case LEFT:
        worm->head.x--;
        break;
    case RIGHT:
        worm->head.x++;
        break;
    }
    if (worm->head.x < 0 || worm->head.x >= WIDTH || worm->head.y < 0 || worm->head.y >= HEIGHT)
    {
        gameover = 1;
    }
    for (int i = 0; i < worm->length; i++)
    {
        if (worm->head.x == worm->tail[i].x && worm->head.y == worm->tail[i].y)
        {
            gameover = 1;
        }
    }

    memmove(&worm->tail[1], &worm->tail[0], worm->length*sizeof(struct Point));

    worm->tail[0] = prev_head;
}

void check_input(struct Worm *worm)
{
    if (_kbhit())
    {
        switch (_getch())
        {
        case 'w':
            if (worm->direction != DOWN)
            {
                worm->direction = UP;
            }
            break;
        case 's':
            if (worm->direction != UP)
            {
                worm->direction = DOWN;
            }
            break;
        case 'a':
            if (worm->direction != RIGHT)
            {
                worm->direction = LEFT;
            }
            break;
        case 'd':
            if (worm->direction != LEFT)
            {
                worm->direction = RIGHT;
            }
            break;
        }
    }
}

void main()
{
    putchar(27);
    puts("[?25l"); //Cursor off
    system("cls"); 

    struct Worm worm = {
        {WIDTH / 2, HEIGHT / 2},
        {{0, 0}},
        RIGHT,
        0};

    struct Point apple = {
        2 + rand() % (WIDTH - 4),
        2 + rand() % (HEIGHT - 4)};

    while (!gameover)
    {
        display_grid(&worm, &apple);
        if (worm.head.x == apple.x && worm.head.y == apple.y)
        {
            worm.length++;
            apple.x = 2 + rand() % (WIDTH - 4);
            apple.y = 2 + rand() % (HEIGHT - 4);
        }
        check_input(&worm);
        update_worm(&worm, &apple);
        // msleep(100);
    }
    printf("Game Over!\n");
    putchar(27);
    puts("[?25h"); //Cursor on
}
