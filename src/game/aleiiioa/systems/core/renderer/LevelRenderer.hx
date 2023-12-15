package aleiiioa.systems.core.renderer;

import aleiiioa.components.core.level.LevelComponent;

class LevelRenderer extends echoes.System {
    public function new (){

    }
    @u function clearRenderer(){
        Game.ME.scroller.removeChildren();
    }
    
    @u function levelRendering(level:LevelComponent){

        level.render();
    }
}