
class TextWidget extends Widget {

  int maxLength;

  TextWidget(int x, int y, int width, int height, String label, color widgetColor, PFont font, int event, int maxLength) { 
    super(x, y, width, height, label, widgetColor, font, event);
    this.x=x;
    this.y=y;
    this.width = width; 
    this.height= height;
    this.label=label;
    this.event=event;
    this.widgetColor=widgetColor;
    this.widgetFont=font;
    labelColor=color(0); 
    this.maxLength=maxLength;
  }
  
  //Add the pressed key to the text
  void append(char userKey) {
    if (userKey==BACKSPACE) {
      if (!label.equals(""))
        label=label.substring(0, label.length()-1);//Remove the last character
    } else if (userKey == CODED || userKey == TAB || userKey == ENTER) {//Inputs to ignore
    } else if (label.length() <maxLength)
      label=label+str(userKey);//Add the character
  }

  
  String getLabel() {
    return label;
  }
}