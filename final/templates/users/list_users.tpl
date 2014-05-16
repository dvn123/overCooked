{include file='common/header.tpl'}

<div class="container">
	<form class="navbar-form navbar-right" role="search" action="{$BASE_URL}pages/questions/search.php" method="get" accept-charset="UTF-8">
        <div class="right-inner-addon">
            <i class="glyphicon glyphicon-search"></i>
             <input name="content" type="search" class="form-control" placeholder="Pesquisar" />
        </div>
    </form>		
</div>

<div class="container">
<!--<div class="col-md-9 pull-right">
        <form class="navbar-form navbar-right" role="search" action="{$BASE_URL}pages/questions/search.php" method="get" accept-charset="UTF-8">
            <div class="right-inner-addon">
                <i class="glyphicon glyphicon-search"></i>
                <input name="content" type="search"
                       class="form-control"
                       placeholder="Pesquisar" />
            </div>
        </form>
		</div>--> 
	<div class="btn-group pull-right" data-toggle="buttons">
        <label class="btn btn-default active">
            <input type="radio" name="param" id="option1">Nome
        </label>
        <label class="btn btn-default">
            <input type="radio" name="param" id="option2">Pontuação
        </label>
        <label class="btn btn-default">
            <input type="radio" name="param" id="option3">Moderadores
        </label>
	</div>
</div>
<br>

<div class="container">
    <div class="panel panel-green">
        <div class="panel-body">
            {foreach $users as $user}
                <div  class="col-md-3">
                    <div class="panel panel-green">
                        <div class="panel-body">
							<div class="row">
								<div  class="col-md-3">
									{if $user.imagelink == null}
										<img src="{$BASE_URL}images/users/default.png" style="width:50px;height:50px;margin-top:0px;">
									{else}
										<img src="{$BASE_URL}images/users/{$user.imagelink}" style="width:50px;height:50px;margin-top:0px;">
									{/if}
								</div>
								<div  class="col-md-9">
									<b><span><a href="{$BASE_URL}pages/users/profile.php?username={$user.username}">{$user.username}</a></span></b><br>
									{if $user.country=='British Indian Ocean Territory'}
										British Indian O.T.
									{else if $user.country=='Democratic Republic of the Congo'}
										Democratic R. Congo
									{else if $user.country=='Saint Vincent and the Grenadines'}
										S. Vincent & Grenadines
									{else}
										{$user.country}
									{/if}
									<br>
									{$user.score}<br>
								</div>
							</div>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>

{include file='common/footer.tpl'}