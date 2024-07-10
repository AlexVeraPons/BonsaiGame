shader_type canvas_item;

void vertex() {
	UV.y += TIME/20.0;
	UV.x += TIME/20.0;
}

