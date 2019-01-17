
#property copyright "Copyright 2019, Hedgebitcoin"
#property link      "https://github.com/fx4btc"
#property version   "2.00"

/*
Save the Chart ids and the chart symbols in individual arrays 
*/

string saveOpenedChartNames  [];
long   saveOpenedChartIDs [];


// need to load the values into the array first 
int load_chart_arrays(){

   charts_manage_chart_id_symbol();
   
   int size = ArraySize(saveOpenedChartNames);
   
   return(size);
   
}

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

void charts_chose_chart_all(){

   load_chart_arrays();
  
  int countcharts =  ArraySize(saveOpenedChartNames);
  
  for(int i = 0; i< countcharts; i++){
   
      string sym = saveOpenedChartNames[i];
     
      GlobalVariableDel(sym);
      
      Print("Closing close now: print symbol after deleting global : " + sym);
      
      long id = saveOpenedChartIDs[i];
      
      string grab_sym = ChartSymbol(id);
      
      if( ChartSymbol(grab_sym) != Symbol() ) {
      
          if(  !ChartClose(id) ){
            Print(" ERROR WITH CLOSING CHART WITH ID " + saveOpenedChartIDs[i] );
          }else{
             // ok good, now delete global
             string make = grab_sym+"_"+id;
             Print(" Print the global variable name to delete: " + make);
             GlobalVariableDel(make);  
             
             // find more,
            //   int count =   GlobalVariablesDeleteAll(NULL,0);
            //   Print(" Print deleted variables : " +count);   
         }  
      }
      
      
      if( saveOpenedChartNames[i] != Symbol()  ){
         charts_close_chart(saveOpenedChartNames[i] );
      }
      
  }
}

void charts_close_chart(string _symbol ){

    long thischart = ChartID();
    long first = ChartFirst();
    long next =   ChartNext(first) ;
    
    long lastchart = 0;
   
   while(lastchart != next)
     {
      
      lastchart = next;
      long newchartID =   ChartNext(next);
      next = newchartID;// replace next with latest chart ID
      string currentchartSym =  ChartSymbol(lastchart);
      
      if( currentchartSym == _symbol){
         ChartClose(lastchart);
         return;
      }
      
    }
    Print(" No charts to close ");
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

