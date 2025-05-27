/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var _w = 200;

var _xm = (mouse_y + mouse_x) div 24;
var _ii = (mouse_y - mouse_x) div 16;
var _i = _ii * _w + _xm;

gpu_pathfind(mouse_x,mouse_y);