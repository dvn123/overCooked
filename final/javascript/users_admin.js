function promoteUser(username) {

    $.post( BASE_URL + "api/admin/promote_user.php", {"username" : username},function( data ) {
        console.log(data);
        //console.log(value);

        if(data == '200')
        {
            console.log("Promoted successfully");
            /*console.log("nabo" + "#" + idUser + " .promote");
            console.log($("#" + username + " .promote").val());
            $("#" + username + " .promote").val("Despromover");*/

        } else
            console.log("Error promoting");

        }
    );

}

function relegateUser(username) {

    console.log("nabo");
    $.post( BASE_URL + "api/admin/relegate_user.php", {"username" : username},function( data ) {
            console.log(data);
            //console.log(value);

            if(data == '200')
            {
                console.log("Promoted successfully");
                /*console.log("nabo" + "#" + idUser + " .promote");
                 console.log($("#" + username + " .promote").val());
                 $("#" + username + " .promote").val("Despromover");*/

            } else {
                console.log("Error promoting");

            }
        }
    );
}


function banUser(username) {

}

function acceptUser(username) {

}
