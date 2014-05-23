{include file='common/header.tpl'}

<div class="container">
    <form class="navbar-form navbar-right" role="search" action="{$BASE_URL}pages/users/list_users.php" method="get" accept-charset="UTF-8">
        <div class="right-inner-addon">
            <i class="glyphicon glyphicon-search"></i>
            <input name="content" type="search" class="form-control" placeholder="Pesquisar" />
        </div>
    </form>
</div>

<div class="container">
    <div class="row pull-right ">
        <div class="btn-group" data-toggle="buttons">
            <label class="btn btn-default {$selection_name}">
                <input type="radio" name="param" id="name">Nome
            </label>
            <label class="btn btn-default {$selection_score}">
                <input type="radio" name="param" id="score">Pontuação
            </label>
            <label class="btn btn-default {$selection_mod}">
                <input type="radio" name="param" id="moderator">Moderadores
            </label>
        </div>
        <div id="order" class="btn-group" data-toggle="buttons"">
            <label class="btn btn-default {$selection_down}" id="desc1">
                <input type="radio" name="order" id="desc"><span class="glyphicon glyphicon-chevron-down"></span>
            </label>
            <label class="btn btn-default {$selection_up}" id="asc1">
                <input type="radio" name="order" id="asc"><span class="glyphicon glyphicon-chevron-up"></span>
            </label>
        </div>
        <div  class="col-md-1 pull-right"></div>
    </div>
</div>
<br>

{if sizeof($users) == 0}
<div class="container">
    <h4 class="col-md-5">Não foram encontrados resultados.. :(</h4>
</div>
{else}

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
{/if}
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>
<script>

    $( document ).ready(function() {
        var location = "{$BASE_URL}pages/users/list_users.php";

        var type = "{$type}";
        var order = "{$order}";

        $('#asc, #desc').change(function(){
            order = $(this).attr("id");
            console.log(order + "  " + type);
            window.location = location + "?type=" + type + "&order=" + order;
        });

        $('#name, #score, #moderator').change(function(){
            type = $(this).attr("id");
            window.location = location + "?type=" + type + "&order=" + order;
        });
    });
</script>

{include file='common/footer.tpl'}