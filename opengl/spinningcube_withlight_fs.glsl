#version 130

struct Material {
  vec3 ambient;
  sampler2D diffuse;
  sampler2D specular;
  float shininess;
};

struct Light {
  vec3 position;
  vec3 ambient;
  vec3 diffuse;
  vec3 specular;
};

out vec4 frag_col;

in vec3 frag_3Dpos;
in vec3 vs_normal;
in vec2 vs_tex_coord;

uniform Material material;
uniform Light light;
uniform vec3 view_pos;


void main() {

  vec3 normal = normalize(vs_normal);

  vec3 material_diffuse = texture(material.diffuse, vs_tex_coord).rgb;
  vec3 material_specular = texture(material.specular, vs_tex_coord).rgb;

  //ambient
  vec3 ambient = light.ambient * material.ambient;
  vec3 light_dir = normalize(light.position - frag_3Dpos);

  //diffuse
  float diff = max(dot(normal, light_dir), 0.0);
  vec3 diffuse=light.diffuse * diff * material_diffuse;

  //specular
  vec3 view_dir = normalize(view_pos - frag_3Dpos);
  vec3 reflect_dir = reflect(-light_dir, normal);
  float spec = pow(max(dot(view_dir, reflect_dir), 0.0), material.shininess);
  vec3 specular = light.specular * spec * material_specular;

  vec3 result = ambient + diffuse + specular;
  frag_col = vec4(result, 1.0);

}
