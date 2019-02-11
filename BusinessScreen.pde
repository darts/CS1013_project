class BusinessScreen extends Screen {
  String BusinessID;
  String name;
  String address;
  String city;
  String state;
  double stars;
  int reviewCount;
  ArrayList <Review>businessReviews;
  Review nextReview;
  Review mostUsefulReview;

  ScrollWindow resultWindow;
  Business business;
  Widget ReviewCountWidg;
  Widget GoogleSearchWidg;
  ScrollWindow ThreeReviewsWindow;
  ScrollBox ThreeReviewsWidget;

  double longitude;
  double latitude;
  Map map;
  ArrayList<Double> longitudeMarkers;
  ArrayList<Double> latitudeMarkers;

  String a="Most Useful Review";
  String b="Highest Rated Review";
  String c="Lowest Rated Review";

  public BusinessScreen(Business business, ArrayList<Review> businessReviews) {
    super();
    userS=false;
    businessS=true;
    longitudeMarkers =new ArrayList<Double>();//For map marker
    latitudeMarkers=new ArrayList<Double>();//For map marker
    BusinessID = business.getBusinessID();
    this.name = business.getName();
    this.name=  this.name.replaceAll("\"", "");
    this.address =business.getAddress();
    this.city = business.getCity();
    this.state = business.getState();
    this.stars =business.getStars();
    this.reviewCount = business.getReviewCount();
    this.businessReviews=businessReviews;
    this.business=business;
    ReviewCountWidg= new Widget (50, 170, 300, 50, "Review Count: "+ businessReviews.size(), 235, NEW_DEF_FONT, EVENT_SHOW_ALL_REVIEWS); //Show number of reviews
    GoogleSearchWidg=new Widget (1200, 800, 300, 50, "Google it", 235, NEW_DEF_FONT, GOOGLE_SEARCH); //Show google search widget
    this.addWidget(ReviewCountWidg);
    this.addWidget(GoogleSearchWidg);
    setupReviews();
    this.longitude=business.getLongitude();
    this.latitude=business.getLatitude();
    longitudeMarkers.add(longitude);
    latitudeMarkers.add(latitude);
    map=new Map(businessMap, USA_MAP_CENTRE_X, USA_MAP_CENTRE_Y, 4);//Create the map
    map.createMarkers(latitudeMarkers, longitudeMarkers);//Place markers on the map
  }
  
  Business getBusiness() {
    return business;
  }

  void draw() {
    super.draw();//Call the super class draw function
    stroke(0);//Set Stroke.
    fill(255);
    if (drawMap) {
      rect(1049, 99, 601, 601);//Draw a map outline
      map.draw();//Draw the map
    }

    stroke(67);

    textSize(70);
    fill(0);

    text(this.name, 50, 100); 
    textSize(40);
    text("Address :  " +this.address, 50, 300);
    text("City: "+this.city, 50, 340);
    text("Average Stars: "+this.stars, 50, 150);
  }

  void setupReviews() {//Creates the most useful, highest and lowest rated reviews.
    Review mostUsefulReview= this.businessReviews.get(0);
    for (int i=1; i<businessReviews.size(); i++) {//gets and sets the most useful review
      nextReview=this.businessReviews.get(i);
      if (nextReview.getUseful()>mostUsefulReview.getUseful()) {
        mostUsefulReview=nextReview;
      }
    }
    Review highestReview= this.businessReviews.get(0);
    for (int i=1; i<businessReviews.size(); i++) {//gets and sets the highest rated review
      nextReview=this.businessReviews.get(i);
      if (nextReview.getStars()>highestReview.getStars()) {
        highestReview=nextReview;
      }
    }
    Review lowestReview= this.businessReviews.get(0);
    for (int i=1; i<businessReviews.size(); i++) {//gets and sets the lowest rated review
      nextReview=this.businessReviews.get(i);
      if (nextReview.getStars()<lowestReview.getStars()) {
        lowestReview=nextReview;
      }
    }


    ArrayList <Review>ThreeReviews=new ArrayList<Review>();
    ArrayList <String>labels=new ArrayList<String>();
    labels.add(a);//name the reviews
    labels.add(b);//^^
    labels.add(c);//^^
    ThreeReviews.add(mostUsefulReview);
    ThreeReviews.add(highestReview);
    ThreeReviews.add(lowestReview);

    ThreeReviewsWindow=new ScrollWindow(100, 400, 600, 300);//Create a new scrollwindow
    ThreeReviewsWindow.populate(ThreeReviews, labels, color(245), NEW_DEF_FONT, 20);//populate the scrollwindow
    this.addScrollWindow( ThreeReviewsWindow);// add the scrollwindow to the screen
  }

  void displayReviews() {//Show the list of revies
    resultWindow = new ScrollWindow(SCREENX-800, 0, 780, 600);
    ArrayList<Review> reviewList = this.businessReviews;//Get a list of results. // review count button?
    //resultCount.changeText("Number of Results: " + reviewList.size());//Show number of results.
    resultWindow.populate(reviewList, null, color(245), NEW_DEF_FONT, 1);//Load scrollwindow with result objects.
    this.addScrollWindow(resultWindow);//Add the scrollwindow to the screen
  }
}