class Query {
  Query() {
  }
  float [] reviewsPerStar(){
    float [] stars = new float [5];
    if(db.connect()){
      int star = 0;
      db.query( "SELECT * FROM yelp_review WHERE stars");
      while(db.next()){ 
        star = db.getInt("stars");
        if(star == 1)
          stars [0] = stars [0] + 1;
        else if(star == 2)
          stars [1] = stars [1] + 1;
        else if(star == 3)
          stars [2] = stars [2] + 1;
        else if(star == 4)
          stars [3] = stars [3] + 1;
        else if(star == 5)
          stars [4] = stars [4] + 1;
      }
    }
    return stars;
  }
  ArrayList<Business> getBusinessByName(String keyword) {
    keyword = keyword.toLowerCase();
    ArrayList<Business> matchingBusinesses = new ArrayList<Business>();
    if ( db.connect() ){
      //read all in table "yelp_business"
      db.query( "SELECT * FROM yelp_business WHERE name LIKE '%"+keyword+"%'" );

      while (db.next()){
        String data = db.getString("catagories");
        String [] splitData = split(data, ',');
        Business newBusiness = new Business(db.getString("business_id"), db.getString("name"), 
          db.getString("neighbourhood"), db.getString("address"), db.getString("city"), 
          db.getString("state"), db.getInt("postal_code"), db.getDouble("latitude"), 
          db.getDouble("longitude"), db.getDouble("stars"), db.getInt("review_count"), 
          db.getBoolean("is_open"), splitData);
        matchingBusinesses.add(newBusiness);
      }
    }
    return matchingBusinesses;
  }
  String getUserName(String userID){
    String name = "";
    if(db.connect()){
      //read all in table "yelp_user"
      db.query( "SELECT * FROM yelp_user WHERE user_id = '"+userID+"'" );
      while(db.next()){
        name = db.getString("name");
      }
    }
    return name;
  }
  ArrayList<User> getUserByName(String keyword){
    keyword = keyword.toLowerCase();
    ArrayList<User> matchingUsers = new ArrayList<User>();
    if(db.connect()){
      //read all in table "yelp_user"
      db.query( "SELECT * FROM yelp_user WHERE name LIKE '"+keyword+"'" );
      while(db.next() && matchingUsers.size()<5){
        String data = db.getString("friends");
        String [] splitData = split(data, ',');
        User newUser = new User(db.getString("user_id"),db.getString("name"),
          db.getInt("review_count"),db.getDate("yelping_since"),splitData,db.getInt("useful"),
          db.getInt("funny"),db.getInt("cool"),db.getInt("fans"),db.getString("elite"),
          db.getDouble("average_stars"),db.getInt("compliment_hot"),db.getInt("compliment_more"),
          db.getInt("compliment_profile"),db.getInt("compliment_cute"),db.getInt("compliment_list"),
          db.getInt("compliment_note"),db.getInt("compliment_plain"),db.getInt("compliment_cool"),
          db.getInt("compliment_funny"),db.getInt("compliment_writer"),db.getInt("compliment_photos"));
        matchingUsers.add(newUser);
      }
    }
    return matchingUsers;
  }
  ArrayList<Review> getReviewsByUserID(String userID){
    ArrayList<Review> userReviews = new ArrayList<Review>();
    if(db.connect()){
      db.query( "SELECT * FROM yelp_review WHERE user_id = '"+userID+"'");
      while(db.next()){
        Review newReview = new Review(db.getString("review_id"),db.getString("user_id"),
          db.getString("business_id"),db.getInt("stars"),db.getDate("date"),db.getString("text"),
          db.getInt("useful"),db.getInt("funny"),db.getInt("cool"));
        userReviews.add(newReview);
      }
    }
    return userReviews;
  }
  ArrayList<Review> greatReviews(){
    ArrayList<Review> greatReviews = new ArrayList<Review>();
    if(db.connect()){
      db.query( "SELECT * FROM yelp_review WHERE stars > 4" );
      while(db.next() && greatReviews.size()<25){
        Review newReview = new Review(db.getString("review_id"),db.getString("user_id"),
        db.getString("business_id"),db.getInt("stars"),db.getDate("date"),db.getString("text"),
        db.getInt("useful"),db.getInt("funny"),db.getInt("cool"));
      greatReviews.add(newReview);
      }
    }
    return greatReviews;
  }
}
  //examples for setting up a query

  // open database file
  //db = new SQLite( this, "projectDB.db" );
  //Query aQuery = new Query();
  
  // search database for a business
  //ArrayList<Business> bList = aQuery.getBusinessByName("Messina");
  //for(int index = 0; index < bList.size(); index++){
  //  println(bList.get(index).getName());
  //}
  
  //search database for a userName by ID
  //String name = aQuery.getUserName(userID);
  
  //search database for a user by name
  //ArrayList<User> uList = aQuery.getUserByName("Chris");
  //for(int index = 0; index < uList.size(); index++){
  //  println(uList.get(index).getName());
  //}
  
  //search database for 20 great reviews
  //ArrayList<Review> rList = aQuery.greatReviews();
  //for(int index = 0; index < rList.size(); index++){
  //  println(rList.get(index).getReviewID());
  //}
  
  //search database for reviews by userID
  //ArrayList<Review> rList = aQuery.getReviewsByUserID(aUser.getUserID());
  //println(rList.size());
  //for(int index = 0; index < rList.size(); index++){
  //  println(rList.get(index).getReviewID());
  //}