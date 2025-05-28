/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
#macro GRID_W 200
#macro GRID_H 200

fpss = fps_real;
alarm[0] = 20;
global.gpu_pathfind_surf = -1;
create_random_map();

mouse_x_prev = mouse_x;
mouse_y_prev = mouse_y;

global.gpu_pathfind_buff = -1;
