#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;

void main() {
    vec2 standard = gl_FragCoord.xy / u_resolution;
    float xAndTime = sin(standard.x + u_time)*5.0;
    
    float isBelow0 = step(0.0, -xAndTime);
    vec3 color = isBelow0 * vec3(1.0, 0.0, 0.0) + (1.0 - isBelow0) * vec3(xAndTime);
    gl_FragColor = vec4(color, 1.0);
}