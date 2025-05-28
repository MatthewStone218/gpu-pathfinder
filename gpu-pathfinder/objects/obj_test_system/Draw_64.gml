/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

if(surface_exists(global.gpu_pathfind_surf)){
	shader_set(shd_test);
	draw_surface_ext(global.gpu_pathfind_surf,0,0,3,3,0,c_white,1);
	shader_reset();
	surface_free(global.gpu_pathfind_surf);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(ft_text);
draw_text(0,0,$"fps: {fpss}");
draw_sprite_ext(spr_cursor,0,device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),1,1,0,c_white,1);
