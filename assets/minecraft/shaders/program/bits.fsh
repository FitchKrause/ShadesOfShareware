#version 120

uniform sampler2D DiffuseSampler;

varying vec2 texCoord;
varying vec2 oneTexel;

uniform vec2 InSize;

uniform float Resolution;
uniform float Saturation;
uniform float MosaicSize;

void main() {
    vec2 scaleFactors = InSize / MosaicSize;
    vec2 truncPos = floor(texCoord * scaleFactors) / scaleFactors;
	
    vec4 baseTexel = texture2D(DiffuseSampler, truncPos);
	
    vec3 truncTexel = floor(baseTexel.rgb * Resolution) / Resolution;
    float luma = dot(truncTexel, vec3(0.3, 0.59, 0.11));
    vec3 chroma = (truncTexel - luma) * Saturation;
	
    gl_FragColor = vec4(luma + chroma, 1.0);
}
