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

<div class="container ">
    <div id="carousel-example-generic" class="carousel slide container" data-ride="carousel" style="padding:0;">

        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner text-center">
            <div class="item active">
                <img src="{$BASE_URL}images/1.png" alt="1" class="img-responsive" style="width:100%">
                <div class="carousel-caption">
                </div>
            </div>
            <div class="item">
                <img src="{$BASE_URL}images/2.png" alt="2" class="img-responsive" style="width:100%">
                <div class="carousel-caption">
                </div>
            </div>
            <div class="item">
                <img src="{$BASE_URL}images/3.png" alt="3" class="img-responsive" style="width:100%">
                <div class="carousel-caption">
                </div>
            </div>
        </div>
        <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>
</div>

<div class="container">
    <h2 class="voffset4 hidden-xs" style="margin-bottom: -35px;">Perguntas</h2>
    <ul class="nav nav-tabs ">
        <li class="active"><a href="#last" data-toggle="tab"><b>Últimas</b></a></li>
        <li><a href="#hot" data-toggle="tab"><b>Quentes</b></a></li>
        {if $USERNAME}
            <li><a href="#subscritas" data-toggle="tab"><b>Subscritas</b></a></li>
        {/if}
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane active" id="last">
            <div class="table-responsive">
                <table class="table table-hover table-responsive ">
                    {foreach $questions as $question}
                        <tr>
                            <td class="col-md-1 text-center ">
                                <div class="row text-danger hidden-xs">{$question.score}</div>
                                <div class="row text-danger hidden-xs">votos</div>
                            </td>
                            <td class="col-md-2 text-center text-muted">
                                <div class="row hidden-xs">{$question.numanswers}</div>
                                <div class="row hidden-xs">respostas</div>
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
            </div>

            <div class="text-center">
                <a href="#" class="btn btn-info">Ver mais</a>
            </div>
        </div>
        <div class="tab-pane" id="hot">
            <table class="table table-hover table-responsive ">
                {foreach $questions_hot as $question_hot}
                    <tr>
                        <td class="col-md-1 text-center">
                            <div class="row text-danger">{$question_hot.score}</div>
                            <div class="row text-danger">votos</div>
                        </td>
                        <td class="col-md-2 text-center text-muted">
                            <div class="row">{$question_hot.numanswers}</div>
                            <div class="row">respostas</div>
                        </td>
                        <td class="col-md-8">
                            <div class="row"><a class="text-grey" href="{$BASE_URL}pages/questions/question.php?idQuestion={$question_hot.idquestion}"><b>{$question_hot.title}</b></a></div>
                            <div class="row">
                                {foreach $question_hot.tags as $tag}
                                    <a href="{$BASE_URL}pages/lists/questions.php?tag={$tag.name}" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                                {/foreach}
                            </div>
                        </td>
                        <td class="col-md-1">
                            <div class="row">
                                <a class="" href="{$BASE_URL}pages/users/profile.php?username={$question_hot.username}">
                                    <b>{$question_hot.username}</b>
                                </a>
                            </div>
                            <div class="row">{$question_hot.date2}</div>
                        </td>
                    </tr>
                {/foreach}
            </table>

            <div class="text-center">
                <a href="#" class="btn btn-info">Ver mais</a>
            </div>
        </div>
        {if $USERNAME}
            <div class="tab-pane" id="subscritas">
                <table class="table table-hover table-responsive ">
                    {foreach $questions_subs as $question_subs}
                        <tr>
                            <td class="col-md-1 text-center">
                                <div class="row text-danger">{$question_subs.score}</div>
                                <div class="row text-danger">votos</div>
                            </td>
                            <td class="col-md-2 text-center text-muted">
                                <div class="row">{$question_subs.numanswers}</div>
                                <div class="row">respostas</div>
                            </td>
                            <td class="col-md-8">
                                <div class="row"><a class="text-grey" href="{$BASE_URL}pages/questions/question.php?idQuestion={$question_subs.idquestion}"><b>{$question_subs.title}</b></a></div>
                                <div class="row">
                                    {foreach $question_subs.tags as $tag}
                                        <a href="{$BASE_URL}pages/lists/questions.php?tag={$tag.name}" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                                    {/foreach}
                                </div>
                            </td>
                            <td class="col-md-1">
                                <div class="row">
                                    <a class="" href="{$BASE_URL}pages/users/profile.php?username={$question_subs.username}">
                                        <b>{$question_subs.username}</b>
                                    </a>
                                </div>
                                <div class="row">{$question_subs.date2}</div>
                            </td>
                        </tr>
                    {/foreach}
                </table>

                <div class="text-center">
                    <a href="#" class="btn btn-info">Ver mais</a>
                </div>
            </div>
        {/if}
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>

{include file='common/footer.tpl'}