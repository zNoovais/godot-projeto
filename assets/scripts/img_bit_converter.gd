# img_bit_converter.gd

# Convert colors
func convert_to_16bit_palette(image: Image) -> Image:
	var width = image.get_width()
	var height = image.get_height()

	for y in range(height):
		for x in range(width):
			var color = image.get_pixel(x, y)
			var r = round(color.r * 31.0) / 31.0
			var g = round(color.g * 63.0) / 63.0
			var b = round(color.b * 31.0) / 31.0
			var quantized_color = Color(r, g, b, color.a)
			image.set_pixel(x, y, quantized_color)
			
	return image
