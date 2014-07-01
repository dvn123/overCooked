{include file='common/header.tpl'}

<div class="container">
    <form class="navbar-form navbar-right" role="search" action="{$BASE_URL}pages/admin/list_users_admin.php" method="get" accept-charset="UTF-8">
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
            <label class="btn btn-default {$selection_ban}">
                <input type="radio" name="param" id="banned">Banidos
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
    <div class="panel panel-green text-center">
        <div class="panel-heading">
            <h3 class="panel-title">Utilizadores</h3>
        </div>
        <div class="panel-body">
            {if sizeof($users) == 0}
                <h4 class="">Não foram encontrados resultados... :(</h4>
            {/if}
            {foreach $users as $user}
                <div  class="col-md-3 col-sm-6 col-xs-12" id="{$user.username}">
                    <div class="panel panel-green">
                        <div class="panel-body">
                            <b><a href="{$BASE_URL}pages/users/profile.php?username={$user.username}">{$user.username}</a></b> - {$user.score} pts
                            <br><br>
                            <div class="btn-group">
                                {if $user.usergroup == 'moderator'}
                                    <button type="button" class="btn btn-warning promote">Despromover</button>
                                {else}
                                    <button type="button" class="btn btn-success promote">Promover</button>
                                {/if}
                                {if $user.banned == 'true'}
                                    <button type="button" class="btn btn-info ban">Desbanir</button>
                                {else}
                                    <button type="button" class="btn btn-danger ban">Banir</button>
                                {/if}

                            </div>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
    var BASE_URL = "{$BASE_URL}";
</script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/users_admin.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>
<script>

    $( document ).ready(function() {
        $('#admin').addClass('active');
        var location = "{$BASE_URL}pages/admin/list_users_admin.php";

        var type = "{$type}";
        var order = "{$order}";

        $('#asc, #desc').change(function(){
            order = $(this).attr("id");
            console.log(order + "  " + type);
            window.location = location + "?type=" + type + "&order=" + order;
        });

        $('#name, #score, #moderator, #banned').change(function(){
            type = $(this).attr("id");
            window.location = location + "?type=" + type + "&order=" + order;
        });

        $(".promote").click(function() {
            if ($(this).text() == "Despromover")
            {
                var username=$(this).parent().parent().parent().parent().attr('id');
                relegateUser(username, $(this));
            }
            else
            {
                var username=$(this).parent().parent().parent().parent().attr('id');
                promoteUser(username, $(this));
            }
        });

        $(".ban").click(function() {
            if ($(this).text() == "Desbanir")
            {
                var username=$(this).parent().parent().parent().parent().attr('id');
                acceptUser(username, $(this));
            }
            else
            {
                var username=$(this).parent().parent().parent().parent().attr('id');
                banUser(username, $(this));
            }
        });
    });
</script>

{include file='common/footer.tpl'}