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

            <!-- <button type="submit" class="btn btn-default">
                <span class="glyphicon glyphicon-search"></span>
                Pesquisa
                <div class="form-group">
                    <input name="content" type="text" class="form-control">
                </div>
            </button> -->
        </form>
    </div>
</div>

<div class="container">
    {if sizeof($questions) == 1}
        <h3 class="col-md-3">{sizeof($questions)} resultado</h3>
    {else}
        <h3 class="col-md-3">{sizeof($questions)} resultados</h3>
    {/if}

</div>
<div class="container voffset4">

    <div class="row pull-right container">
        <div class="col-md-8">

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



        <div class="panel panel-green">
            <table class="table table-hover table-responsive ">
                {foreach $questions as $question}
                    <tr>
                        <td class="col-md-1 text-center">
                            <div class="row text-danger">{$question.score}</div>
                            <div class="row text-danger">votos</div>
                        </td>
                        <td class="col-md-2 text-center text-muted">
                            <div class="row">{$question.numanswers1}</div>
                            <div class="row">respostas</div>
                        </td>
                        <td class="col-md-8">
                            <div class="row"><a class="text-grey"href="{$BASE_URL}pages/questions/question.php?idQuestion={$question.idquestion}"><b>{$question.title}</b></a></div>
                            <div class="row">
                                {foreach $question.tags as $tag}
                                    <a href="#" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
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
        </div>
    </div>
</div>




<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>
<script>

    $( document ).ready(function() {
        var location = "{$BASE_URL}pages/questions/search.php";
        var getvars = "{$get}";
        var type = "{$type}";
        var order = "{$order}";


        $('#asc, #desc').change(function(){
            order = $(this).attr("id");
            console.log(order + "  " + type);
            window.location = location + "?content=" + getvars + "&type=" + type + "&order=" + order;
        });

        $('#date, #answers, #score').change(function(){
            type = $(this).attr("id");
            console.log(order + "  " + type);
            window.location = location + "?content=" + getvars + "&type=" + type + "&order=" + order;
        });
    });
</script>

{include file='common/footer.tpl'}