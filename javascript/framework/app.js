
$('#login').click(function(){
    var loginGtr = G$('John','Doe');

    $('#logindiv').hide();
    
    loginGtr.setLang($('#lang').val()).HTMLGreeting('#greeting',true).log();
});