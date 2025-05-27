
gpu_pathfind(_i, _ii, width, height, func_draw, range = 100, test = false)
    description: Builds a goal-directed vector field.

    _i: horizontal index of the destination.
    _ii: vertical index of the destination.
    width: number of columns in the field.
    height: number of rows in the field.
    func_draw: callback that draws obstacles, e.g., draw_sprite(spr_white_dot, 0, i, ii).
    range: search radius.
    test: if true, stores the field to global.gpu_pathfind_surf; remember to delete this surface.

    return: the vector-field buffer; query cells with gpu_pathfind_get_buffer_dir. you need to delete this after using.



gpu_pathfind_get_buffer_dir(buff, xx, yy, width)
    description: Looks up the flow direction of a cell.

    buff: buffer returned by gpu_pathfind.
    xx: horizontal index of the cell.
    yy: vertical index of the cell.
    width: number of columns in the field.

    return: [x_dir, y_dir] where each component is −1, 0, or 1.