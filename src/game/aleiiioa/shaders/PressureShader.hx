package aleiiioa.shaders;

import h3d.mat.Texture;

class SinShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		@param var texture:Sampler2D;
		@param var speed:Float;
		@param var frequency:Float;
		@param var amplitude:Float;

		function plot(s:Vec2, pct:Float):Float {
			return smoothstep(pct - 0.05, pct, s.y) - smoothstep(pct, pct + 0.05, s.y);
		}
		
		function fragment() {
			var grad_color = texture.get(input.uv);

			var s = sin(atan(calculatedUV.y, calculatedUV.x));
			var scale = calculatedUV.xy ;
			var y = sin(2*scale.x);
			
			var line_color = vec3(1, 1, 0);

			var line_value:Float = plot(scale, y);
			var line:Vec3 = (line_color.rgb * line_value) + grad_color.rgb;
			
			

			
			var canvas = line ;
			pixelColor = vec4(canvas, 1);
		}
	};
	public function new(tex:Texture) {
		super();
		texture = tex;
	}
	
}
class RectangleShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		//@param var time : Float;
		@param var texture:Sampler2D;
		@param var speed:Float;
		@param var frequency:Float;
		@param var amplitude:Float;


		function fragment() {
			var grad_color = texture.get(input.uv);

			var dti = time*0.5;
			var sinus = sin(dti);
			
			var bl1 = step(0.5-sinus,calculatedUV.x);
			var bl2 = step(calculatedUV.x,0.3-sinus);
			var blx = bl1+bl2;
			var bly = step(0,calculatedUV.y);
			var pct = blx*bly;
			
			var line_color = vec3(1, 1, 0);
			

			var line = vec4(line_color+pct,1);
			var canvas = vec4(line);
			pixelColor = vec4(canvas);
		}
	};
	public function new(tex:Texture) {
		super();
		texture = tex;
	}
	
}

class BeetleShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		//@param var time : Float;
		@param var texture:Sampler2D;
		@param var speed:Float;
		@param var frequency:Float;
		@param var amplitude:Float;

		function circle(_uv:Vec2,_radius:Float):Float{
			var dist:Vec2 = _uv-vec2(0.5);
			return 1.0-smoothstep(_radius-(_radius*0.001),_radius+(_radius*0.001),dot(dist,dist)*4.0);
		}

		function fragment() {
			

			var dti = time*0.5;
			
			var line_color = vec3(1, 1, 0);
			

			
			var canvas = vec3(circle(calculatedUV.xy,0.9));
			pixelColor = vec4(canvas,1);
		}
	};
	public function new(tex:Texture) {
		super();
		texture = tex;
	}
	
}

class BitmapShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		@param var texture:Sampler2D;

		
		function fragment() {
			var color:Vec4 = texture.get(input.uv);
			color.g = 0;
			pixelColor = vec4(color);
		}
	}
	
}