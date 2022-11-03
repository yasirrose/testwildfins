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
		url:application_root+"StaticDataNew.cfc?method=DeleteDrugMethod",
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
	$('#Method').val($('#Method-'+id).text());
	$("#add").attr('name', 'editMethod');
	$("#add").text('UPDATE');
	$("#Method_id").val(id);
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
			Method  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Method'
                    }
                }
            }
        }
});
