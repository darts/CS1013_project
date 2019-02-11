class ScrollBox extends Widget { //<>//
  String userName;
  String businessName;
  int revCount;
  double avStars;
  int stars;
  boolean isBusiness, isReview, isUser;
  Business business;
  String shortReview;
  User user;
  Review review;
  String label;

  ScrollBox(User user, int xPos, int yPos, int height, int width, color widgetColor, PFont widgetFont, int event) {//To create a box of type user.
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

  ScrollBox(Business business, int xPos, int yPos, int height, int width, color widgetColor, PFont widgetFont, int event) {//To create a box of type business.
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

  ScrollBox(Review review, String label, int xPos, int yPos, int height, int width, color widgetColor, PFont widgetFont, int event) {//To create a box of type review.
    super(xPos, yPos, height, width, widgetColor, widgetFont, event);
    this.review = review;
    //Get business and user.
    Query infoGetter = new Query();
    business = infoGetter.getBusinessByBusinessID(review.getBusinessID());
    user = infoGetter.getUserByUserID(review.getUserID());
    userName = user.getName();
    businessName = business.getName();
    
    this.label=label;
    revCount = -1;
    avStars = -1;
    stars = review.getStars();
    isBusiness = false;
    isReview = true;
    isUser = false;
  }

  void draw() {//Draw the box
    fill(widgetColor);
    rect(x, y, width, height);//Draw the background
    stroke(0);
    fill(0);
    if (isBusiness) {
      drawTopName(businessName, true);
      drawRevCount();
      drawAvStars();
      drawCity();
    } else if (isUser) {
      drawTopName(userName, false);
      drawRevCount();
      drawAvStars();
    } else {

      if (label==null) {
        if (businessS==true) {
          drawReviewPreview(userName, review);
        }
        if (userS==true) {
          drawReviewPreview(businessName, review);
        }
      } else {
        if (businessS==true) {
          drawReviewPreview(label, review);
        }
        if (userS==true) {
          drawReviewPreview(label, review);
        }
      }

      drawStars();
    }
  }

  void drawCity(){//Draw the city name.
    textAlign(LEFT, TOP);
    text("Location: " + business.getCity() + "   " + business.getState()  , x + (width / 40), y + (20 * (height / 50)));
  }

  void drawReviewPreview(String name, Review review) {//Draw a short preview of the review.
    textAlign(LEFT, TOP);
    int xPos=x+(width / 50);
    int yPos=y+(height / 30);
    textFont(widgetFont);
    name = name.replaceAll("\"", "");
    text( name, xPos, yPos);
    yPos=y + (55 + (height / 30));

    // cuts text so that only what will fix inside a box is shown.
    String text = review.getText();
    String first = "";
    int index = 0;
    List<String> textList = Arrays.asList(text.split(" "));
    text = "";
    boolean finished = false;
    while (index<textList.size() && !finished) {
      text += textList.get(index) + " ";
      if (text.length()<55) first = text;
      else {
        finished = true;
        first = first.substring(0, first.length() - 1);
        first += "...";
      }
      index++;
    }

    textSize(30);
    text(first, xPos, yPos);
  }


  void drawTopName(String name, boolean isBusiness) {//Draw the top name
    textAlign(LEFT, TOP);

    text(((isBusiness)?"Business " : "User ") + "name : " + name, x + (width / 50), y + (height / 50));
  }

  void drawBottomName(String name) {//Draw the bottom name
    textAlign(LEFT, BOTTOM);
    text("Business Name : " + name, x + (width / 40), y - (height / 40));
  }

  void drawRevCount() {//Draw the number of reviews
    textAlign(LEFT, BOTTOM);
    text("Number Of Reviews : " + Integer.toString(revCount), x + (width / 40), y + (49 * (height / 50)));
  }

  void drawAvStars() {//Draw the average star rating
    textAlign(RIGHT, BOTTOM);
    text("Average Stars : " + Double.toString(avStars), x + (width), y + (49 * (height / 50)));
  }

  void drawStars() {//Draw the number of stars
    textAlign(RIGHT, BOTTOM);
    text("Stars : " + Double.toString(stars), x + (width), y + (49 * (height / 50)));
  }

  void drawText(int numOfCharacters) {//Draw the number of characters in a review
    textAlign(LEFT, BOTTOM);
    text(review.getText().substring(0, numOfCharacters), x + (width / 50), y + (49 * (height / 50)));
  }

  void move(int moveSpeed) {//Move the box when scrolling
    y += moveSpeed * 30;
  }

  boolean clicked() {//Determines if the box has been clicked.
    if (this.getEvent(mouseX, mouseY) != EVENT_NULL)
      return true;
    return false;
  }

  boolean isBusiness() {
    return isBusiness;
  }

  boolean isUser() {
    return isUser;
  }

  boolean isReview() {
    return isReview;
  }

  User getUser() {
    return user;
  }

  Business getBusiness() {
    return business;
  }

  Review getReview() {
    return review;
  }
}