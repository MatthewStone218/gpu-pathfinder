/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
if(mouse_check_button_pressed(mb_left)){
	var _x = mouse_x;
	var _y = mouse_y;
	var _w = 200;

	var _xm = (_y + _x) div 24;
	var _ii = (_y - _x) div 16;
	var _i = (_ii * _w + _xm) mod _w;
	
	show_debug_message($"{_i} {_ii}")

	gpu_pathfind(_i,_ii);
}