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

<div class="row pull-right container hidden-xs">
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
<div  class="col-md-12 voffset2 visible-sm">
</div>

<div  class="col-md-12 voffset4">
</div>

<div class="container ">
    <div  class="col-md-3">
        <ul class="nav nav-pills nav-stacked">
            <li class="{$selection_last}" style="display:inline;"><a href="{$BASE_URL}pages/lists/questions.php">Últimas</a></li>
            <li class="{$selection_hot}" style="display:inline;"><a href="{$BASE_URL}pages/lists/questions.php?param=hot">Quentes</a></li>
            {if $USERNAME}
                <li class="{$selection_subscription}" style="display:inline;"><a href="{$BASE_URL}pages/lists/questions.php?param=subscription">Subscritas</a></li>
            {/if}
            <li class="{$selection_tag}" style="display:inline;"><a href="{$BASE_URL}pages/lists/tags.php">Tags</a></li>
        </ul>
    </div>

    <div  class="col-md-9">
        <table class="table table-hover table-responsive ">
            {foreach $questions as $question}
                <tr>
                    <td class="col-md-1 col-sm-1 text-center">
                        <div class="row text-danger hidden-xs">{$question.score}</div>
                        <div class="row text-danger hidden-xs">votos</div>
                    </td>
                    <td class="col-md-2 col-sm-1 text-center text-muted">
                        <div class="row hidden-xs">{$question.numanswers}</div>
                        <div class="row hidden-xs hidden-sm">respostas</div>
                        <div class="row visible-sm">resp.</div>
                    </td>
                    <td class="col-md-8">
                        <div class="row"><a class="text-grey" href="{$BASE_URL}pages/questions/question.php?idQuestion={$question.idquestion}"><b>{$question.title}</b></a></div>
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
