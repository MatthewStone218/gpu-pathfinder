/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(ft_text);
draw_text(0,0,$"fps: {fpss}");

if(surface_exists(global.gpu_pathfind_surf)){
	shader_set(shd_test);
	draw_surface_ext(global.gpu_pathfind_surf,0,0,2,2,0,c_white,1);
	shader_reset();
}