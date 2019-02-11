class ScrollWindow { //<>//
  int xPos, yPos, width, height;
  ArrayList<ScrollBox> contentArray;
  color widgetColor;
  ArrayList<Review> reviewArray;
  ArrayList<User> userArray;
  ArrayList<Business> businessArray;
  ArrayList<String> labels;

  ScrollWindow(int xPos, int yPos, int width, int height) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.width = width;
    this.height = height;
    contentArray = new ArrayList<ScrollBox>();
  }

  //Scroll all of the contained object
  void scroll(int speed) {
    speed = -speed;
    if ((contentArray.get(0).getY() < yPos && speed > 0) || (contentArray.get(contentArray.size() - 1).getY() > yPos + height + 200 && speed < 0)) {
      for (ScrollBox box : contentArray)
        box.move(speed);
    }
  }

  //Fill the window with users
  void populate(ArrayList<User> userArray, color widgetColor, PFont font) {
    this.userArray = userArray;
    this.widgetColor = widgetColor;
    contentArray = new ArrayList<ScrollBox>();
    for (int i = 0; i < userArray.size(); i++) {
      contentArray.add(new ScrollBox(userArray.get(i), xPos, yPos + (201 * i), width, 200, widgetColor, NEW_DEF_FONT, EVENT_USER_WIDGET));
    }
  }

  //Fill the window with businesses
  void populate(ArrayList<Business> businessArray, color widgetColor, PFont font, String useLess) {
    this.businessArray = businessArray;
    this.widgetColor = widgetColor;
    contentArray = new ArrayList<ScrollBox>();
    for (int i = 0; i < businessArray.size(); i++) {
      contentArray.add(new ScrollBox(businessArray.get(i), xPos, yPos + (201 * i), width, 200, widgetColor, NEW_DEF_FONT, EVENT_BUSINESS_WIDGET));
    }
  }

  //Fill the window with reveiws
  void populate(ArrayList<Review> reviewArray, ArrayList<String> labels, color widgetColor, PFont font, int anything) {
    this.labels = labels;
    this.reviewArray = reviewArray;
    this.widgetColor = widgetColor;
    contentArray = new ArrayList<ScrollBox>();
    if (labels==null) {
      for (int i = 0; i < reviewArray.size(); i++) {

        contentArray.add(new ScrollBox(reviewArray.get(i), null, xPos, yPos + (201 * i), width, 200, widgetColor, NEW_DEF_FONT, EVENT_REVIEW_WIDGET));
      }
    } else {
      for (int i = 0; i < reviewArray.size(); i++) {

        contentArray.add(new ScrollBox(reviewArray.get(i), labels.get(i), xPos, yPos + (201 * i), width, 200, widgetColor, NEW_DEF_FONT, EVENT_REVIEW_WIDGET));
      }
    }
  }

  //Clear current content
  void clear(){
   for(ScrollBox box : contentArray){
    contentArray.remove(box); 
   }
  }
  
  //Sort by review count
  void sortByRevCount() {
    if (businessArray != null && businessArray.size() > 1) {//For a business list
      for (int item = 0; item < businessArray.size() - 1; item++) {//A bubblesort implementation
        int numOfReviews = businessArray.get(item).getReviewCount();
        int highestIndex = item;
        for (int newLoc = item + 1; newLoc < businessArray.size() - 1; newLoc++) {
          int newNumOfReviews = businessArray.get(newLoc).getReviewCount();
          if (newNumOfReviews > numOfReviews) {
            highestIndex = newLoc;
            numOfReviews = newNumOfReviews;
          }
        }
        businessArray.set(highestIndex, businessArray.set(item, businessArray.get(highestIndex)));
      }
      populate(businessArray, widgetColor, null, null);
    } else if (userArray != null && userArray.size() > 1) {//for a user list
      for (int item = 0; item < userArray.size() - 1; item++) {//A bubblesort implementation
        int numOfReviews = userArray.get(item).getReviewCount();
        int highestIndex = item;
        for (int newLoc = item + 1; newLoc < userArray.size() - 1; newLoc++) {
          int newNumOfReviews = userArray.get(newLoc).getReviewCount();
          if (newNumOfReviews > numOfReviews) {
            highestIndex = newLoc;
            numOfReviews = newNumOfReviews;
          }
        }
        userArray.set(highestIndex, userArray.set(item, userArray.get(highestIndex)));
      }
      populate(userArray, widgetColor, null);
    }
  }

  void sortByAveStars() {//Sort list by average stars
    if (businessArray != null && businessArray.size() > 1) {//for a business list
      for (int item = 0; item < businessArray.size() - 1; item++) {//A bubblesort implementation
        double avStars = businessArray.get(item).getStars();
        int highestIndex = item;
        for (int newLoc = item + 1; newLoc < businessArray.size() - 1; newLoc++) {
          double newAvStars = businessArray.get(newLoc).getStars();
          if (newAvStars > avStars) {
            highestIndex = newLoc;
            avStars = newAvStars;
          }
        }
        businessArray.set(highestIndex, businessArray.set(item, businessArray.get(highestIndex)));
      }
      populate(businessArray, widgetColor, null, null);
    } else if (userArray != null && userArray.size() > 1) {//For a user list
      for (int item = 0; item < userArray.size() - 1; item++) {//A bubblesort implementation
        double avStars = userArray.get(item).getAverageStars();
        int highestIndex = item;
        for (int newLoc = item + 1; newLoc < userArray.size() - 1; newLoc++) {
          double newAvStars = userArray.get(newLoc).getAverageStars();
          if (newAvStars > avStars) {
            highestIndex = newLoc;
            avStars = newAvStars;
          }
        }
        userArray.set(highestIndex, userArray.set(item, userArray.get(highestIndex)));
      }
      populate(userArray, widgetColor, null);
    }
  }

  //draw the content
  void draw() {
    fill(255);
    textFont(NEW_DEF_FONT);
    if (contentArray.size() >= 1) {
      noStroke();
      rect(xPos, yPos, width, height);//Draw the background
      stroke(0);
      for (ScrollBox box : contentArray)//draw the content
        box.draw();
    }
  }

  //check which box has been clicked
  ScrollBox clicked() {
    for (ScrollBox box : contentArray)//return the clicked box
      if (box.clicked())
        return box;
    return null;
  }

  //Returns if the window has been populated.
  boolean isPopulated() {
    if (contentArray.size() > 1)
      return true;
    return false;
  }
}