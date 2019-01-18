# Virtu-Scanner
* Scans all markets within the **MarketWatch** and open charts automatically based on a search criteria(Gain/Loss percentage).
*close charts if conditions fall under the minimum value 

This robot will open a chart and load a template by name so you can deploy your other robots automatically. Think of this tool as a portfolio manager for your robots.

## Adding the files to your MetaTrader Platform
Download the github zip folder to your desktop , extract the contents and prepare moving the files to the appropriate directories from the directions below.
1. Open Metatrader Platform and locate the Navigation Bar on the Top of platform
2. Click on **File**
3. Click on **Open Data Folder** and this will open the file directory where you place the following files
  * Open the **MQL5** folder
  * Open the **include** folder and place the files from the github zip folder **include** 
  * Open the **Experts** folder and place the file from the github zip folder **"".ex5** 
  * restart the platform (close application and reopen)
  
## Platform Setup Guide
1. Open Metatrader platform and locate the Navigation Bar on the Top of platform
2. Click on **Tools**
3. Click on **Options**
4. Click on **Expert Advisors**
  * Allow automated trading ( checkbox)
  * uncheck the other remaining boxes
5. Click **OK**
6. Locate the Navigation Bar on the Top of platform
7. Click on **View**
8. Click on **Navigator** and you will see Navigator Window embedded into the Platform
9. Double Click on **Expert Advisors** and this will show all your robots
10. Drag and Drop **Robot** on to any Open Chart (anytime Time-Frame, any Market is ok)
11. You will see a Pop Up Box for figuring the **Inputs** tab, see the Robot Guide below for help
12. Within the Pop Up Box, click on **Common** Tab and checkbox the **Allow Automated Trading**
13. Click the **Auto Trading** Button on the Platform, you want to see a Green Arrow for ON, and Red Arrow for OFF
  * Alternatively you can simply double-click the **RobotName** to attach the robot to the most recently selected chart that you have open
  
## Robot Guide 
| Input Variable | Value Description |
| ----------- | ----------- |
|NumberOfRows | Decide how wide you want to the heatmap|
|OpenBullCharts | Decide if you want to open charts (markets) that are at a gain for the day|
|DailyMinGain | Decide how much of a percentage change to consider |
|DailyMaxGain | Decide how much of a percentage increase is enough |
|TemplateNameBulls | Decide what template to open for the Bull charts |
|OpenBearCharts | Decide if you want to open charts (markets) that are at a loss for the day|
|DailyMinGain | Decide how much of a percentage change to consider |
|DailyMaxGain | Decide how much of a percentage decrease is enough |
|TemplateNameBears | Decide what template to open for the Bear charts |







