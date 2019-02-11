class ReviewScreen extends Screen { //<>// //<>//
  Review review;
  String reviewText;
  double longitude;
  double latitude;
  Map map;
  ArrayList<Double> longitudeMarkers;
  ArrayList<Double> latitudeMarkers;

  //The fastest reviewScreen constructor. Use this when clicking on a review scrollbox.
  ReviewScreen(Review review, User user, Business business) {
    if (review == null) {
      println("Review does not exist.");
    } else {
      this.review = review;
      this.user = user;
      this.business = business;
      this.longitude=business.getLongitude();
      this.latitude=business.getLatitude();
      longitudeMarkers =new ArrayList<Double>();
      latitudeMarkers=new ArrayList<Double>();
      longitudeMarkers.add(longitude);
      latitudeMarkers.add(latitude);
      initialiseObjects();
    }
  }

  //Create a ReviewScreen from a user screen. Slightly more efficient than just passing a review.
  ReviewScreen(Review review, User user) {
    if (review == null) {
      println("Review does not exist.");
    } else {
      Query query = new Query();
      this.review = review;
      this.business = query.getBusinessByBusinessID(review.getBusinessID());
      this.user = user;
      longitudeMarkers =new ArrayList<Double>();
      latitudeMarkers=new ArrayList<Double>();
      this.longitude=business.getLongitude();
      this.latitude=business.getLatitude();
      longitudeMarkers.add(longitude);
      latitudeMarkers.add(latitude);
      initialiseObjects();
    }
  }


  //Create a ReviewScreen from a business screen. Slightly more efficient than just passing a review.
  ReviewScreen(Review review, Business business) {
    if (review == null) {
      println("Review does not exist.");
    } else {
      Query query = new Query();
      this.review = review;
      this.business = business;
      this.user = query.getUserByUserID(review.getUserID());
      this.longitude=business.getLongitude();
      this.latitude=business.getLatitude();
      longitudeMarkers =new ArrayList<Double>();
      latitudeMarkers=new ArrayList<Double>();
      longitudeMarkers.add(longitude);
      latitudeMarkers.add(latitude);
      initialiseObjects();
    }
  }

  //Creating a review from a review screen, business and user are pulled from database.
  ReviewScreen(Review review) {
    if (review == null) {
      println("Review does not exist.");
    } else {
      Query query = new Query();
      this.review = review;
      this.business = query.getBusinessByBusinessID(review.getBusinessID());
      this.user = query.getUserByUserID(review.getUserID());
      longitudeMarkers =new ArrayList<Double>();
      latitudeMarkers=new ArrayList<Double>();
      longitudeMarkers.add(business.getLongitude());
      latitudeMarkers.add(business.getLatitude());
      initialiseObjects();
    }
  }

  //Set up widgets on the screen.
  void initialiseObjects() {
    if (business != null) {
      this.addWidget(new TextBar(50, 30, "Business Name : " + business.getName(), NEW_DEF_FONT, EVENT_BUSINESS_WIDGET, true));//Revert to business pressed
      map=new Map(businessMap, USA_MAP_CENTRE_X, USA_MAP_CENTRE_Y, 4);//add a map
      map.createMarkers(latitudeMarkers, longitudeMarkers);//add map markers
    } else {
      this.addWidget(new TextBar(50, 30, "Business No Longer Exists", NEW_DEF_FONT, EVENT_BUSINESS_WIDGET, true));//If business has been deleted
    }
    if (user != null) {
      this.addWidget(new TextBar(120, 100, "User Name : " + user.getName(), NEW_DEF_FONT, EVENT_USER_WIDGET, true));//widget to go back to user
    } else {
      this.addWidget(new TextBar(120, 100, "Account Deleted", NEW_DEF_FONT, EVENT_USER_WIDGET, true));//user account deleted
    }
    reviewText = review.getText();
    addWidget(new TextBar(120, 160, "U: " + review.getUseful() + "  F: " + review.getFunny() + "  C: " + review.getCool(), DEF_FONT, EVENT_NULL, false));// show number of useful, funny and cool votes
    addWidget(new TextBar(1100, 800, "Number of Stars :", NEW_DEF_FONT, EVENT_NULL, true));//show number of stars
    switch (review.getStars()) {//show number of stars
    case 5: 
      addWidget( new Widget(1380+240, 800, star, EVENT_NULL));
    case 4: 
      addWidget( new Widget(1380+180, 800, star, EVENT_NULL));
    case 3: 
      addWidget( new Widget(1380+120, 800, star, EVENT_NULL));
    case 2: 
      addWidget( new Widget(1380+60, 800, star, EVENT_NULL));
    case 1: 
      addWidget( new Widget(1380, 800, star, EVENT_NULL));
    }
    addWidget(new TextBar(1100, 900, "Date : " + review.getDate(), NEW_DEF_FONT, EVENT_NULL, true));//show date of review
  }


  //Draw the screen.
  void draw() {
    if (review != null) {
      super.draw(); //Draw stuff using the super class.
      drawWidgets(); //Draw widgets.
      textFont(DEF_FONT);//Set font.
      stroke(0);//Set Stroke.
      fill(255);//Make fill white.
      rect(80, 200, 940, 800); // draw textBox

      rect(1049, 99, 601, 601);//draw the map outline
      fill(50);

      if (drawMap) map.draw();//draw the map

      fill(0);
      textFont(DEF_FONT);//Set font.
      text(reviewText, 100, 220, 900, 780);//draw the review text
    }
  }

  //This function is taken from the screen class but it would not work when using "super().drawWidgets" or 
  //"super().draw()", it was quicker to copy the code than debug. Not a great solution but it works.
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
  }
}