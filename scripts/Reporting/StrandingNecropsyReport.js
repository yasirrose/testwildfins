$(document).ready(function () {
	
	$('#allReport').DataTable({
		"pageLength": 100,
		"scrollX": true,
		"paging": false,
		"messageTop": null,
		"info": false,
		"responsive": true,
		"title": false,
		dom: 'Brtip',
		buttons: [
			{
				extend: 'copy',
            },
            {
                extend: 'excelHtml5',
                title: null
            },
            {
                extend: 'csv',
            }
          
        ]
	});
	$('input[name="date"]').daterangepicker({
        opens: "right",
        format: "MM/DD/YYYY",
        separator: " - ",
		startDate: "01/01/" + moment().format('YYYY'),
        endDate: moment(),
        minDate: "01/01/1990"
	});
	
	$('input[name="bloodValueDate"]').daterangepicker({
        opens: "right",
        format: "MM/DD/YYYY",
        separator: " - ",
		startDate: "01/01/" + moment().format('YYYY'),
        endDate: moment(),
        minDate: "01/01/1990"
    });
	// Restore any saved form state (checkboxes / selects / date)
	if (typeof restoreFormState === 'function') {
		restoreFormState();
	}

	// Save form state on submit so selections persist after search
	$('#searchAllReports').on('submit', function () {
		if (typeof saveFormState === 'function') {
			saveFormState();
		}
	});
});
function showdate(){

	$('#date').trigger('click');
}
function paginate(value){
	$("#pge").val(value);
	$("#searchAllReports").submit();
}
function excel(){
	var dataTableExcelButton = $('.buttons-excel');
	if (dataTableExcelButton.length) {
		dataTableExcelButton.trigger('click');
		return;
	}
	$('#ConditionFromSighting').attr('checked', false);
	$('#AtICWMarker').attr('checked', false);
	$('#SightingStartEnd').attr('checked', false);
	$('#location').attr('checked', false);
	$('#fieldEstimate').attr('checked', false);
	$('#activity').attr('checked', false);
	$('#behavioralEvents').attr('checked', false);
	$('#feedingEcology').attr('checked', false);
	$('#fisheriesInteractions').attr('checked', false);
	$('#HBOIVesselInteractions').attr('checked', false);
	$('#boatingInteractions').attr('checked', false);
	$('#divetimes').attr('checked', false);
}
function clearAll(){
    localStorage.clear();
	$('#ConditionFromSighting').attr('checked', false);
	$('#AtICWMarker').attr('checked', false);
	$('#SightingStartEnd').attr('checked', false);
	$('#location').attr('checked', false);
	$('#fieldEstimate').attr('checked', false);
	$('#activity').attr('checked', false);
	$('#behavioralEvents').attr('checked', false);
	$('#feedingEcology').attr('checked', false);
	$('#fisheriesInteractions').attr('checked', false);
	$('#HBOIVesselInteractions').attr('checked', false);
	$('#boatingInteractions').attr('checked', false);
	$('#divetimes').attr('checked', false);
}
window.onbeforeunload = function() 
{
	localStorage.setItem("ConditionFromSighting", $('#ConditionFromSighting').is(':checked'));
	localStorage.setItem("AtICWMarker", $('#AtICWMarker').is(':checked'));
	localStorage.setItem("SightingStartEnd", $('#SightingStartEnd').is(':checked'));
	localStorage.setItem("location", $('#location').is(':checked'));
	localStorage.setItem("fieldEstimate", $('#fieldEstimate').is(':checked'));
	localStorage.setItem("activity", $('#activity').is(':checked'));
	localStorage.setItem("behavioralEvents", $('#behavioralEvents').is(':checked'));
	localStorage.setItem("feedingEcology", $('#feedingEcology').is(':checked'));
	localStorage.setItem("fisheriesInteractions", $('#fisheriesInteractions').is(':checked'));
	localStorage.setItem("HBOIVesselInteractions", $('#HBOIVesselInteractions').is(':checked'));
	localStorage.setItem("boatingInteractions", $('#boatingInteractions').is(':checked'));
	localStorage.setItem("divetimes", $('#divetimes').is(':checked'));
	localStorage.setItem("surveyRoute", $('select[name="surveyRoute"]').val());
	localStorage.setItem("BodyCondition", $('select[name="BodyCondition"]').val());
	localStorage.setItem("bodyOfWater", $('select[name="bodyOfWater"]').val());
	localStorage.setItem("surveyType", $('select[name="surveyType"]').val());
	localStorage.setItem("LesionType", $('select[name="LesionType"]').val());
	localStorage.setItem("cetaceanSpecies", $('select[name="cetaceanSpecies"]').val());
	localStorage.setItem("code", $('select[name="code"]').val());
	localStorage.setItem("SDR", $('select[name="SDR"]').val());
	localStorage.setItem("platform", $('select[name="platform"]').val());
	localStorage.setItem("NOAAStock", $('select[name="NOAAStock"]').val());
	localStorage.setItem("surveyEffort", $('select[name="surveyEffort"]').val());
	localStorage.setItem("date", $('#date').val());

	// Generic save for all checkboxes and selects in the search form
	if ($('#searchAllReports').length) {
		saveFormState();
	}
}
window.onload = function() 
{
	if (localStorage.getItem("ConditionFromSighting") == "true"){
		$('#ConditionFromSighting').attr('checked', true);
		$(".ConditionFromSighting").removeClass("hidden");
	} 
	if (localStorage.getItem("AtICWMarker") == "true"){
		$('#AtICWMarker').attr('checked', true);
		$(".AtICWMarker").removeClass("hidden");
	} 
	if (localStorage.getItem("SightingStartEnd") == "true"){
		$('#SightingStartEnd').attr('checked', true);
		$(".SightingStartEnd").removeClass("hidden");
	}
	if (localStorage.getItem("location") == "true"){
		$('#location').attr('checked', true);
		$(".location").removeClass("hidden");
	}
	if (localStorage.getItem("fieldEstimate") == "true"){
		$(".fieldEstimate").removeClass("hidden");
		$('#fieldEstimate').attr('checked', true);
	}
	if (localStorage.getItem("activity") == "true"){
		$(".activity").removeClass("hidden");
		$('#activity').attr('checked', true);
	}
	if (localStorage.getItem("behavioralEvents") == "true"){
		$(".behavioralEvents").removeClass("hidden");
		$('#behavioralEvents').attr('checked', true);
	}
	if (localStorage.getItem("feedingEcology") == "true"){
		$(".feedingEcology").removeClass("hidden");
		$('#feedingEcology').attr('checked', true);
	}
	if (localStorage.getItem("fisheriesInteractions") == "true"){
		$(".fisheriesInteractions").removeClass("hidden");
		$('#fisheriesInteractions').attr('checked', true);
	}
	if (localStorage.getItem("HBOIVesselInteractions") == "true"){
		$(".HBOIVesselInteractions").removeClass("hidden");
		$('#HBOIVesselInteractions').attr('checked', true);
	}
	if (localStorage.getItem("boatingInteractions") == "true"){
		$(".boatingInteractions").removeClass("hidden");
		$('#boatingInteractions').attr('checked', true);
	}
	if (localStorage.getItem("divetimes") == "true"){
		$(".divetimes").removeClass("hidden");
		$('#divetimes').attr('checked', true);
	}
	
	$('select[name="surveyRoute"]').val(localStorage.getItem("surveyRoute"));
	$('select[name="BodyCondition"]').val(localStorage.getItem("BodyCondition"));
	$('select[name="bodyOfWater"]').val(localStorage.getItem("bodyOfWater"));
	$('select[name="surveyType"]').val(localStorage.getItem("surveyType"));
	$('select[name="LesionType"]').val(localStorage.getItem("LesionType"));
	$('select[name="cetaceanSpecies"]').val(localStorage.getItem("cetaceanSpecies"));
	$('select[name="code"]').val(localStorage.getItem("code"));
	$('select[name="SDR"]').val(localStorage.getItem("SDR"));
	$('select[name="platform"]').val(localStorage.getItem("platform"));
	$('select[name="NOAAStock"]').val(localStorage.getItem("NOAAStock"));
	$('select[name="surveyEffort"]').val(localStorage.getItem("surveyEffort"));
	$('#date').val(localStorage.getItem("date"));
}

function getcode(){
	const v = $('select[name="cetaceanSpecies"]').val();
	
	console.log(v);
	$.ajax({
		url: application_root + "StaticDataNew.cfc?method=getCetaceancode",
		type: "post",
		data: {
			codes:v
		},
		success: function (data) {
			var obj = JSON.parse(data);
			console.log(obj);			
			$('select[name="code"]').empty();
			$('select[name="code"]').append('<option value="">Select Code</option>');
			for (var i = 0; i < obj.DATA.length; i++) {
				$('select[name="code"]').append('<option value="'+obj.DATA[i][1]+'">'+obj.DATA[i][1]+'</option>');
			}
			
		}
	});
}

// Save all checkbox/select values from the report form to localStorage
function saveFormState(){
	var $form = $('#searchAllReports');
	if (!$form.length) return;
	$form.find('input[type="checkbox"]').each(function(){
		var key = 'report_cb_' + ( $(this).attr('name') || $(this).attr('id') || $(this).attr('value') );
		try{ localStorage.setItem(key, $(this).is(':checked')); }catch(e){}
	});
	// selects (handle multi-selects by JSON-stringifying value)
	$form.find('select').each(function(){
		var key = 'report_sel_' + ( $(this).attr('name') || $(this).attr('id') );
		try{
			var v = $(this).val();
			localStorage.setItem(key, JSON.stringify(v));
		}catch(e){}
	});
	// inputs (text, number, hidden, textarea)
	$form.find('input[type="text"], input[type="number"], input[type="hidden"], textarea').each(function(){
		var key = 'report_in_' + ( $(this).attr('name') || $(this).attr('id') );
		try{ localStorage.setItem(key, $(this).val()); }catch(e){}
	});
	// radios
	$form.find('input[type="radio"]').each(function(){
		var name = $(this).attr('name');
		if (!name) return;
		var key = 'report_radio_' + name;
		// store checked value for a group once
		if (localStorage.getItem(key) === null){
			var checked = $form.find('input[type="radio"][name="'+name+'"]:checked').val();
			try{ localStorage.setItem(key, checked===undefined?null:checked); }catch(e){}
		}
	});
	// date
	try{ localStorage.setItem('report_date', $('#date').val()); }catch(e){}
}

// Restore saved checkbox/select values into the report form
function restoreFormState(){
	var $form = $('#searchAllReports');
	if (!$form.length) return;
	$form.find('input[type="checkbox"]').each(function(){
		var key = 'report_cb_' + ( $(this).attr('name') || $(this).attr('id') || $(this).attr('value') );
		var v = localStorage.getItem(key);
		if (v === 'true'){
			$(this).prop('checked', true);
			// Unhide any matching named sections if they use the name as a class
			var n = $(this).attr('name'); if (n) $('.'+n).removeClass('hidden');
		} else if (v === 'false'){
			$(this).prop('checked', false);
		}
	});
	// restore selects
	$form.find('select').each(function(){
		var key = 'report_sel_' + ( $(this).attr('name') || $(this).attr('id') );
		var v = localStorage.getItem(key);
		if (v !== null){
			try{
				var parsed = JSON.parse(v);
				$(this).val(parsed);
			}catch(e){
				$(this).val(v);
			}
			// Update Select2 UI if present and trigger change so any listeners react
			try{
				$(this).trigger('change');
				if ($(this).data('select2')) $(this).trigger('change.select2');
			}catch(e){}
		}
	});
	// restore inputs
	$form.find('input[type="text"], input[type="number"], input[type="hidden"], textarea').each(function(){
		var key = 'report_in_' + ( $(this).attr('name') || $(this).attr('id') );
		var v = localStorage.getItem(key);
		if (v !== null) $(this).val(v);
	});
	// restore radios
	var radioGroups = {};
	$form.find('input[type="radio"]').each(function(){
		var name = $(this).attr('name');
		if (!name) return;
		if (radioGroups[name]) return;
		radioGroups[name] = true;
		var key = 'report_radio_' + name;
		var v = localStorage.getItem(key);
		if (v !== null){
			$form.find('input[type="radio"][name="'+name+'"]').prop('checked', false);
			var $to = $form.find('input[type="radio"][name="'+name+'"][value="'+v+'"]');
			if ($to.length) $to.prop('checked', true);
		}
	});
	var d = localStorage.getItem('report_date'); if (d) $('#date').val(d);
}
