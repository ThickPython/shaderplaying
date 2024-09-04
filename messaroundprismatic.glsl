#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

void main() {
	vec3 c;
	float l,z=u_time;
	for(int i=0;i<3;i++) {
		vec2 uv,p=gl_FragCoord.xy/u_resolution.xy;
		uv=p;
		p-=0.5;
		p.x*=u_resolution.x/u_resolution.y;
		z+=.07;
		l=length(p);
		uv+=p/l*(sin(z)+1.)*abs(sin(l*9.-z-z));
		c[i]=.01/length(mod(uv,1.)-.5);
	}
	gl_FragColor=vec4(c/(l*0.1), u_time);
}
