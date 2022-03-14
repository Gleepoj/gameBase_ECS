package aleiiioa.shaders;

import hxd.Math;
import h3d.Vector;
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
			pixelColor = vec4(canvas,1);
		}
	}

	public function new(tex:Texture,_pl:Int) {
		super();
		texture = tex;
		PosLenght = _pl;

	}
	
}

class CircleShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		@param var texture:Sampler2D;
		@param var speed:Float;
		@param var frequency:Float;
		@param var amplitude:Float;

		function circle(_uv:Vec2,_radius:Float):Float{
			var dist:Vec2 = _uv-vec2(0.5);
			return 1.0-smoothstep(_radius-(_radius*0.1),_radius+(_radius*0.1),dot(dist,dist)*4.0);
		}

		function tile(_st:Vec2,_zoom:Float):Vec2{
			_st *= _zoom;
			return fract(_st);
		}

		function fragment() {
			
			var dti = time*2;
			var stime = sin(dti);
			var ctime = cos(dti);

			var size = texture.size();
			var ratio = size.x/size.y;
			
			var uv = vec2(calculatedUV.xy);
			uv.x *= ratio;
			uv.x += stime/2; 
			uv.y += ctime/2;
			
			var uv2 = vec2(calculatedUV.xy);
			uv2.x *= ratio;
			uv2.y += 0.3;
			uv2.y += stime/2;

			var circle2 = vec3(circle(uv2,0.005));
			var circle  = vec3(circle(uv,0.005));
			
			var canvas = vec3(circle2+circle);
			pixelColor = vec4(canvas,1);
		}
	};

	public function new(tex:Texture) {
		super();
		texture = tex;
	}
	
}

class MetaBallsShader extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;
		@param var texture:Sampler2D;
		@param var speed:Float;
		@param var frequency:Float;
		@param var amplitude:Float;

		function metaball(_uv:Vec2,_pos:Vec2,_radius:Float):Float{
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

			var metaBalls:Float = 0.;

			metaBalls += metaball(uv,vec2(0.5,0.4+stime/4),0.0002);
			metaBalls += metaball(uv,vec2(0.5,0.5),0.002);
			metaBalls += metaball(uv,vec2(0.5,0.6-stime/3),0.0002);

			var mbext:Vec3 = color_outer * (1.-smoothstep(metaBalls, metaBalls+0.01, 0.5));
    		var mbin:Vec3  = color_inner * (1.-smoothstep(metaBalls, metaBalls+0.01, 0.8));
			
			var canvas = vec3(mbext+mbin);
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