/*


   https://www.mql5.com/en/docs/chart_operations/chartsavetemplate
   
   https://www.mql5.com/en/docs/objects/objectsetinteger

*/
#property copyright "Copyright 2019, Hedgebitcoin"
#property link "https://github.com/fx4btc"
#property version "2.00"
//+------------------------------------------------------------------+
//| Remove unneeded objects from main chart                          |
//+------------------------------------------------------------------+
void objects_deleteScale(int from, int to = 1)
{
  from--;
  to--;
  for (int i = from; i >= to; i--)
  {
    ObjectDelete(0, "Panel " + IntegerToString(i));
    ObjectDelete(0, "Text " + IntegerToString(i));
    ObjectDelete(0, "Variation " + IntegerToString(i));
  }
}
//+------------------------------------------------------------------+
//| Draw data about a symbol in a panel                              |
//+------------------------------------------------------------------+
void SetText(string name, string text, int x, int y, color colour, int size = 12 )
{
  if (ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
  {
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
    ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
    ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
    ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
  }
  ObjectSetString(0, name, OBJPROP_TEXT, text);
}

void SetText2(string name, string text, int x, int y, color colour, int size = 12, bool setToBackground = false , int corner=0 )
{
  if (!ObjectFind(0, name))
  {
   // create the object 
    if(  ObjectCreate(0,name,OBJ_LABEL,0,0,0) ){  
       ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
       ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
       ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
       ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
       ObjectSetInteger(0, name, OBJPROP_BACK, setToBackground);
       
       if(corner==0){
       Print(" objectset:"+name + "" +  corner );
         ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
       }
       if(corner==1){
       Print(" objectset:"+name + "" +  corner );
         ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
       }
      
       if(corner==2){
       Print(" objectset:"+name + "" +  corner );
         ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_RIGHT_LOWER);
       }
       
       if(corner==3){
       Print(" objectset:"+name + "" +  corner );
         ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_LOWER);
       }
    }else{
      Print("error in manageObjects");
    }
    
   
  }else{
  // object exists
       ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
       ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
       ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
       ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
       ObjectSetString(0, name, OBJPROP_TEXT, text);
  }
  
}
//+------------------------------------------------------------------+
//| Draw a panel with given color for a symbol                       |
//+------------------------------------------------------------------+
void SetPanel(string name, int sub_window, int x, int y, int width, int height, color bg_color, color border_clr, int border_width)
{
  if (ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, sub_window, 0, 0))
  {
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
    ObjectSetInteger(0, name, OBJPROP_XSIZE, width);
    ObjectSetInteger(0, name, OBJPROP_YSIZE, height);
    ObjectSetInteger(0, name, OBJPROP_COLOR, border_clr);
    ObjectSetInteger(0, name, OBJPROP_BORDER_TYPE, BORDER_FLAT);
    ObjectSetInteger(0, name, OBJPROP_WIDTH, border_width);
    ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
    ObjectSetInteger(0, name, OBJPROP_BACK, false);
    ObjectSetInteger(0, name, OBJPROP_SELECTABLE, 0);
    ObjectSetInteger(0, name, OBJPROP_SELECTED, 0);
    ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
    ObjectSetInteger(0, name, OBJPROP_ZORDER, 0);
  }
  ObjectSetInteger(0, name, OBJPROP_BGCOLOR, bg_color);
}
//+------------------------------------------------------------------+
//| Create a label                                                   |
//+------------------------------------------------------------------+
bool CreateLabel2(string name, string text, int x, int y, color col, int size, string font)
{
  font = "Arial";

  if (!ObjectFind(0, name))
  {
    if (ObjectCreate(0, name, OBJ_EDIT, 0, 0, 0))
    {

      //Print(" Edit label text " + name);

      //ObjectSetString(0,name,OBJPROP_NAME
      ObjectSetString(0, name, OBJPROP_FONT, font);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
      ObjectSetInteger(0, name, OBJPROP_COLOR, col);
      ObjectSetString(0, name, OBJPROP_TEXT, text);
      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
    }
  }
  else
  {
    if (ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
    {

      //    Print(" Create label text " + name);

      ObjectSetString(0, name, OBJPROP_FONT, font);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
      ObjectSetInteger(0, name, OBJPROP_COLOR, col);
      ObjectSetString(0, name, OBJPROP_TEXT, text);
      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
    }
  }

  ChartRedraw();

  return (true);
}



bool CreateLabel3(string name, string text, int x, int y, color colour, int size = 12, bool setToBackground = false , int corner=0 )
{
  string font = "Arial";

  if (!ObjectFind(0, name))
  {
  // edit the label 
    if (ObjectCreate(0, name, OBJ_EDIT, 0, 0, 0))
    {

      //Print(" Edit label text " + name);

      //ObjectSetString(0,name,OBJPROP_NAME
      ObjectSetString(0, name, OBJPROP_FONT, font);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
      ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
      ObjectSetString(0, name, OBJPROP_TEXT, text);
      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
      ObjectSetInteger(0, name, OBJPROP_BACK, false);
    }
  }
  else
  {
  // create the label
    if (ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
    {

      //    Print(" Create label text " + name);

      ObjectSetString(0, name, OBJPROP_FONT, font);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
      ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
      ObjectSetString(0, name, OBJPROP_TEXT, text);
      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
      ObjectSetInteger(0, name, OBJPROP_BACK, false);
    }
  }

  ChartRedraw();

  return (true);
}

// Draw a trend line 
/*
                 datetime              time1=0,           // first point time 
                 double                price1=0,          // first point price 
                 datetime              time2=0,           // second point time 
                 double                price2=0,          // second point price 
*/
bool CreateLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth)
{
 
  if (!ObjectFind(0, name))
  {
    if (ObjectCreate(0, name, OBJ_EDIT, 0, time1,price1,time2,price2)) 
    {

      //Print(" Edit label text " + name);
      /*
      ObjectSetInteger(0, name, OBJPROP_TIME, time1);
      ObjectSetInteger(0, name, OBJPROP_TIME, time2);
      ObjectSetDouble(o,name,OBJPROP_PRICE, price1);
  */
      ObjectSetInteger(0, name, OBJPROP_COLOR, col);
      ObjectSetInteger(0, name, OBJPROP_WIDTH, lineWidth);
      // is this the line description 
       ObjectSetString(0, name, OBJPROP_TEXT,text);
      
      
    }
  }
  else
  {
  
    if (ObjectCreate(0, name, OBJ_TREND, 0, time1,price1,time2,price2)) 
    {

      //    Print(" Create trend line " + name);
      ObjectSetInteger(0, name, OBJPROP_COLOR, col);
      ObjectSetInteger(0, name, OBJPROP_WIDTH, lineWidth);
       // is this the line description 
      ObjectSetString(0, name, OBJPROP_TEXT,text);
      
      ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true);
      
      //--- enable (true) or disable (false) the mode of continuation of the line's display to the left 
   ObjectSetInteger(0,name,OBJPROP_RAY_LEFT,true); 
//--- enable (true) or disable (false) the mode of continuation of the line's display to the right 
   ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,true); 
      
    }
  }

  ChartRedraw();

  return (true);
}
