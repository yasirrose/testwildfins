

$('form').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
			group_name  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Group Name'
                    }
                }
            },
			group_description  : {
                validators: {
                    notEmpty: {
                        message: 'Please enter Group description'
                    }
                }
            }
        }
    });

