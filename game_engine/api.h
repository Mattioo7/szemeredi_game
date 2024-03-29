#ifndef API_H
#define API_H

#include "engine.h"

int api_init();
int api_finish();

int api_setup(int, int, int);
int api_clean();

void api_set_state(state);
state api_get_state();

int api_move(int);
int api_check_who_won();

int api_think();


#endif