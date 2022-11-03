	$(document).ready(function() {			   
	var handleBootstrapCombobox = function() {
    "use strict";
    $('.combobox').combobox();
	};
	
	 
	  $(".multiple-select2").select2({ placeholder: "Select a Team Members" });
		handleDateTimePicker = function() {
        "use strict";
        $("#datetimepicker1").datetimepicker({
            format: 'YYYY-MM-DD'
        }).on('dp.change', function(e) {
            // Revalidate the date field
		$('#ResetMe').formValidation('revalidateField', 'Date_p');
        }), $("#datetimepicker2").datetimepicker({
            format: "HH:mm"
        }).on('dp.change', function(e) {
            // Revalidate the date field
		$('#ResetMe').formValidation('revalidateField', 'StartTime');
        }), $("#datetimepicker_endtime").datetimepicker({
            format: 'HH:mm'
        }).on('dp.change', function(e) {
        	$('#ResetMe').formValidation('revalidateField', 'EndTime');
        }), $("#datetimepicker_srvystrt").datetimepicker({
            format: 'HH:mm'
        }).on('dp.change', function(e) {
        	$('#ResetMe').formValidation('revalidateField', 'SurveyStartTime');
        }), $("#datetimepicker_sightingstrt").datetimepicker({
            format: 'HH:mm'
        }).on('dp.change', function(e) {
        	$('#ResetMe').formValidation('revalidateField', 'Sightingstart');
        }), $("#datetimepicker_sightingend").datetimepicker({
            format: 'HH:mm'
        }).on('dp.change', function(e) {
        	$('#ResetMe').formValidation('revalidateField', 'Sightingend');
        }), $("#datetimepicker_srvyend").datetimepicker({
            format: 'HH:mm'
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
	
	
			var handleJqueryTagIt = function() {
			"use strict";
			$('#jquery-tagIt-default').tagit({
				availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"],
				fieldName: "Team"
				
			});
			$('#jquery-tagIt-inverse').tagit({
				availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
			});
			$('#jquery-tagIt-white').tagit({
				availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
			});
			$('#jquery-tagIt-primary').tagit({
				availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
			});
			$('#jquery-tagIt-info').tagit({
				availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
			});
			$('#jquery-tagIt-success').tagit({
				availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
			});
			$('#jquery-tagIt-warning').tagit({
				availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
			});
			$('#jquery-tagIt-danger').tagit({
				availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
			});
			
			}
		
			handleBootstrapCombobox();
			handleDateTimePicker();
			handleJqueryTagIt();
			
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
			});
			
			$(".Photographer_value").click(function(){
				var value=$(this).attr('value');
				var data_id=$(this).attr('data-id');
				$("#Photographer_value").val(value);
				$("#Photographer_value_id").val(data_id);
			});
				
			$(".Driver_value").click(function(){
				var value=$(this).attr('value');
				var data_id=$(this).attr('data-id');
				$("#Driver_value").val(value);
				$("#Driver_value_id").val(data_id);
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
				data=$("#add_dolphin_form" ).serialize();
					$.ajax({
							type:"post",
							data:data,
							url:application_root+"Sighting.cfc?method=add_dolphin",
							success:function(res){
								$(".message").show();
								
								$('#add_dolphin_form').formValidation('resetForm', true);
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
	
	var TIME_PATTERN=/([0-9]+):([0-5][0-9]|60)/;
	/*
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
				
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
            }
        },
        EndTime: {
            validators: {
			
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
				}
            },
		SurveyStartTime: {
            validators: {
			
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
            }
        	},
        SurveyEndTime: {
            validators: {
			
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
				}
            },
		Sightingstart: {
            validators: {
				
				regexp: {
                        regexp: TIME_PATTERN,
                        message: 'Time Fomrat invalide'
                    }
            	}
       			 },
      Sightingend: {
            validators: {
			
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
                        message: 'Please select Survey Area'
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
                        message: 'Please select Zone'
                    }
				}
				},
		Stock:{
				validators: {
                    notEmpty: {
                        message: 'Please select Stock'
                    }
				}
				},
				
				
		Date_p:{
				validators: {
                 
				 date: {
                            format: 'YYYY-MM-DD',
                            message: 'The date and time is not a valid'
                        }
				}
				}
				
				
        }
    });
	*/
	
function decimalPlaces(float,length) {
		  ret = "";
		  str = float.toString();
		  array = str.split(".");
		  if(array.length==2) {
			 ret += array[0] + ".";
			 for(i=0;i<length;i++) {
				if(i>=array[1].length) ret += '0';
				else ret+= array[1][i];
			 }
		  }
		  else if(array.length == 1) {
			ret += array[0] + ".";
			for(i=0;i<length;i++) {
			   ret += '0'
			}
		  }
		
		  return ret;
		}

	
   $("#UTMConversion").click(function(){
		Easting_X = $("#Easting_X").val();
		Northing_Y = $("#Northing_Y").val();
		Easting = Easting_X.toString().length;
		Northing = Northing_Y.toString().length;
		
		if (Easting >= 6  && Northing >=7) {
		
		var utm1 = new UTMRef(Easting_X, Northing_Y, "N", 17);
		var ll3 = utm1.toLatLng();
		lat = ll3.lat;
		lat=decimalPlaces(lat,5);
		//lat = parseFloat(lat.toFixed(5));
		lng = ll3.lng;
		lng=decimalPlaces(lng,5);
		//lng = parseFloat(lng.toFixed(5));
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
   
   
   /////zone project added 
   
   $(document).on("submit","#zoneform",function(){
					var zoneid=$("#addZoneID").val();
					var project_id=$("#zoneprojectid").val();
					if( zoneid == 0 ){
						bootbox.alert('Please select Zone');
						}else{
					$.ajax({
					url:application_root+"Sighting.cfc?method=InsertZonesProject",
					type : "post",
					async : true,
					data : {'id':project_id,'zoneid':zoneid},
					success:function(result) {
					
					$('html, body').animate({scrollTop : 0},800);
					$(".message").html("<div class='alert alert-success'>"+result+".</div>").show();	
					setTimeout(function(){$(".message").hide();},3000);
					}
						   });
						}
					return false;
	});
   
	$("#zone_view_before").click(function(){
		
					$.ajax({
							url:application_root+"Sighting.cfc?method=getZoneForSurvey",
							type : "post",
							async : true,
							dataType:"json", 
							success:function(result) {
						console.log(result);
						if (result.length > 0) {
							$('#zones_list').html('');
							 for(var i = 0; i<result.length; i++) {
								$('#zones_list').append('<tr role="row" class="odd" id="remov_'+result[i].ID+'"><td class="sorting_1" width="33">'+result[i].ID+'</td><td class="sorting_1" width="33">'+result[i].zone+'</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzoneBefore('+result[i].ID+')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>');
							}
								$(".dataTables_scroll").show();
								$(".zoneform").hide();
								$('#view_zone').modal('show');
								}else{
									bootbox.alert('Zone not Found');
									}
								}
							});
				
		});
	
	
	
	$("#zone_add").click(function(){
								  
			BeginZoneID=$("#BeginZoneID").val();
			EndZoneID=$("#EndZoneID").val();
			project_ID=$("#zoneprojectid").val();
			
			if(EndZoneID =='' || BeginZoneID==''){
				bootbox.alert('please select Begin Zone and End Zone');
				}else{
					
					$.ajax({
							url:application_root+"Sighting.cfc?method=InsertZonesProject",
							type : "post",
							async : true,
							data : {'BeginZone':BeginZoneID,'EndZone':EndZoneID,'project_ID':project_ID},
					
							success:function(result) {
								
							result = JSON.parse(result);
							obj = result.DATA.length;
								console.log(obj);
								if (obj > 0) {
									$('#zones_list').html('');
										for(i = 0; i<obj; i++) {
											console.log(i);
											$('#zones_list').append('<tr role="row" class="odd" id="remov_'+result.DATA[i][1]+'"><td class="sorting_1" width="33">'+result.DATA[i][1]+'</td><td class="sorting_1" width="33">'+result.DATA[i][0]+'</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzone('+project_ID+','+result.DATA[i][1]+')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>')
										}
									$(".dataTables_scroll").show();
									$(".zoneform").hide();
									$('#view_zone').modal('show');
									}else{
										bootbox.alert('Zone not Found');
										}
									 
								}
							});
					}
		
	});



$("#zone_add_before").click(function(){
	
			BeginZoneID=$("#BeginZoneID").val();
			EndZoneID=$("#EndZoneID").val();
			if(EndZoneID =='' || BeginZoneID==''){
				bootbox.alert('please select Begin Zone and End Zone');
				}else{
					
					$.ajax({
							url:application_root+"Sighting.cfc?method=InsertZonesProjectBefore",
							type : "post",
							async : true,
							data : {'BeginZone':BeginZoneID,'EndZone':EndZoneID},
							dataType:"json", 
							success:function(result) {
						console.log(result);
						if (result.length > 0) {
							$('#zones_list').html('');
							 for(var i = 0; i<result.length; i++) {
								$('#zones_list').append('<tr role="row" class="odd" id="remov_'+result[i].ID+'"><td class="sorting_1" width="33">'+result[i].ID+'</td><td class="sorting_1" width="33">'+result[i].zone+'</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzoneBefore('+result[i].ID+')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>');
							}
								$(".dataTables_scroll").show();
								$(".zoneform").hide();
								$('#view_zone').modal('show');
								}else{
									bootbox.alert('Zone not Found');
									}
								}
							});
					}
	});

	
	$("#zone_view").click(function(){							   
		var project_id = $("#project_val").val();
		
		if (project_id == '' || project_id == 0 ) {
			bootbox.alert('Please select project');
		}
		
		if (project_id != '' && project_id !=0 ) {
		$.ajax({
				url:application_root+"Sighting.cfc?method=ZonesData",
				type : "get",
				async : true,
					data : {'id':project_id},
					success:function(result) {
						
						result = JSON.parse(result);
						obj = result.DATA.length;
						console.log(obj);
					
					if (obj > 0) {
						$('#zones_list').html('');
							for(i = 0; i<obj; i++) {
								console.log(i);
								
								$('#zones_list').append('<tr role="row" class="odd" id="remov_'+result.DATA[i][1]+'"><td class="sorting_1" width="33">'+result.DATA[i][1]+'</td><td class="sorting_1" width="33">'+result.DATA[i][0]+'</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzone('+project_id+','+result.DATA[i][1]+')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>')
							}
						$(".dataTables_scroll").show();
						$(".zoneform").hide();
						$('#view_zone').modal('show');
						}else{
							bootbox.alert('Zone not Found');
							}
						 
					}
		});
		}
		
	});

				$('input.zonefilter').on('change', function() {
						$('input.zonefilter').not(this).prop('checked', false); 
						var zonetype=$(this).val();
						$.ajax({
							url:application_root+"Sighting.cfc?method=getZoneByType",
							type : "post",
							async : true,
							data : {'zonetype':zonetype},
							success:function(result) {
								
								 result = JSON.parse(result);
								console.log(result);
								obj=result.DATA.length;
								
								if(obj > 0){
									$('#BeginZoneID').html('');
									$('#EndZoneID').html('');
									$("#BeginZoneID").append('<option value=""></option>');
									$("#EndZoneID").append('<option value=""></option>');
									for(i=1; i<obj; i++){
									$("#BeginZoneID").append('<option value="'+result.DATA[i][1]+'">'+result.DATA[i][1]+'</option>');
									$("#EndZoneID").append('<option value="'+result.DATA[i][1]+'">'+result.DATA[i][1]+'</option>');
										}
									}
								}
							});
						});
	
		$(document).on('submit','#ncsgform',function(){
			var data=$(this).serialize();
					$.ajax({
						type:"post",
						url:application_root+"Sighting.cfc?method=save_NCSG",
						async : true,
						data:data,
						success: function(){
						
							$('#ncsgModal').animate({scrollTop : 0},800);
							$(".message").show();	
							setTimeout(function(){$(".message").hide();},3000);
							}
						
					});
					return false;
			});		
				
				
	
	
	});
	

function deleteRecordzoneBefore(zoneID){
	
			bootbox.confirm("Are you sure?", function(result) {
			if (result == true) {
			$.ajax({
				url:application_root+"Sighting.cfc?method=DeleteZoneBeforePro",
				type : "post",
				data : {zoneID:zoneID},
				dataType:"json",
				success:function(result) {
					
					$('html, body').animate({scrollTop : 0},800);
					
					$(".message").html("<div class='alert alert-success'> <strong>Success!</strong> Zone Deleted.</div>").show();
					$("#remov_"+zoneID).remove();
					setTimeout(function(){$(".message").hide();},5000);
					
					
					
					$('#zones_list').html('');
					for(var i = 0; i<result.length; i++) {
					$('#zones_list').append('<tr role="row" class="odd" id="remov_'+result[i].ID+'"><td class="sorting_1" width="33">'+result[i].ID+'</td><td class="sorting_1" width="33">'+result[i].zone+'</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzoneBefore('+result[i].ID+')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>');
							}
						$(".dataTables_scroll").show();
						$(".zoneform").hide();
						$('#view_zone').modal('show');
					
					
				}
				});
				}
				}); 	
	}

function deleteRecordzone(projectID,zoneID){
	
			bootbox.confirm("Are you sure?", function(result) {
			if (result == true) {
			$.ajax({
				url:application_root+"Sighting.cfc?method=DeleteZoneproject",
				type : "get",
				data : {id : projectID,zoneID:zoneID},
				success:function(data) {
					
					$('html, body').animate({scrollTop : 0},800);
					
					$(".message").html("<div class='alert alert-success'> <strong>Success!</strong> Zone Deleted.</div>").show();
					$("#remov_"+zoneID).remove();
					setTimeout(function(){$(".message").hide();},5000);
					
				}
				});
				}
				}); 	
	}


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
    		
				document.getElementById("myform").submit();
			
		}
		
function submitsightForm() {
		var id=document.getElementById('sightid').value;
    		if(id==0){
				document.getElementById("myform").submit();
			}else{
    			document.getElementById("sightform").submit();
			}
		}
		
function sightingDelete() {
	
			bootbox.confirm("Are you sure?", function(result) {
			if (result == true) {
				document.getElementById("sightingDelete").submit();
				}
			}); 
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
		


		
