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
    var lock:Bool;
    var zoom:Float = 1.;


    public function new(){
        debugBounds = new h2d.Graphics();
		Game.ME.origin.add(debugBounds, Const.DP_TOP);
        window = hxd.Window.getInstance();
        wwid = window.width/2;
        whei = window.height/2;
/*        
        wwid = window.width;
        whei = window.height;
        ori = Game.ME.origin;

        inner_width = wwid*1/6;
        inner_height = whei*1/6;

        limitNorth = ori.y+inner_height;
        limitSouth = whei-(inner_height*2);
        limitEast  = wwid-(inner_width*2);
        limitWest  = ori.x+inner_width;

        east = Game.ME.level.cWid - loadCxDistance;
        west = 0 + loadCxDistance ;
        north = 0 + loadCxDistance;
        south = Game.ME.level.cHei - loadCyDistance; */

    }


    @a function onAddPlayer(player:PlayerFlag,gp:GridPosition){
        focus = gp;
    }

    @a function onAddCamera(cam:CameraFocusComponent,gp:GridPosition){
 /*        Game.ME.camera.enableDebugBounds();
        Game.ME.camera.trackEntityGridPosition(gp,true,1);
        //Game.ME.camera.centerOnGridTarget();

        Game.ME.
        camera.clampToLevelBounds = false; */
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
                lock =false;
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

		/* debugBounds.moveTo(0,h*0.5);
		debugBounds.lineTo(w,h*0.5); */

        //debugBounds.lineStyle(2,0xdda200);
		//debugBounds.drawRect(ori.x+inner_width,ori.y+inner_height,wwid-(inner_width*2),whei-(inner_height*2));
        //debugBounds.drawRect(limitWest,limitNorth,limitEast,limitSouth);

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

}

  /*   @u function pushScrollerWhenLimitsReach(player:PlayerFlag,gp:GridPosition){
         var scroller = Game.ME.scroller;

        if(gp.attachX < limitWest){
           scroller.x +=1;
            gp.setPosPixel(limitWest,gp.attachY);
        }
        if(gp.attachX > limitEast){
            scroller.x -=1;
            gp.setPosPixel(limitEast,gp.attachY);
        }
        if(gp.attachY < limitNorth){
            scroller.y +=1;
            gp.setPosPixel(gp.attachX,limitNorth);
        }
        if(gp.attachY > limitSouth){
            scroller.y -=1;
            gp.setPosPixel(gp.attachX,limitSouth);
        }

    }

    @u function syncCameraFocus(player:PlayerFlag,gp:GridPosition){
        if(!onEast && gp.cx > east){
            onEast = true;
            //trace("load East");
            loadEast();
        }
        // chexk load west
        if(!onWest && gp.cx < west){
            onWest = true;
            loadWest();
            //trace("load West");
        }
        // check load north
        if(!onNorth && gp.cy < north){
            onNorth = true;
            loadNorth();
            //trace("load North");
        }
        // check load south
        if(!onSouth && gp.cy > south){
            onSouth = true;
            //trace("load South");
            loadSouth();
        }

        // check unload north   
        if(onNorth && gp.cy > north){
            onNorth = false;
            //trace("unload North");
        }
        // check unload south   
        if(onSouth && gp.cy < south){
            onSouth = false;
            //trace("unload South");
        }   
        // check unload east
        if(onEast && gp.cx < east){
            onEast = false;
            //trace("unload East");
        }
        // check unload west
        if(onWest && gp.cx > west){
            onWest = false;
            //trace("unload West");
        }

    }

    function loadEast(){
        // load east
        var xpos = Game.ME.level.data.worldX;
        var w    = Game.ME.level.data.pxWid;
        var ypos = M.floor(Game.ME.level.data.worldY + Game.ME.level.data.pxHei/2) ;
        
        var eastLevel = Assets.worldData.all_worlds.Default.getLevelAt(xpos+w+10,ypos);
        if(eastLevel != null){
            var test  = eastLevel.isLoaded();
            var test2 = eastLevel.identifier;
            //trace('current :: '+Game.ME.level.data.identifier+'');
            //trace('level   :: '+test2+' :: is loaded :: '+test+'');
            //var l:Level = new Level(eastLevel);
            var nlevel = new LevelComponent(eastLevel);
            new echoes.Entity().add(nlevel);
        }
    }
    //load west
    function loadWest(){
        var xpos = Game.ME.level.data.worldX;
        var w    = Game.ME.level.data.pxWid;
        var ypos = M.floor(Game.ME.level.data.worldY + Game.ME.level.data.pxHei/2) ;
        
        var westLevel = Assets.worldData.all_worlds.Default.getLevelAt(xpos-w-10,ypos);
        if(westLevel != null){
            var test  = westLevel.isLoaded();
            var test2 = westLevel.identifier;
            //trace('current :: '+Game.ME.level.data.identifier+'');
            //trace('level   :: '+test2+' :: is loaded :: '+test+'');
            //var l:Level = new Level(eastLevel);
            var nlevel = new LevelComponent(westLevel);
            new echoes.Entity().add(nlevel);
        }
    }
    //load north
    function loadNorth(){
        var xpos = Game.ME.level.data.worldX;
        var w    = Game.ME.level.data.pxWid;
        var ypos = M.floor(Game.ME.level.data.worldY + Game.ME.level.data.pxHei/2) ;
        
        var northLevel = Assets.worldData.all_worlds.Default.getLevelAt(xpos,ypos-w-10);
        if(northLevel != null){
            var test  = northLevel.isLoaded();
            var test2 = northLevel.identifier;
            //trace('current :: '+Game.ME.level.data.identifier+'');
            //trace('level   :: '+test2+' :: is loaded :: '+test+'');
            //var l:Level = new Level(eastLevel);
            var nlevel = new LevelComponent(northLevel);
            new echoes.Entity().add(nlevel);
        }
    }
    //load south
    function loadSouth(){
        var xpos = Game.ME.level.data.worldX;
        var w    = Game.ME.level.data.pxWid;
        var ypos = M.floor(Game.ME.level.data.worldY + Game.ME.level.data.pxHei/2) ;
        
        var southLevel = Assets.worldData.all_worlds.Default.getLevelAt(xpos,ypos+w+10);
        if(southLevel != null){
            var test  = southLevel.isLoaded();
            var test2 = southLevel.identifier;
            //trace('current :: '+Game.ME.level.data.identifier+'');
            //trace('level   :: '+test2+' :: is loaded :: '+test+'');
            //var l:Level = new Level(eastLevel);
            var nlevel = new LevelComponent(southLevel);
            new echoes.Entity().add(nlevel);
        }
    } */