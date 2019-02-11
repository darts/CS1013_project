class Query {
  //constructs a default empty query object
  Query() {
  }

  //generates an array of ints corresonding to how many
  //[0] useful, [1]funny or [2] cool reviews there are
  int[] numbersOfUsefulFunnyCool() {
    int [] dataArray = {0, 0, 0};
    if (db.connect()) {
      for (int rowID = 1; rowID < 1326101; rowID++) {
        db.query( "SELECT * FROM yelp_user WHERE ROWID = '"+rowID+"'" );
        dataArray [0] += db.getInt("useful");
        dataArray [1] += db.getInt("funny");
        dataArray [2] += db.getInt("cool");
      }
    }
    return dataArray;
  }

  // checks the reviewCount of a business then checks
  // how many reviews have businessID of that business.
  // the number of reviews is then set to the number of reviews found.
  // the number of reviews originally stored is used to limit the search
  // and speed up the process.
  void updateBusinessReviewCount() {
    if (db.connect()) {
      String businessID = "";
      int reviewCount = 0;
      for (int rowID = 1; rowID < 174568; rowID++) {
        db.query( "SELECT * FROM yelp_business WHERE ROWID = '"+rowID+"'" );
        reviewCount = db.getInt("review_count");
        businessID = db.getString("business_id");
        reviewCount = getReviewsByBusinessID(businessID, reviewCount).size();
        println(reviewCount);
        db.query( "UPDATE yelp_business SET review_count = '"+reviewCount+"' WHERE ROWID = '"+rowID+"'" );
        println("RowID = " + rowID);
      }
    }
  }

  // checks the reviewCount of a user then checks
  // how many reviews have userID of that user.
  // the number of reviews is then set to the number of reviews found.
  // the number of reviews originally stored is used to limit the search
  // and speed up the process.
  void updateUserReviewCount() {
    if (db.connect()) {
      String userID = "";
      int reviewCount = 0;
      for (int rowID = 1; rowID < 1326101; rowID++) {
        db.query( "SELECT * FROM yelp_user WHERE ROWID = '"+rowID+"'" );
        reviewCount = db.getInt("review_count");
        println(reviewCount);
        userID = db.getString("user_id");
        reviewCount = getReviewsByUserID(userID, reviewCount).size();
        println(reviewCount);
        db.query( "UPDATE yelp_user SET review_count = '"+reviewCount+"' WHERE ROWID = '"+rowID+"'" );
        println("RowID = " + rowID);
      }
    }
  }

  // takes a user ID as a string
  // returns a User object with the corresponding ID
  User getUserByUserID (String userID) {
    User matchingUser = null;
    if (db.connect()) {
      //read all in table "yelp_user"
      db.query( "SELECT * FROM yelp_user WHERE user_id = '"+userID+"'" );
      while (db.next()) {
        String data = db.getString("friends");
        String [] splitData = split(data, ',');
        matchingUser = new User(db.getString("user_id"), db.getString("name"), 
          db.getInt("review_count"), db.getString("yelping_since"), splitData, db.getInt("useful"), 
          db.getInt("funny"), db.getInt("cool"), db.getInt("fans"), db.getString("elite"), 
          db.getDouble("average_stars"), db.getInt("compliment_hot"), db.getInt("compliment_more"), 
          db.getInt("compliment_profile"), db.getInt("compliment_cute"), db.getInt("compliment_list"), 
          db.getInt("compliment_note"), db.getInt("compliment_plain"), db.getInt("compliment_cool"), 
          db.getInt("compliment_funny"), db.getInt("compliment_writer"), db.getInt("compliment_photos"));
      }
    }
    return matchingUser;
  }

  // takes a business ID as a string
  // returns a Business object with the corresponding ID
  Business getBusinessByBusinessID(String businessID) {
    Business matchingBusiness = null;
    if ( db.connect() ) {
      //read all in table "yelp_business"
      db.query( "SELECT * FROM yelp_business WHERE business_id = '"+businessID+"'");
      while (db.next()) {
        String data = db.getString("catagories");
        String [] splitData = split(data, ',');
        matchingBusiness = new Business(db.getString("business_id"), db.getString("name"), 
          db.getString("neighbourhood"), db.getString("address"), db.getString("city"), 
          db.getString("state"), db.getInt("postal_code"), db.getDouble("latitude"), 
          db.getDouble("longitude"), db.getDouble("stars"), db.getInt("review_count"), 
          db.getBoolean("is_open"), splitData);
      }
    }
    return matchingBusiness;
  }

  // takes the number of users you want as a sample size
  // generates a list of users then randomly selects from
  // the list until the sample size has been met
  ArrayList<User> getRandomUsers(int sampleSize) {
    ArrayList<User> sampleUsers = new ArrayList<User>();
    String keyword = "e";
    ArrayList<User> matchingUsers = new ArrayList<User>();
    if (db.connect()) {
      db.query( "SELECT * FROM yelp_user WHERE name LIKE '"+keyword+"'" );
      while (db.next()) {
        String data = db.getString("friends");
        String [] splitData = split(data, ',');
        User newUser = new User(db.getString("user_id"), db.getString("name"), 
          db.getInt("review_count"), db.getString("yelping_since"), splitData, db.getInt("useful"), 
          db.getInt("funny"), db.getInt("cool"), db.getInt("fans"), db.getString("elite"), 
          db.getDouble("average_stars"), db.getInt("compliment_hot"), db.getInt("compliment_more"), 
          db.getInt("compliment_profile"), db.getInt("compliment_cute"), db.getInt("compliment_list"), 
          db.getInt("compliment_note"), db.getInt("compliment_plain"), db.getInt("compliment_cool"), 
          db.getInt("compliment_funny"), db.getInt("compliment_writer"), db.getInt("compliment_photos"));
        matchingUsers.add(newUser);
      }
      int random = 0;
      for (int index = 0; index < sampleSize; index++) {
        random = int(random(matchingUsers.size()));
        sampleUsers.add(matchingUsers.get(random));
      }
    }
    return sampleUsers;
  }

  // takes the number of businesses you want as a sample size
  // generates a list of businesses then randomly selects from
  // the list until the sample size has been met
  ArrayList<Business> getRandomBusinesses(int sampleSize) {
    ArrayList<Business> matchingBusinesses = new ArrayList<Business>();
    ArrayList<Business> sampleBusinesses = new ArrayList<Business>();
    String keyword = "e";
    if (db.connect()) {
      db.query( "SELECT * FROM yelp_business WHERE name LIKE '%"+keyword+"%'" );
      while (db.next()) {
        String data = db.getString("catagories");
        String [] splitData = split(data, ',');
        Business newBusiness = new Business(db.getString("business_id"), db.getString("name"), 
          db.getString("neighbourhood"), db.getString("address"), db.getString("city"), 
          db.getString("state"), db.getInt("postal_code"), db.getDouble("latitude"), 
          db.getDouble("longitude"), db.getDouble("stars"), db.getInt("review_count"), 
          db.getBoolean("is_open"), splitData);
        matchingBusinesses.add(newBusiness);
      }
      int random = 0;
      for (int index = 0; index < sampleSize; index++) {
        random = int(random(matchingBusinesses.size()));
        sampleBusinesses.add(matchingBusinesses.get(random));
      }
    }
    return sampleBusinesses;
  }

  // creates a float array with the values of how many reviews of each star value
  // were made. index [0] holds the value for how many 1 star reviews were made.
  // index [4] holds the value for how many 5 star reviews were made.
  // the float array is returned after looping through every review and adding
  // 1 to the array entry corresponding to how many stars the review had.
  float [] reviewsPerStar() {
    float [] stars = new float [5];
    if (db.connect()) {
      int star = 0;
      db.query( "SELECT * FROM yelp_review WHERE stars");
      while (db.next()) { 
        star = db.getInt("stars");
        if (star == 1)
          stars [0] = stars [0] + 1;
        else if (star == 2)
          stars [1] = stars [1] + 1;
        else if (star == 3)
          stars [2] = stars [2] + 1;
        else if (star == 4)
          stars [3] = stars [3] + 1;
        else if (star == 5)
          stars [4] = stars [4] + 1;
      }
    }
    return stars;
  }

  // take a review ID as a string and returns an arraylist of reviews
  // with matching user ID's.
  Review getReviewByReviewID(String reviewID) {
    Review aReview = null;
    if (db.connect()) {
      db.query( "SELECT * FROM yelp_review WHERE review_id = '"+reviewID+"'");
      while (db.next()) {
        Review newReview = new Review(db.getString("review_id"), db.getString("user_id"), 
          db.getString("business_id"), db.getInt("stars"), db.getString("date"), db.getString("text"), 
          db.getInt("useful"), db.getInt("funny"), db.getInt("cool"));
        aReview = newReview;
      }
    }
    return aReview;
  }

  // takes the name of a business in string form and returns an arraylist
  // of businesses containing the passed string in their name.
  // checks the name of the business in the name column of the
  // yelp_business table.
  ArrayList<Business> getBusinessByName(String keyword) {
    keyword = keyword.toLowerCase();
    ArrayList<Business> matchingBusinesses = new ArrayList<Business>();
    if ( db.connect() ) {
      //read all in table "yelp_business"
      db.query( "SELECT * FROM yelp_business WHERE name LIKE '%"+keyword+"%'" );
      while (db.next() && matchingBusinesses.size() < NUM_OF_BUSINESSES_TO_GET) {
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

  // takes a user_id as a string and returns the corresponding username
  String getUserNameByID(String userID) {
    String name = "";
    if (db.connect()) {
      //read all in table "yelp_user"
      db.query( "SELECT * FROM yelp_user WHERE user_id = '"+userID+"'" );
      while (db.next()) {
        name = db.getString("name");
      }
    }
    return name;
  }

  // take a name as a string and returns an arraylist of 100 users whose
  // name contains the string.
  ArrayList<User> getUserByName(String keyword) {
    keyword = keyword.toLowerCase();
    ArrayList<User> matchingUsers = new ArrayList<User>();
    if (db.connect()) {
      //read all in table "yelp_user"
      db.query( "SELECT * FROM yelp_user WHERE name LIKE '"+keyword+"'" );
      while (db.next() && matchingUsers.size()<NUM_OF_USERS_TO_GET) {
        String data = db.getString("friends");
        String [] splitData = split(data, ',');
        User newUser = new User(db.getString("user_id"), db.getString("name"), 
          db.getInt("review_count"), db.getString("yelping_since"), splitData, db.getInt("useful"), 
          db.getInt("funny"), db.getInt("cool"), db.getInt("fans"), db.getString("elite"), 
          db.getDouble("average_stars"), db.getInt("compliment_hot"), db.getInt("compliment_more"), 
          db.getInt("compliment_profile"), db.getInt("compliment_cute"), db.getInt("compliment_list"), 
          db.getInt("compliment_note"), db.getInt("compliment_plain"), db.getInt("compliment_cool"), 
          db.getInt("compliment_funny"), db.getInt("compliment_writer"), db.getInt("compliment_photos"));
        matchingUsers.add(newUser);
      }
    }
    return matchingUsers;
  }

  //if getReviewsByUserID is called without a numberOfReviews
  // to limit the search a default limit is set.
  ArrayList<Review> getReviewsByUserID(String userID) {
    return getReviewsByUserID(userID, MARGIN);
  }

  // take a user ID as a string and returns an arraylist of reviews
  // with matching user ID's. After the number of reviews has been
  // reached
  ArrayList<Review> getReviewsByUserID(String userID, int limit) {
    ArrayList<Review> userReviews = new ArrayList<Review>();
    if (db.connect()) {
      db.query( "SELECT * FROM yelp_review WHERE user_id = '"+userID+"'");
      while (db.next() && userReviews.size() < limit) {
        Review newReview = new Review(db.getString("review_id"), db.getString("user_id"), 
          db.getString("business_id"), db.getInt("stars"), db.getString("date"), db.getString("text"), 
          db.getInt("useful"), db.getInt("funny"), db.getInt("cool"));
        userReviews.add(newReview);
      }
    }
    return userReviews;
  }
  // returns an arraylist of 100 reviews with more than 4 stars.
  ArrayList<Review> greatReviews() {
    ArrayList<Review> greatReviews = new ArrayList<Review>();
    if (db.connect()) {
      db.query( "SELECT * FROM yelp_review WHERE stars > 4" );
      while (db.next() && greatReviews.size()<100) {
        Review newReview = new Review(db.getString("review_id"), db.getString("user_id"), 
          db.getString("business_id"), db.getInt("stars"), db.getString("date"), db.getString("text"), 
          db.getInt("useful"), db.getInt("funny"), db.getInt("cool"));
        greatReviews.add(newReview);
      }
    }
    return greatReviews;
  }

  // if getReviewsByBusinessID is called without a limit, sets a limit.
  ArrayList<Review> getReviewsByBusinessID(String businessID) {
    return getReviewsByBusinessID(businessID, MARGIN);
  }

  // takes the ID of a business in string form and returns an arraylist
  // of reviews containing the passed string in their business_id.
  // checks the id of the review in the business_id column of the
  // yelp_review table.
  ArrayList<Review> getReviewsByBusinessID(String businessID, int limit) {
    ArrayList<Review> businessReviews = new ArrayList<Review>();
    if (db.connect()) {
      db.query( "SELECT * FROM yelp_review WHERE business_id = '"+businessID+"'");
      while (db.next() && businessReviews.size() < limit) {
        Review newReview = new Review(db.getString("review_id"), db.getString("user_id"), 
          db.getString("business_id"), db.getInt("stars"), db.getString("date"), db.getString("text"), 
          db.getInt("useful"), db.getInt("funny"), db.getInt("cool"));
        businessReviews.add(newReview);
      }
    }
    return businessReviews;
  }

  // if getUserByReviewCount is called without a second parameter,
  // a default parameter is set.
  ArrayList<User> getUserByReviewCount(int reviewNumber) {
    return getUserByReviewCount(reviewNumber, EVENT_NULL);
  }

  // takes a number of reviews (reviewNumber)
  // and an int greaterOrLess, if greaterOrLess is greater than 0 then it returns
  // an arraylist of users with more than reviewNumber reviews
  // if greaterOrLess is less than 0 then it returns
  // an arraylist of users with less than reviewNumber reviews
  // else reviews with reviewNumber reviews are returned.
  ArrayList<User> getUserByReviewCount(int reviewNumber, int greaterOrLess) {
    ArrayList<User> matchingUsers = new ArrayList<User>();
    if (db.connect()) {
      //read all in table "yelp_user"
      if (greaterOrLess > 0) {
        db.query( "SELECT * FROM yelp_user WHERE review_count > "+ reviewNumber );
      } else if (greaterOrLess < 0) {
        db.query( "SELECT * FROM yelp_user WHERE review_count < "+ reviewNumber );
      } else {
        db.query( "SELECT * FROM yelp_user WHERE review_count = "+ reviewNumber );
      }
      while (db.next() && matchingUsers.size()<100) {
        String data = db.getString("friends");
        String [] splitData = split(data, ',');
        User newUser = new User(db.getString("user_id"), db.getString("name"), 
          db.getInt("review_count"), db.getString("yelping_since"), splitData, db.getInt("useful"), 
          db.getInt("funny"), db.getInt("cool"), db.getInt("fans"), db.getString("elite"), 
          db.getDouble("average_stars"), db.getInt("compliment_hot"), db.getInt("compliment_more"), 
          db.getInt("compliment_profile"), db.getInt("compliment_cute"), db.getInt("compliment_list"), 
          db.getInt("compliment_note"), db.getInt("compliment_plain"), db.getInt("compliment_cool"), 
          db.getInt("compliment_funny"), db.getInt("compliment_writer"), db.getInt("compliment_photos"));
        matchingUsers.add(newUser);
      }
    }
    return matchingUsers;
  }

  // if getUserByAverageStars is called without a second parameter,
  // a default parameter is set.
  ArrayList<User> getUserByAverageStars(double averageStars) {
    return getUserByAverageStars(averageStars, EVENT_NULL);
  }

  // takes an average number of stars (averageStars)
  // and an int greaterOrLess, if greaterOrLess is greater than 0 then it returns
  // an arraylist of users with more than averageStars stars
  // if greaterOrLess is less than 0 then it returns
  // an arraylist of users with less than averageStars stars
  // else reviews with int(averageStars) stars are returned.
  ArrayList<User> getUserByAverageStars(double averageStars, int greaterOrLess) {
    ArrayList<User> matchingUsers = new ArrayList<User>();
    if (db.connect()) {
      //read all in table "yelp_user"
      if (greaterOrLess > EVENT_NULL) {
        db.query( "SELECT * FROM yelp_user WHERE average_stars > "+ averageStars );
      } else if (greaterOrLess < EVENT_NULL) {
        db.query( "SELECT * FROM yelp_user WHERE average_stars < "+ averageStars );
      } else {
        db.query( "SELECT * FROM yelp_user WHERE CAST(average_stars AS INT) = "+ (int)averageStars );
      }
      while (db.next() && matchingUsers.size()<100) {
        String data = db.getString("friends");
        String [] splitData = split(data, ',');
        User newUser = new User(db.getString("user_id"), db.getString("name"), 
          db.getInt("review_count"), db.getString("yelping_since"), splitData, db.getInt("useful"), 
          db.getInt("funny"), db.getInt("cool"), db.getInt("fans"), db.getString("elite"), 
          db.getDouble("average_stars"), db.getInt("compliment_hot"), db.getInt("compliment_more"), 
          db.getInt("compliment_profile"), db.getInt("compliment_cute"), db.getInt("compliment_list"), 
          db.getInt("compliment_note"), db.getInt("compliment_plain"), db.getInt("compliment_cool"), 
          db.getInt("compliment_funny"), db.getInt("compliment_writer"), db.getInt("compliment_photos"));
        matchingUsers.add(newUser);
      }
    }
    return matchingUsers;
  }

  // if getUserByAverageStars is called without a second parameter,
  // a default parameter is set.
  ArrayList<Business> getBusinessByAverageStars(double averageStars) {
    return getBusinessByAverageStars(averageStars, EVENT_NULL);
  }

  // takes an average number of stars (averageStars)
  // and an int greaterOrLess, if greaterOrLess is greater than 0 then it returns
  // an arraylist of businesses with more than averageStars stars
  // if greaterOrLess is less than 0 then it returns
  // an arraylist of businesses with less than averageStars stars
  // else businesses with int(averageStars) stars are returned.
  ArrayList<Business> getBusinessByAverageStars(double averageStars, int greaterOrLess) {
    ArrayList<Business> matchingBusinesses = new ArrayList<Business>();
    if ( db.connect() ) {
      //read all in table "yelp_business"
      if (greaterOrLess > EVENT_NULL) {
        db.query( "SELECT * FROM yelp_business WHERE stars > "+ averageStars );
      } else if (greaterOrLess < EVENT_NULL) {
        db.query( "SELECT * FROM yelp_business WHERE stars < "+ averageStars );
      } else {
        db.query( "SELECT * FROM yelp_business WHERE CAST(stars AS INT) = "+ (int)averageStars );
      }
      while (db.next() && matchingBusinesses.size() < 100) {
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

  ArrayList<Review> getReviewsByDate(String aDate) {
    ArrayList<Review> reviews = new ArrayList<Review>();
    if (db.connect()) {
      db.query( "SELECT * FROM yelp_review WHERE date LIKE '"+ aDate + "'");
      while (db.next() && reviews.size() < 100) {
        Review newReview = new Review(db.getString("review_id"), db.getString("user_id"), 
          db.getString("business_id"), db.getInt("stars"), db.getString("date"), db.getString("text"), 
          db.getInt("useful"), db.getInt("funny"), db.getInt("cool"));
        reviews.add(newReview);
      }
    }
    return reviews;
  }
}
//examples for setting up a query

// open database file
//db = new SQLite( this, "projectDB.db" );
//Query aQuery = new Query();

// search database for reviews by reviewID
//Review aReview = aQuery.getReviewByReviewID("vkVSCC7xljjrAI4UGfnKEQ");
//println(aReview.getText());

// search database for a business by name
//ArrayList<Business> bList = aQuery.getBusinessByName("Messina");
//for(int index = 0; index < bList.size(); index++){
//  println(bList.get(index).getName());
//}

// search database for a userName by ID
//String name = aQuery.getUserNameByID(userID);

// search database for a user by name
//ArrayList<User> uList = aQuery.getUserByName("Chris");
//for(int index = 0; index < uList.size(); index++){
//  println(uList.get(index).getName());
//}

// search database for 20 great reviews
//ArrayList<Review> rList = aQuery.greatReviews();
//for(int index = 0; index < rList.size(); index++){
//  println(rList.get(index).getReviewID());
//}

// search database for reviews by userID
//ArrayList<Review> rList = aQuery.getReviewsByUserID(aUser.getUserID());
//println(rList.size());
//for(int index = 0; index < rList.size(); index++){
//  println(rList.get(index).getReviewID());
//}

// search database for a user by reviewCount
//ArrayList<User> uList = aQuery.getUserByReviewCount(10, 1);
//for(int index = 0; index < uList.size(); index++){
//  println(uList.get(index).getReviewCount());
//}

// search database for a user by average_stars
//ArrayList<User> uList = aQuery.getUserByAverageStars(4, 1);
//for(int index = 0; index < uList.size(); index++){
//  println(uList.get(index).getAverageStars());
//}

// search database for reviews by date - not feasable
//ArrayList<Review> rList = aQuery.greatReviews();
//Review aReview = rList.get(99);
//println(aReview.getDate());
//ArrayList<Review> rListDate = aQuery.getReviewsByDate(aReview.getDate());
//println(rListDate.size());
//for(int index = 0; index < rListDate.size(); index++){
//  println(rListDate.get(index).getDate());
//}