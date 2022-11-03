var value ='';

$('#excelval').click(function () {
    value ='export';
})
$('#exceltmp').click(function () {
    value='temp';
})
$('#exceldel').click(function () {
    value='delete';
})





$('#subsight').click(function () {
    var fixed = '';
    var pass  = $('#passss').val();
    $.ajax({
        url: application_root + "StaticData.cfc?method=getpasswordfield",
        type: "GET",
        data : {
            'pass' : pass
        },

        success:function (data) {

            if(data=="true" && value =="temp"){
                $('#myModal').modal('toggle');
                $('#passss').val('');
                window.location.replace("http://test.wildfins.org/?Module=StaticData&Page=sightingheader");
            }
            else if(data=="true" && value =='export'){
                $('#myModal').modal('toggle');
                $('#passss').val('');
                window.location.replace("http://test.wildfins.org/?Module=StaticData&Page=downloadsighting");
            }
            else if(data=="true" && value =='delete'){
                $('#myModal').modal('toggle');
                $('#passss').val('');
                window.location.replace("http://test.wildfins.org/?Module=StaticData&Page=deletesighting");
            }
            else if (data=="false"){
                $('#passss').val('');
                $('#listerror').show();
                setTimeout(function()
                { $("#listerror").hide(); }, 5000);
            }

        }
    });


})