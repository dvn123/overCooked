function voteQuestion(idQuestion, updown)
{
	var oldvalue = 0;
	if($("#questionUP").hasClass("active"))
		oldvalue = 1;
	else if($("#questionDOWN").hasClass("active"))
		oldvalue = -1;

	var value = -10;

	if(updown == 1)
	{
		if(oldvalue == 1)
		{
			value = 0;
		} else value = 1;
	} else if (updown = -1)
	{
		if(oldvalue == -1)
		{
			value = 0;
		} else value = -1;
	}

	if(value == -10)
	{
		console.log("Error voting");
		return;
	}

	$.post( BASE_URL + "api/questions/insertvotequestion.php", {"idQuestion" : idQuestion, "value" : value},function( data ) {

		if(data == '200')
		{
			$("#questionUP").removeClass("active");
			$("#questionDOWN").removeClass("active");
			if(value == 1)
				$("#questionUP").addClass("active");
			else if (value == -1)
				$("#questionDOWN").addClass("active");
			var dif = Number(value)-Number(oldvalue);
			$("#questionScore").text(Number($("#questionScore").text())+Number(dif));
		} else 
		console.log("Error voting 2");

	}
	);
}

function voteAnswer(idAnswer, updown)
{
	var oldvalue = 0;
	if($("#answerUP"+idAnswer).hasClass("active"))
		oldvalue = 1;
	else if($("#answerDOWN"+idAnswer).hasClass("active"))
		oldvalue = -1;

	var value = -10;

	if(updown == 1)
	{
		if(oldvalue == 1)
		{
			value = 0;
		} else value = 1;
	} else if (updown = -1)
	{
		if(oldvalue == -1)
		{
			value = 0;
		} else value = -1;
	}

	if(value == -10)
	{
		console.log("Error voting answer");
		return;
	}

	$.post( BASE_URL + "api/questions/insertvoteanswer.php", {"idAnswer" : idAnswer, "value" : value},function( data ) {

		if(data == '200')
		{
			$("#answerUP"+idAnswer).removeClass("active");
			$("#answerDOWN"+idAnswer).removeClass("active");
			if(value == 1)
				$("#answerUP"+idAnswer).addClass("active");
			else if (value == -1)
				$("#answerDOWN"+idAnswer).addClass("active");
			var dif = Number(value)-Number(oldvalue);
			console.log(dif);
			$("#answerscore"+idAnswer).text(Number($("#answerscore"+idAnswer).text())+dif);
		} else 
		console.log("Error voting answer 2");

	}
	);
}

function pinquestion(idQuestion)
{
	var value = 0;

	//is not set before clicking
	if(!$("#questionpin").hasClass("active"))
		value = 1; //set

	$.post( BASE_URL + "api/questions/pinquestion.php", {"idQuestion" : idQuestion, "value" : value},function( data ) {

		if(data == '200')
		{
			$("#questionpin").toggleClass("active");
		} else 
		console.log("Error pin");
	});
}

function bestAnswer(idAnswer)
{
	var value = 0;

	//is not set before clicking
	if(!$("#bestanswer"+idAnswer).hasClass("active"))
		value = 1; //set

	$.post( BASE_URL + "api/questions/setbestanswer.php", {"idAnswer" : idAnswer, "value" : value},function( data ) {

		if(data == '200')
		{
			$(".bestanswer").removeClass("active");
			$(".bestanswer").removeClass("btn-success");
			if(value==1)
			{
				$("#bestanswer"+idAnswer).addClass("active");
				$("#bestanswer"+idAnswer).addClass("btn-success");
			}
		} else 
		console.log("Error best answer");
	});

}