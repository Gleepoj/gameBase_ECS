package aleiiioa.systems.core.camera;

import aleiiioa.components.core.level.On_Resize_Event;
import aleiiioa.components.core.level.GameStateManager;
import aleiiioa.components.core.physics.velocity.AnalogSpeedComponent;

import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.core.level.CameraBisComponent;

import aleiiioa.components.logic.qualia.PlayerFlag;
import aleiiioa.components.core.physics.position.GridPosition;

class CameraSynchronizer extends echoes.System {

    var focus:GridPosition;
    var debugBounds:h2d.Graphics;
    var window:hxd.Window;

    var wwid:Float;// = window.width;
    var whei:Float;//  window.height;
    var ori:h2d.Layers;//  Game.ME.origin;

    var scroll :Bool;
    var lock:Bool = true;
    var zoom:Float = 0.;

    public function new(){
        debugBounds = new h2d.Graphics();
		Game.ME.origin.add(debugBounds, Const.DP_TOP);
        window = hxd.Window.getInstance();
        wwid = window.width/2;
        whei = window.height/2;
    }

    @a function onNoFocusedEntity(c:CameraBisComponent,gp:GridPosition) {
        focus = gp;
    }

    @a function onAddPlayer(player:PlayerFlag,gp:GridPosition){
        focus = gp;
    }
 
    @a function onAddCamera(en:echoes.Entity,c:CameraBisComponent,gp:GridPosition){
        gp.moveTo(en,focus.gpToVector(),0.2);
    }

    @a function onAddResizeEvent(en:echoes.Entity, game:GameStateManager,add:On_Resize_Event){
       
        wwid = window.width/2;
        whei = window.height/2;
        en.remove(On_Resize_Event);
    }

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

    function debugControlSpace(c:CameraBisComponent,gp:GridPosition){
        var w = 30;
        var h = 30;
        
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

    @u function pushScrollerWhenLimitsReach(c:CameraBisComponent,gp:GridPosition){
        var s = Const.SCALE + zoom;
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
        Game.ME.origin.removeChildren();
        Game.ME.scroller.removeChildren();

        Game.ME.origin.x = 0;
        Game.ME.origin.y = 0;

        Game.ME.scroller.x = 0;
        Game.ME.scroller.y = 0;
        
        Game.ME.scroller.setScale(s);
        Game.ME.origin.setScale(s);
    }

}
