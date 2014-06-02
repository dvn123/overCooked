<!DOCTYPE html>
<html>
<head>
    <title>OverCooked</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="{$BASE_URL}css/bootstrap-3.1.1/css/bootstrap.css" rel="stylesheet">
    <link href="{$BASE_URL}css/styles.css" rel="stylesheet">
    <link href = "{$BASE_URL}css/custom.css" rel = "stylesheet">
    <link rel="shortcut icon" href="../../images/logo.ico">
</head>
<body>

<div class="navbar navbar-default navbar-static-top">
    <div class="container">
        <a href="{$BASE_URL}" class="navbar-brand"><img src="{$BASE_URL}images/food-logo1.png"></a>
        <button class="navbar-toggle" data-toggle="collapse" data-target=".navHeaderCollapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <div class="collapse navbar-collapse navHeaderCollapse">
            <ul class="nav navbar-nav navbar-right pull-left">
                <li id="askquestion" ><a href = "{$BASE_URL}pages/questions/askquestion.php">Fazer Pergunta</a></li>
                <li id="questions" ><a href = "#">Perguntas</a></li>
                <li id="tags"><a href = "{$BASE_URL}pages/lists/tags.php">Tags</a></li>
                <li id="list_users"><a href = "{$BASE_URL}pages/users/list_users.php">Utilizadores</a></li>
                {if $USERGROUP == 'admin'}
                    <li id="admin" class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Administração<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="{$BASE_URL}pages/admin/list_users_admin.php">Gerir utilizadores</a></li>
                            <li><a href="{$BASE_URL}pages/admin/statistics.php">Estatísticas</a></li>
                        </ul>
                    </li>
                {/if}
            </ul>
            {if $USERNAME}
                {include file='common/menu_logged_in.tpl'}
            {else}
                {include file='common/menu_logged_out.tpl'}
            {/if}
        </div>
    </div>
</div>

<div id="error_messages">
    {foreach $ERROR_MESSAGES as $error}
        <div class="container">
            <div class="alert alert-danger fade in">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                {$error}
            </div>
        </div>
    {/foreach}
</div>
<div id="success_messages">
    {foreach $SUCCESS_MESSAGES as $success}
        <div class="container">
            <div class="alert alert-success fade in">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                {$success}
            </div>
        </div>
    {/foreach}
</div>
