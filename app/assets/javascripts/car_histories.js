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

	$("#print").click(function() {
  //window.alert("clicked internal btn!");
		var i = 0;
		var sell_data = [];
		$('#spare_part_detail tr').each(function() {
		    i = i + 1
		    if (i > 1) {
		      var code = $(this).find(".code").html();
		      var name = $(this).find(".spare_part").html();
		      var amount = $(this).children().find('input')[0].value;
		      var unit_price = $(this).children().find('input')[1].value;
		      var total_price = $(this).children().find('input')[2].value;
		      var sub_total = $("#total").val();
		      var recieved = $("#recieved").val();
		      var return_money = $("#return").val();
		      var car_id = $("#car_history_id").val();
		      var entry_date = $("#datetimepicker").val();
		      sell_data.push({code: code, name: name, amount: amount, unit_price: unit_price, total_price: total_price, sub_total: sub_total, recieved: recieved, return_money: return_money, car_id: car_id, entry_date: entry_date})
		    }
		 });
	  $.ajax({
	      type: "POST",
	      contentType: "application/json; charset=utf-8",
	      url: "/car_histories/"+$("#car_history_id").val()+"/print",
	      //data: "{'data1':'" + value1+ "', 'data2':'" + value2+ "', 'data3':'" + value3+ "'}",
	      data: JSON.stringify(sell_data),
	      dataType: "json",
	      success: function (result) {
	      //do somthing here
	          window.alert("រូចរាល់!!");
	      },
	      error: function (){
	          // window.alert("something wrong!");
	          window.alert("រូចរាល់!!");
	      }
	  });
	});


});

