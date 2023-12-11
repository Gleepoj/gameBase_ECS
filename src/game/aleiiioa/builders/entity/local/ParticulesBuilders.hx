package aleiiioa.builders.entity.local;

import aleiiioa.components.core.physics.collision.affects.FrictionSensitiveAffects;
import aleiiioa.components.core.physics.velocity.body.ParticuleBodyFlag;
import aleiiioa.components.core.physics.collision.affects.CollisionLayer_Wall;

import echoes.Entity;

import aleiiioa.components.core.physics.velocity.*;
import aleiiioa.components.core.physics.position.*;
import aleiiioa.components.core.physics.collision.*;
import aleiiioa.components.local.particules.*;


class ParticulesBuilders {
    
    public static function randSolidParticule(gpemit:GridPosition,speedRange:Float,lifetime:Float,?fric:Float=0) {
            
        var pa  = new ParticulesComponent(lifetime,0.001);
        var bmp = new BitmapComponent(Assets.smoke,0.5);

        var gp  = new GridPosition(gpemit.cx,gpemit.cy,gpemit.xr,gpemit.yr);
        var ang = M.frandRange(-Math.PI,Math.PI);
        var spx = Math.cos(ang)*M.frandRange(0.2,1); 
        var spy = Math.sin(ang)*M.frandRange(0.2,1); 
        var vas = new AnalogSpeedComponent(spx,spy);
        var vc  = new VelocityComponent();
        
        var body = new ParticuleBodyFlag();
        var wall = new CollisionLayer_Wall();
        var fric = new FrictionSensitiveAffects();

        var cl  = new CollisionSensor();
        var ent = new echoes.Entity().add(pa,bmp,gp,vas,vc,cl,body,wall,fric);
        return ent;
    }

    public static function randParticule(gpemit:GridPosition,speedRange:Float,lifetime:Float,?fric:Float=0) {
            
        var pa  = new ParticulesComponent(lifetime,0.001);
        var bmp = new BitmapComponent(Assets.smoke,0.5);

        var gp  = new GridPosition(gpemit.cx,gpemit.cy,gpemit.xr,gpemit.yr);
        var ang = M.frandRange(-Math.PI,Math.PI);
        var spx = Math.cos(ang)*M.frandRange(0.2,1); 
        var spy = Math.sin(ang)*M.frandRange(0.2,1); 
        var vas = new AnalogSpeedComponent(spx,spy);
        var body = new ParticuleBodyFlag();
        var fric = new FrictionSensitiveAffects();

        var vc  = new VelocityComponent();
        var cl  = new CollisionSensor();
        var ent = new echoes.Entity().add(pa,bmp,gp,vas,vc,cl,body,fric);
        return ent;
    }

    public static function smokeSolidParticule(gpemit:GridPosition,dirX:Float,dirY:Float,lifetime:Float,?seed:Int = 0,?fric:Float=0) {
        var pa  = new ParticulesComponent(lifetime,fric);
        var bmp = new BitmapComponent(Assets.smoke,0.5,null,seed);
        var gp  = new GridPosition(gpemit.cx,gpemit.cy,gpemit.xr,gpemit.yr);
        var vas = new AnalogSpeedComponent(dirX,dirY);
        
        var vc  = new VelocityComponent();
        var body = new ParticuleBodyFlag();
        var wall = new CollisionLayer_Wall();
        var fric = new FrictionSensitiveAffects();

        var cl  = new CollisionSensor();
        var ent = new echoes.Entity().add(pa,bmp,gp,vas,vc,cl,body,wall,fric);
        return ent;
    }

    public static function smokeParticule(gpemit:GridPosition,dirX:Float,dirY:Float,lifetime:Float,?seed:Int = 0,?fric:Float=0) {
        var pa  = new ParticulesComponent(lifetime,fric);
        var bmp = new BitmapComponent(Assets.smoke,0.5,null,seed);
        var gp  = new GridPosition(gpemit.cx,gpemit.cy,gpemit.xr,gpemit.yr);
        var vas = new AnalogSpeedComponent(dirX,dirY);
        
        var vc  = new VelocityComponent();
        var body = new ParticuleBodyFlag();
        var fric = new FrictionSensitiveAffects();
        var cl  = new CollisionSensor();
        var ent = new echoes.Entity().add(pa,bmp,gp,vas,vc,cl,body,fric);
        return ent;
    }

    public static function emitter() {
        var em = new EmitterComponent();
        var gp = new GridPosition(5,10);
        new echoes.Entity().add(em,gp);
    }
}