/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var _x = mouse_x;
var _y = mouse_y;
	
var _i = ((_x-800)/16 + _y/8) / 2;
var _ii = (_y/8 - (_x-800)/16) / 2;

var _func = function(){
	with(obj_block){
		draw_sprite(spr_white_dot,0,xx,yy);
	}
}

if(buffer_exists(global.gpu_pathfind_buff)){
	buffer_delete(global.gpu_pathfind_buff);
}
global.gpu_pathfind_buff = gpu_pathfind(_i,_ii,GRID_W,GRID_H,_func,100,true);


if(mouse_check_button_pressed(mb_right)){
	mouse_x_prev = mouse_x;
	mouse_y_prev = mouse_y;	
}

if(mouse_check_button(mb_right)){
	var _x = camera_get_view_x(view_camera[0]);
	var _y = camera_get_view_y(view_camera[0]);
	camera_set_view_pos(view_camera[0],_x-(mouse_x-mouse_x_prev),_y-(mouse_y-mouse_y_prev));
}

mouse_x_prev = mouse_x;
mouse_y_prev = mouse_y;