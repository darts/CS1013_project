class ScreenOrganiser {

  PFont stdFont;        
  PImage image1, image2;
  Widget searchButton, back ;
  TextWidget focus;
  TextWidget searchBar;
  //TextWidget searchUser;
  Screen homeScreen, screen2;
  UserScreen userScreen;
  BusinessScreen businessScreen;
  ArrayList widgetList;
  Screen currentScreen;
  Query qCall;
  Screen cScreen;
  Widget defQ;
  RadioButton selectQ;
  ScrollWindow resultWindow;
  Boolean searchBusiness;
  //ScrollBox sbTest;


  ScreenOrganiser() {
    stdFont=loadFont("Arial-ItalicMT-20.vlw");
    textFont(NEW_DEF_FONT);
    image1=loadImage("restaurant.jpg");
    //image2=loadImage("white.jpg");
    searchBusiness = true;
    homeScreen = new Screen(image1);
    screen2 = new Screen();

    currentScreen = homeScreen;
    qCall = new Query();
    searchBar= new TextWidget(100, 200, 400, 60, " Search By Name ", color(255), stdFont, TEXT_WIDGET, 25);
    resultWindow = new ScrollWindow(1000, 0, 920, 600);
    searchButton= new Widget(525, 200, 140, 60, "Search", color(21, 160, 221), stdFont, EVENT_BUTTON1);
    back= new Widget(700, 50, 100, 40, "back", color(21, 160, 221), stdFont, EVENT_BUTTON2);
    selectQ = new RadioButton(140, 100, 320, 60, "Business", "User", EVENT_SEARCH_BUSINESS, EVENT_SEARCH_USER);
    //defQ = new Widget(200, 450, 150, 50, "Get some data", color(200), stdFont, EVENT_DEF_Q);
    float[] revPStar = qCall.reviewsPerStar();
    for(int i = 0; i < revPStar.length; i++)
      println(revPStar[i]);
    //String[] stC = new String[]{"1", "2","3","4","5"};
    //homeScreen.addChart(new BarChart("Reviews Per Star", 20, 420, 375, 400, max(revPStar), revPStar, stC , "Stars", "Review Count",standardFont,standardFont, color(255), color(200, 50,50), true));
    homeScreen.addTextWidget(searchBar);
    // homeScreen.addTextWidget(searchUser);
    homeScreen.addWidget(searchButton);
    homeScreen.addRadioButton(selectQ);
    //homeScreen.addWidget(defQ);
    homeScreen.addScrollWindow(resultWindow);
    screen2.addWidget(back);

    focus=null;
    widgetList = new ArrayList();
  }

  void draw() {
    textAlign(LEFT, BASELINE);
    textFont(DEF_FONT);
    currentScreen.draw();
  }
  // void mouseMoved() {
  // currentScreen.mouseMoved();
  // }

  void mousePressed() {
    switch(currentScreen.mousePressed()) {
    case EVENT_BUTTON1:
      println("SEARCHING...");
      if (searchBusiness) {

        ArrayList<Business> rList = qCall.getBusinessByName(focus.getLabel());
        resultWindow.populate(rList, color(245), NEW_DEF_FONT, null);
        if (rList.size() > 1) {
          for (int index = 0; index < rList.size(); index++) {
            println(rList.get(index).getBusinessID() + "   " + rList.get(index).getName());
          }
          println(rList.size());
          // currentScreen = new BusinessScreen(rList.get(0));//-----------------------------------------------------------------------------------Uncomment before next run..also probably need error checking on thisi.e if theres no business with that name
        }
      } else {

        ArrayList<User> rList = qCall.getUserByName(focus.getLabel());
        resultWindow.populate(rList, color(245), NEW_DEF_FONT);
        if (rList.size() > 1) {
          for (int index = 0; index < rList.size(); index++) {
            println(rList.get(index).getUserID() + "   " + rList.get(index).getName());
          }
          println(rList.size());
          // currentScreen = new BusinessScreen(rList.get(0));//-----------------------------------------------------------------------------------Uncomment before next run..also probably need error checking on thisi.e if theres no business with that name
        }
      }
      break;

    case EVENT_SEARCH_USER:
      println("Searching by User");
      searchBusiness = false;
      break;
    case EVENT_SEARCH_BUSINESS:
      println("Searching by Business");
      searchBusiness = true;
      break;
    case EVENT_BUTTON2:
      println("BACK ");
      currentScreen = homeScreen;// test only have to mke other events later
      break;
    case EVENT_DEF_Q:
      currentScreen = new Screen();
      currentScreen.addWidget(back);
      ArrayList<Review> rList = qCall.greatReviews();
      float[] aList = new float[rList.size()];
      for (int i = 0; i < rList.size(); i++) {
        aList[i] = (float)rList.get(i).characterCount();
      }
      currentScreen.addChart(new LineGraph("Number of Characters of 5-Star Reviews", 90, 500, 600, 300, (double)5000, aList, new String[0], "", "Characters", standardFont, standardFont, color(200, 0, 0), color(0, 0, 21, 20), false));
      break;
    }
    ScrollBox clickedBox = currentScreen.scrollPressed();
    if (clickedBox != null) {
      if (clickedBox.isBusiness()) {
        currentScreen = new BusinessScreen(clickedBox.getBusiness());
        currentScreen.addWidget(back);
      } else if (clickedBox.isUser()) {
        currentScreen = new UserScreen(clickedBox.getUser());
        currentScreen.addWidget(back);
      } else if (clickedBox.isReview()) {
        println("Delete me and uncomment the next line if you want this to work, line 123, screenorganiser");
        //currentScreen = new ReviewScreen(clickedBox.getReview());
        //currentScreen.addWidget(back);
      }
    }
    // Ask the widgets on the list if the current mouse value is
    // inside them. If it is, the widget has been pressed.
    // Take the appropriate response to this event.
    TextWidget event = currentScreen.textPressed();
    if (event != null) {
      println("clicked on a text entry widget!");
      focus= event;
      focus.label="";
    } else {
      focus=null;
    }
  }

  void keyPressed() {
    if (focus != null) {
      focus.append(key);
    }
  }

  void scroll(int speed) {
    currentScreen.scroll(speed);
  }
}