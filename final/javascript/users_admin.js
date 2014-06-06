function promoteUser(username, object) {

    $.post( BASE_URL + "api/admin/promote_user.php", {"username" : username},function( data ) {
        console.log(data);
        //console.log(value);

        if(data == '200')
        {
            console.log("Promoted successfully");
            /*console.log("nabo" + "#" + idUser + " .promote");
            console.log($("#" + username + " .promote").val());
            $("#" + username + " .promote").val("Despromover");*/
            object.text("Despromover");
            object.removeClass('btn-success');
            object.addClass('btn-warning');
            return true;
        } else
            console.log("Error promoting");
            return false;
        }
    );

}

function relegateUser(username, object) {

    $.post( BASE_URL + "api/admin/relegate_user.php", {"username" : username},function( data ) {
        console.log(data);
        //console.log(value);

        if(data == '200')
        {
            console.log("Relegated successfully");

            object.text("Promover");
            object.removeClass('btn-warning');
            object.addClass('btn-success');
            return true;
        } else {
            console.log("Error relegating");
            return false;
        }
    });
}


function banUser(username, object) {

    $.post( BASE_URL + "api/admin/ban_user.php", {"username" : username},function( data ) {
            console.log(data);
            //console.log(value);

            if(data == '200')
            {
                console.log("Banned successfully");
                object.text("Desbanir");
                object.removeClass('btn-danger');
                object.addClass('btn-info');
                return true;
            } else {
                console.log("Error banning");
                return false;
            }
        }
    );
}

function acceptUser(username, object) {

    $.post( BASE_URL + "api/admin/accept_user.php", {"username" : username},function( data ) {
            console.log(data);
            //console.log(value);

            if(data == '200')
            {
                console.log("Accepted successfully");
                /*console.log("nabo" + "#" + idUser + " .promote");
                 console.log($("#" + username + " .promote").val());
                 $("#" + username + " .promote").val("Despromover");*/
                object.text("Banir");
                object.removeClass('btn-info');
                object.addClass('btn-danger');
                return true;
            } else {
                console.log("Error accepting");
                return false;
            }
        }
    );
}
