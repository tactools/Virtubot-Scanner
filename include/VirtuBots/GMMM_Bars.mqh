 
 
 bool get_NewBar(ENUM_TIMEFRAMES tf)
  {
    static datetime lastbar;
    datetime curbar = iTime(NULL,tf,0);
    if (lastbar != curbar)
    {
      lastbar = curbar;
      return (true);
    }
    else
    {
      return (false);
    }
  }