package aleiiioa.components.core.rendering;


@:forward
abstract SpriteComponent(HSprite) from HSprite to HSprite {
     
    public inline function new(spriteStr:String, assetLib:Dynamic = null) {
        assetLib = assetLib == null ? Assets.tiles : assetLib;
        this = new HSprite(assetLib);
        this.set(spriteStr);
    }

}
