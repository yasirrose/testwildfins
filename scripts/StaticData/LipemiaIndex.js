$(document).ready(function() {
    $('#example').DataTable({
		"pageLength": 10,
		"paging": true,
		"info":    true,
		responsive: true,
	});
} );
function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"StaticDataNew.cfc?method=DeleteLipemiaIndex",
		type : "get",
		data : {id : id},
		success:function(data) {
		$('html, body').animate({scrollTop : 0},800);
			$(".message").show();
			$("#remov_"+id).remove();
			setTimeout(function(){$(".message").hide();},3000);
			var pageURL = $(location).attr("href");
			window.location.href= pageURL;
		}
	});
	}
	}); 
}

function updateRecord(id) {
	$('#type').val($('#type-'+id).text());
	$("#add").attr('name', 'editType');
	$("#add").text('UPDATE');
	$("#Type_id").val(id);
	seletecActiveValue = $('#seletecActiveValue-'+id).val();
	$('#status').val(seletecActiveValue);
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
			type  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Type Name'
                    }
                }
            }
        }
});
