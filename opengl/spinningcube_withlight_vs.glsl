#version 130


in vec3 v_pos;
in vec3 v_normal;
//in vec2 v_tex;

out vec3 frag_3Dpos;
out vec3 vs_normal;
//out vec2 vs_tex_coord;

uniform mat4 model;
uniform mat3 normal;
uniform mat4 view;
uniform mat4 projection;

void main() {
  vec4 pos = vec4(v_pos, 1);
  gl_Position = projection * view * model * pos;
  frag_3Dpos = vec3(model * pos);
  vs_normal = normalize(normal * v_normal);
  //vs_tex_coord =
}
