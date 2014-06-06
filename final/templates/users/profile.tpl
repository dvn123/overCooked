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
                        <img src="{$BASE_URL}images/users/default.png" style="width:100px;height:100px; margin: auto auto;">
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
                    <p><b>Grupo: </b>
                        {if $profile_data.usergroup=='user'}
                            utilizador registado
                         {else if $profile_data.usergroup=='moderator'}
                            moderador
                         {else}
                            administrador
                        {/if}</p>
                    <p><b>Data de registo: </b>{$profile_data.registrationdate} </p>
                    <p><b>País: </b>{$profile_data.country}</p>
                    <p><b>Sobre: </b></p>
                    <p class="text-justify">{$profile_data.about}</p>
                </div>
            </div>

            {if $USERNAME==$profile_data.username}
                <div class="text-center row col-lg-12">
                    <a href="{$BASE_URL}pages/users/edit_profile.php?username={$username_edit}" class="btn btn-default">Editar perfil</a>
                    <a href="{$BASE_URL}pages/users/edit_password.php?username={$username_edit}" class="btn btn-default">Alterar password</a>
                </div>
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
                <li class="active"><a href="#asked" data-toggle="tab"><b>Colocadas</b></a></li>
                <li><a href="#answered" data-toggle="tab"><b>Participadas</b></a></li>
				{if $USERNAME==$profile_data.username}
					<li><a href="#subscribed" data-toggle="tab"><b>Subscritas</b></a></li>
				{/if}
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
				{if $USERNAME==$profile_data.username}
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
									<td class="col-md-8">
										<div class="row"><a class="text-grey" href="{$BASE_URL}pages/questions/question.php?idQuestion={$question_subscribed.idquestion}"><b>{$question_subscribed.title}</b></a></div>
										<div class="row">
											{foreach $question_subscribed.tags as $tag}
												<a href="{$BASE_URL}pages/lists/questions.php?tag={$tag.name}" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
											{/foreach}
										</div>
									</td>
									<td class="col-md-1">
										<div class="row">
											<a class="" href="{$BASE_URL}pages/users/profile.php?username={$question_subscribed.username}">
												<b>{$question_subscribed.username}</b>
											</a>
										</div>
										<div class="row">{$question_subscribed.date2}</div>
									</td>
								</tr>
							{/foreach}
						</table>
					</div>
				{/if}
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
                                <td class="col-md-8">
                                    <div class="row"><a class="text-grey" href="{$BASE_URL}pages/questions/question.php?idQuestion={$question_asked.idquestion}"><b>{$question_asked.title}</b></a></div>
                                    <div class="row">
                                        {foreach $question_asked.tags as $tag}
                                            <a href="{$BASE_URL}pages/lists/questions.php?tag={$tag.name}" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                                        {/foreach}
                                    </div>
                                </td>
                                <td class="col-md-1">
                                    <div class="row">
                                        <a class="" href="{$BASE_URL}pages/users/profile.php?username={$question_asked.username}">
                                            <b>{$question_asked.username}</b>
                                        </a>
                                    </div>
                                    <div class="row">{$question_asked.date2}</div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
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
                                <td class="col-md-8">
                                    <div class="row"><a class="text-grey"href="{$BASE_URL}pages/questions/question.php?idQuestion={$question_answered.idquestion}"><b>{$question_answered.title}</b></a></div>
                                    <div class="row">
                                        {foreach $question_answered.tags as $tag}
                                            <a href="{$BASE_URL}pages/lists/questions.php?tag={$tag.name}" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                                        {/foreach}
                                    </div>
                                </td>
                                <td class="col-md-1">
                                    <div class="row">
                                        <a class="" href="{$BASE_URL}pages/users/profile.php?username={$question_answered.username}">
                                            <b>{$question_answered.username}</b>
                                        </a>
                                    </div>
                                    <div class="row">{$question_answered.date2}</div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>

{include file='common/footer.tpl'}