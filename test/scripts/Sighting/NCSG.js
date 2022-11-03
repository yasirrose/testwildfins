$(document).ready(function(){
						   
		 var handleDatepicker = function() {
		  "use strict";
		  $('.timepickerStrt').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
         		// Revalidate the date field
				 var name=$(this).attr('name');
		 		$("#ncsgform").formValidation('revalidateField', name);
			 });
		  
     	  $('.timepickerEnd').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
         		// Revalidate the date field
				 var name=$(this).attr('name');
		 		$("#ncsgform").formValidation('revalidateField', name);
			 });
		  
		  $(".datetimepicker").datetimepicker({
          	  format: "YYYY-MM-DD"
        	}).on('dp.change', function(e) {
            // Revalidate the date field
			$('#ncsgform').formValidation('revalidateField', 'Date_Entered');
        	})
		  
			
		};
		
handleDatepicker();
				
		$(".Camera_value").click(function(){
										  
				var value=$(this).attr('value');
				var data_id=$(this).attr('data-id');
				$("#Camera_value").val(value);
				//$('#ResetMe').formValidation('revalidateField', 'camera_value');
		});
				

var TIME_PATTERN=/([0-9]+):([0-5][0-9]|60):([0-5][0-9]|60)/;
$('#ncsgform').formValidation({
        framework: 'bootstrap',
		err: {
            container: 'tooltip'
        },
        icon: {
            valid: 'glyphicon ',
            invalid: 'glyphicon ',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
		Sighting_number: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		Date_Entered: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
					date: {
                        format: 'YYYY-MM-DD',
                        message: 'The value is not a valid date'
						}
           			 }
       				},
		SurveyTime_from: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat is invalide'
                    		}
           			 }
       				},
		SurveyTime_to: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat is invalide'
                    		}
           			 }
       				},
		time_from: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat is invalide'
                    		}
           			 }
       				},
		time_to: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				regexp:{
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat is invalide'
                    		}
           			 }
       				},
		Totalhours: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		SurveyHour_to: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		SurveyHour_from: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FieldHours_to: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_TotalDolphin_Min: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_TotalDolphin_Max: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_TotalDolphin_Best: {
            	validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_Adults_Min: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_Adults_Max: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_Adults_Best: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_TotalCalves_Min: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_TotalCalves_Max: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_TotalCalves_Best: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_YOYPresent_Min: {
				 validators: {
					notEmpty: {
							message: 'Please Enter note'
							},
					integer: {
							message: 'The value is not an integer'
							}
						 }
						},
		FE_YOYPresent_Max: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		FE_YOYPresent_Best: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_posids1: {
				validators: {
					notEmpty: {
							message: 'Please Enter note'
							},
					integer: {
							message: 'The value is not an integer'
							}
						 }
       				},
		photo_posids2: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_posids3: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_Minnotids1: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_Minnotids2: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_Minnotids3: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_Maxnotids1: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_Maxnotids2: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_Maxnotids3: {
        	    validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_RevisedMin1: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_RevisedMin2: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_RevisedMin3: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_RevisedMax1: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_RevisedMax2: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_RevisedMax3: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_RevisedBest1: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_RevisedBest2: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
		photo_RevisedBest2: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
	photo_RevisedBest3: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    	},
				integer: {
                        message: 'The value is not an integer'
                    	}
           			 }
       				},
					
					
					
		}});


});