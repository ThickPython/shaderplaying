#ifdef GL_ES
precision highp float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_frame;
uniform vec2 u_pow;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord/u_resolution.xy;

    float t = u_time * 1.5;
    float t1 = sin(t) * 0.5 + 0.5;
    float t2= cos(t) * 0.5 + 0.5;

    float r = sin(2.0 * uv.x + t1) * 0.5 + 0.5;
    float g = cos(3.0 * uv.y + t2) * 0.5 + 0.5;
    float b = sin(4.0 * (uv.x + uv.y) + t1 + t2) * 0.5 + 0.5;

    fragColor = vec4(r, g, b, 1.0);
}

void main() {
    float xDiff = abs(gl_FragCoord.x - u_mouse.x) / u_resolution.x;
    float yDiff = abs(gl_FragCoord.y - u_mouse.y) / u_resolution.y;
    float realDiff = sqrt(pow(xDiff, 2.0) + pow(yDiff, 2.0));
    float avg = 1.0 - (realDiff / sqrt(2.0));

    vec2 st = gl_FragCoord.xy/u_resolution;
    gl_FragColor = vec4(u_mouse.x/u_resolution.x, u_mouse.y/u_resolution.y, 0, avg);
}