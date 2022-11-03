$(document).ready(function(){
    
$(".sighting_required").click(function(){
					var Sid=$("#sightid").val();
  					var Pid=$("#project_val").val();
					if(Sid==0 || Pid==0){
						 bootbox.alert('Please select Sighting');
						}
					  });


$(window).keydown(function(event){
      if(event.target.tagName != 'TEXTAREA') {
        if(event.keyCode == 13) {
          event.preventDefault();
          return false;
        }
      }
  });

handleDateTimePicker = function() {
        "use strict";
        $(".datetimepicker").datetimepicker({
            format: 'YYYY-MM-DD'
        }).on('dp.change', function(e) {
         // Revalidate the date field
		$('#add_dolphinto_dolhpin').formValidation();
        }),$(".timepicker").datetimepicker({
            format: "HH:mm"
        })
		}
	
handleDateTimePicker();
$(".search-box").select2();


	$("#mybiopsy").click(function(event){
		$('#dolphin_modal_close').trigger('click');
		setTimeout(function(){$('#biopsyid').modal('show'); }, 2000);
		event.stopPropagation();
	});
	
	$('.dolphin-modal').click(function(){
		$('#biopsyid').modal('hide');
		setTimeout(function(){$('#dolphin').modal('show'); }, 2000);
		
		});
		
	
	
	$('#Viewbiopsy').click(function(event){
									event.stopPropagation();
									});
	
	
    $("#dscore_assign").click(function(){
		
		$(".display_data").slideUp();
		$(this).hide();
		$("#goback-block").show();
		$("#goback").show();
		$("#dolhphinadd").show();
		$(".add_new").slideDown();
		$("#dolhphinassign").show();
	});
	
	$("#goback").click(function(){
		$(".add_new").slideUp();
		$(this).hide();
		$("#goback-block").hide();
		$(".display_data").slideDown();
		$("#dscore_assign").show();
		$("#dolhphinadd").hide();
		$("#dolhphinassign").hide();
		$(".add_new_dolphin_form").hide();
		
	});
	
	$("#dolhphinadd").click(function(){
			
			$(".add_new").slideUp();
			$(".add_new_dolphin_form").slideDown();
			});
	$("#dolhphinassign").click(function(){
			$(".add_new_dolphin_form").slideUp();
			$(".add_new").slideDown();
			});
	
	
	$("#dolphin_code").change(function(){
		var dolphin_ID=$(this).val();
		if(dolphin_ID!=''){
			$.ajax(
				{
				type:"post",
				Datatype: "json",
				data:{dolphin_ID:dolphin_ID},
				url : application_root+"Sighting.cfc?method=getdolphin",
				success: function(data){
					var obj = JSON.parse(data);
					
					$("#add_dscore").val(obj[0].DScore);					
					$("#add_distictdate").val(obj[0].DistinctDate);
					if(obj[0].Distinct==1){
						
					$("#add_distict").attr("checked","checked");
					}else{
					$('#add_distict').attr('checked', false);
					}
					$("#add_sex").val(obj[0].Sex);
					$("#add_Lineage").val(obj[0].Lineage);
					$("#add_FB_No").val(obj[0].FB_No);
				}}
			);
			
		}
		
	});
	
		$("#dolphin_up_code").change(function(){
		var dolphin_ID=$(this).val();
		if(dolphin_ID!=''){
			$.ajax(
				{
				type:"post",
				Datatype: "json",
				data:{dolphin_ID:dolphin_ID},
				url : application_root+"Sighting.cfc?method=getdolphin",
				success: function(data){
					var obj = JSON.parse(data);
					
					$("#update_dscore").val(obj[0].DScore);					
					$("#update_distictdate").val(obj[0].DScoreDate);
					if(obj[0].Distinct==1){
						
					$("#update_distict").attr("checked","checked");
					}else{
					$('#update_distict').attr('checked', false);
					}
					$("#update_sex").val(obj[0].Sex);
					$("#update_Lineage").val(obj[0].Lineage);
					$("#update_FB_No").val(obj[0].FB_No);
				}}
			);
			
		}
		
	});
	
	
	
/*******   Value insert into  Field  ******************/
	$(".get_val").click(function(){
		var value=$(this).attr("val");
		var id=$(this).attr("id").split("_");
		$("#"+id[0]+"_"+id[1]).val(value);
	});
	
	
	function sumcalculate(){
		
		add_pqf=parseInt($("#add_pqf").val());
		add_pqa=parseInt($("#add_pqa").val());
		add_pqc=parseInt($("#add_pqc").val());
		add_pqpro=parseInt($("#add_pqpro").val());
		add_pqpar=parseInt($("#add_pqpar").val());
		
		var sum=add_pqf+add_pqa+add_pqc+add_pqpro+add_pqpar
		$("#add_pqsum").val(sum);
		$("#add_qscoresum").val(sum);
		
	}
	$(".sum_calculate").keyup(function(){
		sumcalculate();
	});
	$(".sum_calculate").blur(function(){
		sumcalculate();
	});
	$(".sum_calculate").click(function(){
			sumcalculate();
	});
	
	function sumcalculate_update(index){
		add_pqf=parseInt($("#update_pqf"+index).val());
		add_pqa=parseInt($("#update_pqa"+index).val());
		add_pqc=parseInt($("#update_pqc"+index).val());
		add_pqpro=parseInt($("#update_pqpro"+index).val());
		add_pqpar=parseInt($("#update_pqpar"+index).val());
		
		var sum=add_pqf+add_pqa+add_pqc+add_pqpro+add_pqpar
		$("#update_pqsum_"+index).val(sum);
	}

	$(".sum_calculate_update").keyup(function(){
			var index=$(this).attr("index");
			alert(index);
		sumcalculate_update(index);
	});
	$(".sum_calculate_update").blur(function(){
		var index=$(this).attr("index");
		sumcalculate_update(index);
	});
	$(".sum_calculate_update").click(function(){
		var index=$(this).attr("index");
		sumcalculate_update(index);
	});
	
	
	$(".getvals").click(function(){
		text=$(this).text();
		val=$(this).attr("val");
		id=$(this).attr("id").split("_");
		$("#"+id[0]+"_"+id[1]).val(text);
		$("#"+id[0]+"_"+id[1]+"_ID").val(val);
		
	});
	
	
/*	///form submit
	$("#add_dolphin_form").submit(function(){
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
		
		return false;
	});
	*/
	/////Delete Dolphin
	
	$(".delete_dolphin").click(function(){
		var conf=confirm("Are you sure to Delte this Dolphin?");
		if(conf==true){
		var id=$(this).attr("id").split('_');
		SightingID=$(this).attr("Sighting_ID");
		DolphinID=$(this).attr("Dolphin_ID");
		
		$.ajax({
			type:"post",
			data:{SightingID:SightingID,DolphinID:DolphinID},
			url:application_root+"Sighting.cfc?method=del_dolphinsight",
			success:function(res){
				$("#dolphindetail_"+id[1]).remove();
				alert(res);
			}
		});
		
	}else{
	return false;
	}
	});
	
	
	///form submit
	$(document).on("click",".update_dolphin",function(){
		
		form_id=$(this).attr("data_id");
		data=$("#"+form_id).serialize();
		
		$.ajax({
			type:"post",
			data:data,
			url:application_root+"Sighting.cfc?method=update_dolphinsight",
			success:function(res){
				$(".message").show();
				$(".reset").trigger("click");
				$(".message").html(res);
				setTimeout(function(){$(".message").hide();},4000);
			}
		});
		return false;
	});
	
	
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
		
	$('#add_dolphinto_dolhpin').formValidation({
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
		Name: {
            validators: {
				notEmpty: {
                        message: 'Please Enter name'
                    }	
            }
        }
		
		}
										 
		}).on('success.form.fv', function(e) {
            	// Prevent form submission
            	e.preventDefault();
				data=$("#add_dolphinto_dolhpin").serialize();
				
				$.ajax({
						type:"post",
						data:data,
						url:application_root+"Dolphin.cfc?method=add_New_dolphin",
						success:function(res){
							$(".reset").trigger("click");
							
							$('#add_dolphinto_dolhpin').formValidation('resetForm', true);
							
							$(".message").show();
							$(".reset").trigger("click");
							$(".message").html(res);
							setTimeout(function(){$(".message").hide();},4000);
							
						}
					});
 			       });
	
	
	
$(".Source_YOB").click(function(){
		text=$(this).text();
		val=$(this).attr("value");
		$("#Source_YOB").val(text);
		$("#Source_YOB_ID").val(val);
		});	

$(".FB_Side").click(function(){
		text=$(this).text();
		
		$("#FB_Side").val(text);
		});	
	
	
//////login form Js:
$("#go_forget").click(function(){
							  $("#login_form").slideUp("slow");
							  $("#forget_form").slideDown("slow");
							  });
$("#back").click(function(){
							  $("#login_form").slideDown("slow");
							  $("#forget_form").slideUp("slow");
							  });

//////////////////////////////////Biopsy form submit
								$(document).on('submit','#biopsyform',function(){
										data =$(this).serialize();
										
										$.ajax({
										type:"post",
										data:data,
										url:application_root+"Dolphin.cfc?method=Add_Biopsy",
										success:function(res){
										//resetform
										$('#BiopsyReset').trigger('click');
										 
										$('#biopsyid').animate({scrollTop : 0},800);
										$(".message").show().html('<strong>Success</strong> Record Added.');
										setTimeout(function(){$(".message").hide();},5000);
										},
										error:function(error){
											$(".message").show().html('<strong>Alert</strong> Error occurred.');
											setTimeout(function(){$(".message").hide();},5000);
											}
										
										});
										
										
										return false;
									}); 

	
	
});
