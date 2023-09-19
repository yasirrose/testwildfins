$(document).ready(function () {
	$("#input-4").fileinput({ showCaption: false });
	$(".delete-message").hide();
	$(".update-message").hide();
	handleDateTimePicker = function () {
		"use strict";
		$("#datetimepicker1").datetimepicker({
			format: 'MM/DD/YYYY'
		}).on('dp.change', function (e) {
			// Revalidate the date field
			$('form').formValidation('revalidateField', 'DScoreDate');
		}), $("#datetimepicker2").datetimepicker({
			format: "HH:mm:ss"
		}), $("#datetimepicker_endtime").datetimepicker({
			format: 'HH:mm:ss'
		}), $("#datetimepicker_srvystrt").datetimepicker({
			format: 'HH:mm:ss'
		}), $("#datetimepicker_sightingstrt").datetimepicker({
			format: 'HH:mm:ss'
		}), $("#datetimepicker_sightingend").datetimepicker({
			format: 'HH:mm:ss'
		}), $("#datetimepicker_srvyend").datetimepicker({
			format: 'HH:mm:ss'
		}), $("#datetimepicker3").datetimepicker(), $("#datetimepicker4").datetimepicker(), $("#datetimepicker3").on("dp.change", function (e) {
			$("#datetimepicker4").data("DateTimePicker").minDate(e.date)
		}), $("#datetimepicker4").on("dp.change", function (e) {
			$("#datetimepicker3").data("DateTimePicker").maxDate(e.date)
		})
	}

	handleDateTimePicker();

	$(".search-box").select2();

	function getDolphin() {
		console.log("gfcvkb");
		var dolphin_ID = $('#dolphin_dscore').val();
		if (dolphin_ID != '') {
			console.log("dolphin_ID:", dolphin_ID);
			$.ajax(
				{
					type: "post",
					url: application_root + "Sighting.cfc?method=getDscoreJson",
					success: function (data) {
						var response = JSON.parse(data);

						$("#dscore option").each(function (i) {
							$(this).remove();
						});
						$("#dscore").val('').change();

						for (i = 0; i < response.length; i++) {
							$("#dscore").append("<option value='" + response[i].Dscore + "'>" + response[i].Dscore + "</option>");

						}

						$.ajax(
							{
								type: "post",
								Datatype: "json",
								data: { dolphin_ID: dolphin_ID },
								url: application_root + "Sighting.cfc?method=getdolphin",
								success: function (data) {
									console.log(data);
									var obj = JSON.parse(data);
									console.log(obj);
						
								}
							});
					}
				}
			);

			$.ajax({
				type: "post",
				data: { dolphin_ID: dolphin_ID },
				url: application_root + "Sighting.cfc?method=getdolphins",
				success: function (data) {
					$("#list_dolhpin").html(data);
				}
			}
			);
		} else {
			// $("#reset").trigger("click");
		}
	}


	function getFin_Fluke(species_ID, cetacean_ID) {

		var species_ID = species_ID;
		var cetacean_ID = cetacean_ID;

		if (species_ID != '') {
			$.ajax({
				type: "post",
				data: { species_ID: species_ID, cetacean_ID: cetacean_ID },
				url: application_root + "Sighting.cfc?method=getPermanentScar",
				success: function (data) {
					$("#list_dolhpin").html(data);
				}
			}
			);
		} else {
			$("#cetacean_list").empty();
			$("#CetaceanName").val("");
			$("#CetaceanId").val("");
			$("#cetacean_list").val("").trigger("change");
			//$("#reset").trigger("click");
		}
	}
	function getFinFlukeCetaceanCodes(species_ID) {

		var species_ID = species_ID;
		var cetacean_ID = "empty";
		if (species_ID != '') {
			$.ajax({
				type: "post",
				data: { species_ID: species_ID, cetacean_ID: cetacean_ID },
				url: application_root + "Sighting.cfc?method=getFin_Fluke_Cetacean_Codes",
				success: function (data) {

					$("#cetacean_list").html(data);
				}
			}
			);
		} else {
			//$("#reset").trigger("click");
		}
	}

	$("#species").change(function () {
		var species_ID = $('#species').val();
		var cetacean_ID = $('#cetacean_list').val();
		if (cetacean_ID == undefined || cetacean_ID == '') {
			var cetacean_ID = 'empty';
		} else {
			str = $("#cetacean_list option:selected").val();
			cetacean_ID = str.substr(0, str.indexOf(' '));
		}
		getFin_Fluke(species_ID, cetacean_ID);
		getFinFlukeCetaceanCodes(species_ID);
	});

	function getCetaceanImage(cetacean_id) {

		// console.log('getCetaceanImage', cetacean_id);
		if (cetacean_id != '') {
			$.ajax({
				type: "post",
				data: { cetacean_id: cetacean_id },
				url: application_root + "Sighting.cfc?method=getCetaceanImage",
				success: function (data) {
					var response = JSON.parse(data);
					// $("#setPrimaryImage").html('<img src="' + response.setPrimaryImage + '" class="image_max_width">');
					// $("#SecondaryImage").html('<img src="' + response.SecondaryImage + '" class="image_max_width">');
				}
			}
			);
		}
	}

	$("#dolphin_dscore").change(function () {
		getDolphin();
	});

	$("#cetacean_list").change(function () {
		// console.log("Reached==>");
		$("#CetaceanCodeValue").val($("#cetacean_list option:selected").text());
		str = $("#cetacean_list option:selected").val();
		cetacean_id = str.substr(0, str.indexOf(' '));
		cetacean_name = str.substr(str.indexOf(' ') + 1);
		$("#CetaceanName").val(cetacean_name);
		$("#CetaceanId").val(cetacean_id);
		getCetaceanImage(cetacean_id);
		var species_ID = $('#species').val();

		if (species_ID != undefined || species_ID != '' || cetacean_id != '' || cetacean_id != undefined) {

			getFin_Fluke(species_ID, cetacean_id);
		}


	});

});
function ResetAll(){
	$('#add_date').removeAttr('required');
	$("#ScarForm").submit();
  }
function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function (result) {

		if (result == true) {
			$.ajax({
				url: application_root + "Sighting.cfc?method=deletePermanentScar",
				type: "post",
				data: { Id: id },
				success: function (data) {
					$('html, body').animate({ scrollTop: 0 }, 800);
					$(".delete-message").show();
					$(".gradeU_" + id).remove();
					setTimeout(function () { 
						$(".delete-message").hide(); 
						ResetAll();
					}, 3000);
					
				}
			});
		}
	});
}
function updateRecord(id) {
	$('#updateFormID').val(id);
	CetaceanID = $('#CI_'+id).text();
	
	ScarDate = $('#ScarDate_'+id).text();
	ScarType = $('#ScarType_'+id).text();
	BodyRegion = $('#BodyRegion_'+id).text();
	SideOfBody = $('#SideOfBody_'+id).text();
	PrimaryImage = $('#PrimaryImage_'+id).attr('src');
	SecondryImage = $('#SecondryImage_'+id).attr('src');


	CetaceanCode = $('#CetaceanCode_'+id).text();
	// clist = CetaceanID
	// $('#cetacean_list').val(CetaceanCode).trigger('change');
	$("#cetacean_list").val($("#cetacean_list option:contains(" + CetaceanCode + ")").val()).trigger("change");
	$('#add_date').val(ScarDate);
	// $("#ScarType").val($("#ScarType option:contains(" + ScarType + ")").val()).trigger("change");
	// $('#ScarType').val(ScarType).trigger('change');
	// $('#BodyRegion').val(BodyRegion).trigger('change');
	if (ScarType !== '') {
		$("#ScarType option:selected").prop('selected', false);
		var scarTypeValues = ScarType.split(',');
	  
		scarTypeValues.forEach(function(optionValue) {
		  $("#ScarType option:contains('" + optionValue.trim() + "')").prop('selected', true);
		});
		$("#ScarType").trigger("change");
	  }
	if (BodyRegion !== '') {
		$("#BodyRegion option:selected").prop('selected', false);
		var bodyRegionValues = BodyRegion.split(',');
		bodyRegionValues.forEach(function(optionValue) {
		$("#BodyRegion option:contains('" + optionValue.trim() + "')").prop('selected', true);
		});
		$("#BodyRegion").trigger("change");
	}


	$('#SideOfBody').val(SideOfBody).trigger('change');
	$("#setPrimaryImage").html('<img src="' + PrimaryImage + '" class="image_max_width">');
	$("#SecondaryImage").html('<img src="' + SecondryImage + '" class="image_max_width">');
	$('#insertScar').text('Update');
	document.documentElement.scrollTop = 0;
}
function checkValue(e){
	Species = $('#species').val();
	CetaceanCode = $('#cetacean_list').val();

	if(Species == '' ){
		e.preventDefault();
		$('#errorMessage').show();
	}else{
		$('#errorMessage').hide();
	}
	if(CetaceanCode == ''){
		e.preventDefault();
		$('#requiredCetaceanCode').show();
	}else{
		
		$('#requiredCetaceanCode').hide();
	}
}