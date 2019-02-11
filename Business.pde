public class Business {//This is a datatype class
  private String BusinessID;
  private String name;
  private String neighborhood;
  private String address;
  private String city;
  private String state;
  private int postCode;
  private double latitude;
  private double longitude;
  private double stars;
  private int reviewCount;
  private boolean isOpen;
  private String[] categories;
  public Business(String businessID, String name, String neighborhood, String address, String city, String state,
      int postCode, double latitude, double longitude, double stars, int reviewCount, boolean isOpen,
      String[] categories) {
    super();
    BusinessID = businessID;
    this.name = name;
    this.neighborhood = neighborhood;
    this.address = address;
    this.city = city;
    this.state = state;
    this.postCode = postCode;
    this.latitude = latitude;
    this.longitude = longitude;
    this.stars = stars;
    this.reviewCount = reviewCount;
    this.isOpen = isOpen;
    this.categories = categories;
  }
  public String getBusinessID() {
    return BusinessID;
  }
  public void setBusinessID(String businessID) {
    BusinessID = businessID;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getNeighborhood() {
    return neighborhood;
  }
  public void setNeighborhood(String neighborhood) {
    this.neighborhood = neighborhood;
  }
  public String getAddress() {
    return address;
  }
  public void setAddress(String address) {
    this.address = address;
  }
  public String getCity() {
    return city;
  }
  public void setCity(String city) {
    this.city = city;
  }
  public String getState() {
    return state;
  }
  public void setState(String state) {
    this.state = state;
  }
  public int getPostCode() {
    return postCode;
  }
  public void setPostCode(int postCode) {
    this.postCode = postCode;
  }
  public double getLatitude() {
    return latitude;
  }
  public void setLatitude(double latitude) {
    this.latitude = latitude;
  }
  public double getLongitude() {
    return longitude;
  }
  public void setLongitude(double longitude) {
    this.longitude = longitude;
  }
  public double getStars() {
    return stars;
  }
  public void setStars(double stars) {
    this.stars = stars;
  }
  public int getReviewCount() {
    return reviewCount;
  }
  public void setReviewCount(int reviewCount) {
    this.reviewCount = reviewCount;
  }
  public boolean isOpen() {
    return isOpen;
  }
  public void setOpen(boolean isOpen) {
    this.isOpen = isOpen;
  }
  public String[] getCategories() {
    return categories;
  }
  public void setCategories(String[] categories) {
    this.categories = categories;
  }
  
  
}