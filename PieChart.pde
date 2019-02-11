class PieChart extends Chart {
  float diameter, lastAngle, totalData, dataScaler;
  int longestLabel, totalDegrees, legendBaseX, legendBaseY;
  int [] data;
  PFont headerFont, labelFont;
  String title;
  String[] xAxisLabels;

  // contructs a pie chart object, the x and y coordinates correspond to the
  // lower left corner of the chart, diameter is the diameter of the pie charts
  // circle, points is a float array of the data for the chart. chartcolor is
  // the colour of the background behind the chart.
  PieChart(String title, int x, int y, float diameter, float[] points, 
    String[] xAxisLabels, color chartColor, PFont headerFont, PFont labelFont) {
    this.longestLabel = 0;
    this.title = title;
    this.headerFont = headerFont;
    this.labelFont = labelFont;
    this.xAxisLabels = xAxisLabels;
    longestLabel();
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.dataPoints = points;
    this.chartColor = chartColor;
    data = new int [points.length];
    dataToDegrees();
    legendBasePoint();
  }

  void draw() {
    // draw the background
    fill(this.chartColor);
    textFont(headerFont);
    rect(x-MARGIN, y-diameter-(MARGIN*4), diameter+(MARGIN*7)+((int)textAscent()), diameter+(MARGIN*4)+longestLabel);

    //print title
    textAlign(CENTER, BASELINE);
    fill(0);
    text(title, x+diameter/2, y-diameter-MARGIN);

    // draw the piechart
    noStroke();
    lastAngle = 0;
    textFont(labelFont);
    for (int index = 0; index < data.length; index++) {
      float gray = map(index, 0, data.length, 0, 255);
      fill(gray);

      //draw a sector
      arc(x+diameter/2, y-diameter/2, diameter, diameter, lastAngle, lastAngle+radians(data[index]));

      //draw a legend
      rect(legendBaseX, legendBaseY+(index*(2*MARGIN+(int)textAscent())), MARGIN*2, MARGIN*2);
      text(xAxisLabels[index], legendBaseX+5*MARGIN, legendBaseY+(index*(2*MARGIN+(int)textAscent()))+(int)textAscent());

      lastAngle += radians(data[index]);
    }
    textAlign(LEFT, BASELINE);
  }

  // creates an Integer array of the data for the chart but with all
  // the data converted to degrees to represent the information in
  // the pie chart.
  void dataToDegrees() {
    totalData = 0;
    totalDegrees = 0;
    for (int index = 0; index<dataPoints.length; index++) {
      totalData += dataPoints[index];
    }
    dataScaler = 360 / 100;
    for (int index = 0; index<dataPoints.length; index++) {
      data[index] = (int)((dataPoints[index]/totalData)*360);
      totalDegrees += data[index];
    }
    //check for and correct rounding down of data
    if (totalDegrees != 360) data[data.length-1] += 360-totalDegrees;
  }

  // creates points which all legend items are based off
  void legendBasePoint() {
    this.legendBaseX = (int)(x+diameter+(2*MARGIN));
    this.legendBaseY = (int)(y-diameter+MARGIN);
  }

  //calculates the length of the longest label
  void longestLabel() {
    textFont(labelFont);
    for (int index = 0; index < xAxisLabels.length; index++) {
      String s = xAxisLabels[index];
      if (longestLabel < (int)textWidth(s)) longestLabel = (int)textWidth(s);
    }
  }
}