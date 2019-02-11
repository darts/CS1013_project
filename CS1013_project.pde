import de.bezier.data.sql.*;
import java.util.*;
// map stuff
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.Google;

SQLite db;
Query dbUpdater, qCall;
ScreenOrganiser so;
PFont DEF_FONT, NEW_DEF_FONT, BARCHART_FONT,standardFont;
PImage star;
UnfoldingMap businessMap;
UnfoldingMap USAMap;
UnfoldingMap userMap;
//PrintWriter output; // used in preloading data

void settings() {
  size(SCREENX, SCREENY, P2D);// I had to change this to make maps work, shouldn't cause problems
}

void setup() {
  //Demo stuff-------------------------------------------
  star = loadImage("star.jpg");
  DEF_FONT = loadFont("AgencyFB-Reg-24.vlw"); // Cannot be static.
  NEW_DEF_FONT = loadFont("AgencyFB-Reg-50.vlw");//Use this one.
  BARCHART_FONT = loadFont("AgencyFB-Reg-35.vlw");
  standardFont = loadFont("AgencyFB-Reg-16.vlw");
  businessMap = new UnfoldingMap(this, "businessMap", BUSINESS_MAP_X, BUSINESS_MAP_Y, BUSINESS_MAP_WIDTH, BUSINESS_MAP_HEIGHT); 
  USAMap = new UnfoldingMap(this, "USAMap", USA_MAP_X-200, USA_MAP_Y, USA_MAP_WIDTH, USA_MAP_HEIGHT);
  userMap = new UnfoldingMap(this, "userMap", BUSINESS_MAP_X, BUSINESS_MAP_Y+500, BUSINESS_MAP_WIDTH, BUSINESS_MAP_HEIGHT-200); 
  
  MapUtils.createDefaultEventDispatcher(this, businessMap);
  MapUtils.createDefaultEventDispatcher(this, USAMap);
  MapUtils.createDefaultEventDispatcher(this, userMap);
  db = new SQLite( this, "projectDB.db" );

  //New homepage.
  so = new ScreenOrganiser();

  //Queries used for preloading data:
  qCall = new Query();
  //This was used to search all reviews and pull the number of reviews for each star rating.
  //float[] revPStar = qCall.reviewsPerStar();
  //for(int i = 0; i < revPStar.length; i++)
  //  println(revPStar[i]);
  
  //This was used to get some random reviews and see how the number of characters relates to number of stars.
  //ArrayList<User> userList = qCall.getRandomUsers(1000);
  //float[] friendCount = new float[1000];
  //String fC = ""; 
  //float[] reviewCount = new float[1000];
  //String rC = "";
  //for(int i = 0; i < userList.size(); i++){
  // friendCount[i] = userList.get(i).getFriends().length;
  // fC += friendCount[i] + ",";
  // reviewCount[i] = userList.get(i).getReviewCount();
  // rC += reviewCount[i] + ",";
  //}
  //output = createWriter("ta.txt");
  //output.println(fC);
  //output.println(rC);
  //output.flush();
  
}

void draw() { 
  background(255);
  so.draw();// screenOrganiser
}

void mouseWheel(MouseEvent event) {
  so.scroll(event.getCount());
}

void keyPressed() {
  so.keyPressed();
}

void mousePressed() {
  so.mousePressed();
}