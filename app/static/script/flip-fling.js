(function() {
  $(function() {
    return $('input:button').bind('click', function() {
      $('input[name="score[shots]"]').val(this.value);
      return $('form').submit();
    });
  });
}).call(this);
