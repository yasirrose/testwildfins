$("document").ready(function({
							 
$('#login_form').formValidation({
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
		Email: {
            validators: {
				notEmpty: {
                        message: 'Please Enter email'
                    },
			emailAddress:{
					 message: 'This email address is not valid Emial Address'
				}	
            }
        },
		Password: {
            validators: {
				notEmpty: {
                        message: 'Please Enter email'
                    }
            }
        }
		
		}
										 
		});

});