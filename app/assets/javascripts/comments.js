/*
$(function(){
	$(".button").on("click", function(){
		var valuesToSubmit = $("form#new_comment").serialize();
		$.ajax({
			type: "POST",
			url: "/comments",
			data: valuesToSubmit,
			dataType: "HTML"
		}).success(function(data){
			alert("success");
			$(".comments").append(data);
			return false;
		});
		return false;
	});
});
*/