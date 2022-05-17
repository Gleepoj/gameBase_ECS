package aleiiioa.shaders;



import h3d.mat.Texture;

class StreamlineShader extends hxsl.Shader {
    static var SRC = {
		@:import h3d.shader.Base2d;
		@param var texture:Sampler2D;
        
        function rand(r:Vec2):Float {
			return fract(sin(dot(r.xy,vec2(12.9898,78.233)))*43758.5453123);
		}

		function fragment() {
            var uv = calculatedUV.xy;
            
            var color:Vec4 = vec4(rand(uv),rand(uv),0,1);
			//var color:Vec4 = texture.get(input.uv);
            //var color:Vec4 = vec4(rand(),0,0,1);
			pixelColor = vec4(color);
		}
	}

    public function new(tex:Texture) {
		super();
		texture = tex;
	}
}
