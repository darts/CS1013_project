class TextBar extends Widget {
  String text;
  boolean usesLargeFont;

  TextBar(int xPos, int yPos, String text, PFont font, int event, boolean usingNEW_DEF_FONT) {
    this.x = xPos;
    this.y = yPos;
    this.text = text;
    this.widgetFont = font;
    this.event = event;
    usesLargeFont = usingNEW_DEF_FONT;
    setSize();
  }

  void changeText(String text) {//Change the text displayed.
    this.text = text;
    setSize();
    println(height + "    " + width);
  }

  void setSize() {//Procedurally set the width of the container for collision checking.
    if (text != null) {
      if (usesLargeFont) {
        height = 65;
        println(text.length());
        width = text.length() * 17;
      } else {
        height = 30;
        width = (int)(text.length() * 8.4);
      }
    } else {
      width = 0;
      height = 0;
    }
  }

  void draw() {//Draw the object.
    if (text != null) {

      textAlign(LEFT, TOP);
      textFont(widgetFont);
      text(text, x, y);
      textAlign(LEFT, BASELINE);
    }
  }
}