
class TextWidget extends Widget {

  int maxLength;

  TextWidget(int x, int y, int width, int height, String label, color widgetColor, PFont font, int event, int maxLength) { 
    super(x, y, width,  height,  label,widgetColor, font,  event);
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
  void append(char userKey) {
    
    if (userKey==BACKSPACE) {
      if (!label.equals(""))
      
        label=label.substring(0, label.length()-1);
    } 
    else if (label.length() <maxLength)
   
      label=label+str(userKey);
  }
  
  String getLabel(){
   return label; 
  }
}