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
       $(".mytag[tag^="+tag+"]").show();
   	   $(".mytag:not([tag^="+tag+"])").hide();	
    } else
    {
    	$(".mytag").show();
    }
}