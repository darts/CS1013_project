import de.bezier.data.sql.*;
import java.util.*;

SQLite db;
ArrayList<Review> reviewList;
int index;
PFont standardFont;
LineGraph g;
BarChart ch1;
int[] stars;
ScreenOrganiser so;
PFont DEF_FONT, NEW_DEF_FONT;
ScrollBox sb;
ScrollWindow sw;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  //Demo stuff-------------------------------------------
  DEF_FONT = loadFont("AgencyFB-Reg-24.vlw"); // Cannot be static.
  NEW_DEF_FONT = loadFont("AgencyFB-Reg-50.vlw");//Use this one.

  standardFont = loadFont("AgencyFB-Reg-16.vlw");

  db = new SQLite( this, "projectDB.db" );
  //New homepage.
  so = new ScreenOrganiser();
  

  //reviewList = new FileReader("reviews_cleaned.csv").toList();

  //ReviewList list = new ReviewList(reviewList);
  //stars = list.getStarCount();

  ////Create barchart
  //ch1 = new BarChart("Number of stars",color(255),color(20, 20, 240), standardFont, standardFont, true);
  //float[] somePoints = {stars[1], stars[2], stars[3], stars[4], stars[5]};
  ////ch1.setData(somePoints);

  //Create line graph
  //String[] lab = {"2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"};
  //g = new LineGraph("Average Stars Over Time", 90, 500, 600, 300, 5, list.getAverageStars(), lab, "Year", "Stars", standardFont, standardFont, color(200, 0, 0), color(0, 0, 21, 20));
  //ch1 = new BarChart("Average Stars Over Time", 90, 500, 600, 300, 5, list.getAverageStars(), lab, "Year", "Stars", standardFont, standardFont, color(255), color(0, 0, 21, 20));


  //open database file
  Query aQuery = new Query();
  //sw = new ScrollWindow(500, 100, 300, 600);
  //sw.populate(aQuery.getUserByName("aoife"), color(230), NEW_DEF_FONT);
  // sb = new ScrollBox(aQuery.getUserByName("aoife").get(0), 50, 50, 100, 100, color(200), DEF_FONT, 0);
  // sb = new ScrollBox(aQuery.getUser("george").get(0), 50, 50, 200, 200, color(20, 255, 255), DEF_FONT, EVENT_BUTTON2);
  // search database for a business
  //ArrayList<Business> bList = aQuery.getBusinessByName("Messina");
  //for(int index = 0; index < bList.size(); index++){
  //  println(bList.get(index).getName());
  //}

  //search database for a user
  //ArrayList<User> uList = aQuery.getUser("Chris");
  //for(int index = 0; index < uList.size(); index++){
  //  println(uList.get(index).getName());
  //}

  //search database for 20 great reviews
  //ArrayList<Review> rList = aQuery.greatReviews();
  //for(int index = 0; index < rList.size(); index++){
  //  println(rList.get(index).getReviewID());
  //}
}

void draw() { 
  background(255);
  so.draw();// screenOrganiser
  //sb.draw();
  //sw.draw();
}

void mouseWheel(MouseEvent event) {
  //println(event);
  //sw.scroll(event.getCount());
  //sb.move(event.getCount());
  so.scroll(event.getCount());
}

void keyPressed() {
  so.keyPressed();
}

void mousePressed() {
  so.mousePressed();
}