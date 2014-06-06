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
       $(".myuser[user^="+user+"]").show();
   	   $(".myuser:not([user^="+user+"])").hide();	
    } else
    {
    	$(".myuser").show();
    }
}