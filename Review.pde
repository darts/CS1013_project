class Review {
  String userID;
  String reviewID;
  String businessID; 
  int stars;
  String Date;
  String text;
  int useful;
  int funny;
  int cool;

  public Review(String reviewID, String userID, String businessID, int stars, 
    String date, String text, int useful, int funny, int cool) {
    this.userID = userID;
    this.reviewID = reviewID;
    this.businessID = businessID;
    this.stars = stars;
    this.Date = date;
    this.text = text;
    this.useful = useful;
    this.funny = funny;
    this.cool = cool;
  }
  public void printReview(){
    println(toString());
  }
  public String toString(){
    String reviewAsString = "";
    reviewAsString += ("\nUser ID: " + this.userID);
    reviewAsString += ("\nReview ID: " + this.reviewID);
    reviewAsString += ("\nBusiness ID: " + this.businessID);
    reviewAsString += ("\nStars: " + this.stars);
    reviewAsString += ("\nDate: " + this.Date);
    reviewAsString += ("\nReview:\n" + this.text);
    reviewAsString += ("\nUseful: " + this.useful);
    reviewAsString += ("\nFunny: " + this.funny);
    reviewAsString += ("\nCool: " + this.cool + "\n");
    return reviewAsString;
  }
  public int characterCount(){
    return this.text.length();
  }
  public String getUserNameByID() {
    Query nameQuery = new Query();
    return nameQuery.getUserNameByID(this.userID);
  }
  public String getUserID() {
    return userID;
  }
  public void setUserID(String userID) {
    this.userID = userID;
  }
  public String getReviewID() {
    return reviewID;
  }
  public void setReviewID(String reviewID) {
    this.reviewID = reviewID;
  }
  public String getBusinessID() {
    return businessID;
  }
  public void setBusinessID(String businessID) {
    this.businessID = businessID;
  }
  public int getStars() {
    return stars;
  }
  public void setStars(int stars) {
    this.stars = stars;
  }
  public String getDate() {
    return Date;
  }
  public void setDate(String date) {
    Date = date;
  }
  public String getText() {
    return text;
  }
  public void setText(String text) {
    this.text = text;
  }
  public int getUseful() {
    return useful;
  }
  public void setUseful(int useful) {
    this.useful = useful;
  }
  public int getFunny() {
    return funny;
  }
  public void setFunny(int funny) {
    this.funny = funny;
  }
  public int getCool() {
    return cool;
  }
  public void setCool(int cool) {
    this.cool = cool;
  }
}
