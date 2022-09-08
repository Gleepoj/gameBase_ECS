package aleiiioa.builders;

import echoes.Entity;

import aleiiioa.components.core.velocity.*;
import aleiiioa.components.core.position.*;
import aleiiioa.components.core.collision.*;
import aleiiioa.components.particules.*;


import aleiiioa.shaders.PressureShader.SmokeShader;

class ParticulesBuilders {
    

    public static function randParticule(gpemit:GridPosition,speedRange:Float,lifetime:Float,?col:Bool=false,?fric:Float=0,?gr:Float=0) {
            
        var pa  = new ParticulesComponent(lifetime,true,0.001,gr);
        var bmp = new BitmapComponent(Assets.smoke,0.5,null,SmokeShader);

        var gp  = new GridPosition(gpemit.cx,gpemit.cy,gpemit.xr,gpemit.yr);
        var vas = new VelocityAnalogSpeed(M.frandRange(-speedRange,speedRange),M.frandRange(-speedRange,speedRange));
        var vc  = new VelocityComponent();
        var cl  = new CollisionsListener();
        var ent = new echoes.Entity().add(pa,bmp,gp,vas,vc,cl);
        return ent;
    }

    public static function smokeParticule(gpemit:GridPosition,dirX:Float,dirY:Float,lifetime:Float,?col:Bool=false,?fric:Float=0,?gr:Float=0) {
        var pa  = new ParticulesComponent(lifetime,col,fric,gr);
        var bmp = new BitmapComponent(Assets.smoke,0.5,null,SmokeShader);
        var gp  = new GridPosition(gpemit.cx,gpemit.cy,gpemit.xr,gpemit.yr);
        var vas = new VelocityAnalogSpeed(dirX,dirY);
        
        var vc  = new VelocityComponent();
        var cl  = new CollisionsListener();
        var ent = new echoes.Entity().add(pa,bmp,gp,vas,vc,cl);
        return ent;
    }

    public static function emitter() {
        var em = new EmitterComponent();
        var gp = new GridPosition(5,10);
        new echoes.Entity().add(em,gp);
    }
}