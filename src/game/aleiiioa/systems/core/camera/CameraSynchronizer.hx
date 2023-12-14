package aleiiioa.systems.core.camera;

import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.utils.camera.CameraFocusComponent;

class CameraSynchronizer extends echoes.System {
    
    public function new(){

    }

    @a function onAddCamera(cam:CameraFocusComponent,gp:GridPosition){
        Game.ME.camera.trackEntityGridPosition(gp,true,1);
        Game.ME.camera.centerOnGridTarget();		
        Game.ME.camera.clampToLevelBounds = false;
    }

    @u function syncCameraFocus(){
        
    }
}