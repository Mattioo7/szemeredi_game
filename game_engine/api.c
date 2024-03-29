#include "api.h"
#include "engine.h"

int api_init(){
    return init();
}

int api_finish(){
    return finish();
}

int api_setup(int k, int x, int m){
    return setup(k, x, m);
}

void api_set_state(state s){
    set_state(s);
}

state api_get_state(){
    return get_state();
}

int api_clean(){
    return clean();
}

int api_move(int mv){
    return move(mv);
}

int api_check_who_won(){
    return check_who_won();
}

int api_think(){
    return think();
}