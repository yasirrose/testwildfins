$(document).ready(function() {
    handleDateTimePicker = function () {
        "use strict";
        $('#datetimepicker_StartTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#StartTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_EndTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#EndTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_heartRateTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#heartRateTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_respRateTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#respRateTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_DrugTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#DrugTime").formValidation('revalidateField', name);
        });
        $('#datetimepicker_Date').datetimepicker({ format: 'MM/DD/YYYY' }).on('dp.change', function(e) {
            // Revalidate the date field
            var name=$(this).attr('name');
            $("#date").formValidation('revalidateField', name);
        });
    
    }  
    handleDateTimePicker();
    handleJqueryTagIt();  
    // getCode(); 
    $(".removeSeclectValue").css("display", "none");
   
})
const heartRateArray = [];
const heartRateTimeArray = [];
const respRateArray = [];
const respRateTimeArray = [];
const DrugtypeArray = [];
const DrugMethodeArray = [];
const DrugTimeArray = [];
const DrugDosageArray = [];
const DrugVolumeArray = [];
const BiopsyTypeArray = [];
const BiopsyLocationArray = [];
const BiopsySizeArray = [];
const LesionPresentArray = [];
const LesionTypeArray = [];
const RegionArray = [];
const SideArray = [];
const StatusArray = [];


function getCode() {
    species = $("#species option:selected").val();
    sp = $("#species option:selected").text();
    $("#speciesee").val(sp);
    $('#code').empty();
    $('#code').append(new Option('Select Code', '0'));
    if (species != 0) {
        $.ajax({
            url: application_root +
                "SightingNew.cfc?method=getCetaceansCodeForTracking",
            Datatype: "json",
            type: "get",
            data: {
                Cetacean_Species: species,
            },
            success: function (data) {
                var obj = JSON.parse(data);
                for (var i = 0; i < obj.DATA.length; i++) {
                    $('#code').append(new Option(obj.DATA[i][0], obj.DATA[i][1]));
                }
            }
        });
    }
    $("#DorsalFinHeight").hide();
    $("#RostrumtoBlowhole").hide();
    if(species == 5 || species == 12){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Tursiops_Diagram.png");
        $("#measureImg").val("Tursiops_Diagram.png");
    }
    if(species == 6){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Humpback_Diagram.png");
        $("#measureImg").val("Humpback_Diagram.png");
    }
    if(species == 7 || species == 15){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Kogia_Diagram.png");
        $("#measureImg").val("Kogia_Diagram.png");
        $("#DorsalFinHeight").show();
        $("#RostrumtoBlowhole").show();
    }
    if(species == 8 || species == 9){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Globicephala_Diagram.png");
        $("#measureImg").val("Globicephala_Diagram.png");
    }
    if(species == 10){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Rissos_Diagram.png");
        $("#measureImg").val("Rissos_Diagram.png");
    }
    if(species == 11 || species == 13 || species == 22 || species == 23|| species == 24){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Stenella_Species_Diagram.png");
        $("#measureImg").val("Stenella_Species_Diagram.png");
    }
    if(species == 14){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/melon_headed_whale_measurement_diagram.png");
        $("#measureImg").val("melon_headed_whale_measurement_diagram.png");
    }
    if(species == 16){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/SpermWhale_Diagram.png");
        $("#measureImg").val("SpermWhale_Diagram.png");
    }
    if(species == 17){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Steno_Diagram.png");
        $("#measureImg").val("Steno_Diagram.png");
    }
    if(species == 18 || species == 19){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Mesoplodon_Species_Diagram.png");
        $("#measureImg").val("Mesoplodon_Species_Diagram.png");
    }
    if(species == 20){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Cuviers_Diagram.png");
        $("#measureImg").val("Cuviers_Diagram.png");
    }
    if(species == 21){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/FalseKillerWhale_Diagram.png");
        $("#measureImg").val("FalseKillerWhale_Diagram.png");
    }
    if(species == 25){
        $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/NARW_Diagram.png");
        $("#measureImg").val("NARW_Diagram.png");
    }

}

function AddNewRate() {
    heartRate = $("#heartRate").val().trim();
    heartRateTime = $("#heartRateTime").val();
    if (heartRate != '' && heartRateTime !='') {
        heartRateArray.push(heartRate);
        heartRateTimeArray.push(heartRateTime);
        $("#hr").val(heartRateArray);
        $("#hrt").val(heartRateTimeArray);
        $("#heartRate").val("");
        $("#heartRateTime").val("");
        $("#heartHistory").show()   
        $("#heartHistory > tbody").append('<tr><td>' + heartRate + '</td><td>' + heartRateTime + '</td></tr>'); 
        $("#H_rate").html('');
        $("#H_rate_time").html('');
    }else{
        if(heartRate == ''){
            $("#H_rate").html("*Heart Rate Required");
        }
        if(heartRateTime == ''){
            $("#H_rate_time").html("*Time Required");
        }
    }
}

function AddNewResp() {
    respRate = $("#respRate").val().trim();
    respRateTime = $("#respRateTime").val();
    if (respRate != '' && respRateTime !='') {
        respRateArray.push(respRate);
        respRateTimeArray.push(respRateTime);
        $("#rr").val(respRateArray);
        $("#rrt").val(respRateTimeArray);
        $("#respRate").val("");
        $("#respRateTime").val("");
        $("#respHistory").show()   
        $("#respHistory > tbody").append("<tr><td>" + respRate + "</td><td>" + respRateTime + "</td></tr>");  
        $("#resp_rate").html('');
        $("#resp_rate_time").html('');
    }else{
        if(respRate == ''){
            $("#resp_rate").html("*Resp Rate Required");
        }
        if(respRateTime == ''){
            $("#resp_rate_time").html("*Time Required");
        }
    }
}

function AddNewDrug() {
    Drugtype = $("#Drugtype option:selected").text();
    DrugMethod = $("#DrugMethod option:selected").val();
    DrugTime = $("#DrugTime ").val();
    DrugDosage = $("#DrugDosage").val().trim();
    DrugVolume = $("#DrugVolume").val().trim();

    if (Drugtype != '' && DrugMethod !='' && DrugTime != '' && DrugDosage != '' && DrugVolume != '') {
        DrugtypeArray.push(Drugtype);
        DrugMethodeArray.push(DrugMethod);
        DrugTimeArray.push(DrugTime);
        DrugDosageArray.push(DrugDosage);
        if(DrugVolume == ""){
            DrugVolumeArray.push("0");
        }else{
         DrugVolumeArray.push(DrugVolume);
        }

        $("#dt").val(DrugtypeArray);
        $("#dm").val(DrugMethodeArray);
        $("#dtime").val(DrugTimeArray);
        $("#dd").val(DrugDosageArray);
        $("#dv").val(DrugVolumeArray);
        // set empty input fields after add
        $("#Drugtype").val("");
        $("#DrugMethod").val("");
        $("#DrugTime").val("");
        $("#DrugDosage").val("");
        $("#DrugVolume").val("");

        $("#drugHistory").show()   
        $("#drugHistory > tbody").append("<tr><td>" + Drugtype + "</td><td>" + DrugMethod + "</td><td>" + DrugTime + "</td><td>" + DrugDosage + "</td><td>" + DrugVolume + "</td></tr>");
        // set empty error msgs after add   
        $("#D_type").html(''); 
        $("#D_method").html('');
        $("#D_time").html('');
        $("#D_dosage").html('');
        $("#D_volume").html('');
    }else{
        if(Drugtype == ''){
            $("#D_type").html("*Type Required");
        }
        if(DrugMethod == ''){
            $("#D_method").html("*Method Required");
        }
        if(DrugTime == ''){
            $("#D_time").html("*Time Required");
        }
        if(DrugDosage == ''){
            $("#D_dosage").html("*Dosage Required");
        }
        // if(DrugVolume == ''){
        //     $("#D_volume").html("*Volume Required");
        // }
    }
}
function AddNewBiopsy() {
    
    BiopsyType = $("#BiopsyType option:selected").val();
    BiopsyLocation = $("#BiopsyLocation option:selected").val();
    BiopsySize = $("#BiopsySize").val().trim();
    
    if (BiopsyType != '' && BiopsyLocation !='' && BiopsySize != '' ) {
        BiopsyTypeArray.push(BiopsyType);
        BiopsyLocationArray.push(BiopsyLocation);
        BiopsySizeArray.push(BiopsySize);
        $("#bte").val(BiopsyTypeArray);
        $("#bloc").val(BiopsyLocationArray);
        $("#bsize").val(BiopsySizeArray);
        $("#BiopsyType").val("");
        $("#BiopsyLocation").val("");
        $("#BiopsySize").val("");

        $("#biopsyHistory").show()   
        $("#biopsyHistory > tbody").append("<tr><td>" + BiopsyType + "</td><td>" + BiopsyLocation + "</td><td>" + BiopsySize + "</td></tr>"); 
        $("#B_type").html('');
        $("#B_location").html('');
        $("#B_size").html(''); 
    }else{
        if(BiopsyType == ''){
            $("#B_type").html('*Biopsy Type Required');
        }
        if(BiopsyLocation == ''){
            $("#B_location").html('*Biopsy Location Required');
        }
        if(BiopsySize == ''){
            $("#B_size").html('*Biopsy Size Required');
        }
    }
}
function AddNewLesion() {
    buttonname=$("#addNewLesion").val();
// working
    LesionPresent = $("#LesionPresent option:selected").text();
    LesionType = $("#LesionType option:selected").text();
    Region = $("#Region option:selected").text();
    Side = $("#Side option:selected").text();
    Status = $("#Status option:selected").text();


    if(buttonname == "Add New Lesion"){
        if($("#LesionPresent option:selected").text() == "NO")
        {
            LesionPresentArray.push(LesionPresent);
            LesionTypeArray.push(0);
            RegionArray.push(0);
            SideArray.push(0);
            StatusArray.push(0);
            $("#lpet").val(LesionPresentArray);
            $("#ltype").val(LesionTypeArray);
            $("#lregion").val(RegionArray);
            $("#lside").val(SideArray);
            $("#lstatus").val(StatusArray);
            $("#lesionHistory").show();   
            $("#lesionHistory > tbody").append("<tr><td>" + LesionPresent +"</td><td></td><td></td><td></td><td></td><td></td></tr>");
            $("#LesionPresent").val("").change();
    
        }else{
            if (LesionPresent != 'Select Lesion Present' && LesionType !='Select Lesion Type' && Region != 'Select Region' ) {
                LesionPresentArray.push(LesionPresent);
                LesionTypeArray.push(LesionType);
                RegionArray.push(Region);
                if(Side != 'Select Side'){
                    SideArray.push(Side);
                }else{
                    SideArray.push(0);
                }
                if(Status != 'Select Status'){
                    StatusArray.push(Status);
                }else{
                    StatusArray.push(0);
                }                
                    
                $("#lpet").val(LesionPresentArray);
                $("#ltype").val(LesionTypeArray);
                $("#lregion").val(RegionArray);
                $("#lside").val(SideArray);
                $("#lstatus").val(StatusArray);
    
                $("#LesionPresent").val("");
                $("#LesionType").val("");
                $("#Region").val("");
                $("#Side").val("");
                $("#Status").val("");
                
    
                $("#lesionHistory").show()   
                $("#lesionHistory > tbody").append("<tr><td>" + LesionPresent + "</td><td>" + LesionType + "</td><td>" + Region + "</td><td>" + Side + "</td><td>" + Status + "</td></tr>");
                // set empty error msgs
                $("#Lesion_present").html('');
                $("#Lesion_type").html('');
                $("#Lesion_region").html('');
                $("#Lesion_side").html('');
                $("#Lesion_status").html('');
    
            }
            if(LesionPresent == 'Select Lesion Present'){
                $("#Lesion_present").html('*Lesion Present Required');
            }
            if(LesionType == 'Select Lesion Type'){
                $("#Lesion_type").html('*Lesion Type Required');
            }
            if(Region == 'Select Region'){
                $("#Lesion_region").html('*Region Required');
            }
            // if(Side == 'Select Side'){
            //     $("#Lesion_side").html('*Side Required');
            // }
            // if(Status == 'Select Status'){
            //     $("#Lesion_status").html('*Status Required');
            // }
    
           
        }
    }else{
        // LessionId=$("#idd").text();
        LessionId= $("#idForUpdate").val();
        // console.log(LessionId);
        if($("#LesionPresent option:selected").text() == "NO")
        {
            LesionPresentArray.push(LesionPresent);
            LesionTypeArray.push(0);
            RegionArray.push(0);
            SideArray.push(0);
            StatusArray.push(0);
            $("#lpet").val(LesionPresentArray);
            $("#ltype").val(LesionTypeArray);
            $("#lregion").val(RegionArray);
            $("#lside").val(SideArray);
            $("#lstatus").val(StatusArray);
            $("#lesionHistory").show();   
            $("#lesionHistory > tbody").append("<tr><td>" + LesionPresent +"</td><td></td><td></td><td></td><td></td></tr>");
            $("#LesionPresent").val("").change();
    
        }else{
            // working
            if (LesionPresent != 'Select Lesion Present' && LesionType !='Select Lesion Type' && Region != 'Select Region' )
            {
                // if(Side = 'Select Side'){
                //     SideArray.push(0);
                // }
                // if(Status = 'Select Status'){
                //     StatusArray.push(0);                    
                // }
                var ajaxData = new FormData();
                ajaxData.append('LesionPresent', LesionPresent);
                ajaxData.append('LesionType', LesionType);
                ajaxData.append('Region', Region);
                ajaxData.append('Side', Side);
                ajaxData.append('Status', Status);
                ajaxData.append('ID', LessionId);
                $.ajax({
                    url : application_root+"StaticData.cfc?method=updateLesions",
                    type: "POST",
                    cache: false,
                    contentType:false,
                    processData: false,
                    data : ajaxData,
                   
                
                    success: function (response)
                    {
                        let id = $("#idForUpdate").val();
                        $("#L_present"+id).html(LesionPresent);
                        $("#L_type"+id).html(LesionType);
                        $("#L_region"+id).html(Region);
                        $("#L_side"+id).html(Side);
                        $("#L_status"+id).html(Status);
                        
                        $("#LesionPresent").val(''); 
                        $("#LesionType").val('');
                        $("#Region").val('');
                        $("#Side").val('');
                        $("#Status").val('');
                    },
                    error: function (response)
                {
                //    alert(response);
                }
                   
                });
                $("#addNewLesion").val("Add New Lesion");
            }
        }


    }
   
    
}
var count=0;
var pre=0;
count = $('#count').val();
function AddNewSection() {
    count = ++count;
    pre = count-1;
    if(count == 1){
        $('#needcopy').after('<div class="col-lg-12" id="needco'+count+'"><br></div>');
    }else{
        $('#needco'+pre).after('<div class="col-lg-12" id="needco'+count+'"><br></div>');
    }
    $('#needco'+count).append('<div class="input-group" id="needcopytoo'+count+'"></div>');
    $('#needcopytoo'+count).append('<label class="">New Section '+count+'</label>');
    $('#needcopytoo'+count).append(' <textarea class="form-control textareaCustomReset" id="extraNotes'+count+'"name="extraNotes'+count+'"></textarea>');
    $('#maxNotes').val(count);
}
function getFbAndSex() {
    $("#sex").val("");
    code = $("#code option:selected").val();
    if (code != 0) {
        $.ajax({
            url: application_root +
                "Stranding.cfc?method=getFbAndSexOfCode",
            Datatype: "json",
            type: "get",
            data: {
                Code_ID: code,
            },
            success: function (data) {
                var obj = JSON.parse(data);
                console.log(obj);
                $('#hera').val(obj.DATA[0][1]);
                
                let F = 'Female';
                let M = 'Male';
                let C = 'CBD';
                if(obj.DATA[0][0] == 'F')
                $("#sex option:contains("+F+")").attr('selected', 'selected');
                // $('#sex').val('female');
                else if(obj.DATA[0][0] == 'M')
                $("#sex option:contains("+M+")").attr('selected', 'selected');
                else if(obj.DATA[0][0] == 'U')
                $("#sex option:contains("+C+")").attr('selected', 'selected');
                
            }
        });
    }
}
var cn=1;
var PDFArray = [];
if($('#pdfFiles').val() != ''){
    PDFArray.push($('#pdfFiles').val());
}
function img(){
    cn = ++cn;
    pr = cn - 1;
    var files = $('#files').prop('files');
    var f = files[0];
    console.log(f.size);
    if(f.size < 10000000){
        if(f.type == 'application/pdf'){    
            $('#start').after('<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>');
            $('#files').prop('disabled', true);
            var pdffile = new FormData();
            pdffile.append('pdf', f);
            $.ajax({
                url: application_root +"Stranding.cfc?method=uploadpdf",
                type: "POST",
                data: pdffile,
                enctype: 'multipart/form-data',
                processData: false, // tell jQuery not to process the data
                contentType: false, // tell jQuery not to set contentType
                success: function (data) {
                    if(data != ""){
                    PDFArray.push(data);
                    // $('#pdfFiles').val(PDFArray);
                    var oldvalue = $('#pdfFiles').val();
                    var newvalue = data;
                    if(oldvalue){
                        var FullValue = oldvalue +","+ newvalue;
                    }else{
                        var FullValue = newvalue;
                    }
                    $('#pdfFiles').val(FullValue);

                    $('.spi').remove();
                    $('#previousimages').append('<span class="pip"><a data-toggle="modal" data-target="#myModal" href="#" title="http://cloud.wildfins.org/'+data+'" target="blank"><img id="select'+pr+'" class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="'+f.name+'" onclick="selected(this)"/></a><br/><span class="remove" id="'+data+'" onclick="remov(this)">Remove image</span></span>');
                    $('#files').prop('disabled', false);
                    }else{
                        alert('Selected file corrupted PDF');
                        $('.spi').remove();
                        $('#files').prop('disabled', false);
                    }
                }
            });
        }else{
            alert('Selected file is not PDF');
            $('#files').val("");
        }
    }else{
        alert('Selected file is Large than 10MB');
        $('#files').val("");
    }        
}
function remov(el){
    ID = $('#form_id').val();
    var element = el;
    pdffile = element.id
    console.log(pdffile);
console.log(ID);
    data = $('#pdfFiles').val();

    data1 = data.split(",");
    var removeArrayValue = pdffile;
    data1.splice($.inArray(removeArrayValue, data1), 1);
    data2 = data1.toString();

    $('#pdfFiles').val(data2);

console.log(ID);
    $.ajax({
        url: application_root +"Stranding.cfc?method=removepdf",
        type: "POST",
        data: { ID: ID, pdf: pdffile, imgValue: data2 },
        success: function (data) {
            // PDFArray = PDFArray.filter(e => e !== "Get_Started_With_Smallpdf20.pdf"); 
            // $('#pdfFiles').val(PDFArray);
            element.parentNode.remove();
        }
    });    
}
function selected(elem) {
    var element = elem;
    $('#emb').attr('src', element.parentNode.title);
    $('#pdfname').html($(this).attr('title'));
    
}
function chkreq(e){
    if($("#Fnumber").val().trim() == ""){
        $("#Fnumber").val('');
    }
    if($("#Date").val().trim() == ""){
        $("#Date").val('');
    }
}
function edit_row(id){

    $("#idForUpdate").val(id);
    $("#addNewLesion").val("Update");

    if($("#L_present"+id).text() != ''){
        let c=$("#L_present"+id).text();
        $("#LesionPresent option:contains("+c+")").attr('selected', 'selected');
    }
    if($("#L_type"+id).text() != ''){
        let type=$("#L_type"+id).text();
        $("#LesionType option:contains("+type+")").attr('selected', 'selected');
    }
    if($("#L_region"+id).text() != ''){
        let region=$("#L_region"+id).text();
        $("#Region option:contains("+region+")").attr('selected', 'selected');
    }
    if($("#L_side"+id).text() != ''){
        let side=$("#L_side"+id).text();
        // let sides = side.toString();
        let n= side.includes("/");
        if(n == true){
            $("#Side option:contains("+side+")").attr('selected', 'selected');
        }
        if(n == false){
            $("#Side option[value="+side+"]").attr('selected', 'selected');
        }

        // $("#Side option:contains("+side+")").attr('selected', 'selected');
        // $("#Side option[value="+side+"]").attr('selected', 'selected');
        // $("#Side").find("option[index="+side+"]").attr("selected","selected");
      
    }
    if($("#L_status"+id).text() != ''){
        let status=$("#L_status"+id).text();
        $("#Status option:contains("+status+")").attr('selected', 'selected');
    }
}
function delete_row(id){
    LesionID=id;
    var ajaxData = new FormData();
    ajaxData.append('ID', LesionID);
    $.ajax({
        url : application_root+"Stranding.cfc?method=deleteLesion",
        type: "POST",
        cache: false,
        contentType:false,
        processData: false,
        data : ajaxData,
        success: function (response)
        {
            // var pageURL = $(location).attr("href");
            // window.location.href= pageURL;
            $('#'+'tr_'+id).remove();
            
        },
        error: function (response)
        {
            alert(response);
        }
    });
}
function removeOptions() {
    alert();
   
}

// $("#Veterinarian").click(function(){
//     alert("The paragraph was clicked.");
//   });
//   $(document).on("click","#Veterinarian",function() {
//     alert("click");
// });
$("#Veterinarian").on("change", function () {
    // alert('kider');
     
});

function confirmBoxForAllDelete(){
    // alert();
    if(confirm('Are you sure to Delete All Record?'))
    {}
    else{
        return false;
    }
}

$( "#deleteAllRecord" ).click(function() {
    // alert( "Handler for .click() called." );
    $('#date').val('mm/dd/yyyy');
    $('#Fnumber').val(' ');
  });