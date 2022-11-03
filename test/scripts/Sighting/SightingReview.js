	$(document).ready(function() {
	 $(".search-box").select2();						   
	handleDateTimePicker = function() {
        "use strict";
        $("#datetimepicker1").datetimepicker({
            format: 'YYYY-MM-DD HH:mm:ss'
        }).on('dp.change', function(e) {
            // Revalidate the date field
		$('#ResetMe').formValidation('revalidateField', 'Date_p');
        }), $("#datetimepicker2").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function(e) {
            // Revalidate the date field
		$('#ResetMe').formValidation('revalidateField', 'StartTime');
        }), $("#datetimepicker_endtime").datetimepicker({
            format: 'HH:mm:ss'
        }).on('dp.change', function(e) {
        	$('#ResetMe').formValidation('revalidateField', 'EndTime');
        }), $("#datetimepicker_srvystrt").datetimepicker({
            format: 'HH:mm:ss'
        }).on('dp.change', function(e) {
        	$('#ResetMe').formValidation('revalidateField', 'SurveyStartTime');
        }), $("#datetimepicker_sightingstrt").datetimepicker({
            format: 'HH:mm:ss'
        }).on('dp.change', function(e) {
        	$('#ResetMe').formValidation('revalidateField', 'Sightingstart');
        }), $("#datetimepicker_sightingend").datetimepicker({
            format: 'HH:mm:ss'
        }).on('dp.change', function(e) {
        	$('#ResetMe').formValidation('revalidateField', 'Sightingend');
        }), $("#datetimepicker_srvyend").datetimepicker({
            format: 'HH:mm:ss'
        }).on('dp.change', function(e) {
        	$('#ResetMe').formValidation('revalidateField', 'SurveyEndTime');
        }), $("#datetimepicker3").datetimepicker(), $("#datetimepicker4").datetimepicker(), $("#datetimepicker3").on("dp.change", function(e) {
            $("#datetimepicker4").data("DateTimePicker").minDate(e.date)
        }), $("#datetimepicker4").on("dp.change", function(e) {
            $("#datetimepicker3").data("DateTimePicker").maxDate(e.date)
        }),$(".datetimepicker").datetimepicker({
            format: 'YYYY-MM-DD'
        })
    }
	
	
			handleDateTimePicker();
			
			$(".plateform_value").click(function(){
				var value=$(this).attr('value');
				$("#plateform_value").val(value);
				$('#ResetMe').formValidation('revalidateField', 'Platform');
				});
			
			$(".area_value").click(function(){
				var value=$(this).attr('value');
				$("#area_value").val(value);
				$('#ResetMe').formValidation('revalidateField', 'SurveyArea');
				});
			
			$(".stock_value").click(function(){
				var value=$(this).attr('value');
				$("#stock_value").val(value);
				$('#ResetMe').formValidation('revalidateField', 'Stock');
				});
			
				$(".Camera_value").click(function(){
				
				var value=$(this).attr('value');
				var data_id=$(this).attr('data-id');
				
				$("#Camera_value").val(value);
				$("#Camera_value_id").val(data_id);
				
				$('#ResetMe').formValidation('revalidateField', 'camera_value');
				});
			
			$(".Lens_value").click(function(){
				var value=$(this).attr('value');
				var data_id=$(this).attr('data-id');
				$("#Lens_value").val(value);
				$("#Lens_value_id").val(data_id);
				$('#ResetMe').formValidation('revalidateField', 'Lens_value');
			});
				
			  $("#input-4").fileinput({showCaption: false});
		   // App.init();
			
		
		
	$("#input-4").change(function () {
        var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
        if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) == -1) 
		{
            alert("Only formats are allowed : "+fileExtension.join(', '));
			$("#input-4").val('');
		}
		
        });
		
	$('#add_dolphin_form').formValidation({
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
		Note: {
            validators: {
				notEmpty: {
                        message: 'Please Enter note'
                    }
            }
        }
		}
										 
		}).on('success.form.fv', function(e) {
            	// Prevent form submission
				e.preventDefault();
				data=$( "#add_dolphin_form" ).serialize();
					$.ajax({
							type:"post",
							data:data,
							url:application_root+"Sighting.cfc?method=add_dolphin",
							success:function(res){
								$(".message").show();
								$(".reset").trigger("click");
								$(".message").html(res);
								setTimeout(function(){$(".message").hide();},4000);
							}
						});
							
					$.ajax({
							type:"post",
							data:{Sightningid:$("#getsight_ID").val()},
							url:application_root+"Sighting.cfc?method=getlist_dolphinsight",
							success:function(res){
								$(".display_data").html(res);
							
							}
						});
				
				
 			       });
	
	var TIME_PATTERN=/([0-9]+):([0-5][0-9]|60):([0-5][0-9]|60)/;
	
	$('#ResetMe').formValidation({
		
		framework: 'bootstrap',
		err: {
            container: 'tooltip'
        },
        icon: {
            valid: 'glyphicon glyphicon-ok-',
            invalid: 'glyphicon glyphicon-remove-',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
		StartTime: {
            validators: {
				notEmpty: {
                        message: 'Please select time'
                    },
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
            }
        },
        EndTime: {
            validators: {
				notEmpty: {
                        message: 'Please select time'
                    },
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
				}
            },
		SurveyStartTime: {
            validators: {
				notEmpty: {
                        message: 'Please select time'
                    },
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
            }
        	},
        SurveyEndTime: {
            validators: {
				notEmpty: {
                        message: 'Please select time'
                    },
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
				}
            },
		Sightingstart: {
            validators: {
				notEmpty: {
                        message: 'Please select time'
                    },
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
            	}
       			 },
      Sightingend: {
            validators: {
				notEmpty: {
                        message: 'Please select time'
                    },
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
				}
            },
	ResearchTeam:{
				validators: {
                    notEmpty: {
                        message: 'Please select Team member'
                    }
				}
				},
		Platform:{
				validators: {
                    notEmpty: {
                        message: 'Please select Plateform'
                    }
				}
				},
		SurveyArea:{
				validators: {
                    notEmpty: {
                        message: 'Please select Plateform'
                    }
				}
				},
	camera_value:{
				validators: {
                    notEmpty: {
                        message: 'Please select camera'
                    }
				}
				},
		Lens_value:{
				validators: {
                    notEmpty: {
                        message: 'Please select Lens'
                    }
				}
				},
		zone_id:{
				validators: {
                    notEmpty: {
                        message: 'Please select Lens'
                    }
				}
				},
		Stock:{
				validators: {
                    notEmpty: {
                        message: 'Please select Lens'
                    }
				}
				},
		Date_p:{
				validators: {
                    notEmpty: {
                        message: 'Please select Lens'
                    },
				date: {
                            format: 'YYYY-MM-DD HH:MM:SS',
                            message: 'The date and time is not a valid'
                        }
				}
				}
				
				
        }
    });
	
	
	
	
   $("#UTMConversion").click(function(){
		Easting_X = $("#Easting_X").val();
		Northing_Y = $("#Northing_Y").val();
		Easting = Easting_X.toString().length;
		Northing = Northing_Y.toString().length;
		
		if (Easting >= 6  && Northing >=7) {
		
		var utm1 = new UTMRef(Easting_X, Northing_Y, "N", 17);
		var ll3 = utm1.toLatLng();
		lat = ll3.lat;
		lat = parseFloat(lat.toFixed(4));
		lng = ll3.lng;
		lng = parseFloat(lng.toFixed(4));
		$("#Begin_LAT_Dec").val(lat);
		$("#Begin_LON_Dec").val(lng);
			
			$.ajax({
				url:application_root+"Sighting.cfc?method=qGetZone",
				type : "get",
				async : true,
					data : {'Easting':Easting_X,'Northing':Northing_Y},
					success:function(result) {console.log(JSON.parse(result));
					coordinates = JSON.parse(result);
					if (typeof coordinates.DATA[0] != 'undefined') {
					zone = coordinates.DATA[0][0];
					$("#zone_id").val(zone);
					} else {
						$("#zone_id").val(0);
						}
					}
		});
			
		}
});
	
	
	});
	


function makeTeam(id) {
			    val = $("#team_value").val();
				if (val !== '') {
				$("#team_value").val(val+' '+ ($("#member-"+id).text())); 
				} 
				else {
					$("#team_value").val($("#member-"+id).text());
				}
				$("#member-"+id).remove();
				$('#ResetMe').formValidation('revalidateField', 'ResearchTeam');
			}

function sendForm() {
			var id=document.getElementById('project_val').value;
    		if(id == 0){
				ResetAll();
			}else{
				document.getElementById("myform").submit();
			}
		}
		
function submitsightForm() {
		var id=document.getElementById('sightid').value;
    		if(id==0){
				document.getElementById("myform").submit();
			}else{
    			document.getElementById("sightform").submit();
			}
		}
function ResetAll()
		{
			var elements = document.getElementsByTagName("input");
			for (var ii=0; ii < elements.length; ii++) {
		  if (elements[ii].type == "text") {
			elements[ii].value = "";
		  }
		  $("textarea").val();
		  $("#update").val("submit");
		  $("#update").attr("name","add_data");
		  $("#update2").hide();
		}
		
		var element = document.getElementsByTagName('select');
			for (var i = 0; i < element.length; i++)
			{
				element[i].selectedIndex = 0;
			}
		var element = document.getElementsByTagName('textarea');
		for (var i = 0; i < element.length; i++)
			{
				element[i].value="";
			}
		document.getElementById("sightform").style.display = "none";
		}
		


		
