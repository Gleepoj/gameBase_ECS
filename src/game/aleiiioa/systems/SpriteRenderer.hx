package aleiiioa.systems;
import echoes.System;
import aleiiioa.components.*;

class SpriteRenderer extends echoes.System {
	var gameScroller:h2d.Layers;

	public function new(scroller:h2d.Layers) {
		this.gameScroller = scroller;
	}

	@u inline function updateSpritePosition(spr:SpriteComponent,pos:GridPosition) {
		spr.x = pos.attachX;//0;//spr.x + pos.x/100 + 0.5;
		spr.y = pos.attachY;
	  }
	// There are @a, @u and @r shortcuts for @added, @update and @removed metas;
	// @added/@removed-functions are callbacks that are called when an entity is added/removed from the view;
	@a function onEntityAdded(spr:SpriteComponent) {
		this.gameScroller.add(spr,Const.DP_FRONT);
		spr.set(D.tiles.fxCircle15);
		spr.setCenterRatio(0.5,1);
		spr.alpha = 0.5;
	}

	@r function onEntityRemoved(spr:SpriteComponent) {
		spr.remove();
	}
}