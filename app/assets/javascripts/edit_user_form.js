$(document).ready(function () {
  $('.button-collapse').sideNav();

  var checkboxes = $("input[type='checkbox']"),
  submitButt = $("input[type='submit']");

  checkboxes.click(function() {
    submitButt.attr("disabled", !checkboxes.is(":checked"));
  });
});
