$(document).ready(function(){
						   
	
handleDateTimePicker = function() {
        "use strict";
        $(".datetimepicker").datetimepicker({
            format: 'MM/DD/YYYY'
        }).on('dp.change', function(e) {
         // Revalidate the date field
		var name=$(this).attr('name');
		$('#update_dolphinto_dolhpin').formValidation('revalidateField',name);
		$('#MMHSRPform').formValidation('revalidateField',name);
        });
		}
	
handleDateTimePicker();
 
								$("#viewbtn_Biopsy").click(function(){
										var id=$(this).attr('dolphinID');
										$(".addBiopsy_disp").hide();
										 $.ajax({
											  type:"get",
											  data:{'id':id},
											   url:application_root+"Dolphin.cfc?method=getBiopsy",
												success:function(result){
													result = JSON.parse(result);
													console.log(result);
												if (result.DATA.length > 0) {
												$('#listBiopsyBYdolphin').html('');
												var domain=document.domain;
												for(var i = 0; i<result.DATA.length; i++) {
													output='<tr id="remov_'+result.DATA[i][0]+'" class="inverse"><td>'+result.DATA[i][1]+'</td><td>'+result.DATA[i][3]+'</td><td>'+result.DATA[i][2]+'</td><td>';
													
													if(result.DATA[i][4]==true){
														output+='Hit';
													} else if(result.DATA[i][4]==false){
														output+='Miss';
													} else{
														output+='';	
														}		
													output+='</td><td><a href="http://'+domain+'?Module=Sighting&Page=EditBiopsy&Biopsy='+result.DATA[i][0]+'" class="btn btn-xs btn-primary" target="_blank"><i class="fa fa-pencil-square-o"></i></a> <button onclick="deleteRecordBiopsy('+result.DATA[i][0]+')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td></tr>';
												$('#listBiopsyBYdolphin').append(output);
														}
											
											$(".listBiopsy_disp").show();
												}else{
													$('#listBiopsyBYdolphin').html('<tr><td colspan="5"><b>Biopsy not Found</b></td></tr>');
													}
												
												
												}
											  
											  });
										 
										 
								 });
								$("#addbtn_Biopsy").click(function(){
										 $(".addBiopsy_disp").show();
										 $(".listBiopsy_disp").hide();
								 });
						   
 });//ready


	$('#update_dolphinto_dolhpin').formValidation({
		
        framework: 'bootstrap',
			err: {
				container: 'tooltip'
			},
			icon: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
      /*  fields: {
				Name: {
					validators: {
						notEmpty: {
								message: 'Please Enter name'
							}	
						}
					},
				Date_of_Birth_EST: {
					validators: {
						notEmpty: {
								message: 'Please Enter name'
							}
					}
					},
			  DistinctDate: {
					validators: {
						notEmpty: {
								message: 'Please Enter name'
							},
						date: {
									format: 'MM/DD/YYYY',
									message: 'This date  is not a valid'
								}
						}
					},
			Date_of_Death: {
					validators: {
						notEmpty: {
								message: 'Please Enter name'
							},
						date: {
									format: 'MM/DD/YYYY',
									message: 'This date  is not a valid'
								}
						}
					},
			Dispersal_Date: {
					validators: {
						notEmpty: {
								message: 'Please Enter name'
							},
						date: {
									format: 'MM/DD/YYYY',
									message: 'This date  is not a valid'
								}
						}
					},
			YearOfBirth: {
					validators: {
						notEmpty: {
								message: 'Please Enter name'
							}
						}
					},
			First_Sighting_Date: {
					validators: {
						notEmpty: {
								message: 'Please Enter name'
							},
						date: {
									format: 'MM/DD/YYYY',
									message: 'This date  is not a valid'
								}
						}
					}
	  } */
		}).on('success.form.fv', function(e) {
			
            	// Prevent form submission
            	e.preventDefault();
				 data=$("#update_dolphinto_dolhpin").serialize();
				var fd= new FormData(document.getElementById("update_dolphinto_dolhpin"));
				$.ajax({
						
						url:application_root+"Dolphin.cfc?method=update_New_dolphin",
						type: "POST",
						data: fd,
						enctype: 'multipart/form-data',
						processData: false,  // tell jQuery not to process the data
						contentType: false,   // tell jQuery not to set contentType
						success:function(res){
						$(".message").show();
							$(".message").html(res);
							setTimeout(function(){$(".message").hide();},4000);
							
						}
					});
 			       });
	
$("#viewbtn").click(function(){
								 $(".addMMHSRP_disp").hide();
								 $(".listMMHSRP_disp").show();
								 });
$("#addbtn").click(function(){
								 $(".addMMHSRP_disp").show();
								 $(".listMMHSRP_disp").hide();
								 });

$('#changesex').change(function () {
    $('#sourcedsex').show();
})

$('#MMHSRPform').formValidation({
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
					MMHSRP_ID: {
								validators: {
									notEmpty: {
										message: 'The quantity is required'
									}
								}
							},
					Description: {
								validators: {
									notEmpty: {
										message: 'The Description is required'
									},
									integer: {
										message: 'The Description must be a number'
									}
								}
							},
							
					Date_MMHSRP: {
						validators: {
							notEmpty: {
									message: 'Please Enter name'
								},
							date : {
										format: 'MM/DD/YYYY',
										message: 'This date  is not a valid'
									}
						}
					}
            }
        });
		

function deleteRecord(id) {
	
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"Dolphin.cfc?method=DeleteMMHSRP",
		type : "get",
		data : {id : id},
		success:function(data) {
			
			$('html, body').animate({scrollTop : 0},800);
			
			$("#succesmessage").show();
			$("#remov_"+id).remove();
			setTimeout(function(){$("#succesmessage").hide();},3000);
			
		}
	});
	}
	}); 
}

function deleteRecordBiopsy(id) {
	
	bootbox.confirm("Are you sure?", function(result) {
	
	if (result == true) {
	$.ajax({
		url:application_root+"Dolphin.cfc?method=DeleteBiopsy",
		type : "get",
		data : {id : id},
		success:function(data) {
			
			$('#biopsyid').animate({scrollTop : 0},800);
			
			$(".message").show().html('Biopsy Deleted.');
			$("#remov_"+id).remove();
			setTimeout(function(){$(".message").hide();},3000);
			
		}
	});
	}
	}); 
}

