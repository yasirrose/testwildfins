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
									// var option = obj[0].DScore;

									// $("#dolphin_id").val(obj[0].DolphinID);
									// $("#dolphin_name").val(obj[0].Name);
									// $("#recordid").val(obj[0].ID);
									// var image="<img src='"+obj[0].Fin+"' width='200' height='200' id='imageresource'>";
									// $("#image").html(image);
									// $("#dscore option").each(function(i) {
									// 	$('#dscore option[value="'+option+'"]').prev().remove();										
									// });
									//  $("#dscore").val(option).change();
									// $("#image").on("click", function() {
									// $('#imagepreview').attr('src', $('#imageresource').attr('src')); // here asign the image to the modal when the user click the enlarge link
									// $('#imagemodal').modal('show'); // imagemodal is the id attribute assigned to the bootstrap modal, then i use the show function
									// });
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
			$("#reset").trigger("click");
		}
	}


	function getFin_Fluke(species_ID, cetacean_ID) {

		var species_ID = species_ID;
		var cetacean_ID = cetacean_ID;

		if (species_ID != '') {
			$.ajax({
				type: "post",
				data: { species_ID: species_ID, cetacean_ID: cetacean_ID },
				url: application_root + "Sighting.cfc?method=getFin_Fluke",
				success: function (data) {
					$("#list_dolhpin").html(data);
				}
			}
			);
		} else {
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

		console.log('getCetaceanImage', cetacean_id);
		if (cetacean_id != '') {
			$.ajax({
				type: "post",
				data: { cetacean_id: cetacean_id },
				url: application_root + "Sighting.cfc?method=getCetaceanImage",
				success: function (data) {
					var response = JSON.parse(data);
					$("#setPrimaryImage").html('<img src="' + response.setPrimaryImage + '" class="image_max_width">');
					$("#SecondaryImage").html('<img src="' + response.SecondaryImage + '" class="image_max_width">');
				}
			}
			);
		}
	}

	$("#dolphin_dscore").change(function () {
		getDolphin();
	});

	$("#cetacean_list").change(function () {
		console.log("Reached==>");
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



	/*$('#datetimepicker1')
			.datepicker({
				format: 'mm/dd/yyyy HH:mm:ss'
			})
			.on('changeDate', function(e) {
				// Revalidate the date field
				$('form').formValidation('revalidateField', 'DScoreDate');
			});
	*/

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
			DScore: {
				validators: {
					notEmpty: {
						message: 'Please enter DScore'
					},
					stringLength: {
						message: 'Only 2 characters allowed',
						max: function (value, validator, $field) {
							return 2 - (value.match(/\r/g) || []).length;
						}
					}
				}
			},
			DolphiID: {
				validators: {
					notEmpty: {
						message: 'Please select Dolphin'
					}
				}
			},
			DScoreDate: {
				validators: {
					notEmpty: {
						message: 'Please select Date'
					},
					date: {
						format: 'MM/DD/YYYY',
						message: 'The Date is not a valid date'
					}
				}
			}

		}
	});

	// getDolphin();
});

function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function (result) {

		if (result == true) {
			$.ajax({
				url: application_root + "Sighting.cfc?method=deleteFin_Fluke",
				type: "post",
				data: { fin_flukeId: id },
				success: function (data) {
					$('html, body').animate({ scrollTop: 0 }, 800);
					$(".delete-message").show();
					$(".gradeU_" + id).remove();
					setTimeout(function () { $(".delete-message").hide(); }, 3000);
				}
			});
		}
	});
}
function updateRecord(id) {
	var quotations = [];
	$('select#description').find('option').each(function () {
		var locations = {
			text: $.trim($(this).text()),
			value: $.trim($(this).val())
		};
		quotations.push(locations);

	});

	console.log(quotations);

	bootbox.prompt({
		size: "small",
		title: "Select Description",
		inputType: "select",
		inputOptions: quotations,
		className: "bootbox-input-select",
		buttons: {
			confirm: {
				label: "Update"
			}
		},
		callback: function (result) {
			new_description = $(".bootbox-input-select :selected").text();
			if (result != null) {
				console.log("reached");
				console.log(result);
				// return false;
				$.ajax({
					url: application_root + "Sighting.cfc?method=updateFin_Fluke",
					type: "post",
					data: { fin_flukeId: id, description: result },
					success: function (data) {
						$('html, body').animate({ scrollTop: 0 }, 800);
						$(".update-message").show();
						$("tr.gradeU_" + id + " td:nth-child(6)").text(new_description);
						setTimeout(function () { $(".update-message").hide(); }, 3000);
					}
				});
			}
		},
	});

}