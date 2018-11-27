class Screen {
  ArrayList<Widget> widgetList = new ArrayList<Widget>();
  ArrayList<TextWidget> textWidgetList =new ArrayList<TextWidget>();
  ArrayList<Chart> chartList = new ArrayList<Chart>();
  ArrayList<ScrollWindow> scrollWindowList = new ArrayList<ScrollWindow>();
  ArrayList<RadioButton> radioButtonList = new ArrayList<RadioButton>();
  boolean drawScroll;


  PImage background;
  int event;

  Screen(PImage background) {
    this.background = background;
    drawScroll = true;
  }

  Screen() {
    background = null;
    drawScroll = true;
  }

  void addTextWidget(TextWidget textWidget) {
    textWidgetList.add(textWidget);
  }


  void addWidget(Widget widget) {
    widgetList.add(widget);
  }

  void addChart(Chart ch) {
    chartList.add(ch);
  }
  
  void addRadioButton(RadioButton button){
   radioButtonList.add(button); 
  }

  void addScrollWindow(ScrollWindow window) {
    scrollWindowList.add(window);
  }
  
  void scroll(int speed){
    scrollWindowList.get(0).scroll(speed); 
  }

  void draw() {
    //if(background != null)
    //image(background, 0, 0, SCREENX, SCREENY);
    for (int i = 0; i<widgetList.size(); i++) {
      Widget theWidget = (Widget)widgetList.get(i);
      theWidget.draw();
    }
    for (int i = 0; i<textWidgetList.size(); i++) {
      TextWidget theTextWidget = (TextWidget)textWidgetList.get(i);
      theTextWidget.draw();
    }
    for (Chart ch : chartList) {
      ch.draw();
    }
    if (drawScroll){
      for (ScrollWindow window : scrollWindowList)
        window.draw();
    }
    
    for(RadioButton button : radioButtonList){
     button.draw(); 
    }
  }

  int getEvent(int mousX, int mousY) {
    //Chech if any widgets have been pressed.
    for (int i = 0; i < widgetList.size(); i++) {
      Widget widget = widgetList.get(i);
      if (mousX> widget.x && mousX < widget.x+width && mousY >widget.y && mousY <widget.y+height) {
        return event;
      }
    } 
    //Check if any textwidgets have been pressed.
    for (int i = 0; i < textWidgetList.size(); i++) {
      TextWidget textWidget = textWidgetList.get(i);
      if (mousX> textWidget.x && mousX < textWidget.x+width && mousY >textWidget.y && mousY <textWidget.y+height) {
        return event;
      }
    } 



    return EVENT_NULL;
  }


  int mousePressed() {
    int event;
    for (int i =0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget) widgetList.get(i);
      event = aWidget.getEvent(mouseX, mouseY);
      if (event != EVENT_NULL)
        return event;
    }
    for(RadioButton button : radioButtonList){
      if(button.clicked() != EVENT_NULL)
        return button.clicked();
    }
    return EVENT_NULL;
  }
  
  ScrollBox scrollPressed(){
   for(ScrollWindow window : scrollWindowList){
     if(window.clicked() != null)
       return window.clicked();
   }
   return null;
   
  }


  TextWidget textPressed() {
    // Ask the widgets on the list if the current mouse value is
    // inside them. If it is, the widget has been pressed.
    // Take the appropriate response to this event.
    for (int i = 0; i < textWidgetList.size(); i++) {
      TextWidget theWidget = textWidgetList.get(i);
      event = theWidget.getEvent(mouseX, mouseY);
      if (event== TEXT_WIDGET) {
        return theWidget;
      }
    }
    return null;
  }

  void drawScroll(boolean draw) {
    drawScroll = draw;
  }

  //Add borderColour to widget class----------------------
  //void mouseMoved() {
  //  int event;
  //  for (int i = 0; i<widgetList.size(); i++) {
  //    Widget theWidget = (Widget) widgetList.get(i);
  //    event = theWidget.getEvent(mouseX, mouseY);
  //    switch(event) {
  //    case EVENT_NULL:
  //      theWidget.borderColour=0;
  //    }
  //  }
  //}
}