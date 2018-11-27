class BusinessScreen extends Screen{
 String BusinessID;
   String name;
   String address;
   String city;
   String state;
  double stars;
  int reviewCount;
 
 public BusinessScreen(Business business) {// will put in only business object laterr?
  super();
  BusinessID = business.getBusinessID();
  this.name = business.getName();
  this.address =business.getAddress();
  this.city = business.getCity();
  this.state = business.getState();
  this.stars =business.getStars();
  this.reviewCount = business.getReviewCount();
}


void draw(){
    
    super.draw();
    textSize(20);
    
    
    fill(0);
    text(this.name, 50, 220); 
    text("address :  " +this.address, 50, 240);
    text("city: "+this.city, 50,260);
    text("Average Stars: "+ this.stars, 50, 280);

  }
}