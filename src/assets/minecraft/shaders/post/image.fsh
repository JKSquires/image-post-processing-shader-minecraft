#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D ImgSampler;

in vec2 texCoord;

uniform vec2 DiffuseSize;

out vec4 fragColor;

void main() {
	vec2 flippedTexCoord = vec2(texCoord.x, 1.0 - texCoord.y);
	
	vec4 imgTexture = texture(ImgSampler,flippedTexCoord);
	
	fragColor = imgTexture;
}
