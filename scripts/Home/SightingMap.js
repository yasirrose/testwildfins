$(document).ready(function () {
	
	$('input[name="date"]').daterangepicker({
        opens: "right",
        format: "MM/DD/YYYY",
        separator: " - ",
		startDate: "01/01/" + moment().format('YYYY'),
        endDate: moment(),
        minDate: "01/01/1990"
    });
});
function showdate(){

	$('#date').trigger('click');
}

// window.onbeforeunload = function() 
// {
// 	localStorage.setItem("ConditionFromSighting", $('#ConditionFromSighting').is(':checked'));
// 	localStorage.setItem("AtICWMarker", $('#AtICWMarker').is(':checked'));
// 	localStorage.setItem("SightingStartEnd", $('#SightingStartEnd').is(':checked'));
// 	localStorage.setItem("location", $('#location').is(':checked'));
// 	localStorage.setItem("fieldEstimate", $('#fieldEstimate').is(':checked'));
// 	localStorage.setItem("activity", $('#activity').is(':checked'));
// 	localStorage.setItem("behavioralEvents", $('#behavioralEvents').is(':checked'));
// 	localStorage.setItem("feedingEcology", $('#feedingEcology').is(':checked'));
// 	localStorage.setItem("fisheriesInteractions", $('#fisheriesInteractions').is(':checked'));
// 	localStorage.setItem("HBOIVesselInteractions", $('#HBOIVesselInteractions').is(':checked'));
// 	localStorage.setItem("boatingInteractions", $('#boatingInteractions').is(':checked'));
// 	localStorage.setItem("divetimes", $('#divetimes').is(':checked'));
// 	localStorage.setItem("surveyRoute", $('select[name="surveyRoute"]').val());
// 	localStorage.setItem("BodyCondition", $('select[name="BodyCondition"]').val());
// 	localStorage.setItem("bodyOfWater", $('select[name="bodyOfWater"]').val());
// 	localStorage.setItem("surveyType", $('select[name="surveyType"]').val());
// 	localStorage.setItem("LesionType", $('select[name="LesionType"]').val());
// 	localStorage.setItem("cetaceanSpecies", $('select[name="cetaceanSpecies"]').val());
// 	localStorage.setItem("code", $('select[name="code"]').val());
// 	localStorage.setItem("SDR", $('select[name="SDR"]').val());
// 	localStorage.setItem("platform", $('select[name="platform"]').val());
// 	localStorage.setItem("NOAAStock", $('select[name="NOAAStock"]').val());
// 	localStorage.setItem("surveyEffort", $('select[name="surveyEffort"]').val());
// 	localStorage.setItem("date", $('#date').val());
// }
// window.onload = function() 
// {
// 	if (localStorage.getItem("ConditionFromSighting") == "true"){
// 		$('#ConditionFromSighting').attr('checked', true);
// 		$(".ConditionFromSighting").removeClass("hidden");
// 	} 
// 	if (localStorage.getItem("AtICWMarker") == "true"){
// 		$('#AtICWMarker').attr('checked', true);
// 		$(".AtICWMarker").removeClass("hidden");
// 	} 
// 	if (localStorage.getItem("SightingStartEnd") == "true"){
// 		$('#SightingStartEnd').attr('checked', true);
// 		$(".SightingStartEnd").removeClass("hidden");
// 	}
// 	if (localStorage.getItem("location") == "true"){
// 		$('#location').attr('checked', true);
// 		$(".location").removeClass("hidden");
// 	}
// 	if (localStorage.getItem("fieldEstimate") == "true"){
// 		$(".fieldEstimate").removeClass("hidden");
// 		$('#fieldEstimate').attr('checked', true);
// 	}
// 	if (localStorage.getItem("activity") == "true"){
// 		$(".fieldEstimate").removeClass("hidden");
// 		$('#activity').attr('checked', true);
// 	}
// 	if (localStorage.getItem("behavioralEvents") == "true"){
// 		$(".behavioralEvents").removeClass("hidden");
// 		$('#behavioralEvents').attr('checked', true);
// 	}
// 	if (localStorage.getItem("feedingEcology") == "true"){
// 		$(".feedingEcology").removeClass("hidden");
// 		$('#feedingEcology').attr('checked', true);
// 	}
// 	if (localStorage.getItem("fisheriesInteractions") == "true"){
// 		$(".fisheriesInteractions").removeClass("hidden");
// 		$('#fisheriesInteractions').attr('checked', true);
// 	}
// 	if (localStorage.getItem("HBOIVesselInteractions") == "true"){
// 		$(".HBOIVesselInteractions").removeClass("hidden");
// 		$('#HBOIVesselInteractions').attr('checked', true);
// 	}
// 	if (localStorage.getItem("boatingInteractions") == "true"){
// 		$(".boatingInteractions").removeClass("hidden");
// 		$('#boatingInteractions').attr('checked', true);
// 	}
// 	if (localStorage.getItem("divetimes") == "true"){
// 		$(".divetimes").removeClass("hidden");
// 		$('#divetimes').attr('checked', true);
// 	}
	
// 	$('select[name="surveyRoute"]').val(localStorage.getItem("surveyRoute"));
// 	$('select[name="BodyCondition"]').val(localStorage.getItem("BodyCondition"));
// 	$('select[name="bodyOfWater"]').val(localStorage.getItem("bodyOfWater"));
// 	$('select[name="surveyType"]').val(localStorage.getItem("surveyType"));
// 	$('select[name="LesionType"]').val(localStorage.getItem("LesionType"));
// 	$('select[name="cetaceanSpecies"]').val(localStorage.getItem("cetaceanSpecies"));
// 	$('select[name="code"]').val(localStorage.getItem("code"));
// 	$('select[name="SDR"]').val(localStorage.getItem("SDR"));
// 	$('select[name="platform"]').val(localStorage.getItem("platform"));
// 	$('select[name="NOAAStock"]').val(localStorage.getItem("NOAAStock"));
// 	$('select[name="surveyEffort"]').val(localStorage.getItem("surveyEffort"));
// 	$('#date').val(localStorage.getItem("date"));
// }
