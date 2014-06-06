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
       $(".mytag[tagname^="+tag+"]").show();
   	   $(".mytag:not([tagname^="+tag+"])").hide();	
    } else
    {
    	$(".mytag").show();
    }
}