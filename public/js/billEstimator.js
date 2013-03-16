
function showMonitors(newValue)
{
	document.getElementById("monitors_value").innerHTML=newValue;
}

function showChecks(newValue)
{
	document.getElementById("checks_value").innerHTML=newValue;
}

function showMonthlyBill()
{
	time_interval = document.getElementById("checks_value").innerHTML;
        num_of_monitors = document.getElementById("monitors_value").innerHTML;
        charge_per_check = 0.0001;
        total_min_per_month = 43829;
        monthly_bill = num_of_monitors * (total_min_per_month/time_interval) * charge_per_check; 
        decimal_places = 2;
        monthly_bill = roundNumber(monthly_bill,decimal_places);
        if(monthly_bill <= 0.30)
         {
            document.getElementById("monthly_bill").innerHTML="0.00 (FREE service when usage is $0.30 or less)"
          }
        else
         {
          document.getElementById("monthly_bill").innerHTML=monthly_bill;
         }
}

function roundNumber(rnum, rlength) { // Arguments: number to round, number of decimal places
  var newnumber = Math.round(rnum*Math.pow(10,rlength))/Math.pow(10,rlength);
  return newnumber
}

