jQuery.ajaxSetup({
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {

	$("#spare_part_code").keypress(function(e) {
    if(e.which == 13) {
      $.post($(this).attr("action"), $(this).serialize(), null, "script");
      return false;
    }
	});

	$('#datetimepicker').datetimepicker({
		timepicker:false,
		format:'Y/m/d'
	});


});

