{include file='common/header.tpl'}

<div class="container">
    <div class="panel panel-green">
        <div class="panel-heading">
            <h3 class="panel-title">Informação pessoal</h3>
        </div>
        <div class="panel-body">
            <h2 class="col-lg-12">{$profile_data.username}</h2>
            <div class="col-lg-4 ">
                <div class="text-center" >
                    {if $profile_data.imagelink == null}
                        <img src="{$BASE_URL}images/default.png" style="width:100px;height:100px; margin: auto auto;">
                    {else}
                        <img src="{$BASE_URL}images/users/{$profile_data.imagelink}" style="width:100px;height:100px; margin: auto auto;">
                    {/if}
                </div>

                <div class="text-center">
                    <p class="text-danger"><b>Pontuação:</b> {$profile_data.score} </p>
                    <table class="table-responsive table text-center">
                        <tr>
                            <td><b>Perguntas</b></td>
                            <td><b>Respostas</b></td>
                            <td><b>Comentários</b></td>
                        </tr>
                        <tr>
                            <td>{$profile_data.numquestions} </td>
                            <td>{$profile_data.numanswers}</td>
                            <td>{$profile_data.numcomments}</td>
                        </tr>

                    </table>
                </div>
            </div>

            {if $USERNAME==$profile_data.username}
                {include file='users/private_profile.tpl'}
            {/if}

            <div class="col-lg-4">
                <div id="public"> <!--class="voffset4"-->
                    <p><b>Data de registo: </b>{$profile_data.registrationdate} </p>
                    <p><b>País: </b>{$profile_data.country}</p>
                    <p><b>Sobre: </b></p>
                    <p class="text-justify">{$profile_data.about}</p>
                </div>
            </div>

            {if $USERNAME==$profile_data.username}
                {include file='users/edit_button.tpl'}
            {/if}

        </div>
    </div>
</div>
</div>

<div class="container" >
    <div class="panel panel-green">
        <div class="panel-heading">
            <h3 class="panel-title">Perguntas & Respostas</h3>
        </div>
        <div class="panel-body">
            <ul class="nav nav-tabs ">
                <li><a href="#subscribed" data-toggle="tab"><b>Subscritas</b></a></li>
                <li class="active"><a href="#asked" data-toggle="tab"><b>Colocadas</b></a></li>
                <li><a href="#answered" data-toggle="tab"><b>Participadas</b></a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane " id="subscribed">
                    <table class="table table-hover table-responsive ">
                        {foreach $questions_subscribed as $question_subscribed}
                            <tr>
                                <td class="col-md-1 text-center">
                                    <div class="row text-danger">{$question_subscribed.score}</div>
                                    <div class="row text-danger">votos</div>
                                </td>
                                <td class="col-md-2 text-center text-muted">
                                    <div class="row">{$question_subscribed.numanswers}</div>
                                    <div class="row">respostas</div>
                                </td>
                                <td>
                                    <div class="row"><b>{$question_subscribed.title}</b></div>
                                    <div class="row">
                                        {foreach $question_subscribed.tags as $tag}
                                            <a href="#" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                                        {/foreach}
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                    <!--<div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>-->
                </div>
                <div class="tab-pane active" id="asked">
                    <table class="table table-hover table-responsive ">
                        {foreach $questions_asked as $question_asked}
                            <tr>
                                <td class="col-md-1 text-center">
                                    <div class="row text-danger">{$question_asked.score}</div>
                                    <div class="row text-danger">votos</div>
                                </td>
                                <td class="col-md-2 text-center text-muted">
                                    <div class="row">{$question_asked.numanswers}</div>
                                    <div class="row">respostas</div>
                                </td>
                                <td>
                                    <div class="row"><b>{$question_asked.title}</b></div>
                                    <div class="row">
                                        {foreach $question_asked.tags as $tag}
                                            <a href="#" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                                        {/foreach}
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                    <!--<div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>-->
                </div>
                <div class="tab-pane " id="answered">
                    <table class="table table-hover table-responsive ">
                        {foreach $questions_answered as $question_answered}
                            <tr>
                                <td class="col-md-1 text-center">
                                    <div class="row text-danger">{$question_answered.score}</div>
                                    <div class="row text-danger">votos</div>
                                </td>
                                <td class="col-md-2 text-center text-muted">
                                    <div class="row">{$question_answered.numanswers}</div>
                                    <div class="row">respostas</div>
                                </td>
                                <td>
                                    <div class="row"><b>{$question_answered.title}</b></div>
                                    <div class="row">
                                        {foreach $question_answered.tags as $tag}
                                            <a href="#" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                                        {/foreach}
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                    <!--<div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>-->
                </div>
            </div>
        </div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>

{include file='common/footer.tpl'}