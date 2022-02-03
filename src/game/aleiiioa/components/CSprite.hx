package aleiiioa.components;


@:forward
abstract CSprite(HSprite) from HSprite to HSprite {

    public inline function new() {
        this = new HSprite(D.tiles.Square);
        this.colorize(0xff0000);
    }

    public inline function setColor():HSprite {
        this.colorize(0x00ff00);
        return this;
    }

}
