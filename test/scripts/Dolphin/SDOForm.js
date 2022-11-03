$(document).ready(function(){
						   
	    $(".search-box").select2();
		
		
handleDateTimePicker = function() {
        "use strict";
        $(".datepicker-sdo").datetimepicker({
            format: 'YYYY-MM-DD'
        }).on('dp.change', function(e) {
         // Revalidate the date field
		 var name=$(this).attr('name');
		 $("#sdoform").formValidation('revalidateField', name);
		 
        })
		 
		}
	
handleDateTimePicker();
						   
				   
		$('#sdoform').formValidation({			 
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
                    		},
						integer: {
                        	message: 'The value is not an integer'
                    		}
							
					}
                },
				PRES_LOBO_DATE:{
					validators: {
						notEmpty: {
                        message: 'Please select Dolphin'
                    		},
						date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date is not a valid'
                        }
					}
					},
			Recapture_Date_1:{
					validators: {
						notEmpty: {
                        message: 'Please select Dolphin'
                    		},
						date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date is not a valid'
                        }
					}
					},
			Recapture_Date_2:{
					validators: {
						notEmpty: {
                        message: 'Please select Dolphin'
                    		},
						date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date is not a valid'
                        }
					}
					},
			Recapture_Date_3:{
					validators: {
						notEmpty: {
                        message: 'Please select Dolphin'
                    		},
						date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date is not a valid'
                        }
					}
					},
			FinChange1:{
					validators: {
						notEmpty: {
                        message: 'Please select Dolphin'
                    		},
						date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date is not a valid'
                        }
					}
					},
			FinChange2:{
					validators: {
						notEmpty: {
                        message: 'Please select Dolphin'
                    		},
						date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date is not a valid'
                        }
					}
					},
			FinChange3:{
					validators: {
						notEmpty: {
                        message: 'Please select Dolphin'
                    		},
						date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date is not a valid'
                        }
					}
					},
			FB_on_Date:{
					validators: {
						notEmpty: {
                        message: 'Please select Dolphin'
                    		},
						date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date is not a valid'
                        }
					}
					}
					
				
            
        	}});
						   
						   
});