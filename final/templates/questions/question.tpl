{include file='common/header.tpl'}

<script src="{$BASE_URL}lib/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="{$BASE_URL}lib/ckeditor/skins/moono/editor.css">

<div class="question container center col-md-10 col-md-offset-1">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div class="title">{$question.title}</div>
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
                <div class="questioncontent">{$question.html}</div>
                <br/><br/><small>{$question.date}{if $question.date != $question.lastdate}<br>Ultima edição por <a href="{$question.lastuserlink}">{$question.lastusername}</a>  às {$question.lastdate}{/if}</small>
            </div>
            <div class="pull-right">
                <div>
                    <button type="button" onclick="answerShow();" class="answer-button btn btn-default btn-md" style="width: 100px; margin-bottom: 5px;">
                        Responder
                    </button>
                </div>
                <div>
                <button type="button" onclick="commentShowQuestion(this);" class="comment-button-question btn btn-default btn-md" style="width: 100px;">
                    Comentar
                </button>
                </div>
                {if $question.owner == 'true' or $question.moderator == 'true'}
                    <div>
                        <button type="button" onclick="edit(this, 'question');" class="comment-button-question btn btn-default btn-md" style="width: 100px; margin-top: 5px;">Editar</button>
                    </div>
                    <div>
                        <button type="button" onclick="delete_ele(this, 'question');" class="comment-button-question btn btn-default btn-md" style="width: 100px; margin-top: 5px;">Apagar</button>
                    </div>
                {/if}
            </div>
            <div class="col-xs-11 col-xs-offset-1">
            	{foreach $question.tags as $tag}
                <a href="#" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                {/foreach}
            </div>

            {foreach $question.comments as $comment}
            <div id="{$comment.idcomment}" class="highlight col-xs-9 col-xs-offset-1" style="margin-top:10px; padding-top:5px; background-color:LightGrey;">
                <div class="content">{$comment.content}</div><small> - <a href="{$comment.userlink}">{$comment.username}</a>, {$comment.date}</small>
                {if $comment.owner == 'true' or $comment.moderator == 'true'}
                    <span><span>
                    <button type="button" onclick="edit(this, 'questioncomment');" class="comment-button-question btn btn-default btn-md" style="float:right; margin-bottom: 5px;width: 100px;">
                        Editar
                    </button>
                    </span></span>
                    <span><span>
                        <button type="button" onclick="delete_ele(this, 'questioncomment');" class="comment-button-question btn btn-default btn-md" style="float:right; margin-bottom: 5px;width: 100px;">Apagar</button>
                    </span></span>
                {/if}
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
            <textarea class="form-control ckeditor" name="contentAnswer" id="inputText3" cols="80"  rows="10"></textarea>
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
            <div id="{$answer.idanswer}" class="container col-md-12">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="col-xs-1">
                            <button type="button" id="bestanswer{$answer.idanswer}" onclick="bestAnswer({$answer.idanswer})" class="bestanswer btn  btn-md{if $answer.bestanswer eq 'true' and $question.owner eq 'true'} btn-success active{/if}{if $answer.bestanswer eq 'true' and $question.owner != 'true'} btn-success disabled{/if}"
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
                                    <div class="panel-body"><img src="{$answer.userphoto}" style="width:30px;height:30px;"> <a href="{$answer.userlink}">{$answer.username}</a>
                                        <span class="badge">{$answer.userpoints} pts</span>
                                    </div>
                                </div>
                                <div class="pull-right">
                                    <div>
                                        <button type="button" onclick="commentShow(this);" class="comment-button-question btn btn-default btn-md" style="width: 100px;">
                                            Comentar
                                        </button>
                                    </div>
                                    {if $answer.owner == 'true' or $answer.moderator == 'true'}
                                    <div>
                                        <button type="button" onclick="edit(this, 'answer');" class="comment-button-question btn btn-default btn-md" style="width: 100px;margin-top: 5px;">
                                            Editar
                                        </button>
                                    </div>
                                    <div>
                                        <button type="button" onclick="delete_ele(this, 'answer');" class="comment-button-question btn btn-default btn-md" style="width: 100px;margin-top: 5px;">Apagar</button>
                                    </div>
                                    {/if}
                                </div>

                            </div>
                            <br/><div class="answercontent">{$answer.html}</div><br/><br/><small>{$answer.date}{if $answer.date != $answer.lastdate}<br>Ultima edição por <a href="{$answer.lastuserlink}">{$answer.lastusername}</a> às {$answer.lastdate}{/if}</small>
                        </div>
                        <div class="col-xs-8 col-md-11 col-md-offset-1 col-xs-offset-0">
                            {foreach $answer.comments as $acomment}
                            <div id="{$acomment.idcomment}" class="highlight col-xs-10" style="margin-top:10px; padding-top:5px; background-color:LightGrey;">
                                <div class="content">{$acomment.content}</div><small> - <a href="{$acomment.userlink}">{$acomment.username}</a>, {$acomment.date}</small>
                                {if $acomment.owner == 'true' or $acomment.moderator == 'true'}
                                <span>
                                    <button type="button" onclick="edit(this, 'answercomment');" class="comment-button-question btn btn-default btn-md" style="float:right; margin-bottom: 5px;width: 100px;">
                                        Editar
                                    </button>
                                </span>
                                <span>
                                    <button type="button" onclick="delete_ele(this, 'answercomment');" class="comment-button-question btn btn-default btn-md" style="float:right;width: 100px;">Apagar</button>
                                </span>
                                {/if}
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

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript">
    var BASE_URL = "{$BASE_URL}";
</script>
<script src="{$BASE_URL}javascript/main.js"></script>
<script src="{$BASE_URL}javascript/question.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>

<script type="text/javascript">
    var answer_visible = false, comment_visible = false;
    var last_edit_type, edit_content, edit_title, edit_button, old_content;

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
        var jquery = $('#input2');
        if(!comment_visible) {
            jquery.empty();
            jquery.remove();
            comment_visible = true;
            $( "<div id=\"input2\" class=\"container col-md-12\" style='display:none;margin-top: 10px;padding:0px;'><textarea class=\"comm-editor ckeditor form-control\" id=\"inputText\" cols=\"40\"  rows=\"10\">\n</textarea><button type=\"button\" onclick=\"submitAnswerComment(this);\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button><button type=\"button\" onclick=\"commentShowQuestion(this);\" class=\"answer-button btn btn-default btn-md\" style=\"margin-left:5px;margin-top: 10px;\">Cancelar</button></div>" ).appendTo( $(element).parent().parent().parent().parent());
            CKEDITOR.replace( 'inputText' );
            $('#input2').show("slow");
        } else {
            comment_visible = false;
            jquery.hide("slow");
        }
    }
    function commentShowQuestion(element) {
        //console.log(comment_visible);
        var jquery = $('#input2');
        if(!comment_visible) {
            jquery.empty();
            jquery.remove();
            comment_visible = true;
            $( "<div id=\"input2\" style=\"display:none;margin-top: 10px;\" class=\"container col-md-12\"><textarea style='margin-top: 10px;' class=\"comm-editor ckeditor form-control\" id=\"inputText2\" cols=\"40\"  rows=\"10\">\n</textarea><button type=\"button\" onclick=\"submitQuestionComment();\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button><button type=\"button\" onclick=\"commentShowQuestion(this);\" class=\"answer-button btn btn-default btn-md\" style=\"margin-left:5px;margin-top: 10px;\">Cancelar</button></div>" ).insertAfter( $(element).parent().parent());
            CKEDITOR.replace( 'inputText2' );
            $('#input2').show("slow");

        } else {
            comment_visible = false;
            jquery.hide("slow");
        }
    }
    function submitAnswer() {
        var content = CKEDITOR.instances.inputText3.getData();
        if(!check(content, null))
            return;
        var request = $.ajax({
            url: "{$BASE_URL}api/questions/addAnswer.php",
            type: "POST",
            data: { idQuestion: {$question.idquestion}, content:content}
        });
        request.fail(function( jqXHR, textStatus ) {
            console.log( "Request failed: " + textStatus );
            location.reload();
        });
        request.done(function() {
            location.reload();
        });
    }
    function submitAnswerComment(element) {
        var content = CKEDITOR.instances.inputText.getData();
        if(content.length > 200) {
            if(document.getElementById("tag_error") == null)
                $("#error_messages").append("<div id=\"tag_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Tamanho do comentário tem de ser no máximo 200 caracteres</div>");
            return;
        }
        var idAnswer = $(element).parent().parent().parent().parent().parent().attr('id');
        if(!check(content, null))
            return;
        var request = $.ajax({
            url: "{$BASE_URL}api/questions/addCommentAnswer.php",
            type: "POST",
            data: { idAnswer: idAnswer, content:content}
        });
        request.fail(function( jqXHR, textStatus ) {
            console.log( "Request failed: " + textStatus );
            location.reload();
        });
        request.done(function( data ) {
            location.reload();
        });
    }
    function submitQuestionComment() {
        var content = CKEDITOR.instances.inputText2.getData();
        if(content.length > 200) {
            if(document.getElementById("tag_error") == null)
                $("#error_messages").append("<div id=\"tag_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Tamanho do comentário tem de ser no máximo 200 caracteres</div>");
            return;
        }
        if(!check(content, null))
            return;
        //console.log("QUESTION");
        var request = $.ajax({
            url: "{$BASE_URL}api/questions/addCommentQuestion.php",
            type: "POST",
            data: { idQuestion: {$question.idquestion}, content:content}
        });
        request.fail(function( jqXHR, textStatus ) {
            console.log( "Request failed: " + textStatus );
            location.reload();
        });
        request.done(function( data ) {
            location.reload();
        });
    }
    function check(content, title) {
        if(content.length > 1000) {
            if(document.getElementById("content_error") == null)
                $("#error_messages").append("<div id=\"content_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Conteúdo demasiado comprido</div>")
            return false;
        }
        if(title != null) {
            if(title.length > 25) {
                if(document.getElementById("title_error") == null)
                    $("#error_messages").append("<div id=\"title_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Titulo demasiado comprido</div>")
                return false;
            }
        }
        return true;
    }
    function edit(element, type) {
        var element2 = $(element).parent().parent().parent();
        if((!(edit_content == null || edit_content == undefined)  && (last_edit_type != type || edit_content != element2.find('.content').html()))) {
            closeEdit();
        }
        last_edit_type = type;
        if(type == "question") {
            edit_content = element2.find(".questioncontent");
        } else if(type == "answer") {
            edit_content = element2.parent().find(".answercontent");
        } else if(type == "answercomment") {
            edit_content = $(element).parent().parent().find(".content");
        } else {
            edit_content = element2.find(".content");
        }
        edit_button = $(element);
        edit_button.css( "display", "none" );
        old_content = edit_content.html();

        var editor;
        if(type == "question") {
            edit_content.html("<textarea id=\"input4\" class=\"editor content\" style=\"resize: none;width: 100%\">" + old_content + "</textarea><button type=\"button\" onclick=\"submitEdit();\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button><button type=\"button\" onclick=\"closeEdit();\" class=\"answer-button btn btn-default btn-md\" style=\"margin-left:5px;margin-top: 10px;\">Cancelar</button>");
            edit_title = element2.parent().find('.title');
            edit_title.html("<textarea class=\"editor-title title\" rows=\"1\">{$question.title}</textarea>");
            {literal}editor = CKEDITOR.replace( 'input4', {resize_enabled: false } );{/literal}
        } else if(type == "questioncomment" || type == "answercomment") {
            edit_content.html("<textarea id=\"input4\" class=\"editor content\" style=\"resize: none;width: 80%\">" + edit_content.html() + "</textarea><button type=\"button\" onclick=\"submitEdit();\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button><button type=\"button\" onclick=\"closeEdit();\" class=\"answer-button btn btn-default btn-md\" style=\"margin-left:5px;margin-top: 10px;\">Cancelar</button>");
            {literal}editor = CKEDITOR.replace( 'input4',  {width: '80%', resize_enabled: false } );{/literal}
        } else {
            edit_content.html("<textarea id=\"input4\" class=\"editor content\" style=\"resize: none;width: 80%\">" + edit_content.html() + "</textarea><button type=\"button\" onclick=\"submitEdit();\" class=\"comment-button btn btn-default btn-md\" style=\"margin-top: 10px;\">Submeter</button><button type=\"button\" onclick=\"closeEdit();\" class=\"answer-button btn btn-default btn-md\" style=\"margin-left:5px;margin-top: 10px;\">Cancelar</button>");
            {literal}editor = CKEDITOR.replace( 'input4',  {width: '80%', resize_enabled: false } );{/literal}
        }
    }
    function closeEdit() {
        edit_content.html(old_content);
        edit_button.css( "display", "inline" );
        if(last_edit_type == "question") {
            edit_title.html("{$question.title}");
        }
        edit_content = null;
        edit_title = null;
        edit_button = null;
    }
    function submitEdit() {
        if(CKEDITOR.instances.input4.getData().length > 1000) {
            if(document.getElementById("content_error") == null)
                $("#error_messages").append("<div id=\"content_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Conteudo demasiado comprido</div>")
            return;
        }
        var url1, data;
        if(last_edit_type == "question") {
            url1 = "Question.php";
            data = { idQuestion: {$question.idquestion}, title:edit_title.find('textarea').val(), content: CKEDITOR.instances.input4.getData()};
            if(edit_title.find('textarea').val().length > 25) {
                if(document.getElementById("title_error") == null)
                    $("#error_messages").append("<div id=\"title_error\" class=\"container\"><div class=\"alert alert-danger fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>Titulo demasiado comprido</div>")
                return;
            }
        } else if(last_edit_type == "answer") {
            var idAnswer = edit_button.parent().parent().parent().parent().parent().parent().parent().attr('id');
            url1 = "Answer.php";
            data = { idAnswer: idAnswer, content:CKEDITOR.instances.input4.getData()};
        } else if(last_edit_type == "answercomment") {
            var idComment = edit_button.parent().parent().attr('id');
            url1 = "CommentAnswer.php";
            data = { idComment: idComment, content:CKEDITOR.instances.input4.getData()};
        } else if(last_edit_type == "questioncomment") {
            var idComment = edit_button.parent().parent().parent().attr('id');
            url1 = "CommentQuestion.php";
            data = { idComment: idComment, content:CKEDITOR.instances.input4.getData()};
        }
        var url = "{$BASE_URL}api/questions/edit" + url1;
        var request = $.ajax({
            url: url,
            type: "POST",
            data: data
        });
        request.fail(function( jqXHR, textStatus ) {
            console.log( "Request failed: " + textStatus );
            location.reload();
        });
        request.done(function() {
            //console.log(data);
            location.reload();
        });
        closeEdit();
    }
    function delete_ele(element, type) {
        console.log(type);
        var url1, data;
        if(type == "question") {
            url1 = "Question.php";
            data = { idQuestion: {$question.idquestion}};
        } else if(type == "answer") {
            var idAnswer = $(element).parent().parent().parent().parent().parent().parent().parent().attr('id');
            url1 = "Answer.php";
            data = { idAnswer: idAnswer};
        } else if(type == "answercomment") {
            var idComment = $(element).parent().parent().attr('id');
            url1 = "AnswerComment.php";
            data = { idComment: idComment};
        } else if(type == "questioncomment") {
            var idComment = $(element).parent().parent().parent().attr('id');
            url1 = "QuestionComment.php";
            data = { idComment: idComment};
        }
        var url = "{$BASE_URL}api/questions/delete" + url1;
        var request = $.ajax({
            url: url,
            type: "POST",
            data: data
        });
        request.fail(function( jqXHR, textStatus ) {
            console.log( "Request failed: " + textStatus );
            location.reload();
        });
        request.done(function(data) {
            //console.log(data);
            location.reload();
        });
    }
</script>

{include file='common/footer.tpl'}

