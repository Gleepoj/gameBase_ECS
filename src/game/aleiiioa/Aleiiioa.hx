package aleiiioa;


import echoes.System;
import aleiiioa.components.CPos;
import aleiiioa.components.CSprite;
import echoes.SystemList;
import echoes.Workflow;
import echoes.Entity;
/**
	This small class just creates a SamplePlayer instance in current level
**/

class Aleiiioa extends Game {

	public function new() {
		super();
		Workflow.add60FpsSystem(new ERender(Game.ME.scroller));
		
		for (i in 0...100){
			for(j in 0...20){
				var spr = new CSprite();
				var pos = new CPos(i,j);
				new Entity().add(spr,pos);
			}
		}

		//Workflow.update(tmod);
		trace(Workflow.entities.length);
	}

	override function fixedUpdate() {
		super.fixedUpdate();
		//Workflow.update(tmod);
	}
	override function postUpdate() {
		Workflow.postUpdate(tmod);
	}
}
	

class ERender extends echoes.System {
	var gameScroller:h2d.Layers;

	public function new(gs:h2d.Layers) {
		this.gameScroller = gs;
	}

	@u inline function updateSpritePosition(spr:CSprite,pos:CPos) {
		spr.x = spr.x + pos.x/100 + 0.01;// pos.x;
		spr.y = spr.y + pos.y/100 + 0.01;//pos.y;
	  }
	// There are @a, @u and @r shortcuts for @added, @update and @removed metas;
	// @added/@removed-functions are callbacks that are called when an entity is added/removed from the view;
	@a function onEntityAdded(spr:CSprite) {
		this.gameScroller.add(spr);
	}
}


		
		
		/* class Render extends echoes.System {
		  
		  // There are @a, @u and @r shortcuts for @added, @update and @removed metas;
		  // @added/@removed-functions are callbacks that are called when an entity is added/removed from the view;
		  @a function onEntityAdded(spr:Sprite) {
			
			super.addChild(spr);
		  }
		  // Even if callback was triggered by destroying the entity, 
		  // @removed-function will be called before this happens, 
		  // so access to the component will be still exists;
		  @r function onEntityWithSpriteAndPositionRemoved(spr:Sprite){//}, pos:Position, e:Entity) {
			//scene.removeChild(spr); // spr is still not a null
			//trace('Oh My God! They removed ${ e.exists(Name) ? e.get(Name) : "Unknown Sprite" }!');
		  }
		  @u inline function updateSpritePosition(spr:CSprite) {
			spr.x = +1;// pos.x;
			spr.y = +1;//pos.y;
		  }
		  @u inline function afterSpritePositionsUpdated() {
	
		  }
		}*/
