#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float colorARectangle(float stl, float stb, float stt, float str, vec2 st) {
    float l = step(stl, st.x);
    float b = step(stb, st.y);
    float t = step(1.0-stt, 1.0-st.x);
    float r = step(1.0-str, 1.0-st.y);

    return r*t*b*l;
}

float colorARectangleBorder(vec4 st_edges_lbtr, float stthickness, vec2 st) {
    //draw a big rectangle and then just draw a small one

    //add for left bottom
    //subtract for top and right
    vec4 st_hollow = vec4(
        st_edges_lbtr.x + stthickness,
        st_edges_lbtr.y + stthickness,
        st_edges_lbtr.z - stthickness,
        st_edges_lbtr.w - stthickness
    );

    float color_outer = colorARectangle(
        st_edges_lbtr.x,
        st_edges_lbtr.y,
        st_edges_lbtr.z,
        st_edges_lbtr.w,
        st
    );

    float color_inner = colorARectangle(
        st_hollow.x, st_hollow.y, st_hollow.z, st_hollow.w, st
    );

    //only color where outer == 1 and inner == 0
    return color_outer * step(1.0, 1.0-color_inner); 
}

float colorARectangle(vec2 center, float h, float w, vec2 st) {
    return colorARectangle(center.x-w/2.0, center.y-h/2.0, center.y+h/2.0, center.x+w/2.0, st);
}

float colorACircle(vec2 center, vec2 st, float r, float feathering) {
    float distance = sqrt(
        pow(center.x-st.x, 2.0) + pow(center.y-st.y, 2.0)  
    );

    return smoothstep(1.0, 0.0,smoothstep(r-feathering, r, distance));
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(1.0);
    float total_x_offset = 0.5;
    float total_y_offset = 0.5;

    float xoffset = sin(u_time)*total_x_offset;
    float yoffset = cos(u_time)*total_y_offset;

    color = vec3(colorACircle(vec2(0.5+xoffset, 0.5 + yoffset), st, 0.5, 0.05));

/*
    vec3 color = vec3(colorARectangle(0.1, 0.1, 0.9, 0.9, st));*/
    gl_FragColor = vec4(color, 1.0);
}