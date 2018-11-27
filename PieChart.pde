class PieChart extends Chart {
  float diameter, lastAngle, totalData, dataScaler;
  int [] data;

  PieChart(int x, int y, float diameter, float[] points, color chartColor) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.dataPoints = points;
    this.chartColor = chartColor;
    data = new int [points.length];
    dataToDegrees();
  }
  
  void draw(){
    fill(this.chartColor);
    rect(x-MARGIN,y-diameter-MARGIN,diameter+(MARGIN*2),diameter+(MARGIN*2));
    noStroke();
    lastAngle = 0;
    for (int index = 0; index < data.length; index++) {
      float gray = map(index, 0, data.length, 0, 255);
      fill(gray);
      arc(x+diameter/2, y-diameter/2, diameter, diameter, lastAngle, lastAngle+radians(data[index]));
      lastAngle += radians(data[index]);
    }
  }
  
  void dataToDegrees(){
    totalData = 0;
    for(int index = 0; index<dataPoints.length; index++){
      totalData += dataPoints[index];
    }
    dataScaler = 360 / 100;
    for(int index = 0; index<dataPoints.length; index++){
      data[index] = int((dataPoints[index]/totalData)*360);
    }
  }
}

  ////create a piechart
  //float[] piePoints = {5, 10, 15, 20, 25};
  //pc1 = new PieChart(100, 500, 300, piePoints, color(255));
  
  ////draw a piechart
  //pc1.draw();
