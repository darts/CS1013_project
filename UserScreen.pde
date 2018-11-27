class UserScreen extends Screen{
  String userID;
   String name;
  int reviewCount;
   Date yelpingSince;
   String[] friends;
   double averageStars;
  PImage profilePic;
  

    UserScreen(User user) {
      
    super();
    this.profilePic = loadImage("georgeEats.jpg");
    this.userID = user.getUserID() ;
    this.name = user.getName();
    this.reviewCount =  user.getReviewCount();
    this.yelpingSince = user.getYelpingSince();
    this.friends = user.getFriends();
    this.averageStars = user.getAverageStars();
  }
  
  void draw(){
    
    super.draw();
    textSize(20);
    
    image(this.profilePic, 10, 10);
    fill(0);
    text(this.name, 50, 220); 
    text("Review Count:  " +this.reviewCount, 50, 240);
    text("Yelping since: "+this.yelpingSince, 50,260);
    text("Average Stars: "+ this.averageStars, 50, 280);

  }
  
}