{include file='common/header.tpl'}
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/question.js"></script>

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
                <button type="button" id="questionUP" onclick="voteQuestion({$question.idquestion},1)" class="btn btn-default btn-md {if $question.vote eq '1'} active{/if}" style="min-width:50px;">
                    <span class="glyphicon glyphicon-chevron-up"></span>
                </button>
                <div id="questionScore" class="text-center btn btn-default disabled" style="min-width:50px;">{$question.score}</div>
                <button type="button" id="questionDOWN" onclick="voteQuestion({$question.idquestion},-1)" class="btn btn-default btn-md {if $question.vote eq '-1'} active{/if}" style="min-width:50px;">
                    <span class="glyphicon glyphicon-chevron-down"></span>
                </button>
                <button type="button" id="questionpin" onclick="pinquestion({$question.idquestion})" class="btn btn-default btn-md{if $question.subscribed eq '1'} active{/if}" style="min-width:50px;">
                    <span class="glyphicon glyphicon-pushpin"></span>
                </button>
            </div>
            <div class="col-xs-8 col-md-9 col-md-offset-0 col-xs-offset-1">
                {$question.html}<br/><br/><small>{$question.date}</small>
            </div>
            <div class="col-xs-2">
                <button type="button" onclick="answerShow();" class="answer-button btn btn-default btn-md" style="width: 100px; margin-bottom: 5px;">
                    Responder
                </button>
                <button type="button" onclick="commentShowQuestion(this);"class="comment-button-question btn btn-default btn-md" style="width: 100px;">
                    Comentar
                </button>
            </div>
            <div class="col-xs-11 col-xs-offset-1">
            	{foreach $question.tags as $tag}
                <a href="#" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                {/foreach}
            </div>
            
            {foreach $question.comments as $comment}
            <div class="highlight col-xs-9 col-xs-offset-1"
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
            <button type="button" onclick="answerShow();" class="answer-button btn btn-default btn-md" style="margin-top: 5px;">
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
                            <button type="button" id="bestanswer{$answer.idanswer}" onclick="bestAnswer({$answer.idanswer})" class="bestanswer btn btn-success btn-md{if $answer.bestanswer eq 'true' and $question.owner eq 'true'} active{/if}{if $answer.bestanswer eq 'true' and $question.owner != 'true'} disabled{/if}"
                            style="min-width:50px; margin-bottom:10px;{if $answer.bestanswer != 'true' and $question.owner != 'true'}display:none;{/if}">
                            <span class="glyphicon glyphicon-ok"></span>
                            </button>
                        <button type="button" id="answerUP{$answer.idanswer}" onclick="voteAnswer({$answer.idanswer},1)" class="btn btn-default btn-md{if $answer.vote eq '1'} active{/if}" style="min-width:50px;">

                            <span class="glyphicon glyphicon-chevron-up"></span>
                        </button>
                        <div id="answerscore{$answer.idanswer}" class="text-center btn btn-default disabled" style="min-width:50px;">{$answer.score}</div>
                        <button type="button" id="answerDOWN{$answer.idanswer}" onclick="voteAnswer({$answer.idanswer},-1)" class="btn btn-default btn-md{if $answer.vote eq '-1'} active{/if}" style="min-width:50px;">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                        </button>

                        </div>
                        <div class="col-xs-8 col-md-11 col-md-offset-0 col-xs-offset-1">
                            <div style="float:right; margin-left:10px;">
                                <div class="panel panel-default">
                                    <div class="panel-body"><img src="{$answer.userphoto}" style="width:30px;height:30px;margin-top:0px;"> <a href="{$answer.userlink}">{$answer.username}</a>
                                        <span class="badge">{$answer.userpoints} pts</span>
                                    </div>
                                </div>

                                <button type="button" onclick="commentShowQuestion(this);"class="comment-button-question btn btn-default btn-md" style="width: 100px;">
                                    Comentar
                                </button>
                            </div>
                            <br/>{$answer.html}<br/><br/><small>{$answer.date}</small>
                        </div>
                        <div class="col-xs-8 col-md-11 col-md-offset-0 col-xs-offset-1"> 
                            {foreach $answer.comments as $acomment}
                            <div class="highlight col-xs-10"
                            style="margin-top:10px; padding-top:5px; background-color:LightGrey;">
                                <p>{$acomment.content}<small> - <a href="{$acomment.userlink}">{$acomment.username}</a>, {$acomment.date}</small></p> 
                            </div>
                            {/foreach}

                        </div>
                    </div>
                </div>
            </div>
            {/foreach}
        </div>
    </div>
</div>

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
            $( "<div id=\"input2\" class=\"container col-md-12\" style='display:none;margin-top: 10px;padding:0px;'><textarea class=\"comm-editor ckeditor form-control\" id=\"inputText\" cols=\"40\"  rows=\"10\">\n</textarea><button type=\"button\" onclick=\"submitAnswerComment(this.parent);\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button><button type=\"button\" onclick=\"commentShowQuestion(this);\" class=\"answer-button btn btn-default btn-md\" style=\"margin-left:5px;margin-top: 10px;\">Cancelar</button></div>" ).appendTo( $(element).parent());
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
            $( "<div id=\"input2\" style=\"display:none;margin-top: 10px;\" class=\"container col-md-12\"><textarea style='margin-top: 10px;' class=\"comm-editor ckeditor form-control\" id=\"inputText2\" cols=\"40\"  rows=\"10\">\n</textarea><button type=\"button\" onclick=\"submitQuestionComment(this.parent);\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button><button type=\"button\" onclick=\"commentShowQuestion(this);\" class=\"answer-button btn btn-default btn-md\" style=\"margin-left:5px;margin-top: 10px;\">Cancelar</button></div>" ).insertAfter( $(element).parent());
            CKEDITOR.replace( 'inputText2' );
            $('#input2').show("slow");

        } else {
            comment_visible = false;
            var jquery = $('#input2');
            jquery.hide("slow");
        }
    }
    function submitAnswer(element) {
        console.log(element);
        var request = $.ajax({
            url: "{$BASE_URL}api/questions/addAnswer.php",
            type: "POST",
            data: { id : menuId },
            dataType: "html"
        });

        request.done(function( msg ) {
            $( "#log" ).html( msg );
        });
        request.fail(function( jqXHR, textStatus ) {
            alert( "Request failed: " + textStatus );
        });

    }
    function submitAnswerComment(element) {

    }
    function submitQuestionComment(element) {

    }
</script>

{include file='common/footer.tpl'}

