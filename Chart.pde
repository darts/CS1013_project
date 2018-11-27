class Chart{
  float x,y,width,height;
  PFont headerFont, labelFont;
  color chartColor,labelColor;
  String title, xLabel, yLabel;
  float[] dataPoints;
  String[] xLabels;
  boolean labelX;
  
  Chart(float[] dataPoints, String[] xLabels, String xLabel, String yLabel, String title, PFont headerFont, PFont labelFont, boolean labelX){
   this.dataPoints = dataPoints;
   this.xLabels = xLabels;
   this.xLabel = xLabel;
   this.yLabel = yLabel;
   this.title = title;
   this.headerFont = headerFont;
   this.labelFont = labelFont;
   this.labelX = labelX;
   if (xLabels.length != dataPoints.length && labelX == true)
      println("Error creating LineGraph, number of points and number of labels are not the same. Program will likely crash.");
  }
  
  Chart(){}
  
  void draw(){}
  
  void setData(float[] dataPoints){
    this.dataPoints = dataPoints;
  }
  
}