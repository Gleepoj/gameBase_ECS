package aleiiioa.shaders;



import h3d.mat.Texture;

class StreamlineShader extends hxsl.Shader {
    static var SRC = {
		@:import h3d.shader.Base2d;
		@param var wind:Sampler2D;
        @param var rand_seed:Float;

        @param var dr_rate:Float;
        @param var dr_rate_bump:Float;
        
        
        function rand(r:Vec2):Float {
			return fract(sin(dot(r.xy,vec2(12.9898,78.233)))*43758.5453123);
		}

		function fragment() {
            var uv = vec2(calculatedUV.xy);
            var color:Vec4 = wind.get(input.uv);
            var pos:Vec2 = vec2(color.r / 255.0 + color.b,color.g / 255.0 + color.a);
            
            var wind_min:Vec2 = vec2(0,0);
            var wind_max:Vec2 = vec2(1,1);

            var velocity:Vec2 = mix(wind_min, wind_max, lookup_wind(pos));
            var speed_t:Float = length(velocity) / length(wind_max);

            var seed:Vec2 = (pos + uv.y) * rand_seed;    
            
            // drop rate is a chance a particle will restart at random position, to avoid degeneration
            var drop_rate:Float = dr_rate + speed_t * dr_rate_bump;
            var drop = step(1.0 - drop_rate, rand(seed));

            var random_pos:Vec2 = vec2(rand(seed + 1.3),rand(seed + 2.1));
            pos = mix(pos, random_pos, drop);

            var final_color:Vec4 = vec4(fract(pos * 255.0),floor(pos * 255.0) / 255.0);

			pixelColor = vec4(final_color);
		}

        function lookup_wind(uv:Vec2):Vec2 {
            
			
			var res = wind.size();
            
            var px:Vec2 = 1. / res ;
            var vc:Vec2 = (floor(uv *res)) * px;
            var f:Vec2 = fract(uv * res);
            var tl:Vec2 = wind.get(vc).rg;
            var tr:Vec2 = wind.get(vc + vec2(px.x, 0)).rg;
            var bl:Vec2 = wind.get(vc + vec2(0, px.y)).rg;
            var br:Vec2 = wind.get(vc + px).rg;
        
            return mix(mix(tl, tr, f.x), mix(bl, br, f.x), f.y);  
        }
	}


    public function new(tex:Texture) {
		super();
		wind = tex;
        rand_seed = 0.223422;
        dr_rate = 0.3;
        dr_rate_bump = 0.7;
	}
}
/* uniform sampler2D u_particles;
uniform sampler2D u_wind;
uniform vec2 u_wind_res;
uniform vec2 u_wind_min;
uniform vec2 u_wind_max;
uniform float u_rand_seed;
uniform float u_speed_factor;
uniform float u_drop_rate;
uniform float u_drop_rate_bump;

varying vec2 v_tex_pos;

// pseudo-random generator
const vec3 rand_constants = vec3(12.9898, 78.233, 4375.85453);
float rand(const vec2 co) {
    float t = dot(rand_constants.xy, co);
    return fract(sin(t) * (rand_constants.z + t));
}

// wind speed lookup; use manual bilinear filtering based on 4 adjacent pixels for smooth interpolation
vec2 lookup_wind(const vec2 uv) {
    // return texture2D(u_wind, uv).rg; // lower-res hardware filtering
    vec2 px = 1.0 / u_wind_res;
    vec2 vc = (floor(uv * u_wind_res)) * px;
    vec2 f = fract(uv * u_wind_res);
    vec2 tl = texture2D(u_wind, vc).rg;
    vec2 tr = texture2D(u_wind, vc + vec2(px.x, 0)).rg;
    vec2 bl = texture2D(u_wind, vc + vec2(0, px.y)).rg;
    vec2 br = texture2D(u_wind, vc + px).rg;
    return mix(mix(tl, tr, f.x), mix(bl, br, f.x), f.y);
}

void main() {
    vec4 color = texture2D(u_particles, v_tex_pos);
    vec2 pos = vec2(
        color.r / 255.0 + color.b,
        color.g / 255.0 + color.a); // decode particle position from pixel RGBA

    vec2 velocity = mix(u_wind_min, u_wind_max, lookup_wind(pos));
    float speed_t = length(velocity) / length(u_wind_max);

    // take EPSG:4236 distortion into account for calculating where the particle moved
    float distortion = cos(radians(pos.y * 180.0 - 90.0));
    vec2 offset = vec2(velocity.x / distortion, -velocity.y) * 0.0001 * u_speed_factor;

    // update particle position, wrapping around the date line
    pos = fract(1.0 + pos + offset);

    // a random seed to use for the particle drop
    vec2 seed = (pos + v_tex_pos) * u_rand_seed;

    // drop rate is a chance a particle will restart at random position, to avoid degeneration
    float drop_rate = u_drop_rate + speed_t * u_drop_rate_bump;
    float drop = step(1.0 - drop_rate, rand(seed));

    vec2 random_pos = vec2(
        rand(seed + 1.3),
        rand(seed + 2.1));
    pos = mix(pos, random_pos, drop);

    // encode the new particle position back into RGBA
    gl_FragColor = vec4(
        fract(pos * 255.0),
        floor(pos * 255.0) / 255.0);
} */