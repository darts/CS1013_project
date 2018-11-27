class ScatterGraph extends Chart {
  String xTitle, yTitle;
  float maxX, maximumY, minimumY, xStart, xCounter,  yCord, xCord,
    yScaledToChart, scaledColumnHeight, roughColumnWidth, columnWidth;
  float[] xCords, yCords;
  color pointColor;
  //boolean textBelowColumn;
  double toPrint;
  //boolean labelX;

  ScatterGraph(String title, int xPos, int yPos, int width, int height, int maxY, int maxX, float[] yCords, float[] xCords, String[] xAxisLabels, String xLabel, String yLabel, PFont headerFont, PFont labelFont, color chartColor, color pointColor, boolean labelX) {
    super(yCords, xAxisLabels, xLabel, yLabel, title, headerFont, labelFont, labelX);
    //this.textBelowColumn = textBelowColumn;
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
    maximumY = (float)maxY;
    this.maxX=maxX;
  }

  void draw() {
    fill(chartColor);
    rect(x-MARGIN, y-height-MARGIN, width+(2*MARGIN), height+(2*MARGIN));

    //draw axis lines
    stroke(175);
    line(x-3, y+2, x+width, y+2);
    line(x-3, y+2, x-3, y-height);
    noStroke();
    xStart = x;

    //set max y value to +10 the max value in the columnList
    //maximumY = max(dataPoints);
    //maximumY = maximumY + 10;
    xCounter = xCords.length;

    //draw min and max Y axis labels
    textFont(headerFont);
    fill(100);
    textAlign(RIGHT, CENTER);
    text(int(maximumY), x-8, y-height);
    text(int(minimumY), x-8, y);
    text(int (maxX), x+width, y+13);

    //draw the columns
    for (int index = 0; index < xCounter; index++) {
      yCord = yCords[index];
      xCord = xCords[index];
      
     
      //draw column
      fill(pointColor);
      rect(xCord, yCord, 5,5);

      //label column base and values.
      textFont(labelFont);
      textAlign(CENTER, CENTER);
      fill(100);
      //toPrint = round(dataPoints[index]);
      toPrint = (double)(round(dataPoints[index], 1));

      text(Double.toString(toPrint), x + (columnWidth / 2), y - (scaledColumnHeight));
      if (labelX) {
        textAlign(CENTER, TOP);
        text(xLabels[index], x + (columnWidth / 2), y + 8);
      }

      //x startpoint of the next column
      x += roughColumnWidth;
    }
    //reset x so for when draw is called again
    x = xStart;

    // print the title of the chart
    fill(labelColor);
    textAlign(CENTER, TOP);
    text(title, x+width/2, y-height);
    textAlign(RIGHT, BOTTOM);
    text(yLabel, x, y - (height * 1.02));
    textAlign(LEFT, CENTER);
    text(xLabel, x + (width * 1.02), y);
    textAlign(LEFT, BASELINE);
    textFont(DEF_FONT);
  }

  double round (double value, int precision) {
    int scale = (int) Math.pow(10, precision);
    return (double) Math.round(value * scale) / scale;
  }
}