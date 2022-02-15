/* package aleiiioa.systems.vehicule;

private function getTargetFromPath() {
    var p = predict(location,velocity);
    var targetClosestOnPath = VectorUtils.vectorProjection(currentStart.toVector(),p,currentEnd.toVector());
    var d = p.distance(targetClosestOnPath);
    
    if (d<5){
        var targetCurrentEnd = currentEnd.toVector();
        return targetCurrentEnd;
    }
    return targetClosestOnPath;
}

private function updatePathPosition() {
    if(checkIfBoidHadReachEnd())
        setNextSegmentOnPath();
}



private function addPath(_path:Array<Point>) {
    
    var po0 = tools.LPoint.fromCaseCenter(cx,cy);
    path.push(po0);

    for(p in _path){
        var po = tools.LPoint.fromCaseCenter(p.cx,p.cy);
        path.push(po);
    }
    
    startIndex = 0;
    endIndex = 1;
    currentStart = path[startIndex];
    currentEnd   = path[endIndex];
}


private function setNextSegmentOnPath() {

    if (endIndex < path.length-1){
        startIndex += 1;
        endIndex += 1;
        currentStart = path[startIndex];
        currentEnd = path[endIndex];
    }

}

private function checkIfBoidHadReachEnd(){
    var ce = currentEnd.toVector();
    var dist = ce.distance(location);

    if(dist < 10 )
        return true;
    return false;
}
 */
