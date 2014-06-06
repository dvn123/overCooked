{include file='common/header.tpl'}

<div class="container">
    <div class="navbar-form navbar-right" role="search" accept-charset="UTF-8">
        <div class="right-inner-addon">
            <i class="glyphicon glyphicon-search"></i>
            <input id="search" name="content" type="search" class="form-control" placeholder="Pesquisar" {if isset($content)} value="{$content}"{/if} autocomplete="off"/>
        </div>
    </div>
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
        <div id="order" class="btn-group" data-toggle="buttons">
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

<div class="container">
    <div class="panel panel-green">
        <div class="panel-body">
            {foreach $users as $user}
                <div user="{$user.username}" class="col-md-3 col-sm-4 col-xs-6 myuser">
                    <div class="panel panel-green">
                        <div class="panel-body">
							<div class="row">
								<div  class="col-sm-3">
									{if $user.imagelink == null}
										<img src="{$BASE_URL}images/users/default.png" alt="user profile picture" style="width:50px;height:50px;margin-top:0px;">
									{else}
										<img src="{$BASE_URL}images/users/{$user.imagelink}" alt="user profile picture" style="width:50px;height:50px;margin-top:0px;">
									{/if}
								</div>
								<div class="col-sm-9">
								<div  class="col-sm-9">
									<b><span><a href="{$BASE_URL}pages/users/profile.php?username={$user.username}">{$user.username}</a></span></b><br>
									{if $user.country=='British Indian Ocean Territory'}
										British Indian O.T.
									{else if $user.country=='Democratic Republic of the Congo'}
										D. R. Congo
									{else if $user.country=='Saint Vincent and the Grenadines'}
										S. Vincent & Grenadines
                                    {else if $user.country=='Central African Republic'}
                                        Cent. African R.
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

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>
<script src="{$BASE_URL}javascript/list_users.js"></script>
<script>

    $( document ).ready(function() {
        var location = "{$BASE_URL}pages/users/list_users.php";

        var type = "{$type}";
        var order = "{$order}";

        $('#asc, #desc').change(function(){
            order = $(this).attr("id");
            console.log(order + "  " + type);
            var url = location + "?type=" + type + "&order=" + order;
            var srch = $("#search").val();
            if(srch && srch!="")
                window.location = url + "&content=" + srch;
            else window.location = url;
        });

        $('#name, #score, #moderator').change(function(){
            type = $(this).attr("id");
            var url = location + "?type=" + type + "&order=" + order;
            var srch = $("#search").val();
            if(srch && srch!="")
                window.location = url + "&content=" + srch;
            else window.location = url;
        });

        console.log("." +$("#list_users") + ".");
        $('#list_users').addClass('active');

    });
</script>

{include file='common/footer.tpl'}