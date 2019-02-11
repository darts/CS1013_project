class Map {
  UnfoldingMap map;
  double xCentre;
  double yCentre;
  Map(UnfoldingMap map, double xCentre, double yCentre, int zoom) {
    this.map=map;
    this.xCentre=xCentre;
    this.yCentre=yCentre;
    Location centre=new Location(xCentre, yCentre);
    map.zoomAndPanTo(centre, zoom);
  }
  
  //Create the markers on the map
  void createMarkers(ArrayList<Double> xPositions, ArrayList<Double> yPositions) {
    if (xPositions.size()==yPositions.size()) {
      for (int count=0; count<xPositions.size(); count++) {
        Location tempLocation=new Location(xPositions.get(count), yPositions.get(count));//create a new set of coordinates
        SimplePointMarker temp=new SimplePointMarker(tempLocation);//create a marker at coordinates
        temp.setColor(color(#FA0015));//create centre colour
        temp.setStrokeColor(color(#F7F70A));//create stroke colour
        temp.setStrokeWeight(5);//Change size of stroke
        map.addMarkers(temp);//Add marker to map
       
      }
    } else print("Error: The amount of Marker x Coordinates does not equal the amount of marker yCoordinates");
  }
  
  //Draw the map
  void draw() {
    textFont(NEW_DEF_FONT);
    fill(0);
    map.draw();
  }
}