
#property copyright "Copyright 2019, Hedgebitcoin"
#property link      "https://github.com/fx4btc"
#property version   "2.00"

void globals_delete_globalname(string nameOf){
   
   GlobalVariableDel(nameOf);

}

void globals_make_global_name(string nameOf, int chart_id , double globalvalue){
   //"HEATMAP_" + 
    GlobalVariableSet(nameOf + "_" + IntegerToString( chart_id),globalvalue  );
    
}

/*
Find Global Variable Name 
 and change the Value 
*/

   //manage_reset_globalvalue_by_globalname("RiskExposurePercentage_",5);
int globals_reset_value_by_name(string nameOf, double RiskPercent){

    
    int countCharts  = 0;
    long thischart = ChartID();
    long first = ChartFirst();
    long next =   ChartNext(first) ;
    long lastchart = 0;
    long newchartID =0;
    string currentchartSym, front;
   
   while(lastchart != next)
     {
      countCharts++;
      lastchart = next;
      newchartID =   ChartNext(next);
      next = newchartID;// replace next with latest chart ID
     
      currentchartSym =  ChartSymbol(lastchart);

      front = nameOf +currentchartSym;
      
    //  Print("find Global name "+ front);
      
      if( GlobalVariableCheck(front) ){
      
    //  Print("found Global name "+ front);
      double last = GlobalVariableGet(front);
         if( NormalizeDouble(RiskPercent,1) != last ){
         
            Print(front + " changed value from "+ last + " to " + RiskPercent +" At time " + TimeToString( GlobalVariableSet(front,NormalizeDouble(RiskPercent,2)),TIME_MINUTES) );
            
         }
      } 
    }
    
    return(countCharts);
}
