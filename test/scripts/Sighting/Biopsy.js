$(document).ready(function(){
	$(".search-box").select2();					   
$('#disp_biopsy').formValidation({
            framework: 'bootstrap',
			err: {
				container: 'tooltip'
			},
            icon: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
					
				DOLPHIN_ID:{
						validators: {
							notEmpty: {
									message: 'Please select Dolphin'
									}
						}
					}	
					
					
            }
        });

});


function deleteRecord(id) {
	
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"Sighting.cfc?method=DeleteBiopsy",
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
