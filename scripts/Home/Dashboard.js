
$(document).ready(function() {
    $('input[name="date"]').daterangepicker({
        opens: "right",
        format: "MM/DD/YYYY",
        separator: " - ",
        startDate: "01/01/" + moment().format('YYYY'),
        endDate: moment(),
        minDate: "01/01/1990"
    });
    $('input[name="Animaldate"]').daterangepicker({
        opens: "right",
        format: "MM/DD/YYYY",
        separator: " - ",
        startDate: "01/01/" + moment().format('YYYY'),
        endDate: moment(),
        minDate: "01/01/1990"
    });
    $('input[name="Incident_date"]').daterangepicker({
        opens: "right",
        format: "MM/DD/YYYY",
        separator: " - ",
        startDate: "01/01/" + moment().format('YYYY'),
        endDate: moment(),
        minDate: "01/01/1990"
    });

});
function takesdate(){
    $("#date_takes").trigger('click');
};
function dateshow(){
    $("#date_animals").trigger('click');
}
function incidentdate(){
    $("#Incident_date").trigger('click');
}
getTotalTakesByFilters();
getDataByFilter();
getIncidentReports();
getAnimalsByFilters();

$('#Date-range-takes').on('apply.daterangepicker', (e, picker) => {
    getTotalTakesByFilters();
});
$('#Date-range-animals').on('apply.daterangepicker', (e, picker) => {
    getAnimalsByFilters();
});

$('#Date-range-incident').on('apply.daterangepicker', (e, picker) => {
    getIncidentReports();
});

function getDataByFilter() {
    
    species = $("#species option:selected").text();
    species = species.trim();
    status = $("#status option:selected").val();
    categories = $("#categories option:selected").text();
    categories = categories.trim();
    $.ajax({
        url: application_root +
            "StaticDataNew.cfc?method=getTrackingListByFilter",
        Datatype: "json",
        type: "get",
        data: {
            species: species,
            status: status,
            categories: categories,
        },
        success: function (data) {
            $("#trackingHistory > tbody").empty();
            var obj = JSON.parse(data);
            for (var i = 0; i < obj.DATA.length; i++) {
                $("#trackingHistory > tbody").append('<tr><td>' + obj.DATA[i][1] + '</td><td>' + obj.DATA[i][2] +  '</td><td>' + obj.DATA[i][3] + '</td><td>' + obj.DATA[i][5] +'</td></tr>'); 
            }
        }
    });
    
}
function getAnimalsByFilters() {
    species_takes = $("#species_animals option:selected").val();
    surveyRoute = $("#surveyRoute_animals option:selected").val();
    date_takes = $("#date_animals").val();
    $.ajax({
        url: application_root +
            "StaticDataNew.cfc?method=getAnimalsByFilters",
        Datatype: "json",
        type: "get",
        data: {
            species: species_takes,
            date: date_takes,
            surveyRoute: surveyRoute,
        },
        success: function (data) {
            var obj = JSON.parse(data);
            if(obj['Total'] == null)
            $("#Total_animals").html(0); 
            else
            $("#Total_animals").html(obj['Total']); 
            
            if(obj['Adults'] == null)
            $("#Adults_animals").html(0); 
            else
            $("#Adults_animals").html(obj['Adults']); 

            if(obj['Calfs'] == null)
            $("#Calves_animals").html(0); 
            else
            $("#Calves_animals").html(obj['Calfs']); 

            $("#CodesDOD > tbody").empty();
            for (var i = 0; i < obj['TotalDOD']['DATA'].length; i++) {
                $("#CodesDOD > tbody").append('<tr><td>' + obj['TotalDOD']['DATA'][i][0] + '</td><td>' + obj['TotalDOD']['DATA'][i][1] + '</td></tr>'); 
            }
           
        }
    });
    
}
function exportExcel() {
    let table = document.getElementsByTagName("table"); // you can use document.getElementById('tableId') as well by providing id to the table tag
    TableToExcel.convert(table[0], { // html code may contain multiple tables so here we are refering to 1st table tag
        name: `Codes.xlsx`, // fileName you could use any name
        sheet: {
        name: 'Sheet 1' // sheetName
        }
    });
    
}
function getIncidentReports() {
    Incident_date = $("#Incident_date").val();
    $.ajax({
        url: application_root +
            "StaticDataNew.cfc?method=getIncidentReports",
        Datatype: "json",
        type: "get",
        data: {
            date: Incident_date,
        },
        success: function (data) {
            $("#incidentReports > tbody").empty();
            var obj = JSON.parse(data);
            for (var i = 0; i < obj.DATA.length; i++) {
                $("#incidentReports > tbody").append('<tr><td>' + obj.DATA[i][0] + '</td><td>' + obj.DATA[i][1] + '</td></tr>'); 
            }
        }
    });
    
}
function getTotalTakesByFilters() {
    console.log('tttt');
    species_takes = $("#species_takes option:selected").val();
    surveyRoute = $("#surveyRoute_takes option:selected").val();
    date_takes = $("#date_takes").val();
    
    $.ajax({
        url: application_root +
            "StaticDataNew.cfc?method=getTotalTakesByFilters",
        Datatype: "json",
        type: "get",
        data: {
            species: species_takes,
            date: date_takes,
            surveyRoute: surveyRoute,
        },
        success: function (data) {
            var obj = JSON.parse(data);
            if(obj.DATA[0][0] == null)
            $("#Adults").html(0); 
            else
            $("#Adults").html(obj.DATA[0][0]); 
            if(obj.DATA[0][1] == null)
            $("#Calves").html(0); 
            else
            $("#Calves").html(obj.DATA[0][1]); 
            if(obj.DATA[0][2] == null)
            $("#YoY").html(0); 
            else
            $("#YoY").html(obj.DATA[0][2]); 
            if(obj.DATA[0][3] == null)
            $("#Total").html(0); 
            else
            $("#Total").html(obj.DATA[0][3]); 
            // $("#Total").html(obj.DATA[0][0]+obj.DATA[0][1]+obj.DATA[0][2]); 
        }
    });
    
}
