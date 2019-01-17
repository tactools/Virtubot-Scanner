
#property copyright "Copyright 2019, Hedgebitcoin"
#property link      "https://github.com/fx4btc"
#property version   "2.00"
//+------------------------------------------------------------------+
//| Remove unneeded objects from main chart                          |
//+------------------------------------------------------------------+
void objects_deleteScale(int from,int to=1)
  {
//---   
   from--;to--;
   for(int i=from;i>=to;i--)
     {
      ObjectDelete(0,"Panel "+IntegerToString(i));
      ObjectDelete(0,"Text "+IntegerToString(i));
      ObjectDelete(0,"Variation "+IntegerToString(i));
     }
  }
//+------------------------------------------------------------------+
//| Draw data about a symbol in a panel                              |
//+------------------------------------------------------------------+
void SetText(string name,string text,int x,int y,color colour,int size=12)
  {
   if(ObjectCreate(0,name,OBJ_LABEL,0,0,0))
     {
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(0,name,OBJPROP_COLOR,colour);
      ObjectSetInteger(0,name,OBJPROP_FONTSIZE,size);
      ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
     }
   ObjectSetString(0,name,OBJPROP_TEXT,text);
  }
//+------------------------------------------------------------------+
//| Draw a panel with given color for a symbol                       |
//+------------------------------------------------------------------+
void SetPanel(string name,int sub_window,int x,int y,int width,int height,color bg_color,color border_clr,int border_width)
  {
   if(ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
     {
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(0,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(0,name,OBJPROP_YSIZE,height);
      ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
      ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSetInteger(0,name,OBJPROP_WIDTH,border_width);
      ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
      ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger(0,name,OBJPROP_BACK,false);
      ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,name,OBJPROP_SELECTED,0);
      ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
     }
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
  }
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Create a label                                                   |
//+------------------------------------------------------------------+
bool CreateLabel2(string name,string text,int x,int y, color col, int size, string font)
  {
         font="Arial";
  
   if( !ObjectFind(0,name) )
     {
      if(ObjectCreate(0,name,OBJ_EDIT,0,0,0) ){
      
//Print(" Edit label text " + name);
     
      //ObjectSetString(0,name,OBJPROP_NAME
      ObjectSetString(0,name,OBJPROP_FONT,font);
      ObjectSetInteger(0,name,OBJPROP_FONTSIZE,size);
      ObjectSetInteger(0,name, OBJPROP_COLOR, col);
      ObjectSetString(0,name,OBJPROP_TEXT,text);
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
     
     }
     
      
     }else{
     if( ObjectCreate(0,name,OBJ_LABEL,0,0,0) ){
     
     //    Print(" Create label text " + name);
     
         ObjectSetString(0,name,OBJPROP_FONT,font);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,size);
         ObjectSetInteger(0,name, OBJPROP_COLOR, col);
         ObjectSetString(0,name,OBJPROP_TEXT,text);
         ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
         ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
         
         
       }
     
     }
     
     
     ChartRedraw();
     
     
     return(true);
  }

