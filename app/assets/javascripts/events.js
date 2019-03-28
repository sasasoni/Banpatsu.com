$(document).on('turbolinks:load', function () {
  var cb = $('#event_no_expiration');
  var field = $('#event_end_date');
  console.log('hi')

  var changeEndDate = function () {
    if (cb.prop("checked"))
      field.slideUp(700);
    else
      field.slideDown(700);
  }

  cb.bind("click", changeEndDate);

  changeEndDate();
});