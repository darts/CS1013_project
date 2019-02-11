class Widget { //<>//
  int x, y, width, height, event;
  String label;
  color widgetColor, labelColor;
  PFont widgetFont;
  PImage image;

  Widget() {
  }

  Widget(int x, int y, PImage image, int event) {
    this.x=x; 
    this.y=y; 
    this.image = image;
    this.width = image.width; 
    this.height= image.height; 
    this.event=event;
    this.widgetColor=(255); 
    this.widgetFont=DEF_FONT;
    labelColor= color(0);
  }

  Widget(int x, int y, int width, int height, color widgetColor, PFont widgetFont, int event) {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height; 
    this.event=event;
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor= color(0);
  }  

  Widget(int x, int y, int width, int height, String label, 
    color widgetColor, PFont widgetFont, int event) {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label; 
    this.event=event;
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor= color(0);
  }
  
  //Draw the widget
  void draw() {
    if (image != null) {
      image(image, x, y);//draw the image if widget is image
    } else {
      stroke(0);
      textAlign(LEFT, BASELINE);
      fill(widgetColor);
      rect(x, y, width, height);
      textFont(NEW_DEF_FONT);
      if (label != null && label != "") {
        fill(labelColor);
        text(label, x+WIDGET_TEXT_X_OFFSET, y+height + WIDGET_TEXT_Y_OFFSET);//draw text
      }
    }
  }
  
  //has the widget been clicked.
  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      return event;
    }
    return EVENT_NULL;
  }

  void setColor(color theColor) {
    widgetColor = theColor;
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }
}