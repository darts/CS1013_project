class LineGraph extends Chart {
  color linecolor;
  int xPos, yPos, width, height;
  double max;
  double steps;
  double yMul;
  double yStep;
  color graphColour, backColour;
  double yTxtStep;

  LineGraph(String title, int xPos, int yPos, int width, int height, double max, float[] points, String[] xAxisLabels, String xLabel, String yLabel, PFont pointFont, PFont labelFont, color graphColour, color backColour, boolean labelX) { 
    super(points, xAxisLabels, xLabel, yLabel, title, labelFont, pointFont, labelX);
    this.xPos = xPos;
    this.yPos = yPos;
    this.width = width;
    this.height = height;
    this.max = max;
    steps = width / (points.length - 1);
    yMul = height / max;
    yStep = height / 10;
    this.graphColour = graphColour;
    this.backColour = backColour;
    yTxtStep = max / 10;
  }


  void draw() {
    //Draw the graph outline
    stroke(graphColour);
    line((float)xPos, (float)yPos, (float)xPos, (float)(yPos - height));
    line((float)xPos, (float)yPos, (float)(xPos + width), (float)yPos);

    //Draw the title
    textAlign(CENTER, BOTTOM);
    textFont(headerFont);
    text(title, (float)(xPos + (width / 2)), (float)(yPos - (height + (height / 15))));

    //Draw the grid behind the graph and label the y-axis steps
    textFont(labelFont);
    for (int i = 0; i <= 10; i++) {
      stroke(graphColour);
      line((float)xPos, (float)(yPos - (i * yStep)), (float)(xPos - 10), (float)(yPos - (i * yStep)));
      textAlign(RIGHT, CENTER);
      text(Double.toString((yTxtStep  * i)), (float)(xPos - 12), (float)(yPos - (i * yStep)));
      stroke(backColour);
      line((float)xPos, (float)(yPos - (i * yStep)), (float)(xPos + width), (float)(yPos - (i * yStep)));
    }

    //Draw the data to the graph and draw the x-axis labels.
    fill(graphColour);
    for (int i = 0; i < dataPoints.length - 1; i++) {
      stroke(graphColour);
      line((float)(xPos + (i * steps)), (float)(yPos - (dataPoints[i] * yMul)), (float)(xPos + ((i + 1) * steps)), (float)(yPos - (dataPoints[(i + 1)] * yMul)));
      ellipseMode(CENTER);
      ellipse((float)(xPos + (i * steps)), (float)(yPos - (dataPoints[i] * yMul)), (float)(steps / 5), (float)(steps / 5));
      stroke(backColour);
      line((float)(xPos + ((i + 1) * steps)), (float)(yPos), (float)(xPos + ((i + 1) * steps)), (float)(yPos - height));
      //Draw the x-axis labels.
      if (labelX) {
        textAlign(CENTER, TOP);
        stroke(graphColour);
        text(xLabels[i], (float)(xPos + (i * steps)), (float)(yPos + (height / 25)));
      }
    }
    //Draw the last point and label
    textAlign(CENTER, TOP);
    stroke(graphColour);
    if (labelX)
      text(xLabels[xLabels.length - 1], (float)(xPos + width), (float)(yPos + (height / 25)));
    ellipse((float)(xPos + width), (float)(yPos - (dataPoints[dataPoints.length - 1] * yMul)), (float)(steps / 5), (float)(steps / 5));
    //Label x and y axis types.
    textAlign(RIGHT, BOTTOM);
    text(yLabel, xPos, yPos - (height * 1.02));
    textAlign(LEFT, CENTER);
    text(xLabel, xPos + (width * 1.02), yPos);
    //Reset text and font settings.
    textAlign(LEFT, BASELINE);
    textFont(DEF_FONT);
  }
}
