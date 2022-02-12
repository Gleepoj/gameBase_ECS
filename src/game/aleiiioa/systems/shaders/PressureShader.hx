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

class LineShader extends hxsl.Shader {

	static var SRC = {

		@global var camera : {
			var view : Mat4;
			var proj : Mat4;
			var viewProj : Mat4;
		};

		@global var global : {
			var pixelSize : Vec2;
			@perObject var modelView : Mat4;
		};

		@input var input : {
			var position : Vec3;
			var normal : Vec3;
			var uv : Vec2;
		}

		var output : {
			var position : Vec4;
		};

		var transformedNormal : Vec3;
		var transformedPosition : Vec3;
		var projectedPosition : Vec4;

		@param var lengthScale : Float;
		@param var width : Float;

		var pdir : Vec4;

		function __init__() {
			{
				var dir = input.normal * global.modelView.mat3(); // keep scale
				pdir = vec4(dir * mat3(camera.view), 1) * camera.proj;
				pdir.xy *= 1 / sqrt(pdir.x * pdir.x + pdir.y * pdir.y);
				transformedPosition += dir * input.uv.x * lengthScale;
				transformedNormal = dir.normalize();
			}
		}

		function vertex() {
			projectedPosition.xy += (pdir.yx * vec2(1,-1)) * (input.uv.y - 0.5) * projectedPosition.z * global.pixelSize * width;
		}

	};

	public function new( width = 1.5, lengthScale = 1. ) {
		super();
		this.width = width;
		this.lengthScale = lengthScale;
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