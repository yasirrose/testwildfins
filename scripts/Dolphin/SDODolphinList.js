$(document).ready(function(){
						   
	    $(".search-box").select2();
						   
		$('#sdosearch').formValidation({			 
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
				Dolphin_ID  : {
					validators: {
						notEmpty: {
                        message: 'Please select Dolphin'
                    }
					}
                }
            
        	}});
									   
});

function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function(result) {
	if (result == true) {
		$.ajax({
			url:application_root+"Dolphin.cfc?method=DeleteSdodolphin",
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
	}}); 
}