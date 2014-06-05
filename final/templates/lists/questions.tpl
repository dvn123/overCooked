{include file='common/header.tpl'}

<div class="container">
    <div  class="pull-right">
        <form class="navbar-form navbar-right" role="search" action="{$BASE_URL}pages/questions/search.php" method="get" accept-charset="UTF-8">
            <div class="right-inner-addon">
                <i class="glyphicon glyphicon-search"></i>
                <input name="content" type="search"
                       class="form-control"
                       placeholder="Pesquisar" />
            </div>
        </form>
    </div>
</div>
<br>

<div class="row pull-right container">
    <div class="col-md-7">

    </div>

    <div id="param" class="btn-group" data-toggle="buttons">
        <label class="btn btn-default {$selection_date}">
            <input type="radio" name="param" id="date">Data
        </label>
        <label class="btn btn-default {$selection_score}">
            <input type="radio" name="param" id="score">Pontuação
        </label>
        <label class="btn btn-default {$selection_answers}">
            <input type="radio" name="param" id="answers">Nº Respostas
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


</div>

<div  class="col-md-12 voffset4">
</div>

<div class="container">
    <div  class="col-md-3">
        <ul class="nav nav-pills nav-stacked">
            <li class="{$selection_last}" style="display:inline;"><a href="{$BASE_URL}pages/lists/questions.php">Últimas</a></li>
            <li class="{$selection_hot}" style="display:inline;"><a href="{$BASE_URL}pages/lists/questions.php?param=hot">Quentes</a></li>
            {if $USERNAME}
                <li class="{$selection_subscription}" style="display:inline;"><a href="{$BASE_URL}pages/lists/questions.php?param=subscription">Subscritas</a></li>
            {/if}
            <li class="{$selection_tag}" style="display:inline;"><a href="{$BASE_URL}pages/lists/tags.php">Tags</a></li>
            <!--<li class = "dropdown" style="display:inline;">
                <a href = "#" class = "dropdown-toggle" data-toggle = "dropdown">Por tag<b class="caret"></b></a>
                <ul class = "dropdown-menu">
                    <li><a href = "#">vegetariano</a></li>
                    <li><a href = "#">arroz</a></li>
                    <li><a href = "#">cozinhaRapida</a></li>
                    <li><a href = "#">bimby</a></li>
                </ul>
            </li> -->
        </ul>
    </div>

    <div  class="col-md-9">
        <table class="table table-hover table-responsive ">
            {foreach $questions as $question}
                <tr>
                    <td class="col-md-1 text-center">
                        <div class="row text-danger hidden-xs">{$question.score}</div>
                        <div class="row text-danger hidden-xs">votos</div>
                    </td>
                    <td class="col-md-2 text-center text-muted">
                        <div class="row hidden-xs">{$question.numanswers}</div>
                        <div class="row hidden-xs">respostas</div>
                    </td>
                    <td class="col-md-8">
                        <div class="row"><a class="text-grey"href="{$BASE_URL}pages/questions/question.php?idQuestion={$question.idquestion}"><b>{$question.title}</b></a></div>
                        <div class="row">
                            {foreach $question.tags as $tag}
                                <a href="{$BASE_URL}pages/lists/questions.php?tag={$tag.name}" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                            {/foreach}
                        </div>
                    </td>
                    <td class="col-md-1">
                        <div class="row">
                            <a class="" href="{$BASE_URL}pages/users/profile.php?username={$question.username}">
                                <b>{$question.username}</b>
                            </a>
                        </div>
                        <div class="row">{$question.date2}</div>
                    </td>
                </tr>
            {/foreach}
        </table>

        <div class="text-center">
            <ul class="pagination">
                <li class="{if $page == 1}disabled{/if}"><a {if $page != 1}href="{$BASE_URL}pages/lists/questions.php?param={$param}&type={$type}&order={$order}&page={$page-1}"{/if}>&laquo;</a></li>
                {for $i =1 to $total_pages}
                    {if $i == $page}
                        <li class="active" ><a href="{$BASE_URL}pages/lists/questions.php?param={$param}&type={$type}&order={$order}&page={$i}">{$i}</a></li>
                    {else}
                        <li><a href="{$BASE_URL}pages/lists/questions.php?param={$param}&type={$type}&order={$order}&page={$i}">{$i}</a></li>
                    {/if}
                {/for}
                <li class="{if $page+1 > $total_pages}disabled{/if}"><a {if $page+1 <= $total_pages}href="{$BASE_URL}pages/lists/questions.php?param={$param}&type={$type}&order={$order}&page={$page+1}"{/if}>&raquo;</a></li>
            </ul>
        </div>


    </div>
</div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Registar</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="inputName" class="col-sm-2 control-label">Nome</label>

                        <div class="col-sm-10">
                            <input type="name" class="form-control" id="inputName" placeholder="Nome Completo">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-sm-2 control-label">Email</label>

                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="inputEmail" placeholder="Email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-2 control-label">Password</label>

                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="inputPassword" placeholder="Password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCountry" class="col-sm-2 control-label">País</label>

                        <div class="col-sm-10">
                            <input type="dropdown" class="form-control" id="inputCountry" placeholder="País">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCity" class="col-sm-2 control-label">Cidade</label>

                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="inputCity" placeholder="Cidade">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-primary">Regista-te!</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>
<script>

    $( document ).ready(function() {
        $('#questions').addClass('active');

        var location = "{$BASE_URL}pages/lists/questions.php";
        var getvars = "{$get}";
        var type = "{$type}";
        var order = "{$order}";


        $('#asc, #desc').change(function(){
            order = $(this).attr("id");
            console.log(order + "  " + type);
            window.location = location + "?param=" + getvars + "&type=" + type + "&order=" + order;
        });

        $('#date, #answers, #score').change(function(){
            type = $(this).attr("id");
            console.log(order + "  " + type);
            window.location = location + "?param=" + getvars + "&type=" + type + "&order=" + order;
        });
    });
</script>

{include file='common/footer.tpl'}
