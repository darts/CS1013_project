class RadioButton{
  Widget[] widgetList; 
 int xPos, yPos, width, height, eventLeft, eventRight;
 String labelLeft, labelRight;
 color defColor, clickedColor;
 
 RadioButton(int xPos, int yPos, int width, int height, String labelLeft, String labelRight, int eventLeft, int eventRight){
   this.xPos = xPos;
   this.yPos = yPos;
   this.width = width;
   this.height = height;
   this.labelLeft = labelLeft;
   this.labelRight = labelRight;
   this.eventLeft = eventLeft;
   this.eventRight = eventRight;
   widgetList = new Widget[2];
   defColor = color(240);
   clickedColor = color(255, 215, 0);
   initialise();
 }
  
void initialise(){
  widgetList[0] = new Widget(xPos, yPos, width/2, height, labelLeft, clickedColor, NEW_DEF_FONT, eventLeft);
  widgetList[1] = new Widget(xPos + (width/2), yPos, width/2, height, labelRight, defColor, NEW_DEF_FONT, eventRight); 
}
  
  void draw(){
    widgetList[0].draw();
    widgetList[1].draw();
  }
  
  int clicked(){
   if(widgetList[0].getEvent(mouseX, mouseY) != EVENT_NULL){
     widgetList[0].setColor(clickedColor);
     widgetList[1].setColor(defColor);
     return widgetList[0].getEvent(mouseX, mouseY);
   }else if(widgetList[1].getEvent(mouseX, mouseY) != EVENT_NULL){
     widgetList[1].setColor(clickedColor);
     widgetList[0].setColor(defColor);
     return widgetList[1].getEvent(mouseX, mouseY);
   }
   return EVENT_NULL;
  }
  
  
}