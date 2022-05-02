package aleiiioa.shaders;

import h3d.mat.Texture;
// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

/* #ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define NUM_OCTAVES 5

float fbm ( in vec2 _st) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5),
                    -sin(0.5), cos(0.50));
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * noise(_st);
        _st = rot * _st * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy*3.;
    // st += st * abs(sin(u_time*0.1)*3.0);
    vec3 color = vec3(0.0);

    vec2 q = vec2(0.);
    q.x = fbm( st + 0.00*u_time);
    q.y = fbm( st + vec2(1.0));

    vec2 r = vec2(0.);
    r.x = fbm( st + 1.0*q + vec2(1.7,9.2)+ 0.15*u_time );
    r.y = fbm( st + 1.0*q + vec2(8.3,2.8)+ 0.126*u_time);

    float f = fbm(st+r);

    color = mix(vec3(0.101961,0.619608,0.666667),
                vec3(0.666667,0.666667,0.498039),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color,
                vec3(0,0,0.164706),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.666667,1,1),
                clamp(length(r.x),0.0,1.0));

    gl_FragColor = vec4((f*f*f+.6*f*f+.5*f)*color,1.);
}
 */

class BeetleShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		@param var texture:Sampler2D;
		@param var speed:Float;
		@param var frequency:Float;
		@param var amplitude:Float;
		@param var NUM_OCTAVES:Int;
		
		function random(_st:Vec2):Float {
			return fract(sin(dot(_st.xy,vec2(12.9898,78.233)))*43758.5453123);
		}

		function fbm(_st:Vec2):Float {
			var v = 0.0;
			var a = 0.5;
			var shift = vec2(100.0);

			var rot = mat2(cos(0.5), sin(0.5),-sin(0.5), cos(0.50));

			for(i in 0...NUM_OCTAVES){
				v += a * noise(_st);
				_st = _st*rot * 2.0 + shift;
				a *= 0.5;
			}
			return v;

		}

		function noise(_st:Vec2):Float {
			var i = floor(_st);
			var f = fract(_st);

			var a = random(i);
			var b = random(i + vec2(1.0, 0.0));
			var c = random(i + vec2(0.0, 1.0));
			var d = random(i + vec2(1.0, 1.0));

			var u = f*f*(3.0-2.0*f);

			return mix(a, b, u.x) +
					(c - a)* u.y * (1.0 - u.x) +
					(d - b) * u.x * u.y;
		}
		
		function fragment() {
			var st = calculatedUV;
			var color = vec3(0.0);
			
			var q = vec2(0.);
			q.x = fbm( st);// + 0.00*time);
			q.y = fbm( st);// + vec2(1.0));
			
			var r = vec2(0.);
			r.x = fbm( st + 1.0*q + vec2(1.7,9.2)+ 0.15*time );
			r.y = fbm( st + 1.0*q + vec2(8.3,2.8)+ 0.126*time);

			var f = fbm(st-r);

			color = mix(vec3(0.101961,0.619608,0.666667),
					vec3(0.666667,0.666667,0.498039),
					clamp((f*f)*4.0,0.0,1.0));
	
			color = mix(color,
						vec3(0,0,0.164706),
						clamp(length(q),0.0,1.0));
		
			color = mix(color,
						vec3(0.666667,1,1),
						clamp(length(r.x),0.0,1.0));
		
			pixelColor = vec4((f*f*f+.6*f*f+.5*f)*color,1.);

		}
		
	}

	public function new(tex:Texture) {
		super();
		texture = tex;
		NUM_OCTAVES = 5;
	}
	
}

class OrbShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		@param var texture:Sampler2D;
		@param var speed:Float;
		@param var frequency:Float;
		@param var amplitude:Float;
		
		@param @const var PosLenght:Int;
		@param var positions:Array<Vec2,PosLenght>;

		function circle(_uv:Vec2,_pos:Vec2,_radius:Float):Float{
			return _radius/dot(_uv-_pos,_uv-_pos);
		}
		

		function fragment() {
			
			var color_bg = vec3(0.0,0.0,0.0);
    		var color_inner = vec3(1.0,1.0,0.0);
    		var color_outer = vec3(0.5,0.8,0.3);
			
			var dti = time*2;
			var stime = sin(dti);
			var ctime = cos(dti);

			var size = texture.size();
			var ratio = size.x/size.y;
			var uv = vec2(calculatedUV.xy);
			uv.x *= ratio;

			var circles:Float = 0.;
			
			@unroll for( i in 0...PosLenght ){
				circles += circle(uv,positions[i],0.00002);
			}
			
			var stcircle:Vec3 = color_outer * (1.-smoothstep(circles, circles/0.01, 10));
			//_radius-(_radius*0.1),_radius+(_radius*0.1)
			var canvas = vec3(stcircle);
			pixelColor = vec4(canvas,0.3);
		}
	}

	public function new(tex:Texture,_pl:Int) {
		super();
		texture = tex;
		PosLenght = _pl;

	}
	
}

class BitmapShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		@param var texture:Sampler2D;

		
		function fragment() {
			var color:Vec4 = texture.get(input.uv);
			pixelColor = vec4(color);
		}
	}
	
}