var ready=function(){
    alert('1');
    $('#no-sns-id').click(function(){
        $("#no-sns-login").show();
        $("#sns-login,#no-sns-id").hide();
        $("#no-sns-id").parent().hide();
    });
};

document.addEventListener("turbo:load", ready);
