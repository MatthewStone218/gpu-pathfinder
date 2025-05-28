/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

time += 0.1;

x = lerp(old_x,goal_x,time);
y = lerp(old_y,goal_y,time);

if(time >= 1){
	time = 0;
	old_x = x;
	old_y = y;
		
	xx = goal_xx;
	yy = goal_yy;
	zz = goal_zz;
	
	var _dir = gpu_pathfind_z_get_buffer_dir(global.gpu_pathfind_buff,xx,yy,zz,GRID_W);
		
	goal_xx = xx+_dir[0];
	goal_yy = yy+_dir[1];
	goal_zz = global.map_z[goal_xx,goal_yy];
		
	goal_x = 800 + 16*(goal_xx mod GRID_W) - 16*goal_yy;
	goal_y = 8*(goal_xx mod GRID_W) + 8*goal_yy - goal_zz*16;
}

depth = -y;