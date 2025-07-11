// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
// https://help.yoyogames.com/hc/en-us/articles/360005277377 참조
function create_random_map_z(){
	for(var i = 0; i < GRID_W; i++){
		for(var ii = 0; ii < GRID_H; ii++){
			global.map_z[i][ii] = 0;
			if(random(100) < 20){
				var _x = 16*(i mod GRID_W) - 16*ii;
				var _y = 8*(i mod GRID_W) + 8*ii;
				var _zz = irandom_range(20,31);
				global.map_z[i][ii] = _zz;
				var _inst = instance_create_depth(800+_x,_y,-_y,obj_block,{xx: i, yy: ii, zz: _zz, z: _zz*16});
			} else if(random(100) < 1){
				var _x = 16*(i mod GRID_W) - 16*ii;
				var _y = 8*(i mod GRID_W) + 8*ii;
				var _inst = instance_create_depth(800+_x,_y,-_y,obj_human_z,{xx: i, yy: ii, z: 0, zz: 0});
			}
		}
	}
}