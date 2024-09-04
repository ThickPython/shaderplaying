#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.1608, 0.149, 0.9725);
vec3 colorB = vec3(1.0, 0.2235, 0.0275);

void main() {
    vec3 color = vec3(0.0);

    float prog = fract(u_time/4.0);
    //get up progress and then down progress

    float pct = step(0.5, 1.0 - prog)*(sqrt(prog*2.0)) + step(0.5, prog)*(1.0 - (prog-0.5)/0.5);


    color = mix(colorA, colorB, pct);

    gl_FragColor = vec4(color, 1.0);
}