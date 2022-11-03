$(document).ready(function(){
	
	
	$('form').formValidation({
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
		user_email: {
            validators: {
				notEmpty: {
                        message: 'Please Enter email'
                    },
				emailAddress: {
                            message: 'The value is not a valid email address'
                 }
            }
        }
		
		
		}
										 
		});
			
}); ///document ready end