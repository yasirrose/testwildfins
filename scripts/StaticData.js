$(document).ready(function(){

$('#sucess-div').delay(5000).fadeOut('slow');

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

	$("button[type='reset']").on("click", function(event){
        var pagename = getParameterByName('Page');
        $("#add").attr('name', 'add'+pagename);
        $("#add").text('Submit');
	});
	
});