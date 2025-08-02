#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;

uniform vec2 DiffuseSize;

out vec4 fragColor;

void main() {
	vec2 oneTexel = vec2(1.0 / DiffuseSize.x, 1.0 / DiffuseSize.y);
	
	int xKernel[9] = int[](
		-1,0,1,
		-1,0,1,
		-1,0,1
	);
	int yKernel[9] = int[](
		-1,-1,-1,
		0,0,0,
		1,1,1
	);
	
	vec4 kernelPixels[9] = vec4[](
		texture(DiffuseSampler,texCoord + vec2(-oneTexel.x,-oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(0,-oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x,-oneTexel.y)),
		texture(DiffuseSampler,texCoord + vec2(-oneTexel.x,0.0)),texture(DiffuseSampler,texCoord),texture(DiffuseSampler,texCoord + vec2(oneTexel.x,0.0)),
		texture(DiffuseSampler,texCoord + vec2(-oneTexel.x,oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(0,oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x,oneTexel.y))
	);
	
	vec4 appliedXKernel = vec4(0.0);
	vec4 appliedYKernel = vec4(0.0);
	
	for(int i = 0; i < 9; i++) {
		appliedXKernel += xKernel[i] * kernelPixels[i];
		appliedYKernel += yKernel[i] * kernelPixels[i];
	}
	
	vec4 appliedKernels = sqrt(appliedXKernel * appliedXKernel + appliedYKernel * appliedYKernel);
	
	appliedKernels = vec4(1.0) - appliedKernels;
	
	fragColor = appliedKernels;
}
