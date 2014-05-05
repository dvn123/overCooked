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
    <!--<div  class="col-md-3">
        <ul class="nav nav-pills nav-stacked">
            <li class="active" style="display:inline;"><a href="#">Últimas</a></li>
            <li style="display:inline;"><a href="#">Quentes</a></li>
            <li class = "dropdown" style="display:inline;">
                <a href = "#" class = "dropdown-toggle" data-toggle = "dropdown">Por tag<b class="caret"></b></a>
                <ul class = "dropdown-menu">
                    <li><a href = "#">vegetariano</a></li>
                    <li><a href = "#">arroz</a></li>
                    <li><a href = "#">cozinhaRapida</a></li>
                    <li><a href = "#">bimby</a></li>
                </ul>
            </li>
        </ul>
    </div>-->
    <div class="row pull-right container">
        <div class="col-md-8">

        </div>
        <!--<div class="btn-group col-md-4" role="param">
            <button type="button" class="btn btn-default">Data</button>
            <button type="button" class="btn btn-default">Pontuação</button>
            <button type="button" class="btn btn-default">Nº Respostas</button>
        </div> -->
        <div id="param" class="btn-group" data-toggle="buttons">
            <label class="btn btn-default active">
                <input type="radio" name="param" id="option1">Data
            </label>
            <label class="btn btn-default">
                <input type="radio" name="param" id="option2">Pontuação
            </label>
            <label class="btn btn-default">
                <input type="radio" name="param" id="option3">Nº Respostas
            </label>
        </div>
        <!--
        <div class="btn-group col-md-2" role="order">
            <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-chevron-up"></span></button>
            <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-chevron-down"></span></button>
        </div>-->
        <div id="order" class="btn-group" data-toggle="buttons">
            <label class="btn btn-default active">
                <input type="radio" name="order" id="period1"><span class="glyphicon glyphicon-chevron-down"></span>
            </label>
            <label class="btn btn-default">
                <input type="radio" name="order" id="period2"><span class="glyphicon glyphicon-chevron-up"></span>
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
                            <div class="row"><b>{$question.title}</b></div>
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



<script src="{$BASE_URL}javascript/main.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>

{include file='common/footer.tpl'}