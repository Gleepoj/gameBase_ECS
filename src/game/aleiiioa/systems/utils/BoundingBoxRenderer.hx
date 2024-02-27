package aleiiioa.systems.utils;

import aleiiioa.components.core.rendering.SpriteExtension;
import aleiiioa.components.core.rendering.SpriteComponent;
import aleiiioa.components.core.physics.collision.BoundingBox;
import aleiiioa.components.core.physics.position.GridPosition;

class BoundingBoxRenderer extends echoes.System{
    var gameScroller:h2d.Layers;
    
    public function new(scroller:h2d.Layers){
        this.gameScroller = scroller;
    }

    @a function onEntityAdd(bb:BoundingBox,gp:GridPosition,spr:SpriteComponent,se:SpriteExtension){
        bb.attachX = gp.attachX;
        bb.attachY = gp.attachY;
		
		bb.pivotX = 0.5;
		bb.pivotY = 0.5;
		
		bb.hei = Const.GRID;
		bb.wid = Const.GRID;
    }

    @u function updateDebugBounds(bb:BoundingBox,gp:GridPosition) {
        debugRequest(bb);
        renderAllDebugs(bb);
    }
	
	@r function onEntityRemove(bb:BoundingBox) {
        bb.debugBounds.remove();
    }

    private function renderDebugBounds(bb:BoundingBox) {
		// debug bound origin is attachX attachY 
		var c = Col.randomRGB(0.9,0.3,0.3);
		bb.debugBounds.clear();

		// Bounds rect
		bb.debugBounds.lineStyle(1, c, 0.5);
		bb.debugBounds.drawRect(bb.left,bb.top, bb.wid, bb.hei);

		// Attach point
		bb.debugBounds.lineStyle(1);
		bb.debugBounds.beginFill(c, 0.8);
		bb.debugBounds.drawRect(-1, -1, 3, 3);
		bb.debugBounds.endFill();

		bb.debugBounds.lineStyle(1, dn.Col.green(), 1);
		bb.debugBounds.drawCircle(0,0, 2);	
	}

	private function disableDebugBounds(bb:BoundingBox) {
		if (bb.debugBounds != null) {
			bb.debugBounds.remove();
			bb.debugBounds = null;
		}
	}

	private function enableDebugBounds(bb:BoundingBox) {
		if (bb.debugBounds == null) {
			bb.debugBounds = new h2d.Graphics();
			this.gameScroller.add(bb.debugBounds, Const.DP_TOP);
		}
		bb.invalidateDebugBounds = true;
	}
	
	function renderAllDebugs(bb:BoundingBox) {

		// Debug bounds
		if (bb.debugBounds != null) {
			if (bb.invalidateDebugBounds) {
				bb.invalidateDebugBounds = false;
				renderDebugBounds(bb);
			}
			bb.debugBounds.x = Std.int(bb.attachX);
			bb.debugBounds.y = Std.int(bb.attachY);
		}
	}

	function debugRequest(bb:BoundingBox) {
		#if debug
		// Show bounds (with `/bounds` in console)
		if (ui.Console.ME.hasFlag("bounds") && bb.debugBounds == null)
			enableDebugBounds(bb);

		// Hide bounds
 		if (!ui.Console.ME.hasFlag("bounds") && bb.debugBounds != null)
			disableDebugBounds(bb); 
		#end
	}
}