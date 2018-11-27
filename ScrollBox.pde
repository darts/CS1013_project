class ScrollBox extends Widget {
  String userName;
  String businessName;
  int revCount;
  double avStars;
  int stars;
  boolean isBusiness, isReview, isUser;
  Business business;
  User user;
  Review review;

  ScrollBox(User user, int xPos, int yPos, int height, int width, color widgetColor, PFont widgetFont, int event) {
    super(xPos, yPos, height, width, widgetColor, widgetFont, event);
    this.user = user;
    userName = user.getName();
    businessName = null;
    revCount = user.getReviewCount();
    avStars = user.getAverageStars();
    stars = -1;
    isBusiness = false;
    isReview = false;
    isUser = true;
  }

  ScrollBox(Business business, int xPos, int yPos, int height, int width, color widgetColor, PFont widgetFont, int event) {
    super(xPos, yPos, height, width, widgetColor, widgetFont, event);
    this.business = business;
    userName = null;
    businessName = business.getName();
    revCount = business.getReviewCount();
    avStars = business.getStars();
    stars = -1;
    isBusiness = true;
    isReview = false;
    isUser = false;
  }

  ScrollBox(Review review, int xPos, int yPos, int height, int width, color widgetColor, PFont widgetFont, int event) {
    super(xPos, yPos, height, width, widgetColor, widgetFont, event);
    this.review = review;
    userName = null;
    businessName = review.getBusinessID();
    revCount = -1;
    avStars = -1;
    stars = review.getStars();
    isBusiness = false;
    isReview = true;
    isUser = false;
  }

  void draw() {
    fill(widgetColor);
    rect(x, y, width, height);
    stroke(0);
    fill(0);
    if (isBusiness) {
      drawTopName(businessName, true);
      drawRevCount();
      drawAvStars();
    } else if (isUser) {
      drawTopName(userName, false);
      drawRevCount();
      drawAvStars();
    } else {
      drawTopName(userName, false);
      drawStars();
      drawBottomName(businessName);
    }
  }

  void drawTopName(String name, boolean isBusiness) {
    textAlign(LEFT, TOP);
    text(((isBusiness)?"Business " : "User ") + "name : " + name, x + (width / 50), y + (height / 50));
  }

  void drawBottomName(String name) {
    textAlign(LEFT, BOTTOM);
    text("Business Name : " + name, x + (width / 40), y - (height / 40));
  }

  void drawRevCount() {
    textAlign(LEFT, BOTTOM);
    text("Number Of Reviews : " + Integer.toString(revCount), x + (width / 40), y + (49 * (height / 50)));
  }

  void drawAvStars() {
    textAlign(RIGHT, BOTTOM);
    text("Average Stars : " + Double.toString(avStars), x + (width), y + (49 * (height / 50)));
  }

  void drawStars() {
    textAlign(RIGHT, BOTTOM);
    text("Stars : " + Double.toString(stars), x + (width), y + (49 * (height / 50)));
  }

  void drawText(int numOfCharacters) {
    textAlign(LEFT, BOTTOM);
    text(review.getText().substring(0, numOfCharacters), x + (width / 50), y + (49 * (height / 50)));
  }

  void move(int moveSpeed) {
    y += moveSpeed * 15;
  }

  boolean clicked() {
    if (this.getEvent(mouseX, mouseY) != EVENT_NULL)
      return true;
    return false;
  }
  
  boolean isBusiness(){
    return isBusiness;
  }
  
  boolean isUser(){
    return isUser;
  }
  
  boolean isReview(){
    return isReview;
  }
  
  User getUser(){
    return user;
  }
  
  Business getBusiness(){
   return business;
  }
  
  Review getReview(){
    return review;
  }
}