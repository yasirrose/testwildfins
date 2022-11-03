function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
	if (result == true) {
		$.ajax({
			url:application_root+"StaticData.cfc?method=DeleteBiopsyBehavior",
			type : "get",
			data : {id : id},
			async:true,
			success:function(data) {
			$('html, body').animate({scrollTop : 0},800);
			$(".message").show();
			$("#remov_"+id).remove();
			setTimeout(function(){$(".message").hide();},3000);
			}
		});
	}
	}); 
}

function updateRecord(id) {
	var text = $.trim($('#LevelofResponse-'+id).text());
	console.log(text);
	if(text == 'Target Response Level'){
		var textID = 1;
	}else if(text == 'Target Response Behavior 1'){
		var textID = 2;
	}else if(text == 'Target Response Behavior 2'){
		var textID = 3;
	}else if(text == 'Target Response Behavior 3'){
		var textID = 4;
	}else if(text == 'Group Response Behavior'){
		var textID = 5;
	}
	$('#LevelofResponse').val(textID).change();;
	$('#ObservedResponse').val($('#ObservedResponse-'+id).text());
	$("#add").attr('name', 'editBiopsyBehavior');
	$("#add").text('Edit');
	$("#BiopsyBehavior_id").val(id);
	seletecActiveValue = $('#seletecActiveValue-'+id).val();
	$('#active').val(seletecActiveValue);
	$("html, body").animate({ scrollTop: 0 }, 600);
}

$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			Camera  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Camera Name'
                    }
                }
            }
        }
    });

function ApplyPagination(startmeup)
{
	document.paginationform.startHereIndex.value = startmeup;
	document.paginationform.submit();
}