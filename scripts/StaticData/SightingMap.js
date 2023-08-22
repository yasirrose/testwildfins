function deleteRecord(id) {
    // alert(id);
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"StaticDataNew.cfc?method=DeleteSightingMap",
		type : "get",
		data : {id : id},
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
    // alert();
    // return false;
	$('#latitude').val($('#lat-'+id).text());
	$('#longitude').val($('#lng-'+id).text());
    $('#mapZoom').val($('#mapzoom-'+id).text());
    
	$("#addMapSetting").attr('name', 'editMapSetting');
	$("#addMapSetting").text('Edit');
	$("#latitude_id").val(id);
	$("#longitude_id").val(id);
	$("#mapZoom_id").val(id);
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
			LesionTypeName  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter LesionTypeName'
                    }
                }
            }
        }
    });
// function ApplyPagination(startmeup)
// {
// 	document.paginationform.startHereIndex.value = startmeup;
// 	document.paginationform.submit();
// }