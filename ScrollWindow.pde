class ScrollWindow {
  int xPos, yPos, width, height;
  ArrayList<ScrollBox> contentArray;

  ScrollWindow(int xPos, int yPos, int width, int height) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.width = width;
    this.height = height;
    contentArray = new ArrayList<ScrollBox>();
  }

  void scroll(int speed) {
    if ((contentArray.get(0).getY() < yPos && speed > 0) || (contentArray.get(contentArray.size() - 1).getY() > yPos + height + 200 && speed < 0)) {
      for (ScrollBox box : contentArray)
        box.move(speed);
    }
  }

  void populate(ArrayList<User> userArray, color widgetColor, PFont font) {
    contentArray = new ArrayList<ScrollBox>();
    println(userArray.size());
    for (int i = 0; i < userArray.size(); i++) {
      contentArray.add(new ScrollBox(userArray.get(i), xPos, yPos + (201 * i), width, 200, widgetColor, NEW_DEF_FONT, EVENT_USER_WIDGET));
    }
  }

  void populate(ArrayList<Business> businessArray, color widgetColor, PFont font, String useLess) {
    contentArray = new ArrayList<ScrollBox>();
    println(businessArray.size());
    for (int i = 0; i < businessArray.size(); i++) {
      contentArray.add(new ScrollBox(businessArray.get(i), xPos, yPos + (201 * i), width, 200, widgetColor, NEW_DEF_FONT, EVENT_BUSINESS_WIDGET));
    }
  }

  void populate(ArrayList<Review> reviewArray, color widgetColor, PFont font, int anything) {
    contentArray = new ArrayList<ScrollBox>();
    println(reviewArray.size());
    for (int i = 0; i < reviewArray.size(); i++) {
      contentArray.add(new ScrollBox(reviewArray.get(i), xPos, yPos + (201 * i), width, 200, widgetColor, NEW_DEF_FONT, EVENT_REVIEW_WIDGET));
    }
  }

  void draw() {
    for (ScrollBox box : contentArray)
      box.draw();
  }

  ScrollBox clicked() {
    for (ScrollBox box : contentArray)
      if (box.clicked())
        return box;
    return null;
  }
}