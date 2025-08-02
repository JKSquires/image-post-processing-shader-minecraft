#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;

uniform vec2 DiffuseSize;
uniform float Angle;

out vec4 fragColor;

void main() {
	vec2 coord = (texCoord - 0.5) * DiffuseSize;
	
	float radAngle = Angle * 3.14159265 * 0.00555556;
	
	float cosAngle = cos(radAngle);
	float sinAngle = sin(radAngle);
	
	vec2 transformedCoord = vec2(coord.x*cosAngle-coord.y*sinAngle,coord.x*sinAngle+coord.y*cosAngle);
	
	transformedCoord = transformedCoord / DiffuseSize + 0.5;
	
	if(transformedCoord.x < 0.0 || transformedCoord.x > 1.0 || transformedCoord.y < 0.0 || transformedCoord.y > 1.0) {
		fragColor = vec4(0.0, 0.0, 0.0, 1.0);
	} else {
		vec4 pixel = texture(DiffuseSampler, transformedCoord);
		
		fragColor = pixel;
	}
}
