#ifndef ENGINE_H
#define ENGINE_H

#define MEM_SIZE 4

typedef unsigned long long U64;
#define MAX_NUMBER (int)(MEM_SIZE * sizeof(U64) * 8)

#define __set_bit(word, index) ((word) |= (1ULL << (U64)(index)))
#define __get_bit(word, index) ((word) & (1ULL << (U64)(index)))
#define __pop_bit(word, index) ((word) &= ~(1ULL << (U64)(index)))

#define set_bit(array, index) (__set_bit((array)[(index) / (sizeof(U64) * 8)], (index) & (63ULL)))
#define get_bit(array, index) (__get_bit((array)[(index) / (sizeof(U64) * 8)], (index) & (63ULL)))
#define pop_bit(array, index) (__pop_bit((array)[(index) / (sizeof(U64) * 8)], (index) & (63ULL)))

#define BLACK 0
#define WHITE 1
#define DRAW  2
#define PLAY  3

typedef struct
{
    U64 set[MEM_SIZE];
    U64 white[MEM_SIZE];
    U64 black[MEM_SIZE];
    int to_move;
} state;

typedef struct
{
    int k;
    int x;
    int m;
} settings;



int init();
int finish();

int setup(int, int, int);
int clean();

void set_state(state);
state get_state();

int move(int);
int check_who_won();

int think();

void print_state();
void print_possible_moves();
void make_random_move();

#endif