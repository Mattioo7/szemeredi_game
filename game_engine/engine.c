#include "engine.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

state _state;
settings _settings;

int check_if_black_won(){
    for (int i = 0; i < _settings.m; ++i) {
        if (!get_bit(_state.black, i)) continue;
        for (int j = i + 1; j < _settings.m; ++j) {
            if (!get_bit(_state.black, j)) continue;
            int diff = j - i;
            int k = j + diff;
            int count = 2;
            while (get_bit(_state.black, k)) {
                count++;
                k = k + diff;
                if (count >= _settings.k) {
                    return 1;
                }
            }
        }
    }
    return 0;
}
int check_if_white_won(){
    for (int i = 0; i < _settings.m; ++i) {
        if (!get_bit(_state.white, i)) continue;
        for (int j = i + 1; j < _settings.m; ++j) {
            if (!get_bit(_state.white, j)) continue;
            int diff = j - i;
            int k = j + diff;
            int count = 2;
            while (get_bit(_state.white, k)) {
                count++;
                k = k + diff;
                if (count >= _settings.k) {
                    return 1;
                }
            }
        }
    }
    return 0;
}
int check_if_move_exists(){
    for(int i = 0; i < MEM_SIZE; i++){
        if(_state.set[i] != 0) return 1;
    }
    return 0;
}


int init(){
    srand((int)time(NULL));
    return 0;
}

int finish(){
    return 0;
}

int setup(int k, int x, int m){
    if(k < 3 || x < 6 || m < 6 || x > m || m >= MAX_NUMBER) return -1;
    _settings.k = k;
    _settings.x = x;
    _settings.m = m;
    for(int i = 0; i < MEM_SIZE; i++){
        _state.set[i] = 0;
        _state.white[i] = 0ULL;
        _state.black[i] = 0ULL;
    }
    int count = 0;
    while(count < x){
        int num = rand() % m;
        if(!get_bit(_state.set, num)){
            set_bit(_state.set, num);
            count++;
        }
    }
    return 0;
}

int clean(){
    return 0;
}

void set_state(state s){
    _state = s;
}

state get_state(){
    return _state;
}

int move(int mv){
    pop_bit(_state.set, mv);
    if(_state.to_move == WHITE){
        set_bit(_state.white, mv);
        _state.to_move = BLACK;
    }
    else{
        set_bit(_state.black, mv);
        _state.to_move = WHITE;
    }
    return 0;
}

int check_who_won(){
    if(!check_if_move_exists()){
        return DRAW;
    }
    if(check_if_white_won()){
        return WHITE;
    }
    if(check_if_black_won()){
        return BLACK;
    }
    return PLAY;
}

int think(){
    for(int i = 0; i < MAX_NUMBER; i++){
        if(get_bit(_state.set, i)){
            return i;
        }
    }
    return -1;
}

void print_state(){
    printf("\nALL:  ");
    for(int i = 0; i < MAX_NUMBER; i++){
        if(get_bit(_state.set, i)){
            printf("% 4d", i);
        }
    }
    printf("\nWHITE:");
    for(int i = 0; i < MAX_NUMBER; i++){
        if(get_bit(_state.white, i)){
            printf("% 4d", i);
        }
    }
    printf("\nBLACK:");
    for(int i = 0; i < MAX_NUMBER; i++){
        if(get_bit(_state.black, i)){
            printf("% 4d", i);
        }
    }
    printf("\n\n");
}

void print_possible_moves(){

}

void make_random_move(){

}
