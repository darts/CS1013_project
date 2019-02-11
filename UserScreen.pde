class UserScreen extends Screen { //<>//
  String userID;
  String name;
  int reviewCount;
  String yelpingSince;
  String[] friends;
  double averageStars;
  PImage profilePic;
  ArrayList <Review>userReviews;
  Review nextReview;
  ScrollWindow resultWindow;
  User user;
  Query findBusiness =new Query();
  Widget ReviewCountWidg;
  ScrollWindow coolFunWindow;
  // ScrollBox coolestRevWidget;
  float[] points;
  String a="Coolest Review";
  String b="Funniest Review";
  String c="Most Useful Review";

  double longitude;
  double latitude;
  Map map;
  ArrayList<Double> longitudeMarkers;
  ArrayList<Double> latitudeMarkers;


  UserScreen(User user, ArrayList<Review> userReviews  ) {
    super();
    userS=true;
    businessS=false;
    this.profilePic = loadImage("georgeEats.jpg");
    this.userID = user.getUserID() ;
    this.name = user.getName();
    this.reviewCount =  user.getReviewCount();
    this.yelpingSince = user.getYelpingSince();
    this.friends = user.getFriends();
    this.averageStars = user.getAverageStars();
    this.userReviews=userReviews;
    this.user=user;
    ReviewCountWidg= new Widget (50, 200, 300, 50, "Review count: " + userReviews.size(), 235, NEW_DEF_FONT, EVENT_SHOW_ALL_REVIEWS); //Create show all reviews widget
    this.addWidget(ReviewCountWidg);
    longitudeMarkers =new ArrayList<Double>();
    latitudeMarkers=new ArrayList<Double>();
    longitudeMarkers=getLongitudeMarkers(userReviews);
    latitudeMarkers=getLatitudeMarkers(userReviews);
    map=new Map(userMap, USA_MAP_CENTRE_X, USA_MAP_CENTRE_Y, 4);//set up map

    map.createMarkers(latitudeMarkers, longitudeMarkers);//add map markers

    //Create barchart of number of each star review
    points = new float[]{0, 0, 0, 0, 0};
    for (int i=0; i<userReviews.size(); i++) {
      Review nextReview=this.userReviews.get(i);
      int stars= nextReview.getStars();
      points[stars-1]++;
    }
    String[] xLabels = new String[]{"1", "2", "3", "4", "5"};
    this.addChart(new BarChart("Reviews Per Star", SCREENX-650, 510, 550, 440, max(points), points, xLabels, "Stars", "Review Count", BARCHART_FONT, BARCHART_FONT, color(255), color(  255, 228, 225), true));
    setupReviews();
  }

  void draw() {
    super.draw();  
    stroke(0);//Set Stroke.
    fill(255);
    if (drawMap){//Draw the map
      rect(BUSINESS_MAP_X-1, BUSINESS_MAP_Y+499, 601, 401);
      map.draw();
    }
    textSize(70);
    textAlign(LEFT, BASELINE);
    image(this.profilePic, 400, 10);
    fill(0);

    text(this.name, 50, 60); 
    textSize(40);
    text("Yelping since: "+this.yelpingSince, 50, 100);
    text("Average Stars: "+ this.averageStars, 50, 150);
  }
  
  //Setup top reviews
  void setupReviews() {
    Review coolestReview= this.userReviews.get(0);//get coolest review
    for (int i=1; i<userReviews.size(); i++) {
      nextReview=this.userReviews.get(i);
      if (nextReview.getCool()>coolestReview.getCool()) {
        coolestReview=nextReview;
      }
    }
    Review funniestReview= this.userReviews.get(0);//get funniest review
    for (int i=1; i<userReviews.size(); i++) {
      nextReview=this.userReviews.get(i);
      if (nextReview.getFunny()>coolestReview.getFunny()) {
        funniestReview=nextReview;
      }
    }

    Review mostUsefulReview= this.userReviews.get(0);//get most useful review
    for (int i=1; i<userReviews.size(); i++) {
      nextReview=this.userReviews.get(i);
      if (nextReview.getUseful()>coolestReview.getUseful()) {
        mostUsefulReview=nextReview;
      }
    }

    //Initialise the scrollwindow of top reviews
    ArrayList <Review>coolFunReviews=new ArrayList<Review>();
    ArrayList <String>labels=new ArrayList<String>();
    labels.add(a);
    labels.add(b);
    labels.add(c);
    coolFunReviews.add(coolestReview);
    coolFunReviews.add(funniestReview);
    coolFunReviews.add(mostUsefulReview);
    coolFunWindow=new ScrollWindow(100, 400, 600, 300);
    coolFunWindow.populate(coolFunReviews, labels, color(245), NEW_DEF_FONT, 20);
    this.addScrollWindow( coolFunWindow);
  }

  void displayReviews() {//Display top reviews
    resultWindow = new ScrollWindow(SCREENX-800, 0, 780, 600);
    ArrayList<Review> reviewList = this.userReviews;//Get a list of results.

    //resultCount.changeText("Number of Results: " + reviewList.size());//Show number of results.
    resultWindow.populate(reviewList, null, color(245), NEW_DEF_FONT, 1);//Load scrollwindow with result objects.
    this.addScrollWindow(resultWindow);
  }
  
  //Get markers for map
  ArrayList<Double> getLongitudeMarkers(ArrayList <Review> userReviews) {
    ArrayList<Double> longitudes = new ArrayList<Double>();
    for (int count=0; count<userReviews.size(); count++) {
      longitudes.add(findBusiness.getBusinessByBusinessID(userReviews.get(count).getBusinessID()).getLongitude());
    }
    return longitudes;
  }
  
  //Get markers for map
  ArrayList<Double> getLatitudeMarkers(ArrayList <Review> userReviews) {
    ArrayList<Double> latitudes = new ArrayList<Double>();
    for (int count=0; count<userReviews.size(); count++) {
      latitudes.add(findBusiness.getBusinessByBusinessID(userReviews.get(count).getBusinessID()).getLatitude());
    }
    return latitudes;
  }
}