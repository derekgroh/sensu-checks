    $counters = @(           
    "\.NET CLR Memory(_Global_)\# Gen 0 Collections",
    "\.NET CLR Memory(_Global_)\# Gen 1 Collections",
    "\.NET CLR Memory(_Global_)\# Gen 2 Collections",
    "\.NET CLR Memory(w3wp#1)\# Gen 0 Collections",
    "\.NET CLR Memory(w3wp#1)\# Gen 1 Collections",
    "\.NET CLR Memory(w3wp#1)\# Gen 2 Collections",
    "\.NET CLR Memory(w3wp#1)\% Time in GC",
    "\.NET CLR Memory(w3wp#2)\# Gen 0 Collections",
    "\.NET CLR Memory(w3wp#2)\# Gen 1 Collections",
    "\.NET CLR Memory(w3wp#2)\# Gen 2 Collections",
    "\.NET CLR Memory(w3wp#2)\% Time in GC",
    "\.NET CLR Memory(_Global_)\Gen 0 heap size",
    "\.NET CLR Memory(_Global_)\Gen 1 heap size",
    "\.NET CLR Memory(_Global_)\Gen 2 heap size",
    "\.NET CLR Memory(_Global_)\Large Object Heap size",
    "\.NET CLR Memory(_Global_)\% Time in GC",
    "\.NET CLR Memory(_Global_)\# Bytes in all Heaps",
    "\.NET CLR Memory(_Global_)\# Total committed Bytes",
    "\.NET CLR Memory(_Global_)\# Total reserved Bytes",
    "\.NET CLR Memory(_Global_)\# of Pinned Objects",
    "\APP_POOL_WAS(Web_Tradera)\Current Application Pool State",
    "\APP_POOL_WAS(Web_Tradera)\Current Application Pool Uptime",
    "\APP_POOL_WAS(Web_Tradera)\Current Worker Processes",
    "\ASP.NET\Applications Running",
    "\ASP.NET\Request Execution Time",
    "\ASP.NET\Request Wait Time",
    "\ASP.NET\Requests Current",
    "\ASP.NET\Requests Queued",
    "\ASP.NET\Requests Rejected",
    "\ASP.NET\State Server Sessions Abandoned",
    "\ASP.NET\State Server Sessions Active",
    "\ASP.NET\State Server Sessions Timed Out",
    "\ASP.NET\State Server Sessions Total",
    "\ASP.NET\Worker Process Restarts",
    "\ASP.NET\Worker Processes Running",
    "\ASP.NET Applications(__Total__)\Error Events Raised/Sec",
    "\ASP.NET Applications(__Total__)\Errors During Compilation",
    "\ASP.NET Applications(__Total__)\Errors During Execution",
    "\ASP.NET Applications(__Total__)\Errors During Preprocessing",
    "\ASP.NET Applications(__Total__)\Errors Total",
    "\ASP.NET Applications(__Total__)\Errors Total/Sec",
    "\ASP.NET Applications(__Total__)\Errors Unhandled During Execution",
    "\ASP.NET Applications(__Total__)\Errors Unhandled During Execution/Sec",
    "\ASP.NET Applications(__Total__)\Events Raised/Sec",
    "\ASP.NET Applications(__Total__)\Infrastructure Error Events Raised/Sec",
    "\ASP.NET Applications(__Total__)\Request Error Events Raised/Sec",
    "\ASP.NET Applications(__Total__)\Requests Executing",
    "\ASP.NET Applications(__Total__)\Requests Failed",
    "\ASP.NET Applications(__Total__)\Requests In Application Queue",
    "\ASP.NET Applications(__Total__)\Requests/Sec",
    "\ASP.NET Applications(__Total__)\Session SQL Server connections total",
    "\ASP.NET Applications(__Total__)\Session State Server connections total",
    "\ASP.NET Applications(__Total__)\Sessions Active",
    "\ASP.NET Applications(__Total__)\Sessions Total",
    "\ASP.NET Apps v2.0.50727(__Total__)\Cache % Machine Memory Limit Used",
    "\ASP.NET Apps v2.0.50727(__Total__)\Cache % Process Memory Limit Used",
    "\ASP.NET Apps v2.0.50727(__Total__)\Cache Total Entries",
    "\ASP.NET Apps v2.0.50727(__Total__)\Cache Total Hit Ratio",
    "\ASP.NET Apps v2.0.50727(__Total__)\Cache Total Turnover Rate",
    "\ASP.NET Apps v2.0.50727(__Total__)\Session State Server connections total",
    "\ASP.NET Apps v4.0.30319(__Total__)\Cache Total Entries",
    "\ASP.NET Apps v4.0.30319(__Total__)\Cache Total Hit Ratio",
    "\ASP.NET Apps v4.0.30319(__Total__)\Cache Total Turnover Rate",
    "\ASP.NET Apps v4.0.30319(__Total__)\Error Events Raised/Sec",
    "\ASP.NET Apps v4.0.30319(__Total__)\Errors Total/Sec",
    "\ASP.NET Apps v4.0.30319(__Total__)\Errors Unhandled During Execution/Sec",
    "\ASP.NET Apps v4.0.30319(__Total__)\Events Raised/Sec",
    "\ASP.NET Apps v4.0.30319(__Total__)\Request Error Events Raised/Sec",
    "\ASP.NET Apps v4.0.30319(__Total__)\Session State Server connections total",
    "\ASP.NET Apps v4.0.30319(*)\Cache % Machine Memory Limit Used"
);


 
$unixEpochStart = new-object DateTime 1970,1,1,0,0,0,([DateTimeKind]::Utc)
$nowInSecconds = [int]([DateTime]::UtcNow - $unixEpochStart).TotalSeconds

(Get-counter -Counter $counters -MaxSamples 1).CounterSamples | 
foreach {
    ($_.Path.substring(2) -replace '[\)]', '' -replace '[\. ]','_' -replace '[\\\(]', '.' -replace '%', 'pct' -replace '/', '_per_' -replace '#', 'number')  + "`t" + [System.Math]::Round($_.CookedValue,2) + "`t" +  [int][double]::Parse($nowInSecconds)
}
