$(function(){

    $('input:button').bind('click',function(){
        $('input[name="score[shots]"]').val(this.value);
        $('form').submit()
    });

});