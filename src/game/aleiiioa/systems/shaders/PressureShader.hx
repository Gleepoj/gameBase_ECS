package aleiiioa.systems.shaders;

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

			var s = sin(atan(calculatedUV.y, calculatedUV.x));
			var scale = calculatedUV.xy ;
			var y = sin(2*scale.x);
			
			var line_color = vec3(1, 1, 0);

			var line_value:Float = plot(scale, y);
			var line:Vec3 = line_color.rgb * line_value;
			var canvas = line;
			pixelColor = vec4(canvas, 1);
		}
	};
	public function new(tex:Texture) {
		super();
		texture = tex;
	}
	
}

class PressShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		@param var texture:Sampler2D;

		
		function fragment() {
			
		}
	}
	
}