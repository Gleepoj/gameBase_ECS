package aleiiioa.components.particules;

import h2d.SpriteBatch.BatchElement;
import h2d.Tile;

class EmitterComponent {
    
    public var cd:dn.Cooldown;
    public var tick:Bool = false;

    public var sbParticules : Array<h2d.SpriteBatch.BatchElement>;
    public var layer  : h2d.Layers;
    public var sb     : h2d.SpriteBatch;
    public var texture: h3d.mat.Texture;

    public function new() {
        cd = new dn.Cooldown(Const.FPS);

        layer = new h2d.Layers();
        Game.ME.root.add(layer,Const.DP_FRONT);
		layer.name = "VFX";
        
        //texture = h2d.Tile.fromColor(Col.fromRGBf(1,0,1),128,128);
        sbParticules = [];
        //sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Col.fromRGBf(1,0,1),128,128));
        sb = new h2d.SpriteBatch(Assets.tiles.getTile(D.tiles.wing));
        sb.hasRotationScale = true;
        sb.hasUpdate = true;
        sb.blendMode = Add;
        

        layer.add(sb,Const.DP_FRONT);
        layer.setPosition(400,400);
    }

    public function addParticule(be:BatchElement) {
        sb.add(be);
        sbParticules.push(be);
    }

}