class ScatterGraph extends Chart {
  String xTitle, yTitle;
  float maxX, maxY, minimumY, xStart, xCounter, yCord, xCord, 
    yScaledToChart, scaledColumnHeight, roughColumnWidth, columnWidth;
  float[] xCords, yCords;
  color pointColor;
  //boolean textBelowColumn;
  double toPrint;
  //boolean labelX;

  ScatterGraph(String title, int xPos, int yPos, int width, int height, int maxY, int maxX, float[] yCords, float[] xCords, String[] xAxisLabels, String xLabel, String yLabel, PFont headerFont, PFont labelFont, color chartColor, color pointColor, boolean labelX) {
    super(yCords, xAxisLabels, xLabel, yLabel, title, headerFont, labelFont, labelX);
    this.pointColor = pointColor;
    this.x = xPos; 
    this.width = width; 
    this.height = height;
    this.y = yPos; 
    this.title=title;
    this.chartColor=chartColor; 
    this.headerFont=headerFont;
    this.labelFont = labelFont;
    this.xCords=xCords;
    this.yCords=yCords;
    labelColor= color(0);
    minimumY = 0;
    this.maxY = maxY;
    this.maxX=maxX;
  }

  void draw() {//Draw the scatterplot
    fill(chartColor);
    noStroke();
    rect(x-MARGIN, y-height-MARGIN, width+(2*MARGIN), height+(2*MARGIN));//draw the outline/background
    stroke(0);

    //draw axis lines
    stroke(175);
    line(x-3, y+2, x+width, y+2);
    line(x-3, y+2, x-3, y-height);
    noStroke();
    xStart = x;

    xCounter = xCords.length;

    //draw min and max Y axis labels
    textFont(headerFont);
    fill(100);
    textAlign(RIGHT, CENTER);
    text(int(maxY), x-8, y-height);
    text(int(minimumY), x-8, y);
    text(int (maxX), x+width, y+13);

    //draw the columns
    for (int index = 0; index < xCounter; index++) {
      yCord = yCords[index];
      xCord = xCords[index];
      yCord= y-(yCord*(height/maxY));
      xCord= x+(xCord*(width/maxX)-5);

      //draw points
      fill(pointColor);
      rect(xCord, yCord, 5, 5);
    }
    //reset x so for when draw is called again
    x = xStart;

    // print the title of the chart
    fill(labelColor);
    textAlign(CENTER, TOP);
    text(title, x+width/2, y-height-20);
    textAlign(RIGHT, BOTTOM);
    text(yLabel, x, y - (height * 1.02));
    textAlign(LEFT, CENTER);
    text(xLabel, x + (width * 1.02), y);
    textAlign(LEFT, BASELINE);
    textFont(DEF_FONT);
  }

  //round to x decimal points.
  double round (double value, int precision) {
    int scale = (int) Math.pow(10, precision);
    return (double) Math.round(value * scale) / scale;
  }
}