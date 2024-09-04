#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st.x *= u_resolution.x/u_resolution.y;
  vec3 color = vec3(0.0);
  float d = 0.0;

  // Remap the space to -1. to 1.
  st = st *2.-1.;

  float time_scalar = sin(u_time*5.)*0.5+0.5;
  time_scalar *= 3.;
  time_scalar += 0.3;

  float delta = sin(mod(u_time, 3.14159*2.)*time_scalar)*0.5+0.5;
  float scalar = 25.0;

  delta = delta*0.3+0.4;
  delta = floor(delta*scalar)/scalar;


  // Make the distance field
  d = length( abs(st)-0.3 );
  //d = length( min(abs(st)-.3,0.) );
  d = length( max(abs(st)-delta,0.) );

  // Visualize the distance field
  gl_FragColor = vec4(vec3(fract(d*scalar)),1.0);

  // Drawing with the distance field
  // gl_FragColor = vec4(vec3( step(.3,d) ),1.0);
  // gl_FragColor = vec4(vec3( step(.3,d) * step(d,.4)),1.0);
  // gl_FragColor = vec4(vec3( smoothstep(.3,.4,d)* smoothstep(.6,.5,d)) ,1.0);
}