package aleiiioa.shaders;

import h3d.mat.Texture;


class BeetleShader extends hxsl.Shader {
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
			color.g = 0;
			pixelColor = vec4(color);
		}
	}
	
}