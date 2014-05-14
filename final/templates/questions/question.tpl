{include file='common/header.tpl'}



<div class="question container center col-md-8 col-md-offset-1">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
                {$question.title}
                <div class="pull-right panel panel-default">
                <div class="panel-body"><img src="{$question.userphoto}" style="width:50px;height:50px;margin-top:0px;"> </img><a href="{$question.userlink}">{$question.username}</a> <span class="badge">{$question.userpoints} pts</span>
                    </div>
                </div>
            </h3>
        </div>
        <div class="panel-body">

            <div class="col-xs-1">
                <button type="button" class="btn btn-default btn-md {if $question.vote eq '1'} active{/if}" style="min-width:50px;">
                    <span class="glyphicon glyphicon-chevron-up"></span>
                </button>
                <div class="text-center btn btn-default disabled" style="min-width:50px;">{$question.score}</div>
                <button type="button" class="btn btn-default btn-md {if $question.vote eq '-1'} active{/if}" style="min-width:50px;">
                    <span class="glyphicon glyphicon-chevron-down"></span>
                </button>
                <button type="button" class="btn btn-default btn-md{if $question.subscribed eq '1'} active{/if}" style="min-width:50px;">
                    <span class="glyphicon glyphicon-pushpin"></span>
                </button>
            </div>
            <div class="col-xs-8 col-md-11 col-md-offset-0 col-xs-offset-1">
                {$question.html}<br/><br/><small>{$question.date}</small>
            </div>
            <div class="col-xs-11 col-xs-offset-1">
            	{foreach $question.tags as $tag}
                <a href="#" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                {/foreach}
                <!--<button type="button" class="comment-button-question btn btn-default btn-md col-xs-offset-7" style="position: absolute;bottom: 30px; right:45px;min-width:50px;min-width:50px;">
                    Comment
                </button>
                <button type="button" class="answer-button btn btn-default btn-md" style="position: absolute;bottom: 30px; right:135px;min-width:50px;min-width:50px;">
                    Answer
                </button>-->

            </div>
            {foreach $question.comments as $comment}
            <div class="highlight col-xs-11 col-xs-offset-1"
            style="margin-top:10px; padding-top:5px; background-color:LightGrey;">
            <p>{$comment.content}<small> - <a href="{$comment.userlink}">{$comment.username}</a>, {$comment.date}</small></p> 
        </div>
        {/foreach}
    </div>
</div>
</div>

<div class="container col-md-8 col-md-offset-1">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">{$question.numanswers} resposta{if $question.numanswers != '1'}s{/if}</h3>
        </div>
        <div class="panel-body">
            {foreach $question.answers as $answer}
            <div class="container col-md-12">
                <div class="panel panel-default">

                    <div class="panel-body">
                       <!-- <button type="button" class="comment-button btn btn-default btn-md" style="position: absolute;bottom: 30px; right:45px;min-width:50px;">
                            Comment
                        </button>-->

                        <div class="col-xs-1">
                            {if $answer.bestanswer eq 'true'}
                            <button type="button" class="btn btn-success btn-md{if $question.owner eq true} active{else} disabled{/if}"
                            style="min-width:50px; margin-bottom:10px;">
                            <span class="glyphicon glyphicon-ok"></span>
                        </button>
                        {/if}
                        <button type="button" class="btn btn-default btn-md{if $answer.vote eq '1'} active{/if}" style="min-width:50px;">
                            <span class="glyphicon glyphicon-chevron-up"></span>
                        </button>
                        <div class="text-center btn btn-default disabled" style="min-width:50px;">{$answer.score}</div>
                        <button type="button" class="btn btn-default btn-md{if $answer.vote eq '-1'} active{/if}" style="min-width:50px;">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                        </button>

                    </div>


                    <div class="col-xs-8 col-md-11 col-md-offset-0 col-xs-offset-1">
                        <div class="panel panel-default" style="float:right;">
                            <div class="panel-body"><img src="{$answer.userphoto}" style="width:30px;height:30px;margin-top:0px;"> <a href="{$answer.userlink}">{$answer.username}</a>
                                <span class="badge">{$answer.userpoints} pts</span>
                            </div>
                        </div>
                        <br/>{$answer.html}<br/><br/><small>{$answer.date}</small>

                    </div>
                    {foreach $answer.comments as $acomment}
                    <div class="highlight col-xs-11 col-xs-offset-1"
                    style="margin-top:10px; padding-top:5px; background-color:LightGrey;">
                    <p>{$acomment.content}<small> - <a href="{$acomment.userlink}">{$acomment.username}</a>, {$acomment.date}</small></p> 
                </div>
                {/foreach}

            </div>
        </div>
    </div>
    {/foreach}
<!----
            <div class="container col-md-12">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <button type="button" class="comment-button btn btn-default btn-md" style="position: absolute;bottom: 30px; right:45px;min-width:50px;">
                            Comment
                        </button>

                        <div class="col-xs-1">
                            <button type="button" class="btn btn-default btn-md" style="min-width:50px;">
                                <span class="glyphicon glyphicon-chevron-up"></span>
                            </button>
                            <div class="text-center btn btn-default disabled" style="min-width:50px;">0</div>
                            <button type="button" class="btn btn-default btn-md" style="min-width:50px;">
                                <span class="glyphicon glyphicon-chevron-down"></span>
                            </button>
                        </div>
                        <div class="col-xs-8 col-md-11 col-md-offset-0 col-xs-offset-1">
                            <div class="panel panel-default" style="float:right;">
                                <div class="panel-body"><img src="images/default.png" style="width:30px;height:30px;margin-top:0px;">mariajose
                                    <span class="badge">5 pts</span>
                                </div>
                            </div>
                            É dificl ajudar com poucos detalhes.... :(
                            <br/><br/><br/><small>14/03/2014 01:23</small>
                        </div>

                    </div>
                </div>
            </div>
--><!--
            <div class="text-center">
                <ul class="pagination">
                    <li><a href="#">&laquo;</a></li>
                    <li><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">&raquo;</a></li>
                </ul>
            </div>-->
        </div>
    </div>
</div>
</div>
</div>

<!--<div class="navbar navbar-default navbar-fixed-bottom" style="border-bottom:0px;border-top:10px;border-color: #606E14;height: 35px;">
    <div class="container">
        <ul class="nav navbar-nav pull-left" style="position:relative;top: -8px;">
            <li ><a href="#">@2014 overCooked Foundation</a></li>
        </ul>
            <ul class="nav navbar-nav pull-right" style="position:relative;top: -8px;">
                <li ><a href="#">Quem Somos</a></li>
                <li><a href="#">Contatos</a></li>
                <li><a href="#">Política de privacidade</a></li>
            </ul>
    </div>
</div>-->

<script src="{$BASE_URL}javascript/main.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>

<script src="ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="ckeditor/skins/moono/editor.css">
<script>
    var answer_visible = false, comment_visible = false;

    $(document).ready(function() {
        $('.comment-button').on('click', function() {
            console.log(comment_visible);
            if(!comment_visible) {
                comment_visible = true;
                $( "<div id=\"input2\" class=\"container col-md-12\" style='margin: 0px;padding:0px;'><textarea class=\"comm-editor form-control\" id=\"inputText\" cols=\"40\"  rows=\"10\">\n</textarea><button type=\"button\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button></div>" ).appendTo( $(this).parent());
                CKEDITOR.replace( 'inputText' );
            } else {
                comment_visible = false;
                $('#input2').empty();
                $('#input2').remove();
            }
        })
        $('.comment-button-question').on('click', function() {
            console.log(comment_visible);
            if(!comment_visible) {
                comment_visible = true;
                $( "<div id=\"input2\" class=\"container col-md-12\"><textarea style='margin-top: 10px;' class=\"comm-editor form-control\" id=\"inputText\" cols=\"40\"  rows=\"10\">\n</textarea><button type=\"button\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button></div>" ).insertAfter( $(this).parent());
                CKEDITOR.replace( 'inputText' );
            } else {
                comment_visible = false;
                $('#input2').empty();
                $('#input2').remove();
            }
        })
        $('.answer-button').on('click', function() {
            if(!answer_visible) {
                answer_visible = true;
                $( "<div id=\"input2\" class=\"container col-md-12\"><textarea style='margin-top: 10px;' class=\"answer-editor form-control\" id=\"inputText\" cols=\"40\"  rows=\"10\">\n</textarea><button type=\"button\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button></div>" ).insertAfter( $(this).parent());
                CKEDITOR.replace( 'inputText' );
            } else {
                answer_visible = false;
                $('#input2').empty();
                $('#input2').remove();
            }
        })
    })

</script>

{include file='common/footer.tpl'}

