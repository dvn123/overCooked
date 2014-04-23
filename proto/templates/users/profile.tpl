{include file='common/header.tpl'}

<div class="container">
    <div class="panel panel-green">
        <div class="panel-heading">
            <h3 class="panel-title">Área pessoal</h3>
        </div>
        <div class="panel-body">
            <h2 class="col-lg-12">{$profile_data.username}</h2>
            <div class="col-lg-4 ">
                <div class="text-center" >
                    <img src="images/default.png" style="width:100px;height:100px; margin: auto auto;">
                </div>

                <div class="text-center">
                    <p><b>Data de registo</b>: {$profile_data.registrationdate} </p>
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

            <div class="col-lg-4">
                <h4 class="text-center text-pink">Privado</h4>
                <div class="voffset4">
                    <p><b>Nome:</b>{$profile_data.name}</p>
                    <p><b>Data de nascimento:</b> {$profile_data.birthdate}</p>

                    <p><b>Cidade:</b> {$profile_data.city}</p>
                    <p><b>Email:</b> {$profile_data.email}</p>
                </div>
                <br>
            </div>

            <div class="col-lg-4">
                <h4 class="text-center text-pink">Público</h4>
                <div id="about" class="voffset4">

                    <p><b>País:</b> {$profile_data.country}</p>
                    <p><b>Sobre:</b></p>
                    <p class="text-justify">{$profile_data.about}</p>
                </div>

            </div>
            <div class="text-center row col-lg-12">
                <a href="#" class="btn btn-default">Editar</a>
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
                <li><a href="#asked" data-toggle="tab"><b>Colocadas</b></a></li>
                <li><a href="#answered" data-toggle="tab"><b>Participei</b></a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active" id="subscribed">
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
                        {/foreach}

                    </table>
                    <div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane" id="asked">
                    <table class="table table-hover table-responsive ">
                      hhjj  {var_dump($questions_asked)}hhhh
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
                    <div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane" id="answered">
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
                    <div class="text-center">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include file='common/footer.tpl'}