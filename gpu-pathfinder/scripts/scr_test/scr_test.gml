// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
// https://help.yoyogames.com/hc/en-us/articles/360005277377 참조
function create_random_map(){
	instance_destroy(obj_entity);
	var _w = 200;
	var _h = 100;
	for(var i = 0; i < _w; i++){
		for(var ii = 0; ii < _h; ii++){
			global.grid[i][ii] = -1;
			if(random(100) < 20){
				var _x = 16*(i mod _w) - 16*ii;
				var _y = 8*(i mod _w) + 8*ii;
				var _inst = instance_create_depth(800+_x,_y,-_y,obj_block);
				global.grid[i][ii] = _inst;
				_inst.xx = i;
				_inst.yy = ii;
			} else if(random(100) < 5){
				var _x = 16*(i mod _w) - 16*ii;
				var _y = 8*(i mod _w) + 8*ii;
				var _inst = instance_create_depth(800+_x,_y,-_y,obj_human);
				global.grid[i][ii] = _inst;
				_inst.xx = i;
				_inst.yy = ii;
			}
		}
	}
}