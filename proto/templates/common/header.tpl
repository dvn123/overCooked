<!DOCTYPE html>
<html>
<head>
	<title>OverCooked</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="{$BASE_URL}css/bootstrap-3.1.1/css/bootstrap.css" rel="stylesheet">
	<link href="{$BASE_URL}css/styles.css" rel="stylesheet">
	<link href = "{$BASE_URL}css/custom.css" rel = "stylesheet">
</head>
<body>


<div class="navbar navbar-default navbar-static-top">
    <div class="container">

        <a href="{$BASE_URL}" class="navbar-brand"><img src="images/food-logo1.png"></a>


        <button class="navbar-toggle" data-toggle="collapse" data-target=".navHeaderCollapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>

        <div class="collapse navbar-collapse navHeaderCollapse">

            <ul class="nav navbar-nav navbar-right pull-left">

                <li class = "active"> <a href = "#"><span style="color:#7d094a;">over</span><span style="color:#a1a616;">Cooked</span></a></li>
                <li ><a href = "#">Fazer Pergunta</a></li>
                <li><a href = "#">Perguntas</a></li>
                <li><a href = "#">Tags</a></li>

            </ul>

		{if $USERNAME}
		{include file='common/menu_logged_in.tpl'}
		{else}
		{include file='common/menu_logged_out.tpl'}
		{/if}

        </div>

    </div>
</div>
