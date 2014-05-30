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



<div class="container">
    <div class="panel panel-green text-center">
        <div class="panel-heading">
            <h3 class="panel-title">Utilizadores</h3>
        </div>
        <div class="panel-body">
            {if sizeof($users) == 0}
                <h4 class="">Não foram encontrados resultados.. :(</h4>
            {/if}
            {foreach $users as $user}
                <div  class="col-md-3">
                    <div class="panel panel-green">
                        <div class="panel-body">
                            <b><a href="{$BASE_URL}pages/users/profile.php?username={$user.username}">{$user.username}</a></b> - {$user.score} pts
                            <br><br>
                            <div class="btn-group">
                                <button type="button" class="btn btn-success">Promover</button>
                                <button type="button" class="btn btn-danger">Banir</button>
                            </div>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
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