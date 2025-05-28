// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
// https://help.yoyogames.com/hc/en-us/articles/360005277377 참조
function gpu_pathfind(_i,_ii,width,height,func_draw,range = 100,test = false){
	
	var gpu_pathfind_surf = surface_create(width,height);
	var _surf = surface_create(width,height);
	var _surf_block = surface_create(width,height);
	
	surface_set_target(_surf_block);
	draw_clear_alpha(c_black,0);
	
	func_draw();
	
	surface_reset_target();
	
	surface_copy(_surf,0,0,_surf_block);
	surface_set_target(_surf_block);
	shader_set(shd_gpu_pathfind_obstacle);
	draw_surface(_surf,0,0);
	shader_reset();
	surface_reset_target();
	
	surface_set_target(gpu_pathfind_surf);
	draw_clear_alpha(c_black,0);
	
	draw_sprite(spr_white_dot,0,_i,_ii);
	
	shader_set(shd_gpu_pathfind);
	
	var _texture = surface_get_texture(_surf);
	shader_set_uniform_f(shader_get_uniform(shd_gpu_pathfind,"u_texel"),texture_get_texel_width(_texture),texture_get_texel_height(_texture));
	texture_set_stage(shader_get_sampler_index(shd_gpu_pathfind,"u_texture_obstacle"),surface_get_texture(_surf_block));
	gpu_set_blendenable(false);
	
	for(var i = 0; i < range; i++){
		shader_set_uniform_i(shader_get_uniform(shd_gpu_pathfind,"u_passthrough"),1);
		surface_copy(_surf,0,0,gpu_pathfind_surf);
		shader_set_uniform_i(shader_get_uniform(shd_gpu_pathfind,"u_passthrough"),0);
		draw_surface(_surf,0,0);
	}
	shader_reset();
	gpu_set_blendenable(true);
	
	draw_sprite(spr_white_dot,0,_i,_ii);
	
	surface_reset_target();
	
	surface_free(_surf);
	surface_free(_surf_block);
	if(test){
		global.gpu_pathfind_surf = gpu_pathfind_surf;
	} else {
		surface_free(gpu_pathfind_surf);
	}
	
	var _buff = buffer_create(width*height*4,buffer_fast,1);
	buffer_get_surface(_buff,gpu_pathfind_surf,0);
	return _buff;
}

function gpu_pathfind_get_buffer_dir(buff,xx,yy,width){
	if(buffer_exists(buff)){
		var r = buffer_peek(buff, (yy * width + xx) * 4, buffer_u8);
		var g = buffer_peek(buff, (yy * width + xx) * 4 + 1, buffer_u8);
		var b = buffer_peek(buff, (yy * width + xx) * 4 + 2, buffer_u8);
		var a = buffer_peek(buff, (yy * width + xx) * 4 + 3, buffer_u8);

		var _x_dir = (a-b)/255;
		var _y_dir = (g-r)/255;
		
		return [_x_dir,_y_dir];
	}
	return [0,0];
}

function gpu_pathfind_z(_i,_ii,_iii,width,height,func_draw,range = 100,test = false){
	
	var gpu_pathfind_surf = surface_create(width,height,surface_rgba32float);
	var _surf = surface_create(width,height,surface_rgba32float);
	var _surf_block = surface_create(width,height);
	
	surface_set_target(_surf_block);
	draw_clear_alpha(c_black,0);
	
	func_draw();
	
	surface_reset_target();
	
	surface_copy(_surf,0,0,_surf_block);
	surface_set_target(_surf_block);
	shader_set(shd_gpu_pathfind_obstacle);
	draw_surface(_surf,0,0);
	shader_reset();
	surface_reset_target();
	
	surface_set_target(gpu_pathfind_surf);
	draw_clear_alpha(c_black,0);
	
	shader_set(shd_gpu_pathfind_f32);
	shader_set_uniform_f(shader_get_uniform(shd_gpu_pathfind_f32,"u_f32"),_iii/31);
	draw_sprite(spr_white_dot,0,_i,_ii);
	shader_reset();
	
	shader_set(shd_gpu_pathfind_z);
	
	var _texture = surface_get_texture(_surf);
	shader_set_uniform_f(shader_get_uniform(shd_gpu_pathfind_z,"u_texel"),texture_get_texel_width(_texture),texture_get_texel_height(_texture));
	texture_set_stage(shader_get_sampler_index(shd_gpu_pathfind_z,"u_texture_obstacle"),surface_get_texture(_surf_block));
	gpu_set_blendenable(false);
	
	for(var i = 0; i < range; i++){
		shader_set_uniform_i(shader_get_uniform(shd_gpu_pathfind_z,"u_passthrough"),1);
		surface_copy(_surf,0,0,gpu_pathfind_surf);
		shader_set_uniform_i(shader_get_uniform(shd_gpu_pathfind_z,"u_passthrough"),0);
		draw_surface(_surf,0,0);
	}
	shader_reset();
	gpu_set_blendenable(true);
	
	shader_set(shd_gpu_pathfind_f32);
	shader_set_uniform_f(shader_get_uniform(shd_gpu_pathfind_f32,"u_f32"),_iii/31);
	draw_sprite(spr_white_dot,0,_i,_ii);
	shader_reset();
	
	surface_reset_target();
	
	surface_free(_surf);
	surface_free(_surf_block);
	if(test){
		global.gpu_pathfind_surf = gpu_pathfind_surf;
	} else {
		surface_free(gpu_pathfind_surf);
	}
	
	var _buff = buffer_create(width*height*4*4,buffer_fixed,1);
	buffer_get_surface(_buff,gpu_pathfind_surf,0);
	return _buff;
}

function gpu_pathfind_z_get_buffer_dir(buff,xx,yy,zz,width){
	if(buffer_exists(buff)){
		var r = buffer_peek(buff, ((yy * width + xx) * 4)*4, buffer_u32);
		var g = buffer_peek(buff, ((yy * width + xx) * 4 + 1)*4, buffer_u32);
		var b = buffer_peek(buff, ((yy * width + xx) * 4 + 2)*4, buffer_u32);
		var a = buffer_peek(buff, ((yy * width + xx) * 4 + 3)*4, buffer_u32);

		var _up = ((r >> zz) << 31) & 0x1;
		var _down = ((g >> zz) << 31) & 0x1;
		var _left = ((b >> zz) << 31) & 0x1;
		var _right = ((a >> zz) << 31) & 0x1;

		var _x_dir = 0;
		var _y_dir = 0;

		if(_up){
			_y_dir = -1;
		} else if(_down){
			_y_dir = 1;
		}
		
		if(_left){
			_x_dir = -1;
		} else if(_right){
			_x_dir = 1;
		}
		
		return [_x_dir,_y_dir];
	}
	return [0,0];
}