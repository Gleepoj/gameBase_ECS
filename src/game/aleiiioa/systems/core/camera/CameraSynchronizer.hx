package aleiiioa.systems.core.camera;

import aleiiioa.components.logic.qualia.PlayerFlag;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.utils.camera.CameraFocusComponent;

class CameraSynchronizer extends echoes.System {
    var onWest:Bool = false;
    var onEast:Bool = false;
    
    var loadCxDistance:Int = 5;
    var east:Int = 0;
    var west:Int = 0 ;

    
    public function new(){
  
        east = Game.ME.level.cWid - loadCxDistance;
        west = 0 + loadCxDistance ;

    }

    @a function onAddCamera(cam:CameraFocusComponent,gp:GridPosition){
        Game.ME.camera.trackEntityGridPosition(gp,true,1);
        Game.ME.camera.centerOnGridTarget();		
        Game.ME.camera.clampToLevelBounds = false;
    }

    @u function syncCameraFocus(player:PlayerFlag,gp:GridPosition){
        if(!onEast && gp.cx > east){
            onEast = true;
            trace("load East");
            loadEast();
        }
        // chexk load west
        if(!onWest && gp.cx < west){
            onWest = true;
            trace("load West");
        }
        // check unload east
        if(onEast && gp.cx < east){
            onEast = false;
            trace("unload East");
        }
        // check unload west
        if(onWest && gp.cx > west){
            onWest = false;
            trace("unload West");
        }

    }

    function loadEast(){
        // load east
        var xpos = Game.ME.level.data.worldX;
        var ypos = Game.ME.level.data.worldY;
   
        var eastLevel = Assets.worldData.all_worlds.Default.getLevelAt(xpos+(loadCxDistance*Const.GRID*Const.GRID),ypos);
        var test = eastLevel.isLoaded();
        var test2 = eastLevel.identifier;
        trace('current ::'+ Game.ME.level.data.identifier +'');
        trace('level :'+test2+' is loaded :: '+test+'');


    }
}