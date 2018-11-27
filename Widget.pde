class Widget { //<>//
  int x, y, width, height, event;
  String label;
  color widgetColor, labelColor;
  PFont widgetFont;

  Widget() {
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
  void draw() { 
    textAlign(LEFT, BASELINE);
    fill(widgetColor);
    rect(x, y, width, height);
    textFont(NEW_DEF_FONT);
    if (label != null && label != "") {
      fill(labelColor);
      text(label, x+WIDGET_TEXT_X_OFFSET, y+height + WIDGET_TEXT_Y_OFFSET);
    }
  }
  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      return event;
    }
    return EVENT_NULL;
  }
  
  void setColor(color theColor){
   widgetColor = theColor; 
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
}