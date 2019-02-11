class BarChart extends Chart {
  String xTitle, yTitle;
  float maxXvalue, maximumY, minimumY, 
    xStart, xCounter, columnHeight, 
    yScaledToChart, scaledColumnHeight, 
    roughColumnWidth, columnWidth;
  color columnColor;
  double toPrint;

  //Create a new barchart
  BarChart(String title, int xPos, int yPos, int width, int height, double max, 
    float[] points, String[] xAxisLabels, String xLabel, String yLabel, 
    PFont headerFont, PFont labelFont, color chartColor, 
    color columnColor, boolean labelX) {
    super(points, xAxisLabels, xLabel, yLabel, title, headerFont, labelFont, labelX);
    this.columnColor = columnColor;
    this.x = xPos; 
    this.width = width; 
    this.height = height;
    this.y = yPos; 
    this.title=title;
    this.chartColor=chartColor; 
    this.headerFont=headerFont;
    this.labelFont = labelFont;
    labelColor= color(0);
    minimumY = 0;
    maximumY = (float)max;
  }
  
  //Draw the barchart
  void draw() {
    noStroke();
    fill(chartColor);
    rect(x-MARGIN, y-height-MARGIN, width+(2*MARGIN), height+(2*MARGIN));//Draw the chart container/background.

    //draw axis lines
    stroke(175);
    line(x-3, y+2, x+width, y+2);
    line(x-3, y+2, x-3, y-height);
    noStroke();
    xStart = x;
    xCounter = dataPoints.length;

    //draw min and max Y axis labels
    textFont(headerFont);
    fill(100);
    textAlign(RIGHT, CENTER);
    text(int(maximumY), x-8, y-height);
    text(int(minimumY), x-8, y);

    //draw the columns
    for (int index = 0; index < xCounter; index++) {
      columnHeight = dataPoints[index];
      //scale columnHeight to chart
      yScaledToChart = height / maximumY;
      scaledColumnHeight = columnHeight * yScaledToChart;
      if (scaledColumnHeight > height) scaledColumnHeight = height;
      //scale columnWidth to chart
      roughColumnWidth = width / xCounter;
      columnWidth = roughColumnWidth - 5;
      //draw column
      fill(columnColor);
      quad(x, y, x, y-scaledColumnHeight, x + columnWidth, y-scaledColumnHeight, x + columnWidth, y);

      //label column base and values.
      textFont(labelFont);
      textAlign(CENTER, BOTTOM);
      fill(100);
      //toPrint = round(dataPoints[index]);
      toPrint = (double)(round(dataPoints[index], 1));

      //Print x-axis labels.
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
    textAlign(CENTER, BOTTOM);
    text(title, x+width/2, y-height-30);
    textAlign(RIGHT, BOTTOM);
    text(yLabel, x, y - (height * 1.02));
    textAlign(LEFT, CENTER);
    text(xLabel, x + (width * 1.02), y);
    textAlign(LEFT, BASELINE);
    textFont(DEF_FONT);
    stroke(0);
  }

  //Round a number to x decimal places.
  double round (double value, int precision) {
    int scale = (int) Math.pow(10, precision);
    return (double) Math.round(value * scale) / scale;
  }
}