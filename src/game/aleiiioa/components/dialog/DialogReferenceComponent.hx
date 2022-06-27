package aleiiioa.components.dialog;

class DialogReferenceComponent {
    public var reference:String;
    public var res:hxd.res.Any;
    
    public function new(yarnFilePath:String) {
        reference = yarnFilePath;
        var path:String = "yarn/"+yarnFilePath+".yarn";
        res = hxd.Res.loader.load(path);  
    }
}