#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;

uniform vec2 DiffuseSize;

out vec4 fragColor;

void main() {
	vec2 oneTexel = vec2(1.0 / DiffuseSize.x, 1.0 / DiffuseSize.y);
	
	int kernelA[25] = int[](
		1,1,1,0,0,
		1,1,1,0,0,
		1,1,1,0,0,
		0,0,0,0,0,
		0,0,0,0,0
	);
	int kernelB[25] = int[](
		0,0,1,1,1,
		0,0,1,1,1,
		0,0,1,1,1,
		0,0,0,0,0,
		0,0,0,0,0
	);
	int kernelC[25] = int[](
		0,0,0,0,0,
		0,0,0,0,0,
		1,1,1,0,0,
		1,1,1,0,0,
		1,1,1,0,0
	);
	int kernelD[25] = int[](
		0,0,0,0,0,
		0,0,0,0,0,
		0,0,1,1,1,
		0,0,1,1,1,
		0,0,1,1,1
	);
	
	vec4 kernelWindow[25] = vec4[](
		texture(DiffuseSampler,texCoord + vec2(-oneTexel.x*2,-oneTexel.y*2)),texture(DiffuseSampler,texCoord + vec2(-oneTexel.x,-oneTexel.y*2)),texture(DiffuseSampler,texCoord + vec2(0,-oneTexel.y*2)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x,-oneTexel.y*2)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x*2,-oneTexel.y*2)),
		texture(DiffuseSampler,texCoord + vec2(-oneTexel.x*2,-oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(-oneTexel.x,-oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(0,-oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x,-oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x*2,-oneTexel.y)),
		texture(DiffuseSampler,texCoord + vec2(-oneTexel.x*2,0)),texture(DiffuseSampler,texCoord + vec2(-oneTexel.x,0)),texture(DiffuseSampler,texCoord + vec2(0,0)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x,0)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x*2,0)),
		texture(DiffuseSampler,texCoord + vec2(-oneTexel.x*2,oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(-oneTexel.x,oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(0,oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x,oneTexel.y)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x*2,oneTexel.y)),
		texture(DiffuseSampler,texCoord + vec2(-oneTexel.x*2,oneTexel.y*2)),texture(DiffuseSampler,texCoord + vec2(-oneTexel.x,oneTexel.y*2)),texture(DiffuseSampler,texCoord + vec2(0,oneTexel.y*2)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x,oneTexel.y*2)),texture(DiffuseSampler,texCoord + vec2(oneTexel.x*2,oneTexel.y*2))
	);
	
	vec4 appliedKernelA = vec4(0.0);
	vec4 appliedKernelB = vec4(0.0);
	vec4 appliedKernelC = vec4(0.0);
	vec4 appliedKernelD = vec4(0.0);
	
	float standardDeviationA = 0.0;
	float standardDeviationB = 0.0;
	float standardDeviationC = 0.0;
	float standardDeviationD = 0.0;
	
	for(int i = 0; i < 25; i++) {
		appliedKernelA += kernelA[i] * kernelWindow[i];
		appliedKernelB += kernelB[i] * kernelWindow[i];
		appliedKernelC += kernelC[i] * kernelWindow[i];
		appliedKernelD += kernelD[i] * kernelWindow[i];
	}
	
	appliedKernelA *= 0.1111;
	appliedKernelB *= 0.1111;
	appliedKernelC *= 0.1111;
	appliedKernelD *= 0.1111;
	
	float avgAppliedKernelAPxl = 0.3333 * (appliedKernelA.r + appliedKernelA.g + appliedKernelA.b);
	float avgAppliedKernelBPxl = 0.3333 * (appliedKernelB.r + appliedKernelB.g + appliedKernelB.b);
	float avgAppliedKernelCPxl = 0.3333 * (appliedKernelC.r + appliedKernelC.g + appliedKernelC.b);
	float avgAppliedKernelDPxl = 0.3333 * (appliedKernelD.r + appliedKernelD.g + appliedKernelD.b);
	
	for(int i = 0; i < 25; i++) {
		float avgKernelWindowPxl = 0.3333 * (kernelWindow[i].r + kernelWindow[i].g + kernelWindow[i].b);
		standardDeviationA += kernelA[i] * (avgKernelWindowPxl - avgAppliedKernelAPxl) * (avgKernelWindowPxl - avgAppliedKernelAPxl);
		standardDeviationB += kernelB[i] * (avgKernelWindowPxl - avgAppliedKernelBPxl) * (avgKernelWindowPxl - avgAppliedKernelBPxl);
		standardDeviationC += kernelC[i] * (avgKernelWindowPxl - avgAppliedKernelCPxl) * (avgKernelWindowPxl - avgAppliedKernelCPxl);
		standardDeviationD += kernelD[i] * (avgKernelWindowPxl - avgAppliedKernelDPxl) * (avgKernelWindowPxl - avgAppliedKernelDPxl);
	}
	
	//vec4 appliedKernels;
	
	if(standardDeviationA <= standardDeviationB && standardDeviationA <= standardDeviationC && standardDeviationA <= standardDeviationD) {
		fragColor = appliedKernelA;
		//appliedKernels = sqrt(standardDeviationA * 0.1111);
	} else if(standardDeviationB <= standardDeviationA && standardDeviationB <= standardDeviationC && standardDeviationB <= standardDeviationD) {
		fragColor = appliedKernelB;
		//appliedKernels = sqrt(standardDeviationB * 0.1111);
	} else if(standardDeviationC <= standardDeviationA && standardDeviationC <= standardDeviationB && standardDeviationC <= standardDeviationD) {
		fragColor = appliedKernelC;
		//appliedKernels = sqrt(standardDeviationC * 0.1111);
	} else {
		fragColor = appliedKernelD;
		//appliedKernels = sqrt(standardDeviationD * 0.1111);
	}
	
	//appliedKernels = vec4(1.0) - appliedKernels;
	
	//fragColor = appliedKernels;
}
