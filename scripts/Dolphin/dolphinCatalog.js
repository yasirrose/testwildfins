function ApplyPagination(startmeup)
{
	document.dolphinCatalog.startHereIndex.value = startmeup;
	document.dolphinCatalog.submit();
}
$(".viewDolphinImage").on("click", function() {
	$('#imagepreview').attr('src', $(this).data('url'));  
	$('#imagemodal').modal('show'); 
});
$(".removeDolphin").on("click", function() {
	$(this).parent("li").remove();
});
$("#btnReset").on('click',function(){
	$("select[name=catalog]").val("");
	$("select[name=dscore]").val("");
});
this.imagePreview = function(){	
	/* CONFIG */
		
		xOffset = 10;
		yOffset = 30;
		
		// these 2 variable determine popup's distance from the cursor
		// you might want to adjust to get the right result
		
	/* END CONFIG */
	$("a.preview").hover(function(e){
		this.t = this.title;
		this.title = "";	
		var c = (this.t != "") ? "<br/>" + this.t : "";
		var url = $(this).data("url");
		$("body").append("<p id='preview'><img width='400' height='400' src='"+ url +"' alt='Image preview' />"+ c +"</p>");
		var  current_possition = e.pageX + yOffset;
		if(current_possition+410 > $(window).width()){
			current_possition = current_possition-450;
		}								 
		$("#preview")
			.css("top","10%")
			.css("left",(current_possition) + "px")
			.fadeIn("fast");						
    },
	function(){
		this.title = this.t;	
		$("#preview").remove();
    });	
	$("a.preview").mousemove(function(e){
		/*$("#preview")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px");*/
	});			
};
// starting the script on page load
$(document).ready(function(){
	imagePreview();
});
