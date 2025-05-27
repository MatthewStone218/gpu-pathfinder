// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
// https://help.yoyogames.com/hc/en-us/articles/360005277377 참조
function gpu_pathfind(_i,_ii){
	if(!surface_exists(global.gpu_pathfind_surf)){
		global.gpu_pathfind_surf = surface_create(array_length(global.grid),array_length(global.grid[0]));
	}
	var _surf = surface_create(array_length(global.grid),array_length(global.grid[0]));
	var _surf_block = surface_create(array_length(global.grid),array_length(global.grid[0]));
	
	surface_set_target(_surf_block);
	draw_clear_alpha(c_black,0);
	with(obj_block){
		draw_sprite(spr_white_dot,0,xx,yy);
	}
	
	surface_reset_target();
	
	surface_copy(_surf,0,0,_surf_block);
	surface_set_target(_surf_block);
	shader_set(shd_gpu_pathfind_obstacle);
	draw_surface(_surf,0,0);
	shader_reset();
	surface_reset_target();
	
	surface_set_target(global.gpu_pathfind_surf);
	draw_clear_alpha(c_black,0);
	
	draw_sprite(spr_white_dot,0,_i,_ii);
	
	gpu_set_blendenable(false);
	for(var i = 0; i < 100; i++){
		surface_copy(_surf,0,0,global.gpu_pathfind_surf);
		var _texture = surface_get_texture(_surf);
		
		shader_set(shd_gpu_pathfind);
		shader_set_uniform_f(shader_get_uniform(shd_gpu_pathfind,"u_texel"),texture_get_texel_width(_texture),texture_get_texel_height(_texture));
		texture_set_stage(shader_get_sampler_index(shd_gpu_pathfind,"u_texture_obstacle"),surface_get_texture(_surf_block));
		draw_surface(_surf,0,0);
		shader_reset();
	}
	gpu_set_blendenable(true);
	
	surface_reset_target();
	
	surface_free(_surf);
	surface_free(_surf_block);
}