boolean userS=false;  //<>//
boolean businessS=false;
class ScreenOrganiser {
  PFont stdFont;
  Widget searchButton, back, home;
  TextWidget focus;
  Screen homeScreen;
  Screen currentScreen;
  Query qCall;
  RadioButton sortQ;
  ScrollWindow resultWindow;
  Boolean searchBusiness, sortByRevCount;
  TextBar resultCount;
  ArrayList<Screen> screenStack;
  GoogleSearchWidget gsw;



  ScreenOrganiser() {
    stdFont = NEW_DEF_FONT;//Load standard font.
    qCall = new Query();//Create new query object.
    resetHomeScreen();
    back= new Widget(SCREENX-1050, 120, 100, 60, "Back", color(21, 160, 221), stdFont, EVENT_BUTTON_BACK);//Create back button.
    home= new Widget(SCREENX-1150, 120, 100, 60, "Home", color(255, 255, 0), stdFont, EVENT_HOME);//Create back button.
  }

  void initResultWindow() {//Set up the scrollwindow of search results
    resultWindow = new ScrollWindow(SCREENX-800, 0, 780, 1080);//create a new window
    resultWindow.clear();//clear it
    homeScreen.addScrollWindow(resultWindow);//add the new window
  }
  

  void resetHomeScreen() {
    screenStack = new ArrayList<Screen>();//List of previous screens.
    searchBusiness = true; //Should program search by business.
    homeScreen = new Screen();//Initialise home screen.
    currentScreen = homeScreen;//Set current screen.
    homeScreen.addTextWidget(new TextWidget(100, 200, 400, 60, " Search By Name ", color(255), stdFont, TEXT_WIDGET, 25));//Add searchBar to homescreen.
    //Add the result scrollwindow to the homescreen.
    initResultWindow();


    //Add search button to home screen.
    searchButton= new Widget(525, 200, 140, 60, "Search", color(21, 160, 221), stdFont, EVENT_BUTTON_SEARCH);
    homeScreen.addWidget(searchButton);
    
    homeScreen.addRadioButton(new RadioButton(140, 100, 320, 60, "Business", "User", EVENT_SEARCH_BUSINESS, EVENT_SEARCH_USER));//Add search-type selector radio button.

    //Add result sorting option.
    homeScreen.addRadioButton(new RadioButton(130, 320, 360, 60, "Av. Stars", "Rev. Count", EVENT_AVE_STARS, EVENT_REV_COUNT));
    sortByRevCount = false;

    //Create textbar to show number of results.
    resultCount = new TextBar(100, 290, null, DEF_FONT, EVENT_NULL, false);
    homeScreen.addWidget(resultCount);

    //Set up default graph showing pre-fetched and compiled data, this one is the bar chart of review count per star.
    String[] graphData = loadStrings("startGraphData.txt");
    String[] parsedData = graphData[1].split(",");
    float[] revPStar = new float[]{Float.parseFloat(parsedData[0]), Float.parseFloat(parsedData[1]), Float.parseFloat(parsedData[2]), Float.parseFloat(parsedData[3]), Float.parseFloat(parsedData[4])};
    String[] stC = new String[]{"1", "2", "3", "4", "5"};
    homeScreen.addChart(new BarChart("Reviews Per Star", SCREENX-650, 510, 550, 440, max(revPStar), revPStar, stC, "Stars", "Review Count", BARCHART_FONT, BARCHART_FONT, color(255), color(210, 194, 177), true));

    //Set up default graph showing more pre-fetched data, this one is the scatter graph of review count vs number of friends.
    String[] friends = graphData[5].split(",");
    String[] reviews = graphData[7].split(",");
    float[] friendCount = new float[friends.length];
    float[] reviewCount = new float[reviews.length];
    for (int i = 0; i < friendCount.length; i++) {
      friendCount[i] = Float.parseFloat(friends[i]);
      reviewCount[i] = Float.parseFloat(reviews[i]);
    }
    homeScreen.addChart(new ScatterGraph("Friends vs Review Count", SCREENX-650, 1000, 500, 400, (int)(max(friendCount)), (int)(max(reviewCount)), friendCount, reviewCount, new String[]{"1", "2", "3", "4"}, "Reviews", "Friends", DEF_FONT, DEF_FONT, color(255), color(0), false)); 

    //Set up default graph showing more pre-fetched data, this one is the pie chart of the amount of useful, funny and cool ratings.
    String[] UFCData = graphData[3].split(",");
    float[] gData = new float[]{Float.parseFloat(UFCData[0]), Float.parseFloat(UFCData[1]), Float.parseFloat(UFCData[2])};
    homeScreen.addChart(new PieChart("Useful vs Funny vs Cool", 100, 1000, 550, gData, new String[]{"Useful", "Funny", "Cool"}, color(255), DEF_FONT, DEF_FONT));

    focus=null;//What textwidget is currently selected, in this case null.
  }

  void draw() {
    textAlign(LEFT, BASELINE);//Reset text position.
    textFont(DEF_FONT);//Reset font.
    currentScreen.draw();//Draw the current screen.
  }
  void search() {
    println("SEARCHING...");
    if (focus != null && !focus.getLabel().equals("")) {//has the user selected the search bar.
      if (searchBusiness) {//If user is looking for a business.
        ArrayList<Business> rList = qCall.getBusinessByName(focus.getLabel());//Get a list of results.
        resultCount.changeText("Number of Results: " + rList.size());//Show number of results.
        if (rList.size() >= 1)
          resultWindow.populate(rList, color(245), NEW_DEF_FONT, null);//Load scrollwindow with result objects.
        else if (rList.size() == 0) {
          homeScreen.removeScrollWindow(resultWindow);//Remove old results
          initResultWindow();//Create new window
        }
        if (sortByRevCount)//Sorting results.
          resultWindow.sortByRevCount();//sort by review count
        else {
          resultWindow.sortByRevCount();//sort by review count
          resultWindow.sortByAveStars();//sort by average stars
        }
      } else {
        ArrayList<User> rList = qCall.getUserByName(focus.getLabel());//Get a list of results.
        resultCount.changeText("Number of Results: " + rList.size());//Show number of results.
        if (rList.size() >= 1)
          resultWindow.populate(rList, color(245), NEW_DEF_FONT);//Load scrollwindow with result objects.
        else if (rList.size() == 0) {
          homeScreen.removeScrollWindow(resultWindow);//remove old results
          initResultWindow();//create new window
        }
        if (sortByRevCount)//Sorting results.
          resultWindow.sortByRevCount();//sort by review count
        else {
          resultWindow.sortByRevCount();//sort by review count
          resultWindow.sortByAveStars();//sort by average stars
        }
      }
    }
  }

  void mousePressed() {
    switch(currentScreen.mousePressed()) {//Check what event the current screen returns.
    case EVENT_BUTTON_SEARCH://has the search button been pressed.
      search();
      break;
    case EVENT_SHOW_ALL_REVIEWS://Show all reveiws in business and user screen
      currentScreen.drawMap = false;//hide the map
      currentScreen.displayReviews();//show the reviews
      break; 
    case EVENT_HOME://Home button pressed.
      resetHomeScreen();//Reset the home screen.
      break;
    case EVENT_SEARCH_USER://Radio button for searching by user clicked.
      println("Searching by User");
      searchBusiness = false;//No longer searching by business.
      break;
    case EVENT_SEARCH_BUSINESS://Radio button for searching by business clicked.
      println("Searching by Business");
      searchBusiness = true;//Searching by business.
      break;
    case EVENT_AVE_STARS://Radio button for sorting by average stars clicked.
      //if (resultWindow.isPopulated())
      if (sortByRevCount)
        resultWindow.sortByAveStars();//Sort the current list by average stars.
      sortByRevCount = false;//Sort future lists by average stars.
      break;
    case EVENT_REV_COUNT://Radio button for sorting by review count clicked.
      //if (resultWindow.isPopulated())
      if (!sortByRevCount)
        resultWindow.sortByRevCount();//Sort the current list by review count.
      sortByRevCount = true;//Sort future lists by review count
      break;
    case EVENT_BUTTON_BACK://Back button presses
      println("BACK ");
      currentScreen = screenStack.get(screenStack.size() - 1);//set current screen to previous screen
      screenStack.remove(screenStack.size() - 1);//Remove old screen from stack.
      break;
    case GOOGLE_SEARCH:
      Business b =currentScreen.getBusiness();//get the business
      gsw = new GoogleSearchWidget(b.getName());//create a search with the business name
      gsw.searchGoogle();//search google
    case EVENT_BUSINESS_WIDGET://business widget clicked
      if (currentScreen instanceof ReviewScreen) {
        Business clickedBusiness = currentScreen.getBusiness();
        if (clickedBusiness != null) {
          screenStack.add(currentScreen);//push the current screen to the stack
          ArrayList<Review> businessReviews= qCall.getReviewsByBusinessID(clickedBusiness.getBusinessID(), clickedBusiness.getReviewCount());//Get the selected user's reviews.

          currentScreen= new BusinessScreen(currentScreen.getBusiness(), businessReviews);//change the screen
          currentScreen.addWidget(back);//add back button
          currentScreen.addWidget(home);//Add home widget
        } else {
          println("User Account Deleted");
        }
      }
      break;
    case EVENT_USER_WIDGET:
      if (currentScreen instanceof ReviewScreen) {
        User clickedUser = currentScreen.getUser();
        if (clickedUser != null) {
          screenStack.add(currentScreen);
          ArrayList<Review> userReviews= qCall.getReviewsByUserID(clickedUser.getUserID(), clickedUser.getReviewCount());//Get the selected user's reviews.
          currentScreen= new UserScreen(clickedUser, userReviews);
          currentScreen.addWidget(back);
          currentScreen.addWidget(home);//Add home widget
        } else {
          println("User Account Deleted");
        }
      }
      break;
    default:
      ScrollBox clickedBox = currentScreen.scrollPressed();//Get which box has been pressed.
      if (clickedBox != null) {//If a box has been clicked.
        if (clickedBox.isBusiness()) {//If box is business type.
          screenStack.add(currentScreen);//Add the current screen to the stack.
          ArrayList<Review> businessReviews= qCall.getReviewsByBusinessID(clickedBox.getBusiness().getBusinessID(), clickedBox.getBusiness().getReviewCount());
          currentScreen = new BusinessScreen(clickedBox.getBusiness(), businessReviews);//Open a new screen of type business.
          currentScreen.addWidget(back);//Add back widget
          currentScreen.addWidget(home);//Add home widget
        } else if (clickedBox.isUser()) {//If box is user type.
          screenStack.add(currentScreen);//Add the current screen to the stack.
          ArrayList<Review> userReviews= qCall.getReviewsByUserID(clickedBox.getUser().getUserID(), clickedBox.getUser().getReviewCount());//Get the selected user's reviews.
          currentScreen = new UserScreen(clickedBox.getUser(), userReviews);
          currentScreen.addWidget(back);//Add back widget
          currentScreen.addWidget(home);//Add home widget
        } else if (clickedBox.isReview()) {//If box is review type.
          screenStack.add(currentScreen);//Add the current screen to the stack.
          currentScreen = new ReviewScreen(clickedBox.getReview());//Open a new screen of type review.
          currentScreen.addWidget(back);//Add back widget
          currentScreen.addWidget(home);//Add home widget
        }
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
    }
  }

  void keyPressed() {
    if (focus != null) {
      if (key == ENTER)
        search();
      focus.append(key);//Add character to search bar.
    }
  }

  void scroll(int speed) {
    currentScreen.scroll(speed);//Scroll the results.
  }
}