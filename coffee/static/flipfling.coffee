$ ->

    $('input:button').bind 'click', ->
        $('input[name="score[shots]"]').val this.value
        $('form').submit()

