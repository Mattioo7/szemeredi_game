#ifndef API_H
#define API_H

struct ApiState_t
{
    unsigned long long set;
    unsigned long long white;
    unsigned long long black;
    int to_move;
};

typedef struct ApiState_t ApiState;

int api_init();
int api_finish();

int api_setup(int, int, int);
int api_clean();

void api_set_state(ApiState);
ApiState api_get_state();

int api_move(int);
int api_check_who_won();

int api_think();

#endif