$(document).ready(function(){

$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			
			first_name  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter First name'
                    }
                }
            },
			last_name  : {
                validators: {
                	notEmpty: {
                        message: 'Please enter Last Name'
                    }
                }
            },
			username  : {
                validators: {
                	notEmpty: {
                        message: 'Please enter User Name'
                    }
                }
            },
			user_email:{
				validators:{
					notEmpty: {
                        message: 'Please enter User Name'
                    },
					emailAddress:{
						message: 'Please enter correct email address'
						}
					
					}
				},
			permission:{
				validators:{
					notEmpty: {
                        message: 'Choose minimum one option'
                    }
					
					}
				}
			
			
        }
    });


						   
});