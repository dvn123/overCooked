$(document).ready(function() {
searchIt();
$( "#search" )
  .keyup(function () {
  	searchIt();
  });
});

function searchIt()
{
	var user = $("#search").val();
    if(user != "")
    {
       $(".myuser[id^="+user+"]").show();
   	   $(".myuser:not([id^="+user+"])").hide();	
    } else
    {
    	$(".myuser").show();
    }
}