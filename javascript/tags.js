$(document).ready(function() {
searchIt();
$( "#search" )
  .keyup(function () {
  	searchIt();
  });
});

function searchIt()
{
	var tag = $("#search").val();
    if(tag != "")
    {
       $(".mytag[id^="+tag+"]").show();
   	   $(".mytag:not([id^="+tag+"])").hide();	
    } else
    {
    	$(".mytag").show();
    }
}