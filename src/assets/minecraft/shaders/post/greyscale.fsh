#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;

uniform vec2 DiffuseSize;

out vec4 fragColor;

void main() {
	vec4 pixel = texture(DiffuseSampler, texCoord);
	float avgVal = 0.33333 * (pixel.r + pixel.g + pixel.b);
	
	fragColor = vec4(avgVal, avgVal, avgVal, 1);
}
