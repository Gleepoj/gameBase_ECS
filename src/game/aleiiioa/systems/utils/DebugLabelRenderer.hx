package aleiiioa.systems.utils;

import echoes.Entity;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.utils.debug.DebugLabel;


class DebugLabelRenderer extends echoes.System{
    var gameScroller:h2d.Layers;
	var val:Float =0 ;
    
    public function new(scroller:h2d.Layers){
        this.gameScroller = scroller;
    }

    @a function onEntityAdd(dl:DebugLabel,gp:GridPosition){

    }

    @r function onEntityRemove(dl:DebugLabel) {
        dl.debugLabel.remove();
    }

	function renderAllDebugs(dl:DebugLabel,gp:GridPosition) {

        		// Debug label
		if( dl.debugLabel!=null ) {
			dl.debugLabel.x = Std.int(gp.attachX - dl.debugLabel.textWidth*0.5);
			dl.debugLabel.y = Std.int(gp.attachY+1);
		}
	}
    	/** Print some numeric value below entity **/
	public inline function debugFloat(dl:DebugLabel,v:Float, ?c=0xffffff) {
		debug(dl,M.pretty(v), c );
	}


	/** Print some value below entity **/
	public inline function debug(dl:DebugLabel,?v:Dynamic, ?c=0xffffff) {
		#if debug
		if( v==null && dl.debugLabel!=null ) {
			dl.debugLabel.remove();
			dl.debugLabel = null;
		}
		if( v!=null ) {
			if( dl.debugLabel==null ) {
				dl.debugLabel = new h2d.Text(Assets.fontPixel, gameScroller);
				dl.debugLabel.filter = new dn.heaps.filter.PixelOutline();
			}
			dl.debugLabel.text = Std.string(v);
			dl.debugLabel.textColor = c;
		}
		#end
	}


}