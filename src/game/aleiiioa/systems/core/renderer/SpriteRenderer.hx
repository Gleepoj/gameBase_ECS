package aleiiioa.systems.core.renderer;

import h3d.Vector;
import echoes.System;
import aleiiioa.components.core.*;

class SpriteRenderer extends echoes.System {
	var gameScroller:h2d.Layers;
	var game:Game;


	public function new(scroller:h2d.Layers,_game:Game) {
		this.gameScroller = scroller;
		this.game = _game;
	}

	@a function onEntityAdded(spr:SpriteComponent) {
		this.gameScroller.add(spr,Const.DP_FRONT);
		spr.setCenterRatio(0.5,1);
		spr.alpha = 1;
	}
	
/* 	@u inline function updateSpritePosition(dt:Float,spr:SpriteComponent,gp:GridPosition,se:SpriteExtension) {
		this.renderSprite(dt,spr,gp,se);
	} */
/* 	@u function offsetChild(spr:SpriteComponent,gp:GridPosition,ogp:GridPositionOffset) {
		spr.x = gp.attachX + ogp.ox;
		spr.y = gp.attachY + ogp.oy;
	} */

	@r function onEntityRemoved(spr:SpriteComponent) {
		spr.remove();
	}

	private function interpolateSpritePosition(gp:GridPosition){
		var _x = M.lerp(gp.lastFixedUpdateX, (gp.cx+gp.xr)*Const.GRID, game.getFixedUpdateAccuRatio());
		var _y = M.lerp(gp.lastFixedUpdateY, (gp.cy+gp.yr)*Const.GRID, game.getFixedUpdateAccuRatio()); 
		return new Vector(_x,_y);
	}

	private function setPivots(se:SpriteExtension,spr:SpriteComponent, x:Float, ?y:Float) {
		se.pivotX = x;
		se.pivotY = y!=null ? y : x;
	
		spr.setCenterRatio(se.pivotX, se.pivotY);
	}

	/** Briefly squash sprite on X (Y changes accordingly). "1.0" means no distorsion. **/
	private function setSquash(se:SpriteExtension,spr:SpriteComponent) {
		se.squashX = spr.scaleX;
		se.squashY = 2 - spr.scaleX;
		
		se.squashX = 2 - spr.scaleY;
		se.squashY = spr.scaleY;
	}

	@u private function renderSprite(dt:Float,spr:SpriteComponent,gp:GridPosition,se:SpriteExtension) {
		if (se.interpolateSprPos){
			var interpolatePos = this.interpolateSpritePosition(gp);
			spr.x = interpolatePos.x;
			spr.y = interpolatePos.y;
		}
		if (!se.interpolateSprPos){
			spr.x = gp.attachX;
			spr.y = gp.attachY;
		}

		spr.scaleX = se.dir * se.sprScaleX * se.squashX;
		spr.scaleY = se.sprScaleY * se.squashY;

		se.squashX += (1 - se.squashX) * M.fmin(1, 0.2 * dt);
		se.squashY += (1 - se.squashY) * M.fmin(1, 0.2 * dt);		
	}

	@u private function renderChildSprite(dt:Float,spr:SpriteComponent,gp:GridPosition,se:SpriteExtension,ogp:GridPositionOffset) {
		if (se.interpolateSprPos){
			var interpolatePos = this.interpolateSpritePosition(gp);
			spr.x = interpolatePos.x + ogp.ox;
			spr.y = interpolatePos.y + ogp.oy;
		}
		if (!se.interpolateSprPos){
			spr.x = gp.attachX + ogp.ox;
			spr.y = gp.attachY + ogp.oy;
		}

		spr.scaleX = se.dir * se.sprScaleX * se.squashX;
		spr.scaleY = se.sprScaleY * se.squashY;

		se.squashX += (1 - se.squashX) * M.fmin(1, 0.2 * dt);
		se.squashY += (1 - se.squashY) * M.fmin(1, 0.2 * dt);		
	}
}
