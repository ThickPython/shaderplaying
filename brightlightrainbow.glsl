#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

//peak intensity and end at the widths
//0 at low intensity 1 at peak intensity
float calcIntensity(float position, float width, float peak) {
    return smoothstep(clamp(peak-width, 0.0, 1.0), peak, position) - smoothstep(peak, clamp(peak+width, 0.0, 1.0), position);
}

void main() {
    vec2 standard = gl_FragCoord.xy/u_resolution;
    //get distance to center


    //on a scale from 0 to 1 these are where the peaks are
    float colorWidth = 0.2;
    float redPeak = 0.3;
    float greenPeak = 0.5;
    float bluePeak = 0.7;

    float brightBoost = 0.5;

    //pos is 0 to 1
    float pos = smoothstep(0.2, 0.8, standard.x);
    float redIntensity = calcIntensity(pos, colorWidth, redPeak);
    float blueIntensity = calcIntensity(pos, colorWidth, bluePeak);
    float greenIntensity = calcIntensity(pos, colorWidth, greenPeak);

    vec3 color = vec3(redIntensity, greenIntensity, blueIntensity);
    color = color + brightBoost;
    gl_FragColor = vec4(color, 0.3);


/*

    //increase as farther from center
    float propDisToCenter = sqrt(pow(0.5 - standard.x, 2.0)+pow(0.5 - standard.y, 2.0));


    //increase as closer to center also clamped to 0-1
    propDisToCenter = smoothstep(1.0, 0.0, propDisToCenter);


    //radian from 0 to pi, aka sin = 0 -> 1 -> 0
    float radian = propDisToCenter*PI;
    



    float redV = smoothstep(0.3*PI, 0.0, radian);


    //get full sin range. Alternate from center, closest to center is 0
    propDisToCenter = sin(radian)*0.5+0.5;


    gl_FragColor = vec4(1.0, 1.0, 1.0, propDisToCenter);*/

}