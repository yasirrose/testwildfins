$(document).ready(function () {
	$('#example').DataTable(
		{
			bFilter: false,
			bInfo: false,
			bLengthChange: false
		}
	);
	$('input').keydown(function(e) {
		if (e.keyCode == 13) {
			$(this).closest('form').submit();
		}
	});
});

function deleteRecord(id) {
	bootbox.confirm("Are you sure?", function (result) {
		if (result == true) {
			$.ajax({
				url: application_root + "Cetaceans.cfc?method=deleteCetacean",
				type: "get",
				data: { id: id },
				success: function (data) {
					$('html, body').animate({ scrollTop: 0 }, 800);
					$(".message").show();
					$("#remov_" + id).remove();
					setTimeout(function () { $(".message").hide(); }, 3000);
				}
			});
		}
	});
}

function ApplyPagination(startmeup) {
	document.searchfrom.startHereIndex.value = startmeup;
	document.searchfrom.submit();
}
