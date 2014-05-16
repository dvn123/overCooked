{include file='common/header.tpl'}

<div class="question container center col-md-10 col-md-offset-1">
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
                <button type="button" onclick="answerShow();" class="answer-button btn btn-default btn-md" style="position: relative;bottom: 0px; right:-175px;min-width:50px;min-width:50px;">
                    Responder
                </button>
                <button type="button" onclick="commentShowQuestion(this);"class="comment-button-question btn btn-default btn-md" style="position: relative;bottom: 0px; right:-175px;min-width:50px;min-width:50px;">
                    Comentar
                </button>

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

<div id="answer" class="container col-md-10 col-md-offset-1" style="display:none">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
                <span>Escreva a sua resposta</span>
            </h3>
        </div>
        <div class="panel-body">
            <textarea class="form-control ckeditor" name="contentAnswer" id="inputText3" cols="80"  rows="10">
            </textarea>
            <button type="button" onclick="submitAnswer();" class="answer-button btn btn-default btn-md" style="margin-top: 5px;" >
                Submeter
            </button>
            <button type="button" onclick="answerShow();" class="answer-button btn btn-default btn-md" style="position-relative:margin-top: 5px;">
                Cancelar
            </button>
        </div>
    </div>
</div>


<div class="container col-md-10 col-md-offset-1">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">{$question.numanswers} resposta{if $question.numanswers != '1'}s{/if}</h3>
        </div>
        <div class="panel-body">
            {foreach $question.answers as $answer}
            <div class="container col-md-12">
                <div class="panel panel-default">
                    <div class="panel-body">
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
                            <button type="button" onclick="commentShowQuestion(this);"class="comment-button-question btn btn-default btn-md pull-right" style="position: relative;bottom: 0px; right:-140px;min-width:50px;">
                                Comentar
                            </button>
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

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>
<script src="{$BASE_URL}lib/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="{$BASE_URL}lib/ckeditor/skins/moono/editor.css">
<script>
    var answer_visible = false, comment_visible = false;

    function answerShow() {
        if(!answer_visible) {
            answer_visible = true;
            $('#answer').show("slow");
        } else {
            answer_visible = false;
            $('#answer').hide("slow");
        }
    }
    function commentShow(element) {
        if(!comment_visible) {
            var jquery = $('#input2');
            jquery.empty();
            jquery.remove();
            comment_visible = true;
            $( "<div id=\"input2\" class=\"container col-md-12\" style='display:none;margin-top: 10px;padding:0px;'><textarea class=\"comm-editor ckeditor form-control\" id=\"inputText\" cols=\"40\"  rows=\"10\">\n</textarea><button type=\"button\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button><button type=\"button\" onclick=\"commentShowQuestion(this);\" class=\"answer-button btn btn-default btn-md\" style=\"margin-left:5px;margin-top: 10px;\">Cancelar</button></div>" ).appendTo( $(element).parent());
            CKEDITOR.replace( 'inputText' );
            $('#input2').show("slow");
        } else {
            comment_visible = false;
            var jquery = $('#input2');
            jquery.hide("slow");
        }
    }
    function commentShowQuestion(element) {
        console.log(comment_visible);
        if(!comment_visible) {
            var jquery = $('#input2');
            jquery.empty();
            jquery.remove();
            console.log($(element));
            comment_visible = true;
            $( "<div id=\"input2\" style=\"display:none;margin-top: 10px;\" class=\"container col-md-12\"><textarea style='margin-top: 10px;' class=\"comm-editor ckeditor form-control\" id=\"inputText2\" cols=\"40\"  rows=\"10\">\n</textarea><button type=\"button\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button><button type=\"button\" onclick=\"commentShowQuestion(this);\" class=\"answer-button btn btn-default btn-md\" style=\"margin-left:5px;margin-top: 10px;\">Cancelar</button></div>" ).insertAfter( $(element).parent());
            CKEDITOR.replace( 'inputText2' );
            $('#input2').show("slow");

        } else {
            comment_visible = false;
            var jquery = $('#input2');
            jquery.hide("slow");
        }
    }
    function submitAnswer() {

    }
</script>

{include file='common/footer.tpl'}

