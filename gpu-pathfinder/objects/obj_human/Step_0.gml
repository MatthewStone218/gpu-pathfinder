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
	
	if(buffer_exists(global.bfs_dir)){
		var r = buffer_peek(global.bfs_dir, (yy * GRID_W + xx) * 4, buffer_u8);
		var g = buffer_peek(global.bfs_dir, (yy * GRID_W + xx) * 4 + 1, buffer_u8);
		var b = buffer_peek(global.bfs_dir, (yy * GRID_W + xx) * 4 + 2, buffer_u8);
		var a = buffer_peek(global.bfs_dir, (yy * GRID_W + xx) * 4 + 3, buffer_u8);

		var _x_dir = (a-b)/255;
		var _y_dir = (g-r)/255;
		
		goal_xx = xx+_x_dir;
		goal_yy = yy+_y_dir;
		
		goal_x = 800 + 16*(goal_xx mod GRID_W) - 16*goal_yy;
		goal_y = 8*(goal_xx mod GRID_W) + 8*goal_yy;
	}
}

depth = -y;