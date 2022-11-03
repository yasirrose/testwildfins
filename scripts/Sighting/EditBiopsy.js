$(document).ready(function(){

$('#biopsyform').formValidation({
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
					Sighting_ID: {
								validators: {
									notEmpty: {
										message: 'The field is required'
									},
									integer: {
										message: 'The field must be a number'
									}
									}
								},
					ShotNumber: {
								validators: {
									notEmpty: {
										message: 'The field is required'
									},
									integer: {
										message: 'The field must be a number'
									},
								stringLength: {
									message: 'value content must be  255 characters',
									max: function (value, validator, $field) {
										return 256 - (value.match(/\r/g) || []).length;
									}
								}

								}
							},

					DOLPHINID: {
						validators: {
							notEmpty: {
									message: 'The field is required'
								},
							integer: {
										message: 'The field must be a number'
									}
						}
					},
					Hit:{
						validators: {
							notEmpty: {
									message: 'The field is required'
								},
							integer: {
										message: 'The field must be a number'
									}
								}
							},
					Miss:{
						validators: {
							notEmpty: {
									message: 'The field is required'
								},
							integer: {
										message: 'The field must be a number'
									},
							stringLength: {
									message: 'value content must be  1 characters',
									max: function (value, validator, $field) {
										return 2 - (value.match(/\r/g) || []).length;
									}
								}
								}
							},
				Sample:{
						validators: {
							notEmpty: {
									message: 'The field is required'
									},
							stringLength: {
									message: 'value must be  50 characters',
									max: function (value, validator, $field) {
										return 51 - (value.match(/\r/g) || []).length;
								}
								}
						}
					},
				SampleNumber:{
						validators: {
							notEmpty: {
									message: 'The field is required'
									},
							stringLength: {
									message: 'value must be  50 characters',
									max: function (value, validator, $field) {
										return 51 - (value.match(/\r/g) || []).length;
								}
								}
						}
					}


            }
        });
		
		$("#hitOutcome").click(function(){
				$("#missHeight").css('display','none');
				$("#missWidth").css('display','none');
				$("#missDistance").css('display','none');
				$("#missDescriptor").css('display','none');
				$("#hitDescriptor").css('display','block');
				});		
			$("#missOutcome").click(function(){
				$("#missHeight").css('display','block');
				$("#missWidth").css('display','block');
				$("#missDistance").css('display','block');
				$("#missDescriptor").css('display','block');
				$("#hitDescriptor").css('display','none');
				});

});


function deleteRecord(id) {

	bootbox.confirm("Are you sure?", function(result) {

	if (result == true) {
	$.ajax({
		url:application_root+"Dolphin.cfc?method=DeleteBiopsy",
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
