package aleiiioa.systems.core.camera;

import aleiiioa.components.core.physics.velocity.AnalogSpeedComponent;
import aleiiioa.components.core.physics.velocity.VelocityComponent;
import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.core.level.CameraBisComponent;
import aleiiioa.components.core.level.LevelComponent;
import aleiiioa.components.logic.qualia.PlayerFlag;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.utils.camera.CameraFocusComponent;

class CameraSynchronizer extends echoes.System {
    var onWest:Bool = false;
    var onEast:Bool = false;
    var onNorth:Bool = false;
    var onSouth:Bool = false;

    var loadCxDistance:Int = 5;
    var loadCyDistance:Int = 5;

    var east:Int = 0;
    var west:Int = 0 ;
    var north:Int = 0;
    var south:Int = 0;


    var focus:GridPosition;
    var debugBounds:h2d.Graphics;
    var window:hxd.Window;
    var wwid:Float;// = window.width;
    var whei:Float;//  window.height;
    var ori:h2d.Layers;//  Game.ME.origin;

    var inner_width:Float;//  = wwid*1/6;
    var inner_height:Float;//  = whei*1/6;

    var limitNorth:Float;
    var limitSouth:Float;
    var limitEast:Float;
    var limitWest:Float;

    var scroll :Bool;
    var lock:Bool = false;
    var zoom:Float = 1.;


    public function new(){
        debugBounds = new h2d.Graphics();
		Game.ME.origin.add(debugBounds, Const.DP_TOP);
        window = hxd.Window.getInstance();
        wwid = window.width/2;
        whei = window.height/2;
    }

    @a function onNoFocusedEntity(c:CameraBisComponent,gp:GridPosition) {
        focus = gp;
       // trace(gp.gpToVector());
    }
    
/*     @a function onAddPlayer(player:PlayerFlag,gp:GridPosition){
        focus = gp;
    }
 
    @a function onAddCamera(en:echoes.Entity,c:CameraBisComponent,gp:GridPosition){
        gp.moveTo(en,focus.gpToVector(),0.2);
    }
 */
    @u function order(en:echoes.Entity,c:CameraBisComponent,inp:InputComponent,gp:GridPosition,vas:AnalogSpeedComponent){
        if(inp.ca.isKeyboardPressed(K.U)){
            //trace("move to player");
            gp.moveTo(en,focus.gpToVector(),0.2);
        }

        vas.reset();

        if(inp.ca.isKeyboardPressed(K.O)){
            if(scroll)
                scroll =false;
            else scroll = true;
        }

        if(inp.ca.isKeyboardPressed(K.P)){
            if(lock)
                lock = false;
            else lock = true;
        }

        if(inp.ca.isKeyboardPressed(K.T)){
            zoom -= 0.1;
        }

        if(inp.ca.isKeyboardPressed(K.Y)){
            zoom += 0.1;
        }

        if(inp.ca.isKeyboardDown(K.I)){
            vas.ySpeed = -0.1;
        }
        if(inp.ca.isKeyboardDown(K.K)){
            vas.ySpeed = 0.1;
        }
        if(inp.ca.isKeyboardDown(K.J)){
            vas.xSpeed = -0.1;
        }
        if(inp.ca.isKeyboardDown(K.L)){
            vas.xSpeed = 0.1;
        }

        if(scroll)
            vas.ySpeed = -0.1;

        if(lock){
            vas.reset();
            gp.setPosPixel(focus.attachX,focus.attachY);
        }
    }

    @u function debugControlSpace(c:CameraBisComponent,gp:GridPosition){
        var w = 30;
        var h = 60;
        
        debugBounds.setPosition(gp.attachX,gp.attachY);
        debugBounds.clear();
		debugBounds.lineStyle(1,0x007ddd);
		debugBounds.drawRect(-w*0.5,-h*0.5,w,h);

	 	debugBounds.moveTo(0, -h*0.5);
		debugBounds.lineTo(0, h*0.5); 

        debugBounds.moveTo(-w*0.5,0);
        debugBounds.lineTo(w*0.5,0);

        for(resolution in Const.RESOLUTIONS){
            debugBounds.lineStyle(4, dn.Col.green());
            debugBounds.drawRect(-resolution.x*0.5,-resolution.y*0.5,resolution.x,resolution.y);
        }

    }
    @u function pushScrollerWhenLimitsReach(c:CameraBisComponent,gp:GridPosition){
        var s = zoom;
        Game.ME.origin.x = -(gp.attachX*s) + (wwid);
        Game.ME.origin.y = -(gp.attachY*s) + (whei);
        Game.ME.scroller.x = Game.ME.origin.x;
        Game.ME.scroller.y = Game.ME.origin.y;
        Game.ME.scroller.setScale(s);
        Game.ME.origin.setScale(s);
    }

    @r function onRemoveCamera(c:CameraBisComponent){
        //trace("reset scroller");
        var s = 1;
        Game.ME.origin.x = 0;
        Game.ME.origin.y = 0;
        Game.ME.scroller.x = 0;
        Game.ME.scroller.y = 0;
        Game.ME.scroller.setScale(s);
        Game.ME.origin.setScale(s);
    }

}
