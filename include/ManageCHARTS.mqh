
#property copyright "Copyright 2019, Hedgebitcoin"
#property link      "https://github.com/fx4btc"
#property version   "2.01"

/*
Save the Chart ids and the chart symbols in individual arrays 
when chart is opened, save the chartID and mae a special global
feb 7,2019

Feb 14, 2019
   bringToFront , loop through charts, change templates every 15 seconds, 
*/

string saveOpenedChartNames  [];
long   saveOpenedChartIDs [];


// need to load the values into the array first 
int load_chart_arrays(){

   charts_manage_chart_id_symbol();
   
   int size = ArraySize(saveOpenedChartNames);
   
   return(size);
   
}
// Check if chart is already opened for symbol
bool charts_compare_charts(string check_symbol){
  // Load arrays
  load_chart_arrays();
  
  int size = ArraySize(saveOpenedChartNames);
 
 //Print("number of opened charts | array  ", size  );
 
 for(int i = 0;i<size; i++){
 
   if(check_symbol != saveOpenedChartNames[i] ){
     // Print("Current opened chart does not match " + saveOpenedCharts[i] );
      }else{
         // Print("Current opened chart does match " );
         return(false);
      }
   }
   
   Print("Criteria: Open chart " + check_symbol);
   return(true);
}



/*
Pass in symbols you want to delete/close their opened charts 
1 grab the chart by ID, 
2 get the symbol
3 if match then close the chart
4 delete the global by chartID 
*/

void charts_close_chart_all(string Host_symbol){

   load_chart_arrays();
  
  int countcharts =  ArraySize(saveOpenedChartNames);
  
  for(int i = 0; i< countcharts; i++){
   
      // grab the symbol from the selected chart based on its index in the chartarray[]
      // string sym = saveOpenedChartNames[i];
      // if we 
      // if( GlobalVariableCheck(sym) ){
         // processed
          // delete the globals daily %+/-
       //  GlobalVariableDel(sym);
           // grab the chartID based on the chart index 
      long id = saveOpenedChartIDs[i];
      // grab the symbol based on the chartID()
      string grab_sym = ChartSymbol(id);
      string make = grab_sym+"_"+id;
      Print(" Trying to close this chart symbol name with chart ID: " + make );
      // prevent closing the chart that the robot is attached to. 
       if( grab_sym != Host_symbol && GlobalVariableCheck(make) ) {
      
          if(  !ChartClose(id) ){
            Print(" ERROR WITH CLOSING CHART WITH ID " + saveOpenedChartIDs[i] );
          }else{
             // ok good, now delete global
             
             Print("GlobalNameWithChartID being deleted: " + make);
             // each chart is assigned its on global? Feb 7,2019 
             GlobalVariableDel(make);         
         }  
      
     }


     
   
      
      // pass in the symbol that you want to close the chart 
      /*
      if( saveOpenedChartNames[i] != Symbol()  ){
         charts_close_chart(saveOpenedChartNames[i] );
      }
      */
      
  }
}

// Look for a chart that matches the symbol 
   //Close the chart based on symbol 
void charts_close_chart(string _symbol ,string message){

    long thischart = ChartID();
    long first = ChartFirst();
    long next =   ChartNext(first) ;
    
    long lastchart = 0;
   bool flag = false;
   while(lastchart != next)
     {
      
      lastchart = next;
      long newchartID =   ChartNext(next);
      next = newchartID;// replace next with latest chart ID
      string currentchartSym =  ChartSymbol(lastchart);
      
      string grabsym_id = currentchartSym + "_"+ next;
      
      
      if( GlobalVariableCheck(grabsym_id) ){
         Print("charts_close_chart(): found the global variable match ");
         flag = true;
      }
      
      //
      if( currentchartSym == _symbol && flag ){
         ChartClose(lastchart);
         flag = false;
         return;
      }
      
    }
    // list all the charts that would normally close if they were already opened.
         //chart has already been closed
    //  Print(_symbol + " || charts_close_chart(): No chart to close:  " + message);
}

/*
Manage something 
   run through all exixting charts, and save their symbol then compare with
   sym 
   if sym == already Opened chart. , the don't open a new chart.
*/

void charts_open_chart(string _symbol , string template_name , double direction, bool LatestChartUpfront ){

   if( !charts_compare_charts(_symbol)){
     return;
    }

    //\\Files\\my_template.tpl
    template_name = template_name+".tpl";
    long   chart_id=ChartOpen(_symbol,PERIOD_CURRENT );
    
  //   Print( IntegerToString(chart_id) + " +  ID" );
     
     
     // make the global
  
      GlobalVariableSet(_symbol +"_"+ IntegerToString(chart_id,0,0) ,0);
  
      // if not found, return now
      if(chart_id==0)
      {
         return;
      }else{
               
            if(!ChartApplyTemplate(chart_id,template_name))
            {
             Print("File 'my_template.tpl' not found in " 
            +TerminalInfoString(TERMINAL_PATH)+"\\MQL5\\Files"); 
            }else{
               // redraw after new template
                ChartSetInteger(chart_id,CHART_BRING_TO_TOP,LatestChartUpfront);//CHART_BRING_TO_TOP  -- // maybe the new chart goes to front automatically?
                ChartRedraw(chart_id);
              
            }
            
      }
}



/*
// Create the Chart Arrays
   // ChartNames
   // ChartIDs 
   saveOpenedChartNames,currentSymbolsTotal);
   saveOpenedChartIDs,currentSymbolsTotal);
*/
void charts_manage_chart_id_symbol(){
   
    int currentSymbolsTotal=SymbolsTotal(true);
    /*
    currentSymbolsTotal now equals the total opened charts on the platform 
    next, 
    we save value to external global variable 
    */
    ArrayResize(saveOpenedChartNames,currentSymbolsTotal);
    
    ArrayResize(saveOpenedChartIDs,currentSymbolsTotal);
    
    int countCharts  = 0;
    long thischart = ChartID();
    long first = ChartFirst();
    long next =   ChartNext(first) ;
    long lastchart = 0;
   
   while(lastchart != next)
     {
      countCharts++;
      lastchart = next;
      long newchartID =   ChartNext(next);
      
      
      next = newchartID;// replace next with latest chart ID
      saveOpenedChartIDs[countCharts-1] = next;
      
      string currentchartSym =  ChartSymbol(lastchart);
      saveOpenedChartNames[countCharts-1] = currentchartSym;
      
    }
    
    ArrayResize(saveOpenedChartNames,countCharts);// saves the symbols of all the openeded charts 
    ArrayResize(saveOpenedChartIDs,countCharts);
   
}

// loop through all open charts 
bool charts_bringToFront(string check_symbol){
  
    int countCharts  = 0;
    long thischart = ChartID();
    long first = ChartFirst();
    long next =   ChartNext(first) ;
    long lastchart = 0;
   
   while(lastchart != next)
     {
      countCharts++;
      lastchart = next;
      long newchartID =   ChartNext(next);
     
      Print("Loop Charts counter:" + countCharts);
      Sleep(30000);
    //  string currentchartSym =  ChartSymbol(lastchart);
     
    }
   return(false);
}

