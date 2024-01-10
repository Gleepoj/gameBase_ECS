package aleiiioa.systems.core.renderer;

import aleiiioa.components.core.level.*;


class LevelRenderer extends echoes.System {
 
    public function new (){
      
    }

    @u function clearRenderer(){
        Game.ME.scroller.removeChildren();
    }
    // Attention focus n'est pas un chunk actif //
    @u function levelRendering(level:LevelComponent,active:Chunk_Active){
        level.render();
    } 
    @u function levelfocusRendering(level:LevelComponent,active:Focused_Chunk){
        level.render();
    } 

}