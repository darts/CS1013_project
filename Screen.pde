class Screen {
  ArrayList<Widget> widgetList = new ArrayList<Widget>();
  ArrayList<TextWidget> textWidgetList =new ArrayList<TextWidget>();
  ArrayList<Chart> chartList = new ArrayList<Chart>();
  ArrayList<ScrollWindow> scrollWindowList = new ArrayList<ScrollWindow>();
  ArrayList<RadioButton> radioButtonList = new ArrayList<RadioButton>();
  boolean drawScroll;
  boolean drawMap;
  Business business;
  User user;

  {
    user = null;
    business = null;
  }


  PImage background;
  int event;

  Screen(PImage background) {
    this.background = background;
    drawScroll = true;
  }

  Screen() {
    background = null;
    drawScroll = true;
    drawMap = true;
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

  void addRadioButton(RadioButton button) {
    radioButtonList.add(button);
  }

  void addScrollWindow(ScrollWindow window) {
    scrollWindowList.add(window);
  }
  
  void removeScrollWindow(ScrollWindow window){
   scrollWindowList.remove(window); 
  }

  void scroll(int speed) {
    if (scrollWindowList.size() == 1)
      scrollWindowList.get(0).scroll(speed);
    else if (scrollWindowList.size() == 2)
      scrollWindowList.get(1).scroll(speed);
  }

  //Draws all widgets and buttons.
  void draw() {
    //Draw the background.
    noStroke();
    fill(255);
    rect(0, 0, 1920, 1080);
    drawWidgets();
  }

  void drawWidgets() {
    //Draw the widgets.
    for (int i = 0; i<widgetList.size(); i++) {
      Widget theWidget = (Widget)widgetList.get(i);
      theWidget.draw();
    }
    //Draw the textWidgets.
    for (int i = 0; i<textWidgetList.size(); i++) {
      TextWidget theTextWidget = (TextWidget)textWidgetList.get(i);
      theTextWidget.draw();
    }
    //Draw the charts.
    for (Chart ch : chartList) {
      ch.draw();
    }
    //Draw the scrollwindows.
    if (drawScroll) {
      for (ScrollWindow window : scrollWindowList)
        window.draw();
    }
    //Draw the radiobuttons.
    for (RadioButton button : radioButtonList) {
      button.draw();
    }

    textAlign(LEFT, BASELINE);
  }

  void displayReviews() {
  };

  int mousePressed() {
    int event;
    for (int i =0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget) widgetList.get(i);
      event = aWidget.getEvent(mouseX, mouseY);
      if (event != EVENT_NULL)
        return event;
    }
    for (RadioButton button : radioButtonList) {
      if (button.clicked() != EVENT_NULL)
        return button.clicked();
    }

    return EVENT_NULL;
  }

  //Returns a scrollbox object if it has been pressed, otherwise returns null. This is separate to the 
  //main mousepressed function as it returns a scrollbox object and not an int.
  ScrollBox scrollPressed() {
    for (ScrollWindow window : scrollWindowList) {
      if (window.clicked() != null)
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

  //Determines if the scrollboxes should be drawn.
  void drawScroll(boolean draw) {
    drawScroll = draw;
  }

  Business getBusiness() {
    return business;
  }

  User getUser() {
    return user;
  }
}