$(document).ready(function() {
  handleDateTimePicker = function () {
      $('#lasttable').DataTable({
          "pageLength": 100,
          "scrollX": true,
          "paging": false,
          "info":    false,
          responsive: true,
          dom: 'rtip',
      });
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
      $('#datetimepicker_Date').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#date").formValidation('revalidateField', name);
      });
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
      $('#datetimepicker_Time').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#Time").formValidation('revalidateField', name);
      });
      $('#datetimepicker_Chem_dateTime').datetimepicker({ format: 'HH:mm:ss' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#Chem_dateTime").formValidation('revalidateField', name);
      });
      $('#datetimepicker_Date').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#date").formValidation('revalidateField', name);
      });
      $('#collection_date_picker').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#collection_date").formValidation('revalidateField', name);
      });
      $('#ISTAT_CG4_date_picker').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#ISTAT_CG4_date").formValidation('revalidateField', name);
      });
      $('#Chem_date_picker').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#Chem_date").formValidation('revalidateField', name);
      });
      $('#datetimepicker_Date_TD').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#date").formValidation('revalidateField', name);
      });
  
      $('#datetimepicker_Date_sadd').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#SampleAccessionDate").formValidation('revalidateField', name);
      });
      $('#datetimepicker_Date_sad').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#HistopathologyDate").formValidation('revalidateField', name);
      });
      $('#datetimepicker_Datee').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#Analysis_date").formValidation('revalidateField', name);
      });
      $('#datetimepicker_Date_subsample').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#subsampleDate").formValidation('revalidateField', name);
      });
      $('#datetimepicker_Date_sample').datetimepicker({ format: 'YYYY-MM-DD' }).on('dp.change', function(e) {
          // Revalidate the date field
          var name=$(this).attr('name');
          $("#Sample_Date").formValidation('revalidateField', name);
      });  
      $("#first_date")
      .datetimepicker({ format: "YYYY-MM-DD" })
      .on("dp.change", function(e) {
        // Revalidate the date field
        var name = $(this).attr("name");
        $("#birthday").formValidation("revalidateField", name);
      });
    $("#LevelA_Date")
      .datetimepicker({ format: "YYYY-MM-DD" })
      .on("dp.change", function(e) {
        // Revalidate the date field
        var name = $(this).attr("name");
        $("#Level_A_Date").formValidation("revalidateField", name);
      });
    $("#Necropsy_Date")
      .datetimepicker({ format: "YYYY-MM-DD" })
      .on("dp.change", function(e) {
        // Revalidate the date field
        var name = $(this).attr("name");
        $("#NecropsyDate").formValidation("revalidateField", name);
      });
    $("#Chem_date_picker")
      .datetimepicker({ format: "YYYY-MM-DD" })
      .on("dp.change", function(e) {
        // Revalidate the date field
        var name = $(this).attr("name");
        $("#Chem_date").formValidation("revalidateField", name);
      });
  }  
  
  if($('#Fnumber').val()){
      
      $('.showDiv').show();
  }else{

      $('.showDiv').hide();
  }
  handleDateTimePicker();
  handleJqueryTagIt();  

  $("#subsamplee").hide();
  $("#Thawedd").hide();
  $("#subsampleDatee").hide();
  // getCode(); 
  $(".removeSeclectValue").css("display", "none");


  // tab functionality
  let tab_url1 = $(location).attr('href');
  // const slug = tab_url1.split('&').pop(); // 2020
  // // var url1      = window.location.pathname;

 let tab_url =  tab_url1.split('&').pop();
 const histoDirect = tab_url.substring(0, tab_url.indexOf('='));
//  console.log(before_)
 console.log(tab_url);
 if(tab_url == "CetaceanExam"){
  $("#HIstoFormSerch").hide();
  $("#CetaceanSearch").show();
  $("#PageText").text("Cetacean Exam");
  $('.nav-tabs li:eq(0) a').tab('show');
  // $('.nav-tabs a:last').tab('show');
}

  if(tab_url == 'HIForm'){
      $("#HIformSerch").show();
      $("#CetaceanSearch").hide();
      $("#PageText").text("HI Form");
 
      // $('.nav-tabs a:last').tab('show')
      $('.nav-tabs li:eq(1) a').tab('show');
  }
  
  if(tab_url == "LevelAForm"){
      $("#LAFormSerch").show();
      $("#CetaceanSearch").hide();
      $("#PageText").text("Level A Form");
      $('.nav-tabs li:eq(2) a').tab('show');
  }
  if(tab_url == "Histopathology" || histoDirect == "LCE_HID"){
      $("#HIstoFormSerch").show();
      $("#CetaceanSearch").hide();
      $("#PageText").text("Histopathology");
      $('.nav-tabs li:eq(3) a').tab('show');
  }
  if(tab_url == "BloodValue"){
      $("#BloodValueFormSerch").show();
      $("#CetaceanSearch").hide();
      $("#PageText").text("Blood value");
      $('.nav-tabs li:eq(4) a').tab('show');
  }
  if(tab_url == "Toxicology"){
      $("#ToxicologyFormSerch").show();
      $("#CetaceanSearch").hide();
      $("#PageText").text("Toxicology");
      $('.nav-tabs li:eq(5) a').tab('show');
  }
  if(tab_url == "AncillaryDiagnostics"){
      $("#AncillaryDiagnosticsFormSerch").show();
      $("#CetaceanSearch").hide();
      $("#PageText").text("Ancillary Diagnostics");
      $('.nav-tabs li:eq(6) a').tab('show');
      // $('.nav-tabs a:last').tab('show');
  }
  if(tab_url == "Morphometrics"){
      $("#MorphometricsFormSerch").show();
      $("#CetaceanSearch").hide();
      $("#PageText").text("Morphometrics");
      $('.nav-tabs li:eq(9) a').tab('show');
      // $('.nav-tabs a:last').tab('show');
  }
  if(tab_url == "SampleArchive"){
      $("#sampleAechiveFormSerch").show();
      $("#CetaceanSearch").hide();
      $("#PageText").text("Sample Archive");
      $('.nav-tabs li:eq(7) a').tab('show');
      // $('.nav-tabs a:last').tab('show');
  }
  if(tab_url == "NecropsyReport"){
      $("#NecropstFormSerch").show();
      $("#CetaceanSearch").hide();
      $("#PageText").text("Necropsy Report");
      $('.nav-tabs li:eq(8) a').tab('show');
      // $('.nav-tabs a:last').tab('show');
  }
  getCode();
 
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
  console.log(species);
  $("#DorsalFinHeight").hide();
  $("#RostrumtoBlowhole").show();
  $("#KogiaSpan").hide();
  // speciesArray = ['','','','','','Tursiops_Diagram.png','Humpback_Diagram.png','Kogia_Diagram.png','Globicephala_Diagram.png','Globicephala_Diagram.png'];
  // console.log(speciesArray[species]);
  // if(species != ''){
  //   $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/"+speciesArray[species]);
  //   $("#measureImg").val(speciesArray[species]);
  // }

  if(species == 5 || species == 12){
    $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Tursiops_Diagram.png");
    $("#measureImg").val("Tursiops_Diagram.png");
}
if(species == 6){
    $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Humpback_Diagram.png");
    $("#measureImg").val("Humpback_Diagram.png");
}
if(species == 7 || species == 15 || species == 40 || species == 37){
    $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Kogia_Diagram.png");
    $("#measureImg").val("Kogia_Diagram.png");
    $("#DorsalFinHeight").show();
    $("#KogiaSpan").show();
    // $("#RostrumtoBlowhole").show();
}
// if(species == 40 || species == 37){
//   $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Kogia_Diagram.png");
//   $("#measureImg").val("Kogia_Diagram.png");
// }
if(species == 8 || species == 9 || species == 59){
    $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Globicephala_Diagram.png");
    $("#measureImg").val("Globicephala_Diagram.png");
}

  if(species == 53 || species == 58){
      $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Cuviers_Diagram.png");
      $("#measureImg").val("Cuviers_Diagram.png");
  }
  if(species == 54){
      $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Humpback_Diagram.png");
      $("#measureImg").val("Humpback_Diagram.png");
  }

  if(species == 45){
      $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/melon_headed_whale_measurement_diagram.png");
      $("#measureImg").val("melon_headed_whale_measurement_diagram.png");
  }
  if(species == 38){
    $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Rissos_Diagram.png");
    $("#measureImg").val("Rissos_Diagram.png");
} 

// for seel image not uploaded  
  if(species == 43 || species == 42){  
      $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Seal.png");
      $("#measureImg").val("Seal.png");
      $("#RostrumtoBlowhole").hide();
  }

if(species == 44 || species == 56 || species == 39 || species == 62 || species == 63 || species == 64 ){
  $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Stenella_Species_Diagram.png");
  $("#measureImg").val("Stenella_Species_Diagram.png");
}
if(species == 41){
  $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Steno_Diagram.png");
  $("#measureImg").val("Steno_Diagram.png");
}
if(species == 36 || species == 65){
  $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Tursiops_Diagram.png");
  $("#measureImg").val("Tursiops_Diagram.png");
}
if(species == 50){
  $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/SpermWhale_Diagram.png");
  $("#measureImg").val("SpermWhale_Diagram.png");
}
  if(species == 57){
      $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/NARW_Diagram.png");
      $("#measureImg").val("NARW_Diagram.png");
  }
  if(species == 46 || species == 60){
    $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Mesoplodon_Species_Diagram.png");
    $("#measureImg").val("Mesoplodon_Species_Diagram.png");
}
   if(species == 61){
      $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Sea_lion_Drawing.png");
      $("#measureImg").val("Sea_lion_Drawing.png");
      $("#RostrumtoBlowhole").hide();
  }
 
  if(species == 66){
      $("#measureImage").attr("src","http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/FalseKillerWhale_Diagram.png");
      $("#measureImg").val("FalseKillerWhale_Diagram.png");
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
  console.log(Drugtype);
  console.log(DrugMethod);
  console.log(DrugTime);
  console.log(DrugDosage);
  console.log(DrugVolume);

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
      // if(Drugtype == '' || Drugtype == 'Select Type'){
      //     $("#D_type").html("*Type Required");
      // }else{
      //   $("#D_type").html(''); 
      // }
      // if(DrugMethod == ''){
      //     $("#D_method").html("*Method Required");
      // }else{
      //   $("#D_method").html('');
      // }
      // if(DrugTime == ''){
      //     $("#D_time").html("*Time Required");
      // }else{
      //   $("#D_time").html('');
      // }
      // if(DrugDosage == ''){
      //     $("#D_dosage").html("*Dosage Required");
      // }else{
      //   $("#D_dosage").html('');
      // }
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
// function remov(el){
//   ID = $('#form_id').val();
//   var element = el;
//   pdffile = element.id
//   console.log(pdffile);
// console.log(ID);
//   data = $('#pdfFiles').val();

//   data1 = data.split(",");
//   var removeArrayValue = pdffile;
//   data1.splice($.inArray(removeArrayValue, data1), 1);
//   data2 = data1.toString();

//   $('#pdfFiles').val(data2);

// console.log(ID);
//   $.ajax({
//       url: application_root +"Stranding.cfc?method=removepdf",
//       type: "POST",
//       data: { ID: ID, pdf: pdffile, imgValue: data2 },
//       success: function (data) {
//           // PDFArray = PDFArray.filter(e => e !== "Get_Started_With_Smallpdf20.pdf"); 
//           // $('#pdfFiles').val(PDFArray);
//           element.parentNode.remove();
//       }
//   });    
// }

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
  $('#date').val('YYYY-MM-DD');
  $('#Fnumber').val(' ');
});


function removeRequired(){
  // alert();
  $(".showDiv").show();
  $('#Fnumber').attr('required', false); 
  $('#date').attr('required', false); 
}
function changeLEC(){
  $('#Fnumber').attr('required', false); 
  $('#date').attr('required', false);
  
  
}

function showHISearchBar(){
  // alert();
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&HIForm');

  $("#HIformSerch").show();
  $("#CetaceanSearch").hide();
  $("#LAFormSerch").hide();
  $("#AncillaryDiagnosticsFormSerch").hide();
  $("#HIstoFormSerch").hide();
  $("#ToxicologyFormSerch").hide();
  $("#MorphometricsFormSerch").hide();
  $("#sampleAechiveFormSerch").hide();
  $("#BloodValueFormSerch").hide();
  $("#NecropstFormSerch").hide();
  $("#PageText").text("HI Form");
  

}

function showCetaceanSearchBar(){
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&CetaceanExam');

  $("#HIformSerch").hide();
  $("#LAFormSerch").hide();
  $("#HIstoFormSerch").hide();
  $("#CetaceanSearch").show();
  $("#ToxicologyFormSerch").hide();
  $("#MorphometricsFormSerch").hide();
  $("#sampleAechiveFormSerch").hide();
  $("#AncillaryDiagnosticsFormSerch").hide();
  $("#NecropstFormSerch").hide();
  $("#BloodValueFormSerch").hide();
  $("#PageText").text("Cetacean Exam");

}
function goToCetecanExamPage(){
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&CetaceanExam');

  // $("#HIformSerch").hide();
  // $("#LAFormSerch").hide();
  // $("#HIstoFormSerch").hide();
  // $("#ToxicologyFormSerch").hide();
  // $("#MorphometricsFormSerch").hide();
  // $("#sampleAechiveFormSerch").hide();
  // $("#AncillaryDiagnosticsFormSerch").hide();
  // $("#BloodValueFormSerch").hide();
  $("#NecropstFormSerch").hide();
  $("#CetaceanSearch").show();
  $("#PageText").text("Cetacean Exam");
  $('.nav-tabs li:eq(8) a').tab('hide');
  $('.nav-tabs li:eq(0) a').tab('show');

}

function showLASearchBar(){
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&LevelAForm');
  // alert();
  $("#HIformSerch").hide();
  $("#HIstoFormSerch").hide();
  $("#LAFormSerch").show();
  $("#CetaceanSearch").hide();
  $("#BloodValueFormSerch").hide();
  $("#AncillaryDiagnosticsFormSerch").hide();
  $("#ToxicologyFormSerch").hide();
  $("#MorphometricsFormSerch").hide();
  $("#NecropstFormSerch").hide();
  $("#sampleAechiveFormSerch").hide();
  $("#PageText").text("Level A Form");
}
function HIstoFormSerch(){
  // alert();
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&Histopathology');

  $("#HIformSerch").hide();
  $("#HIstoFormSerch").show();
  $("#LAFormSerch").hide();
  $("#CetaceanSearch").hide();
  $("#BloodValueFormSerch").hide();
  $("#MorphometricsFormSerch").hide();
  $("#ToxicologyFormSerch").hide();
  $("#sampleAechiveFormSerch").hide();
  $("#NecropstFormSerch").hide();
  $("#AncillaryDiagnosticsFormSerch").hide();
  $("#PageText").text("Histopathology");
}
function showBloodValueSerch(){
  // alert();
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&BloodValue');

  $("#HIformSerch").hide();
  $("#BloodValueFormSerch").show();
  $("#HIstoFormSerch").hide();
  $("#ToxicologyFormSerch").hide();
  $("#MorphometricsFormSerch").hide();
  $("#LAFormSerch").hide();
  $("#sampleAechiveFormSerch").hide();
  $("#AncillaryDiagnosticsFormSerch").hide();
  $("#CetaceanSearch").hide();
  $("#NecropstFormSerch").hide();
  $("#PageText").text("Blood Value");
}
function showToxicologySerch(){
  // alert();
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&Toxicology');
  $("#HIformSerch").hide();
  $("#ToxicologyFormSerch").show();
  $("#BloodValueFormSerch").hide();
  $("#HIstoFormSerch").hide();
  $("#MorphometricsFormSerch").hide();
  $("#LAFormSerch").hide();
  $("#AncillaryDiagnosticsFormSerch").hide();
  $("#CetaceanSearch").hide();
  $("#sampleAechiveFormSerch").hide();
  $("#NecropstFormSerch").hide();
  $("#PageText").text("Toxicology");
}
function showAncillaryDiagnosticsSerch(){
  // alert();
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&AncillaryDiagnostics');
  $("#HIformSerch").hide();
  $("#AncillaryDiagnosticsFormSerch").show();
  $("#ToxicologyFormSerch").hide();
  $("#BloodValueFormSerch").hide();
  $("#HIstoFormSerch").hide();
  $("#MorphometricsFormSerch").hide();
  $("#sampleAechiveFormSerch").hide();
  $("#LAFormSerch").hide();
  $("#CetaceanSearch").hide();
  $("#NecropstFormSerch").hide();
  $("#PageText").text("Ancillary Diagnostics");
}
function showSampleArchiveSerch(){
  // alert();
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&SampleArchive');
  $("#HIformSerch").hide();
  $("#AncillaryDiagnosticsFormSerch").hide();
  $("#sampleAechiveFormSerch").show();
  $("#MorphometricsFormSerch").hide();
  $("#ToxicologyFormSerch").hide();
  $("#BloodValueFormSerch").hide();
  $("#HIstoFormSerch").hide();
  $("#LAFormSerch").hide();
  $("#CetaceanSearch").hide();
  $("#NecropstFormSerch").hide();
  $("#PageText").text("Sample Archive");
}
function showMorphometricsSerch(){
  // alert();
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&Morphometrics');
  $("#HIformSerch").hide();
  $("#MorphometricsFormSerch").show();
  $("#AncillaryDiagnosticsFormSerch").hide();
  $("#sampleAechiveFormSerch").hide();
  $("#ToxicologyFormSerch").hide();
  $("#BloodValueFormSerch").hide();
  $("#HIstoFormSerch").hide();
  $("#LAFormSerch").hide();
  $("#CetaceanSearch").hide();
  $("#NecropstFormSerch").hide();
  $("#PageText").text("Morphometrics");
}
function showNecropsyReportSerch(){
  // alert();
  url = $('#Site_url').val();
  $('#myforma').attr('action', url + '&NecropsyReport');
  $("#HIformSerch").hide();
  $("#NecropstFormSerch").show();
  $("#MorphometricsFormSerch").hide();
  $("#AncillaryDiagnosticsFormSerch").hide();
  $("#sampleAechiveFormSerch").hide();
  $("#ToxicologyFormSerch").hide();
  $("#BloodValueFormSerch").hide();
  $("#HIstoFormSerch").hide();
  $("#LAFormSerch").hide();
  $("#CetaceanSearch").hide();
  $("#PageText").text("Necropsy Report");

}


function cetaceanExamform(){
  url = $('#Site_url').val();
  $('#myCetaceanExamform').attr('action', url + '&CetaceanExam');
  $( "#myCetaceanExamform" ).submit();
}
function cetaceanExamDateform(){
  url = $('#Site_url').val();
  $('#myCetaceanExamDateform').attr('action', url + '&CetaceanExam');
  $( "#myCetaceanExamDateform" ).submit();
}
function cetaceanExamFieldNumberform(){
  url = $('#Site_url').val();
  $('#myCetaceanExamFieldNumberform').attr('action', url + '&CetaceanExam');
  $( "#myCetaceanExamFieldNumberform" ).submit();
}
function hIFormDate(){
  url = $('#Site_url').val();
  $('#myHIFormDate').attr('action', url + '&HIForm');
  $( "#myHIFormDate" ).submit();
}
function hiFormFieldNumber(){
  url = $('#Site_url').val();
  $('#myHiFormFieldNumber').attr('action', url + '&HIForm');
  $( "#myHiFormFieldNumber" ).submit();
}
function hIFormCode(){
  url = $('#Site_url').val();
  $('#myHIFormCode').attr('action', url + '&HIForm');
  $( "#myHIFormCode" ).submit();
}
function levelAFormID(){
  url = $('#Site_url').val();
  $('#myLevelAFormID').attr('action', url + '&LevelAForm');
  $( "#myLevelAFormID" ).submit();
}
function levelAFormDate(){
  url = $('#Site_url').val();
  $('#myLevelAFormDate').attr('action', url + '&LevelAForm');
  $( "#myLevelAFormDate" ).submit();
}
function levelAFormFieldNumber(){
  url = $('#Site_url').val();
  $('#myLevelAFormFieldNumber').attr('action', url + '&LevelAForm');
  $( "#myLevelAFormFieldNumber" ).submit();
}
function formHistopathology(){
  url = $('#Site_url').val();
  $('#myFormHistopathology').attr('action', url + '&Histopathology');
  $( "#myFormHistopathology" ).submit();
}
function formHistopathologyByDate(){
  url = $('#Site_url').val();
  $('#myformHistopathologyByDate').attr('action', url + '&Histopathology');
  $( "#myformHistopathologyByDate" ).submit();
}
function formHistopathologyByFieldNumber(){
  url = $('#Site_url').val();
  $('#myformHistopathologyByFieldNumber').attr('action', url + '&Histopathology');
  $( "#myformHistopathologyByFieldNumber" ).submit();
}
function formBloodValueByFieldNumber(){
  url = $('#Site_url').val();
  $('#myformBloodValueByFieldNumber').attr('action', url + '&BloodValue');
  $( "#myformBloodValueByFieldNumber" ).submit();
}
function formBloodValueByDate(){
  url = $('#Site_url').val();
  $('#myformBloodValueByDate').attr('action', url + '&BloodValue');
  $( "#myformBloodValueByDate" ).submit();
}
function formBloodValueByFieldNum(){
  url = $('#Site_url').val();
  $('#myformBloodValueByFieldNum').attr('action', url + '&BloodValue');
  $( "#myformBloodValueByFieldNum" ).submit();
}
function formToxicology(){
  url = $('#Site_url').val();
  $('#myformToxicology').attr('action', url + '&Toxicology');
  $( "#myformToxicology" ).submit();
}
function formToxicologybyDate(){
  url = $('#Site_url').val();
  $('#myformToxicologybyDate').attr('action', url + '&Toxicology');
  $( "#myformToxicologybyDate" ).submit();
}
function formToxicologybyFieldNumber(){
  url = $('#Site_url').val();
  $('#myformToxicologybyFieldNumber').attr('action', url + '&Toxicology');
  $( "#myformToxicologybyFieldNumber" ).submit();
}
function formAncillaryDiagnosticsSerch(){
  url = $('#Site_url').val();
  $('#myformAncillaryDiagnosticsSerch').attr('action', url + '&AncillaryDiagnostics');
  $( "#myformAncillaryDiagnosticsSerch" ).submit();
}
function formAncillaryDiagnosticsSerchByDate(){
  url = $('#Site_url').val();
  $('#myformAncillaryDiagnosticsSerchByDate').attr('action', url + '&AncillaryDiagnostics');
  $( "#myformAncillaryDiagnosticsSerchByDate" ).submit();
}
function formAncillaryDiagnosticsSerchByFieldNumber(){
  url = $('#Site_url').val();
  $('#myformAncillaryDiagnosticsSerchByFieldNumber').attr('action', url + '&AncillaryDiagnostics');
  $( "#myformAncillaryDiagnosticsSerchByFieldNumber" ).submit();
}
function formSampleSerchByFieldNumber(){
  url = $('#Site_url').val();
  $('#myformSampleArchive').attr('action', url + '&SampleArchive');
  $( "#myformSampleArchive" ).submit();
}
function formMorphometricsSerchByFieldNumber(){
  url = $('#Site_url').val();
  $('#myformMorphometricsSerchByFieldNumber').attr('action', url + '&Morphometrics');
  $( "#myformMorphometricsSerchByFieldNumber" ).submit();
}
function formMorphometricsSerchByDate(){
  url = $('#Site_url').val();
  $('#myformMorphometricsSerchByDate').attr('action', url + '&Morphometrics');
  $( "#myformMorphometricsSerchByDate" ).submit();
}
function formNecropsySerchByFieldNumber(){
  url = $('#Site_url').val();
  $('#myformNecropsySerchByFieldNumber').attr('action', url + '&NecropsyReport');
  $( "#myformNecropsySerchByFieldNumber" ).submit();
}

function fieldnum(){
  field=$("#fieldList option:selected").text().trim();
  console.log(field);
  $("#fielnumb").val(field);
  url = $('#Site_url').val();
  $('#fieldform').attr('action', url + '&SampleArchive');
  $("#fieldform").submit();
}

function TissueTypeForm(){
  $( "#myforma" ).submit();
}
function formNewSamples(){
  $( "#myforma" ).submit();
}

const TypeofHIArray = [];
const LocationofHIArray = [];
const GearCollectedArray = [];
const TypeofGearCollectedArray = [];
const GearDepositionArray = [];
var PDFArray = [];


function AddNewHiExam(){
  
  buttonname=$("#addNewHiExam").val();

  data = $("#TypeofHI").select2("val");
  // console.log(data)
  // TypeofHI1 = $("#TypeofHI option:selected").text();
  if($("#TypeofHI").select2("val") != null){
      if($("#TypeofHI").select2("val").length > 1){
          TypeofHI1 = $("#TypeofHI").select2("val").toString();
          TypeofHI = TypeofHI1.replaceAll(',', '-');
      }else{
          TypeofHI = $("#TypeofHI").select2("val");
          TypeofHI1= $("#TypeofHI").select2("val");
      }
  }else{
      TypeofHI = $("#TypeofHI").select2("val");
      TypeofHI1= '';
  }
  if($("#LocationofHI").select2("val") != null){
      if($("#LocationofHI").select2("val").length > 1){
          LocationofHI1 = $("#LocationofHI").select2("val").toString();
          LocationofHI = LocationofHI1.replaceAll(',', '-');
      }
      else{
          LocationofHI = $("#LocationofHI").select2("val");
          LocationofHI1= $("#LocationofHI").select2("val");
      }
  }else{
      LocationofHI = $("#LocationofHI").select2("val");
      LocationofHI1= '';
  }
  if($("#TypeofGearCollected").select2("val") != null){
      if($("#TypeofGearCollected").select2("val").length > 1){
          TypeofGearCollected1 = $("#TypeofGearCollected").select2("val").toString();
          TypeofGearCollected = TypeofGearCollected1.replaceAll(',', '-');
      }else{
          TypeofGearCollected = $("#TypeofGearCollected").select2("val");
          TypeofGearCollected1= $("#TypeofGearCollected").select2("val");
      }
  }else{
      TypeofGearCollected = $("#TypeofGearCollected").select2("val");
      TypeofGearCollected1= '';
  }

  GearDeposition = $("#GearDeposition option:selected").text();
  if(GearDeposition == "Select Type of Gear Collected"){
      GearDeposition= '';
  }else{
      GearDeposition = $("#GearDeposition option:selected").text();
  }
  
  if ($('#GearCollected').is(":checked"))
      {
      GearCollected = "Yes";
  }else{
      GearCollected = "No";        
      }
  // working


  if(buttonname == "Add New"){
      // if($("#TypeofHI").select2("val") != null){
          // }
      // if($("#LocationofHI").select2("val") != null){
          // }
      // if($("#TypeofGearCollected").select2("val") != null){
      //     }

          if(TypeofHI != null){
              TypeofHIArray.push(TypeofHI);
          }else{
              TypeofHIArray.push(0);
              TypeofHI ='';
          }  
          if(LocationofHI != null){
              LocationofHIArray.push(LocationofHI);
          }else{
              LocationofHIArray.push(0);
              LocationofHI ='';
          }  
          if(TypeofGearCollected != null){
              TypeofGearCollectedArray.push(TypeofGearCollected);
          }else{
              TypeofGearCollectedArray.push(0);
              TypeofGearCollected ='';
          }  
          console.log(TypeofHIArray);

          if(GearDeposition == ""){
              GearDepositionArray.push(0);
              }else{
              GearDepositionArray.push(GearDeposition);
              }
      // TypeofHIArray.push(TypeofHI);
      // LocationofHIArray.push(LocationofHI);
      // TypeofGearCollectedArray.push(TypeofGearCollected);
      GearDepositionArray.push(GearDeposition);
      GearCollectedArray.push(GearCollected);
  //   console.log(TypeofHIArray);

      $("#HiType").val(TypeofHIArray);
      $("#HiLocation").val(LocationofHIArray);
      $("#typeOfGearCollected").val(TypeofGearCollectedArray);
      $("#gearDeposition").val(GearDepositionArray);
      $("#gearCollected").val(GearCollectedArray);        
      
      
      // TypeofGearCollected
      $('#TypeofHI').val(null).trigger('change');
      $('#LocationofHI').val(null).trigger('change');
      $('#TypeofGearCollected').val(null).trigger('change');
      $("#GearDeposition").val("");
      $('#GearCollected').prop('checked', false);
          
      $("#HiForm").show();   
      $("#HiForm > tbody").append("<tr><td>" + TypeofHI1 + "</td><td>" + LocationofHI1 + "</td><td>" + GearCollected + "</td><td>" + TypeofGearCollected1 + "</td><td>" + GearDeposition + "</td></tr>");
  
      // // set empty error msgs
      // $("#Lesion_present").html('');
      // $("#Lesion_type").html('');
      // $("#Lesion_region").html('');
      // $("#Lesion_side").html('');
      // $("#Lesion_status").html('');
  }else{
    // nouman
      LessionId= $("#idForUpdateHiExam").val();

      var ajaxData = new FormData();
      ajaxData.append('TypeofHI', TypeofHI);
      ajaxData.append('LocationofHI', LocationofHI);
      ajaxData.append('TypeofGearCollected', TypeofGearCollected);
      ajaxData.append('GearDeposition', GearDeposition);
      ajaxData.append('GearCollected', GearCollected);
      ajaxData.append('ID', LessionId);
      $.ajax({
          url : application_root+"Stranding.cfc?method=updateHiExam",
          type: "POST",
          cache: false,
          contentType:false,
          processData: false,
          data : ajaxData,
         
      
          success: function (response)
          {
              
              let id = $("#idForUpdateHiExam").val();


              $("#TYPEOFHI_"+id).html(TypeofHI);
              $("#LocationofHI_"+id).html(LocationofHI);
              $("#TypeofGearCollected_"+id).html(TypeofGearCollected);
              $("#GearDeposition_"+id).html(GearDeposition);
              $("#GearCollected_"+id).html(GearCollected);
              
              $('#TypeofHI').val(null).trigger('change');
              $('#LocationofHI').val(null).trigger('change');
              $('#TypeofGearCollected').val(null).trigger('change');
              $("#GearDeposition").val("");
              $('#GearCollected').prop('checked', false);
          },
          error: function (response)
      {
      //    alert(response);
      }
         
      });
      $("#addNewHiExam").val("Add New");

  }
  
}

const SampleTypeArray = [];
const SampleNoteArray = [];


function AddDrug() {

  SampleType = $("#SampleType option:selected").text().trim();
  SampleTypeval = $("#SampleType option:selected").val().trim();
  SampleNote = $("#SampleNote").val().trim();
  
  if(SampleTypeval != ''){
      if(SampleNote == ""){
          SampleNoteArray.push(0);
      }else{
          SampleNoteArray.push(SampleNote);
      }
      SampleTypeArray.push(SampleType);

      $("#snotes").val(SampleNoteArray);
      $("#stype").val(SampleTypeArray);

      $("#SampleNote").val("");
      $("#SampleType").val("");

      $("#drugHistorya").show()   
      $("#drugHistorya > tbody").append("<tr><td>" + SampleType + "</td><td>" + SampleNote + "</td></tr>");
      
      $("#stypee").html('');
      $("#snote").html('');
  }else{
      if(SampleTypeval == ""){
          
          $("#stypee").html('*Sapmle type required');
      }
  }
}


function edit_row(id){
  // alert(id);

  $("#idForUpdateHiExam").val(id);
  $("#addNewHiExam").val("Update");


  dara = $("#TYPEOFHI_"+id).text();
  console.log(dara);
  if($("#TYPEOFHI_"+id).text() != ''){
      let c=$("#TYPEOFHI_"+id).text();
      // str = c.replace('-', ',');    
      hitype = c.split(",")
      $('#TypeofHI').val(hitype).trigger('change');
      // $("#TypeofHI option:contains("+hitype+")").attr('selected', 'selected');
  }else{
      let c=$("#TYPEOFHI_"+id).text();
      // str = c.replace('-', ',');    
      hitype = c.split(",")
      $('#TypeofHI').val(hitype).trigger('change');
  }

  if($("#LocationofHI_"+id).text() != ''){
      let c=$("#LocationofHI_"+id).text();
      hilocation = c.split(",")
      $('#LocationofHI').val(hilocation).trigger('change');
  }else{
      let c=$("#LocationofHI_"+id).text();
      hilocation = c.split(",")
      $('#LocationofHI').val(hilocation).trigger('change');
  }
  if($("#TypeofGearCollected_"+id).text() != ''){
      let c=$("#TypeofGearCollected_"+id).text();
      geartype = c.split(",")
      $('#TypeofGearCollected').val(geartype).trigger('change');
  }else{
      let c=$("#TypeofGearCollected_"+id).text();
      geartype = c.split(",")
      $('#TypeofGearCollected').val(geartype).trigger('change');
  }

  if($("#GearCollected_"+id).text() == "Yes"){
      $('#GearCollected').prop('checked', true);
  }else{
      $('#GearCollected').prop('checked', false);
  }
  if($("#GearDeposition_"+id).text() != ''){
      let c=$("#GearDeposition_"+id).text();
      $("#GearDeposition option:contains("+c+")").attr('selected', 'selected');
  }else{
      $('#GearDeposition').val('');
  }
}
function delete_row(id){
  LesionID=id;
  var ajaxData = new FormData();
  ajaxData.append('ID', LesionID);
  $.ajax({
      url : application_root+"Stranding.cfc?method=deleteHiExam",
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

// working end

$( "#deleteAllHiFormRecord" ).click(function() {
  $('#date').val('YYYY-MM-DD');
  $('#Fnumber').val(' ');
});

$( "#deleteToxicologyAllRecord" ).click(function() {
  $('#date').val('YYYY-MM-DD');
  $('#Fnumber').val(' ');
});

$( "#deleteBloodValuesRecord" ).click(function() {
  // alert( "Handler for .click() called." );
  $('#date').val('YYYY-MM-DD');
  $('#Fnumber').val(' ');
});
$( "#deleteAllLevelAFormRecord" ).click(function() {
  // alert( "Handler for .click() called." );
  $('#date').val('YYYY-MM-DD');
  $('#Fnumber').val(' ');
});

$( "#deleteHIstoRecord" ).click(function() {
  // alert( "Handler for .click() called." );
  $('#date').val('YYYY-MM-DD');
  $('#Fnumber').val(' ');
});


var count=0;
function newToxi(){
  count = ++count;

  // $( "#Toxi" ).append('<div class="row toxi-rw"><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><input type="text" placeholder="Toxin" value="" name="toxi_label" id="toxi_label" required><input type="text" maxlength="8" value="" name="toxi_type" id="toxi_type" required><span>ug/g dry</span></div><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><label >Reference Range</label><input type="text" maxlength="8" value="" name="toxi_range"  id="toxi_range" required><span>ug/g dry</span></div><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><label class="t-cust-l">Sample Result</label><select name="toxi_report" id="toxi_report" ><option value="High">High</option><option value="Low">Low</option><option value="Critical Result">Critical Result</option><option value="Corrected">Corrected</option><option value="None">None</option></select></div></div>');

  // $( "#Toxi" ).append('<div class="row toxi-rw"><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column toxic-col"><input class="toxic-field-label" type="text" placeholder="Toxin" value="" name="toxi_label" id="toxi_label" required><input type="text" class="toxic-field" maxlength="8" value="" name="toxi_type" id="toxi_type" required><span>ug/g dry</span></div><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><div class="form-group blood-from-froup thre-rw"><div class="input-group "><label class="">Reference Range</label><input class="Arsenic _Reference_Range" type="text" maxlength="8" value="" name="Arsenic_Reference_Rangee"  id="Arsenic_Reference_Range"><span>ug/g dry</span></div></div></div><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column toxic-col"><div class="form-group blood-from-froup"><div class="input-group result-row"><label class="county-label">Sample Result</label><select class="form-control" name="Arsenic_Sample_Results" id="Arsenic_Sample_Result"><cfloop from="1" to="#ArrayLen(ToxicologySelectoptions)#" index="j"><option value="High">High</option><option value="Low">Low</option><option value="Critical Result">Critical Result</option><option value="Corrected">Corrected</option><option value="None">None</option></cfloop></select></div></div></div></div>');

  $( "#Toxi" ).append('<div class="row toxi-rw"><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><input type="text" placeholder="Toxin" value="" name="toxi_label" id="toxi_label" required><input type="text" maxlength="8" value="" name="toxi_type" id="toxi_type" required><span>ug/g dry</span></div><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><label >Reference Range</label><input type="text" maxlength="8" value="" name="toxi_range"  id="toxi_range" required><span>ug/g dry</span></div><div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column"><label class="t-cust-l">Sample Result</label><select name="toxi_report" id="toxi_report" ><option value="High">High</option><option value="Low">Low</option><option value="Critical Result">Critical Result</option><option value="Corrected">Corrected</option><option value="None">None</option></select></div></div>');
  $("#dynamic_Toxi").val(count);

  $("#toxi_label").val();
}


//start AncillaryDiagnostics
const DiagnosticTestArray = [];
const TestResultsArray = [];
const DiagnosticLabArray = [];
const TestingDateArray = [];

function AddNewTest() {
  // alert();
  // $("#drugHistory").hide();
  // return false
  DiagnosticTest = $("#DiagnosticTest").val();
  TestResults = $("#TestResults").val();
  DiagnosticLab = $("#DiagnosticLab").val();
  TestingDate = $("#TestingDate").val();
 
  // console.log($('#TestNew').val());
if($('#TestNew').val() == "Add New"){
 
  if (DiagnosticTest != '' && TestResults !='') {      
    
      DiagnosticTestArray.push(DiagnosticTest);
      TestResultsArray.push(TestResults);
      if(DiagnosticLab == ""){
          DiagnosticLabArray.push(0);
      }else{
          DiagnosticLabArray.push(DiagnosticLab);
      }
      if(TestingDate == ""){
          TestingDateArray.push(0);
      }else{
          TestingDateArray.push(TestingDate);
      }
  
  
      $("#DT").val(DiagnosticTestArray);
      $("#TR").val(TestResultsArray);
      $("#DLAB").val(DiagnosticLabArray);
      $("#TD").val(TestingDateArray);
      $("#AncillaryTable").show();
      $("#AncillaryTable > tbody").append('<tr><td>' +  DiagnosticTest + '</td><td>' + TestResults +'</td><td>' + DiagnosticLab + '</td><td>' + TestingDate + '</td><td></td></tr>'); 
      $("#DiagnosticTest").val('');
      $("#TestResults").val('');
      $("#DiagnosticLab").val('');
      $("#TestingDate").val('');
      imgA();
      // $("#files").val('');
  
  }
}else{

  LessionId= $("#idForUpdate").val();

  
  if (DiagnosticTest != '' && TestResults !='') {  
    
    if(DiagnosticLab == ""){
        DiagnosticLab = "0";
    }

    if(TestingDate == ""){
        TestingDate = "0";
    }
 
    var files = $("#filesAncillary").prop("files");
    var f = files[0];
   
    // $("#embAncillaryDiagnostics").attr("src", element.parentNode.title);
    // nouman
    // pdffile.append("pdf", f);
    // console.log(DiagnosticTest);
    // console.log(TestResults);
    // console.log(DiagnosticLab);
    // console.log(TestingDate);
    let id = $("#idForUpdate").val();
    console.log($('#imagetitle_'+id).attr('title'));
    console.log(id);
    // return false;
    
    var PDFName = $('#imagetitle_'+id).attr('title');
    console.log(PDFName);
    if(f == '' || f == 'undefined'){
      if(PDFName == "undefined"){
        PDFName = ''
      }else{
        var PDFName = $('#imagetitle_'+id).attr('title');
      }
    }
    // console.log(PDFName);
    var ajaxData = new FormData();
    ajaxData.append('DiagnosticTest', DiagnosticTest);
    ajaxData.append('TestResults', TestResults);
    ajaxData.append('DiagnosticLab', DiagnosticLab);
    ajaxData.append('TestingDate', TestingDate); 
    ajaxData.append('name', '');
    console.log(f);
    ajaxData.append('name', PDFName);   
    // if(f){
    // }
    // else{
    //   if(PDFName == "undefined"){
    //     PDFName = ''
    //   }else{
    //     var PDFName = $('#imagetitle_'+id).attr('title');
    //   }
    // }
  
    ajaxData.append("pdf", f);

    ajaxData.append('ID', LessionId);
    $.ajax({
      url : application_root+"Stranding.cfc?method=updateAncillaryDiagnostics",
      type: "POST",
      cache: false,
      contentType:false,
      processData: false,
      data : ajaxData, 
      enctype: "multipart/form-data",    
  
      success: function (response)
      {
          // console.log('nouman Awan');
          let id = $("#idForUpdate").val();
       

          $("#DiagnosticTest_"+id).html(DiagnosticTest);
          $("#TestResults_"+id).html(TestResults);
          $("#DiagnosticLab_"+id).html(DiagnosticLab);
          $("#AncillaryDate_"+id).html(TestingDate);
          // $("#GearCollected_"+id).html(GearCollected);
          
          $("#DiagnosticTest").val('');
          $("#TestResults").val('');
          $("#DiagnosticLab").val('');
          $("#TestingDate").val('');
      },
      error: function (response)
  {
  //    alert(response);
  }
     
  });
  $("#TestNew").val("Add New");

  }
 
}

}

var PDFArrayAncillary = [];
function imgA(){
  if($('#filesAncillary').val() != ''){

      var filesAncillary = $('#filesAncillary').prop('files');
      console.log(filesAncillary);
      var f = filesAncillary[0];
      if(f.size < 10000000){
          // alert()
          if(f.type == 'application/pdf'){ 
              $('#filesAncillary').hide();
              $('#filesAncillary').attr('name','pdf');   
              $('#filesAncillary').attr('id','fi');   
              src= URL.createObjectURL(f);
              PDFArrayAncillary.push(f.name);
              $('#filesAncillary').hide();
              $('#filediv').append('<input class="input-style xl-width" type="file"  name="emptypdf" id="filesAncillary" accept="application/pdf">')

              $('#AncillaryTable').find('td:last').append('<span><a data-toggle="modal" data-target="#myModalAA" href="#" title="'+src+'" target="blank"><img class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="'+f.name+'" onclick="showPDFmodal(this)"/></a><br/></span>');
          }else{
              alert('Selected file is not PDF');
              PDFArrayAncillary.push(0);
          }
      }else{
          alert('Selected file is Large than 10MB');
          PDFArrayAncillary.push(0);
      }
  }else{
      PDFArrayAncillary.push(0);
  } 
  console.log(PDFArrayAncillary); 
  $('#pdfFilesAncillary').val(PDFArrayAncillary);

}
$( "#deleteAncillaryAllRecord" ).click(function() {
  $('#date').val('YYYY-MM-DD');
  $('#Fnumber').val(' ');
});
//end AncillaryDiagnostics

// for sampleArchive
function getFocus() {
  document.getElementById("search").focus();
}
$( "#deleteallSampleArchiveRecord" ).click(function() {
  $('#date').val('YYYY-MM-DD');
  $('#Fnumber').val(' ');
});

$( "#SaveAndNewSampleArchive" ).click(function() {
  $('#SampleID').attr('required', true); 
});



function deleteit(){
  $('#SampleID').prop('required',false);
}

function showFieldsOfSampleArchive() {
  // alert();
  SampleTracking = $("#SampleTracking option:selected").val().trim();
  if(SampleTracking == 5){
      $("#subsamplee").show();
      $("#Thawedd").show();
      $("#subsampleDatee").show();
      
  }else{
      $("#subsamplee").hide();
      $("#Thawedd").hide();
      $("#subsampleDatee").hide();
  }
}

const SampleAccessionDateArray = [];
const SampleLocationArray = [];
// const DrugTimeArray = []; //will change
const SampleTrackingArray = [];
const LabSenttoArray = [];
const SampleArchiveNoteArray = []; //will change
const subsampleArray = [];
const SampleThawedArray = [];
const subsampleDateArray = [];





function AddNewRecordforSample() {
  buttonname=$("#SampleAr").val();
  // alert();
  if(buttonname =='Add New'){
      // alert(buttonname);

      SampleAccessionDate = $("#SampleAccessionDate").val().trim();
      SampleLocation = $("#SampleLocation option:selected").text().trim();
      SampleTracking = $("#SampleTracking option:selected").text().trim();
      SampleTrack = $("#SampleTracking option:selected").val().trim();
      LabSentto = $("#LabSentto option:selected").text().trim();
      SampleNote = $("#SampleArchiveNote").val().trim();
      SampleID = $("#SampleID").val().trim();
      Thawed = $("#Thawed option:selected").val().trim();
      subsample = $("#subsample option:selected").val().trim();
      subsampleDate= $("#subsampleDate").val().trim();
      
      // console.log(SampleNote);
      // console.log(Thawed);
      // console.log(subsample);
      if (SampleAccessionDate != '' && SampleLocation !='Select Sample Location' && SampleTracking != 'Select Sample Tracking' && LabSentto != 'Select Lab Sent to' ) {
          // alert();
          SampleAccessionDateArray.push(SampleAccessionDate);
          SampleLocationArray.push(SampleLocation);
          SampleTrackingArray.push(SampleTracking);
          LabSenttoArray.push(LabSentto);
          if(SampleNote != ''){
              SampleArchiveNoteArray.push(SampleNote);
          }else{
              SampleArchiveNoteArray.push(0);
              SampleNote ='';
          }
          if(SampleTracking == 'Subsampled' && subsample !='Select Availability' && Thawed !='Select Thawed' ){
              subsampleArray.push(subsample);
              SampleThawedArray.push(Thawed);
              subsampleDateArray.push(subsampleDate);
          }else{
              subsampleArray.push(0);
              SampleThawedArray.push(0);
              subsampleDateArray.push(0);
              subsample ='';
              Thawed='';
              subsampleDate='';
          }
          

          $("#sad").val(SampleAccessionDateArray);
          $("#SL").val(SampleLocationArray);
          $("#ST").val(SampleTrackingArray);
          $("#lsto").val(LabSenttoArray);
          $("#samplenotes").val(SampleArchiveNoteArray);
          $("#Thaw").val(SampleThawedArray);
          $("#Avail").val(subsampleArray);
          $("#sub").val(subsampleDateArray);
          $("#SampleAccessionDate").val("");
          $("#SampleLocation").val("");
          $("#LabSentto").val("");
          $("#SampleTracking").val("");
          $("#SampleArchiveNote").val("");
          $("#Thawed").val("");
          $("#subsample").val("");
          $("#subsampleDate").val("");


          $("#sampleArchivedrugHistory").show(); 
          $("#sampleArchivedrugHistory > tbody").append("<tr><td>" + SampleAccessionDate + "</td><td>" + SampleID + "</td><td>" + SampleLocation + "</td><td>" + SampleTracking + "</td><td>" + LabSentto + "</td><td>" + SampleNote + "</td><td>" + subsampleDate + "</td><td>" + subsample + "</td><td>" + Thawed +"</td><td>" + ''+ "</td></tr>");  
          
          $("#sampleDate").html('');
          $("#sampleLocation").html('');
          $("#sampleTracking").html('');
          $("#labsentto").html('');
          $("#SampleArchiveNote").html('');
      }else{
          if(SampleAccessionDate == ''){
              $("#sampleDate").html('Date Required');
          }else{
              $("#sampleDate").html('');
          }
          if(SampleLocation == 'Select Sample Location'){
              $("#sampleLocation").html('*Location Required');
          }else{
              $("#sampleLocation").html('');
          }
          if(SampleTracking == 'Select Sample Tracking'){
              $("#sampleTracking").html('*Select sample tracking');
          }else{
              $("#sampleTracking").html('');
          }
          if(LabSentto == 'Select Lab Sent to'){
              $("#labsentto").html('*Select Lab');
          }else{
              $("#labsentto").html('');
          }
          // if(SampleNote == ''){
          //     $("#sampleNote").html('*Write Note');
          // }else{
          //     $("#sampleNote").html('');
          // }
      }
  }else{
      SampleAccessionDate = $("#SampleAccessionDate").val().trim();
      SampleLocation = $("#SampleLocation option:selected").text().trim();
      SampleTracking = $("#SampleTracking option:selected").text().trim();
      LabSentto = $("#LabSentto option:selected").text().trim();
      SampleNote = $("#SampleArchiveNote").val().trim();
      Thawed = $("#Thawed option:selected").val().trim();
      subsample = $("#subsample option:selected").val().trim();
      subsampleDate= $("#subsampleDate").val().trim();
      // no=$("#idd").text();
      no= $("#idForUpdate").val();
      sampledetailID=no;
      if(SampleAccessionDate != ''){
          var ajaxData = new FormData();
          ajaxData.append('samplDate', SampleAccessionDate);
          ajaxData.append('locat', SampleLocation);
          ajaxData.append('track', SampleTracking);
          ajaxData.append('sent', LabSentto);
          ajaxData.append('note', SampleNote);
          ajaxData.append('ID', sampledetailID);
          if(subsample!='Select Availability'&& subsample!=''){
              ajaxData.append('subsample', subsample);
          }else{
              ajaxData.append('subsample', '0');
          }
          if(Thawed!= '' && Thawed!='Select Thawed'){
              ajaxData.append('Thawed', Thawed);
          }else{
              ajaxData.append('Thawed', '0');
          }
          ajaxData.append('subsampleDate', subsampleDate);
          $.ajax({
              url : application_root+"StaticData.cfc?method=updatesampleDetail",
              type: "POST",
              cache: false,
              contentType:false,
              processData: false,
              data : ajaxData,
             
          
              success: function (response)
              {                                     
                  // subsampleDate= $("#subsampleDate").val().trim();
                  // working
                  // var pageURL = $(location).attr("href");
                  // window.location.href= pageURL;
                  let id = $("#idForUpdate").val();
                  $("#date"+id).html(SampleAccessionDate);
                  $("#location"+id).html(SampleLocation);
                  $("#track"+id).html(SampleTracking);
                  $("#labsent"+id).html(LabSentto);
                  $("#samplenotes"+id).html(SampleNote);
                  $("#subdate"+id).html(subsampleDate);                    
                  
                  if(Thawed != "Select Thawed"){
                      $("#thawed"+id).html(Thawed);
                  }                    
                  if(subsample != "Select Availability"){
                      $("#availbility"+id).html(subsample);
                  }
                  $("#SampleAccessionDate").val(''); 
                  $("#SampleLocation").val('');
                  $("#SampleTracking").val('');
                  $("#LabSentto").val('');
                  $("#SampleArchiveNote").val('');
                  $("#Thawed").val('');
                  $("#subsample").val('');
                  $("#subsampleDate").val('');
                  $("#SampleAr").val("Add New");

                  Thawed = '';
                  subsample= '';
                  subsampleDate='';


              },
              error: function (response)
          {
          //    alert(response);
          }
             
          });
      }else{
          alert('Fill Sample Accession Date.');
          $("#SampleAccessionDate").focus();
      }
  }
}


function edit_SampleRow(no)
{
  $("#idForUpdate").val(no);
  $("#SampleAr").val("Update");
  $("#SampleAccessionDate").val($("#date"+no).text());

  if($("#location"+no).text() != ''){
      let c=$("#location"+no).text();
      $("#SampleLocation option:contains("+c+")").attr('selected', 'selected');
  }

  if($("#labsent"+no).text() != ''){
      let e=$("#labsent"+no).text();
      $("#LabSentto option:contains("+e+")").attr('selected', 'selected');
  }

  $("#SampleArchiveNote").val($("#samplenotes"+no).text());

  if($("#track"+no).text() != ''){
      let d=$("#track"+no).text();
      $("#SampleTracking option:contains("+d+")").attr('selected', 'selected');

      if(d == 'Subsampled'){
          $("#subsamplee").show();
          $("#Thawedd").show();
          $("#subsampleDatee").show();
          
      }else{
          $("#subsamplee").hide();
          $("#Thawedd").hide();
          $("#subsampleDatee").hide();
          $("#subdate"+no).text("");
          $("#availbility"+no).text("");
          $("#thawed"+no).text("");
          tttt=$("#Thawed").val("0");
          $("#subsample").val("0");
          $("#subsampleDate").val("");
      }
  }

  let g=$("#subdate"+no).text();
  let h=$("#availbility"+no).text();
  let i=$("#thawed"+no).text();
  if(g != '' && h!= 'Select Availability' && h!= '' && i!= 'Select Thawed' && i!= ''){
      $("#subsampleDate ").val(g);
      $("#subsample option:contains("+h+")").attr('selected', 'selected');
      $("#Thawed option:contains("+i+")").attr('selected', 'selected');
  }
 
}

function delete_sampleRow(no)
{
  sampledetailID=no;
  // console.log(sampledetailID);
  var ajaxData = new FormData();
  ajaxData.append('ID', sampledetailID);
  $.ajax({
      url : application_root+"Stranding.cfc?method=deletesampleDetail",
      type: "POST",
      cache: false,
      contentType:false,
      processData: false,
      data : ajaxData,
      success: function (response)
      {
          // var pageURL = $(location).attr("href");
          // window.location.href= pageURL;
          $('#'+'tr_'+no).remove();
      },
      error: function (response)
      {
          alert(response);
      }
  });
}
//end for sampleArchive
// necropsy

var count = 0;
function newNUTRITIONAL() {
count = ++count;
$("#newNUTRI").append(
  '<div class="col-lg-12 mt-10"><div class="cust-row ingm-rw kidneyClass"><div class="cust-fld"><label class="fl-lbl"><input type="text" name="organs_label" id="organs" placeholder="Add Title" class="text-field"></label></div><div class="cust-inp"><select class="stl-op"name="newNUTRI" id="newNUTRI"><option value="">Select</option><option value="Abundant - No Atrophy">Abundant - No Atrophy</option><option value="Mild to Moderate Atrophy">Mild to Moderate Atrophy</option><option value="Severe Atrophy">Severe Atrophy</option><option value="NE">NE</option></select></div></div></div>'
);

$("#dynamic_NUTRITIONAL").val(count);
}
var node = 0;
function newLymphnode() {
// $("#lymphnode").val("");
node = ++node;
console.log("ok");
$(".chako:last").clone().find("input").val("").end().insertAfter(".chako:last");
$("select#lymphnode:last").attr("name", "lymphnode").val(" ");
$("input#nodelength:last").attr("name", "nodelength").val(" ");
$("input#nodewidth:last").attr("name", "nodewidth").val(" ");
$("#dynamic_Lymph").val(node);
}
var parasite = 0;
function newparasite() {
parasite = ++parasite;
$(".parasitediv:last").clone().find("input").val("").end().insertAfter(".parasitediv:last");
$("select#PARASITES:last").attr("name", "PARASITES").val(" ");
$("select#ParasiteType:last").attr("name", "ParasiteType").val(" ");
$("select#Parasitelocation:last").attr("name", "Parasitelocation").val(" ");
$("#dynamic_parasite").val(parasite);
}

function showPictures() {
  var files = $("#ExternalExamphoto").prop("files");

  // var image = files[0]['name'];
  var imagename = files[0]["name"];
  var imgname = "externalExam_" + imagename;

  var image = files[0];

  imagesFileValue = $("#imagesFile").val();
  imagesFileLength = imagesFileValue.split(",");
  console.log(imagesFileLength.length);
  if (imagesFileLength.length < 5) {
    if (image) {
      var imagefile = new FormData();
      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#ExternalExamphoto").prop("disabled", true);
      $("#start").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          // console.log(data);
          if (data != "") {
            var oldvalue = $("#imagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#imagesFile").val(FullValue);
            $(".spi").remove();
            $("#ExternalExamphoto").val("");

            $("#previousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="ExternalExamphotoremove(this)">Remove image</span></span>'
            );
            if (imagesFileLength.length < 4) {
              $("#ExternalExamphoto").prop("disabled", false);
            } else {
              $("#ExternalExamphoto").prop("disabled", true);
              $("#ExternalExamphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#ExternalExamphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    // alert('You are already uploaded 5 pictures.')
    $("#ExternalExamphoto").prop("disabled", true);
    $("#ExternalExamphoto").val("");
  }
}
function remov(element) {
 
  ID = $("#form_id").val();
  image = element.id;
  data = $("#imagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#imagesFile").val(data2);
  dbName = 'ST_CetaceanNecropsyReport';
  $.ajax({
    url: application_root + "Stranding.cfc?method=removeImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2, dbName: dbName },
    success: function(data) {
      // PDFArray = PDFArray.filter(e => e !== pdffile);
      // $('#pdfFiles').val(PDFArray);
      element.parentNode.remove();
      $("#ExternalExamphoto").prop("disabled", false);
    }
  });
}
function setValue() {
  // alert();
  fieldValur = $("#fieldnumber").val();
  // console.log(fieldValur);
  $("#fieldno").val(fieldValur);
  // console.log($("#fieldno").val());
}

function selected(elem) {
  var element = elem;
  $("#emb").attr("src", element.parentNode.title);
}
function selectedNecropsy(elem) {
  var element = elem;
  console.log(element.parentNode.title);
  $("#embNecropsy").attr("src", element.parentNode.title);
}

function checkfield() {
  var field = $("#fieldnumber")
    .val()
    .trim();
  if (field == "0") {
    $("#report").val("emptys");
    $("label[for='necropsyfieldnumber']").text('Enter New Field Number');
    

    $("#myformNecropsySerchByFieldNumber")
      .closest("form")
      .find("input[type=text], textarea")
      .val("");

    $("input:checkbox").removeAttr("checked");
    $("select option[value= '']").attr("selected", "selected");
    $("#Gonads_Identified").val(" ");
    $("#species").val("");

    $("#attendingVeterinarian").select2().val("").trigger("change.select2");
    $("#Prosectors").select2().val("").trigger("change.select2");
    $("#NxLocation")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#eye_left")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#eye_right")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#Skeletal_Findings")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#Musculature_Findings")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#ABDOMINAL_Lining")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#Liver_Findings")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#Overall_Findings")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#Parasites_Location")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#Kidney_left")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#Kidney_right")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#GIForeignMaterialType")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#CENTRALBrainFindings")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#CENTRALSpinalCordfinding")
      .select2()
      .val("")
      .trigger("change.select2");
    $("#Lungs_Findings")
      .select2()
      .val("")
      .trigger("change.select2");

    $("#fieldnumber").val("");

    // forImges
    $("#histoImages").val("");
    $("#histoUpload").empty();

    $("#ExternalExamDiv").hide();
    $("#previousimages").empty();
    $("#imagesFile").val("");

    $("#intenalExamphotoDiv").hide();
    $("#intenalExamPreviousimages").empty();
    $("#intenalExamImagesFile").val("");

    $("#musculoskeletalDiv").hide();
    $("#musculoskeletalPreviousimages").empty();
    $("#musculoskeletalImagesFile").val("");

    $("#thoracicphotoDiv").hide();
    $("#thoracicPreviousimages").empty();
    $("#thoracicImagesFile").val("");

    $("#abdominalDiv").hide();
    $("#abdominalPreviousimages").empty();
    $("#abdominalImagesFile").val("");

    $("#hepatobiliaryDiv").hide();
    $("#hepatobiliaryPreviousimages").empty();
    $("#hepatobiliaryImagesFile").val("");

    $("#cardiovascularDiv").hide();
    $("#cardiovascularPreviousimages").empty();
    $("#cardiovascularImagesFile").val("");

    $("#pulmonaryDiv").hide();
    $("#pulmonaryPreviousimages").empty();
    $("#pulmonaryImagesFile").val("");

    $("#lymphoreticularDiv").hide();
    $("#lymphoreticularPreviousimages").empty();
    $("#lymphoreticularImagesFile").val("");

    $("#endocrineDiv").hide();
    $("#endocrinePreviousimages").empty();
    $("#endocrineImagesFile").val("");

    $("#urogenitalDiv").hide();
    $("#urogenitalPreviousimages").empty();
    $("#urogenitalImagesFile").val("");

    $("#alimentaryphotoDiv").hide();
    $("#alimentaryPreviousimages").empty();
    $("#alimentaryImagesFile").val("");

    $("#centralNervousdiv").hide();
    $("#centralNervousPreviousimages").empty();
    $("#centralNervousImagesFile").val("");

    var count = $(".parasitediv").length;
    console.log(count);
    if(count > 1){
      for (let i = 0; i < count; i++) {
        $(".parasitediv:eq(1)").remove();
      }
    }

    $('#PARASITES').val('Yes');   
    $('#ParasiteType').val('Nemotode');
    $('#Parasitelocation').val('testing location');

    $("#PARASITES").attr("name", "PARASITES");
    $("#ParasiteType").attr("name", "ParasiteType");
    $("#Parasitelocation").attr("name", "Parasitelocation");
    
    var count1 = $(".chako").length;
    if(count1 > 1){
      for (let i = 0; i < count1; i++) {
        $(".chako:eq(1)").remove();
      }

    }

    $("#lymphnode").attr("name", "lymphnode");
    // $("#nodelength").attr("name", "nodelength");
    // $("#Parasitelocation").attr("name", "Parasitelocation");

    $(".kidneyClass").remove();
    $("#delete_btn").hide();
    $('#errorMessage').hide();
    

  } else {
    $("label[for='necropsyfieldnumber']").text('Field Number');
      // $("#Fnumber").attr("required", false);
      // $("#Fnumber").attr("name", "Fnumber2");
  //   $("select#fieldnumber").attr("name", "Fnumber");
  }
  $("#fieldno").val(field);

  if (field !== "0" && field !== "") {
      console.log(field);
    $.ajax({
      url: application_root + "Stranding.cfc?method=getmatchFnumb",
      type: "POST",
      data: {
        fieldno: field
      },
      success: function(data) {
        console.log(data);
        $("#report").val(data);
        if (data > 0) {
          url = $('#Site_url').val();
          $('#myformNecropsySerchByFieldNumber').attr('action', url + '&NecropsyReport');
          $("#myformNecropsySerchByFieldNumber").submit();
        } else {
          url = $('#Site_url').val();
          $('#myformNecropsySerchByFieldNumber').attr('action', url + '&NecropsyReport');
          $("#myformNecropsySerchByFieldNumber").submit();
  
        }
      }
    });
  }
}
$("#savebutton").click(function(){
    fieldNumber = $('#fieldnumber').val();
    fieldNumber2 = $('#Fnumber').val().trim();
    if(fieldNumber == '' && fieldNumber2 == ''){
        $('#errorMessage').show();
        $(window).scrollTop(top);
        // $("#fieldnumber").focus();
    }else{
        $('#errorMessage').hide();
    }
  });
function integumentshowPictures() {
  var files = $("#Integumentphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "integument_" + imagename;

  // var image = files[0]['name'];
  var image = files[0];
  integumentImagesValue = $("#integumentImagesFile").val();
  integumentImagesLength = integumentImagesValue.split(",");
  if (integumentImagesLength.length < 5) {
    if (image) {
      var imagefile = new FormData();
      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#Integumentphoto").prop("disabled", true);
      $("#startSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#integumentImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#integumentImagesFile").val(FullValue);
            $(".spi").remove();
            $("#Integumentphoto").val("");

            $("#IntegumentPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="integumentImageremove(this)">Remove image</span></span>'
            );
            if (integumentImagesLength.length < 4) {
              $("#Integumentphoto").prop("disabled", false);
            } else {
              $("#Integumentphoto").prop("disabled", true);
              $("#Integumentphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#Integumentphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    // alert('You are already uploaded 5 pictures.')
    $("#Integumentphoto").prop("disabled", true);
    $("#Integumentphoto").val("");
  }
}
function ExternalExamphotoremove(element) {
 
  ID = $("#form_id").val();
  image = element.id;
  data = $("#imagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#imagesFile").val(data2);
  dbName = 'ST_CetaceanNecropsyReport';
  $.ajax({
    url: application_root + "Stranding.cfc?method=removeImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2, dbName: dbName },
    success: function(data) {
      // PDFArray = PDFArray.filter(e => e !== pdffile);
      // $('#pdfFiles').val(PDFArray);
      element.parentNode.remove();
      $("#ExternalExamphoto").prop("disabled", false);
    }
  });
}
function integumentImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#integumentImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#integumentImagesFile").val(data2);
  console.log(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeIntegumentImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      // PDFArray = PDFArray.filter(e => e !== pdffile);
      // $('#pdfFiles').val(PDFArray);
      element.parentNode.remove();
      $("#Integumentphoto").prop("disabled", false);
      console.log("data");
    }
  });
}

function intenalExamPictures() {
  var files = $("#intenalExamphoto").prop("files");
  // console.log(files);
  var imagename = files[0]["name"];
  var imgname = "internalExam_" + imagename;

  var image = files[0];

  intenalExamValue = $("#intenalExamImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");

  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#intenalExamphoto").prop("disabled", true);
      $("#intenalExamSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          // console.log(data);
          if (data != "") {
            var oldvalue = $("#intenalExamImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#intenalExamImagesFile").val(FullValue);
            $(".spi").remove();
            $("#intenalExamphoto").val("");

            $("#intenalExamPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="intenalImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#intenalExamphoto").prop("disabled", false);
            } else {
              $("#intenalExamphoto").prop("disabled", true);
              $("#intenalExamphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#intenalExamphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    // alert('You are already uploaded 5 pictures.')
    $("#intenalExamphoto").prop("disabled", true);
    $("#intenalExamphoto").val("");
  }
}

function intenalImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#intenalExamImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#intenalExamImagesFile").val(data2);
  console.log(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeIntenalExamImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#intenalExamphoto").prop("disabled", false);
      console.log("data");
    }
  });
}

var cn = 1;
var histoUploadPDFArray = [];
if ($("#histoImages").val() != "") {
  histoUploadPDFArray.push($("#histoImages").val());
}

function histoUploadshowPictures() {
  cn = ++cn;
  pr = cn - 1;
  var files = $("#histofile").prop("files");
  var f = files[0];
  console.log(f.size);
  histoImagesValue = $("#histoImages").val();
  histoImagesLength = histoImagesValue.split(",");
  if (histoImagesLength.length < 3) {
    if (f.size < 10000000) {
      if (f.type == "application/pdf") {
        $("#histoSpinner").after(
          '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
        );
        $("#histofile").prop("disabled", true);
        var pdffile = new FormData();
        pdffile.append("pdf", f);
        $.ajax({
          url: application_root + "Stranding.cfc?method=uploadpdf",
          type: "POST",
          data: pdffile,
          enctype: "multipart/form-data",
          processData: false, // tell jQuery not to process the data
          contentType: false, // tell jQuery not to set contentType
          success: function(data) {
            if (data != "") {
              histoUploadPDFArray.push(data);

              var oldvalue = $("#histoImages").val();
              var newvalue = data;
              if (oldvalue) {
                var FullValue = oldvalue + "," + newvalue;
              } else {
                var FullValue = newvalue;
              }
              $("#histoImages").val(FullValue);

              // $('#histoImages').val(histoUploadPDFArray);
              $(".spi").remove();
              $("#histoUpload").append(
                '<span class="pip"><a data-toggle="modal" data-target="#myModala" href="#" title="http://cloud.wildfins.org/' +
                  data +
                  '" target="blank"><img id="select' +
                  pr +
                  '" class="imageThumb imag imageTh" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="' +
                  f.name +
                  '" onclick="pdfselected(this)"/></a><br/><span class="remove" id="' +
                  data +
                  '" onclick="histoPdfRemove(this)">Remove image</span></span>'
              );
              $("#histofile").prop("disabled", false);
              $("#histofile").val("");
              if (histoImagesLength.length < 2) {
                $("#histofile").prop("disabled", false);
              } else {
                $("#histofile").prop("disabled", true);
                $("#histofile").val("");
              }
            } else {
              alert("Selected file corrupted PDF");
              $(".spi").remove();
              $("#histofile").prop("disabled", false);
              $("#histofile").val("");
            }
          }
        });
      } else {
        alert("Selected file is not PDF");
        $("#histofile").val("");
      }
    } else {
      alert("Selected file is Large than 10MB");
      $("#histofile").val("");
    }
  } else {
    // alert('You are already uploaded 3 files.');
    $("#histofile").prop("disabled", false);
    $("#histofile").val("");
  }
}
function histoPdfRemove(el) {
  ID = $("#form_id").val();
  var element = el;
  pdffile = element.id;
  console.log(pdffile);

  data = $("#histoImages").val();

  data1 = data.split(",");
  var removeArrayValue = pdffile;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#histoImages").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=historemovepdf",
    type: "POST",
    data: { ID: ID, image: pdffile, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#histofile").prop("disabled", false);
      console.log("data");
    }
  });
}
function pdfselected(elem) {
  var element = elem;
  $("#embe").attr("src", element.parentNode.title);
  $("#pdfname").html($(this).attr("title"));
}

function thoracicshowPictures() {
  var files = $("#thoracicphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "thoracic_" + imagename;

  var image = files[0];

  intenalExamValue = $("#thoracicImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#thoracicphoto").prop("disabled", true);
      $("#startThoracicSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#thoracicImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#thoracicImagesFile").val(FullValue);
            $(".spi").remove();
            $("#thoracicphoto").val("");

            $("#thoracicPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="thoracicImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#thoracicphoto").prop("disabled", false);
            } else {
              $("#thoracicphoto").prop("disabled", true);
              $("#thoracicphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#thoracicphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    // alert('You are already uploaded 5 pictures.')
    $("#thoracicphoto").prop("disabled", true);
    $("#thoracicphoto").val("");
  }
}

function thoracicImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#thoracicImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#thoracicImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeThoracicImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#thoracicphoto").prop("disabled", false);
      console.log("data");
    }
  });
}

// for ABDOMINAL

function abdominalshowPictures() {
  var files = $("#abdominalphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "abdominal_" + imagename;

  var image = files[0];

  intenalExamValue = $("#abdominalImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#abdominalphoto").prop("disabled", true);
      $("#startAbdominalSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#abdominalImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#abdominalImagesFile").val(FullValue);
            $(".spi").remove();
            $("#abdominalphoto").val("");

            $("#abdominalPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="thoracicImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#abdominalphoto").prop("disabled", false);
            } else {
              $("#abdominalphoto").prop("disabled", true);
              $("#abdominalphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#abdominalphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    $("#abdominalphoto").prop("disabled", true);
    $("#abdominalphoto").val("");
  }
}

function abdominalImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#abdominalImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#abdominalImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeAbdominalImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#abdominalphoto").prop("disabled", false);
      console.log("data");
    }
  });
}


function hepatobiliaryShowPictures() {
  var files = $("#hepatobiliaryphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "hepatobiliary_" + imagename;

  var image = files[0];

  intenalExamValue = $("#hepatobiliaryImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#hepatobiliaryphoto").prop("disabled", true);
      $("#startHepatobiliarySpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#hepatobiliaryImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#hepatobiliaryImagesFile").val(FullValue);
            $(".spi").remove();
            $("#hepatobiliaryphoto").val("");

            $("#hepatobiliaryPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="hepatobiliaryImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#hepatobiliaryphoto").prop("disabled", false);
            } else {
              $("#hepatobiliaryphoto").prop("disabled", true);
              $("#hepatobiliaryphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#hepatobiliaryphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    $("#hepatobiliaryphoto").prop("disabled", true);
    $("#hepatobiliaryphoto").val("");
  }
}

function hepatobiliaryImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#hepatobiliaryImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#hepatobiliaryImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeHepatobiliaryImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#hepatobiliaryphoto").prop("disabled", false);
      console.log("data");
    }
  });
}

// for CARDIOVASCULAR
function cardiovascularShowPictures() {
  var files = $("#cardiovascularphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "cardiovascular_" + imagename;

  var image = files[0];

  intenalExamValue = $("#cardiovascularImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#cardiovascularphoto").prop("disabled", true);
      $("#startCardiovascularSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#cardiovascularImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#cardiovascularImagesFile").val(FullValue);
            $(".spi").remove();
            $("#cardiovascularphoto").val("");

            $("#cardiovascularPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="hepatobiliaryImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#cardiovascularphoto").prop("disabled", false);
            } else {
              $("#cardiovascularphoto").prop("disabled", true);
              $("#cardiovascularphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#cardiovascularphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    $("#cardiovascularphoto").prop("disabled", true);
    $("#cardiovascularphoto").val("");
  }
}

function cardiovascularImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#cardiovascularImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#cardiovascularImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeCardiovascularImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#cardiovascularphoto").prop("disabled", false);
      console.log("data");
    }
  });
}

// for PULMONARY

function pulmonaryShowPictures() {
  var files = $("#pulmonaryphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "pulmonary_" + imagename;

  var image = files[0];

  intenalExamValue = $("#pulmonaryImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#pulmonaryphoto").prop("disabled", true);
      $("#startPulmonarySpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#pulmonaryImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#pulmonaryImagesFile").val(FullValue);
            $(".spi").remove();
            $("#pulmonaryphoto").val("");

            $("#pulmonaryPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="pulmonaryImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#pulmonaryphoto").prop("disabled", false);
            } else {
              $("#pulmonaryphoto").prop("disabled", true);
              $("#pulmonaryphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#pulmonaryphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    $("#pulmonaryphoto").prop("disabled", true);
    $("#pulmonaryphoto").val("");
  }
}

function pulmonaryImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#pulmonaryImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#pulmonaryImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removePulmonaryImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#pulmonaryphoto").prop("disabled", false);
      console.log("data");
    }
  });
}

function lymphoreticularShowPictures() {
  var files = $("#lymphoreticularphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "lymphoreticular_" + imagename;

  var image = files[0];

  intenalExamValue = $("#lymphoreticularImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#lymphoreticularphoto").prop("disabled", true);
      $("#startLymphoreticularSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#lymphoreticularImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#lymphoreticularImagesFile").val(FullValue);
            $(".spi").remove();
            $("#lymphoreticularphoto").val("");

            $("#lymphoreticularPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="lymphoreticularImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#lymphoreticularphoto").prop("disabled", false);
            } else {
              $("#lymphoreticularphoto").prop("disabled", true);
              $("#lymphoreticularphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#lymphoreticularphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    $("#lymphoreticularphoto").prop("disabled", true);
    $("#lymphoreticularphoto").val("");
  }
}

function lymphoreticularImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#lymphoreticularImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#lymphoreticularImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeLymphoreticularImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#lymphoreticularphoto").prop("disabled", false);
      console.log("data");
    }
  });
}

function endocrineShowPictures() {
  var files = $("#endocrinephoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "endocrine_" + imagename;

  var image = files[0];

  intenalExamValue = $("#endocrineImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#endocrinephoto").prop("disabled", true);
      $("#startEndocrineSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#endocrineImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#endocrineImagesFile").val(FullValue);
            $(".spi").remove();
            $("#endocrinephoto").val("");

            $("#endocrinePreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="endocrineImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#endocrinephoto").prop("disabled", false);
            } else {
              $("#endocrinephoto").prop("disabled", true);
              $("#endocrinephoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#endocrinephoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    $("#endocrinephoto").prop("disabled", true);
    $("#endocrinephoto").val("");
  }
}

function endocrineImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#endocrineImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#endocrineImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeEndocrineImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#endocrinephoto").prop("disabled", false);
      console.log("data");
    }
  });
}

function urogenitalShowPictures() {
  var files = $("#urogenitalphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "urogenital_" + imagename;

  var image = files[0];

  intenalExamValue = $("#urogenitalImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#urogenitalphoto").prop("disabled", true);
      $("#startUrogenitalSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#urogenitalImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#urogenitalImagesFile").val(FullValue);
            $(".spi").remove();
            $("#urogenitalphoto").val("");

            $("#urogenitalPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="urogenitalImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#urogenitalphoto").prop("disabled", false);
            } else {
              $("#urogenitalphoto").prop("disabled", true);
              $("#urogenitalphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#urogenitalphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    // alert('You are already uploaded 5 pictures.')
    $("#urogenitalphoto").prop("disabled", true);
    $("#urogenitalphoto").val("");
  }
}

function urogenitalImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#urogenitalImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#urogenitalImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeUrogenitalImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#urogenitalphoto").prop("disabled", false);
      console.log("data");
    }
  });
}

function alimentaryShowPictures() {
  var files = $("#alimentaryphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "alimentary_" + imagename;

  var image = files[0];

  intenalExamValue = $("#alimentaryImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#alimentaryphoto").prop("disabled", true);
      $("#startAlimentarySpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#alimentaryImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#alimentaryImagesFile").val(FullValue);
            $(".spi").remove();
            $("#alimentaryphoto").val("");

            $("#alimentaryPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="alimentaryImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#alimentaryphoto").prop("disabled", false);
            } else {
              $("#alimentaryphoto").prop("disabled", true);
              $("#alimentaryphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#alimentaryphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    // alert('You are already uploaded 5 pictures.')
    $("#alimentaryphoto").prop("disabled", true);
    $("#alimentaryphoto").val("");
  }
}

function alimentaryImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#alimentaryImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#alimentaryImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeAlimentaryImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#alimentaryphoto").prop("disabled", false);
      console.log("data");
    }
  });
}
// for musculoskeletal
function musculoskeletalshowPictures() {
  var files = $("#musculoskeletal").prop("files");

  var imagename = files[0]["name"];
  var imgname = "musculoskeletal_" + imagename;

  var image = files[0];

  intenalExamValue = $("#musculoskeletalImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#musculoskeletal").prop("disabled", true);
      $("#startMusculoskeletalSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#musculoskeletalImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#musculoskeletalImagesFile").val(FullValue);
            $(".spi").remove();
            $("#musculoskeletal").val("");

            $("#musculoskeletalPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="musculoskeletalImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#musculoskeletal").prop("disabled", false);
            } else {
              $("#musculoskeletal").prop("disabled", true);
              $("#musculoskeletal").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#musculoskeletal").prop("disabled", false);
          }
        }
      });
    }
  } else {
    // alert('You are already uploaded 5 pictures.')
    $("#musculoskeletal").prop("disabled", true);
    $("#musculoskeletal").val("");
  }
}

function musculoskeletalImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#musculoskeletalImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#musculoskeletalImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removemusculoskeletalImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#musculoskeletal").prop("disabled", false);
      console.log("data");
    }
  });
}

// for CENTRAL NERVOUS
function centralNervousShowPictures() {
  var files = $("#centralNervousphoto").prop("files");

  var imagename = files[0]["name"];
  var imgname = "centralNervous_" + imagename;

  var image = files[0];

  intenalExamValue = $("#centralNervousImagesFile").val();
  intenalExamLength = intenalExamValue.split(",");
  if (intenalExamLength.length < 5) {
    if (image) {
      var imagefile = new FormData();

      imagefile.append("pdf", image);
      imagefile.append("name", imgname);

      $("#centralNervousphoto").prop("disabled", true);
      $("#startCentralNervousSpinner").after(
        '<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>'
      );

      $.ajax({
        url: application_root + "Stranding.cfc?method=uploadImage",
        type: "POST",
        data: imagefile,
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function(data) {
          if (data != "") {
            var oldvalue = $("#centralNervousImagesFile").val();
            var newvalue = data;
            if (oldvalue) {
              var FullValue = oldvalue + "," + newvalue;
            } else {
              var FullValue = newvalue;
            }
            $("#centralNervousImagesFile").val(FullValue);
            $(".spi").remove();
            $("#centralNervousphoto").val("");

            $("#centralNervousPreviousimages").append(
              '<span class="pip"><a data-toggle="modal" data-target="#myNecropsyModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selectedNecropsy(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="centralNervousImageremove(this)">Remove image</span></span>'
            );
            if (intenalExamLength.length < 4) {
              $("#centralNervousphoto").prop("disabled", false);
            } else {
              $("#centralNervousphoto").prop("disabled", true);
              $("#centralNervousphoto").val("");
            }
          } else {
            $(".spi").remove();
            alert("Image not Uploaded");
            $("#centralNervousphoto").prop("disabled", false);
          }
        }
      });
    }
  } else {
    // alert('You are already uploaded 5 pictures.')
    $("#centralNervousphoto").prop("disabled", true);
    $("#centralNervousphoto").val("");
  }
}

function centralNervousImageremove(element) {
  ID = $("#form_id").val();
  image = element.id;
  data = $("#centralNervousImagesFile").val();
  data1 = data.split(",");
  var removeArrayValue = image;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $("#centralNervousImagesFile").val(data2);

  $.ajax({
    url: application_root + "Stranding.cfc?method=removeCentralNervousImage",
    type: "POST",
    data: { ID: ID, image: image, imgValue: data2 },
    success: function(data) {
      element.parentNode.remove();
      $("#centralNervousphoto").prop("disabled", false);
      console.log("data");
    }
  });
}

function lessionphotos() {
  // alert();
  if ($("#lessionphototaken").is(":checked")) {
    $("#ExternalExamDiv").show();
    $("#previousimages").show();
    // $('#integumentdiv').show();
    // $('#IntegumentPreviousimages').show();
  } else {
    $("#ExternalExamDiv").hide();
    $("#previousimages").hide();
    // $('#integumentdiv').hide();
    // $('#IntegumentPreviousimages').hide();
  }
}
function centralNervous() {
  if ($("#centralNervousCheck").is(":checked")) {
    $("#centralNervousdiv").show();
    $("#centralNervousPreviousimages").show();
  } else {
    $("#centralNervousdiv").hide();
    $("#centralNervousPreviousimages").hide();
  }
}
function internalPhoto() {
  if ($("#internal_phototaken").is(":checked")) {
    $("#intenalExamphotoDiv").show();
    $("#intenalExamPreviousimages").show();
  } else {
    $("#intenalExamphotoDiv").hide();
    $("#intenalExamPreviousimages").hide();
  }
}
function thoraticPhoto() {
  if ($("#thoratic_phototaken").is(":checked")) {
    $("#thoracicphotoDiv").show();
    $("#thoracicPreviousimages").show();
  } else {
    $("#thoracicphotoDiv").hide();
    $("#thoracicPreviousimages").hide();
  }
}
function abdominalPhoto() {
  if ($("#abdominal_phototaken").is(":checked")) {
    $("#abdominalDiv").show();
    $("#abdominalPreviousimages").show();
  } else {
    $("#abdominalDiv").hide();
    $("#abdominalPreviousimages").hide();
  }
}
function hepatobiliaryPhoto() {
  if ($("#hepatobiliary_phototaken").is(":checked")) {
    $("#hepatobiliaryDiv").show();
    $("#hepatobiliaryPreviousimages").show();
  } else {
    $("#hepatobiliaryDiv").hide();
    $("#hepatobiliaryPreviousimages").hide();
  }
}
function cardioPhoto() {
  if ($("#cardio_phototaken").is(":checked")) {
    $("#cardiovascularDiv").show();
    $("#cardiovascularPreviousimages").show();
  } else {
    $("#cardiovascularDiv").hide();
    $("#cardiovascularPreviousimages").hide();
  }
}
function pulmonaryPhoto() {
  if ($("#pulmonary_phototaken").is(":checked")) {
    $("#pulmonaryDiv").show();
    $("#pulmonaryPreviousimages").show();
  } else {
    $("#pulmonaryDiv").hide();
    $("#pulmonaryPreviousimages").hide();
  }
}
function lymphoPhoto() {
  if ($("#lympho_phototaken").is(":checked")) {
    $("#lymphoreticularDiv").show();
    $("#lymphoreticularPreviousimages").show();
  } else {
    $("#lymphoreticularDiv").hide();
    $("#lymphoreticularPreviousimages").hide();
  }
}
function endocrinePhoto() {
  if ($("#endocrine_phototaken").is(":checked")) {
    $("#endocrineDiv").show();
    $("#endocrinePreviousimages").show();
  } else {
    $("#endocrineDiv").hide();
    $("#endocrinePreviousimages").hide();
  }
}
function UROGENITALPhoto() {
  if ($("#UROGENITAL_phototaken").is(":checked")) {
    $("#urogenitalDiv").show();
    $("#urogenitalPreviousimages").show();
  } else {
    $("#urogenitalDiv").hide();
    $("#urogenitalPreviousimages").hide();
  }
}
function ParasitePhoto() {
  if ($("#Parasite_phototaken").is(":checked")) {
    $("#alimentaryphotoDiv").show();
    $("#alimentaryPreviousimages").show();
  } else {
    $("#alimentaryphotoDiv").hide();
    $("#alimentaryPreviousimages").hide();
  }
}

function muscularPhoto() {
  if ($("#muscular_phototaken").is(":checked")) {
    $("#musculoskeletalDiv").show();
    $("#musculoskeletalPreviousimages").show();
  } else {
    $("#musculoskeletalDiv").hide();
    $("#musculoskeletalPreviousimages").hide();
  }
}

$(document).ready(function() {
  if ($("#lessionphototaken").is(":checked")) {
    $("#ExternalExamDiv").show();
    $("#previousimages").show();
    // $('#integumentdiv').show();
    // $('#IntegumentPreviousimages').show();
  } else {
    $("#ExternalExamDiv").hide();
    $("#previousimages").hide();
    // $('#integumentdiv').hide();
    // $('#IntegumentPreviousimages').hide();
  }

  if ($("#centralNervousCheck").is(":checked")) {
    $("#centralNervousdiv").show();
    $("#centralNervousPreviousimages").show();
  } else {
    $("#centralNervousdiv").hide();
    $("#centralNervousPreviousimages").hide();
  }

  if ($("#internal_phototaken").is(":checked")) {
    $("#intenalExamphotoDiv").show();
    $("#intenalExamPreviousimages").show();
  } else {
    $("#intenalExamphotoDiv").hide();
    $("#intenalExamPreviousimages").hide();
  }

  if ($("#thoratic_phototaken").is(":checked")) {
    $("#thoracicphotoDiv").show();
    $("#thoracicPreviousimages").show();
  } else {
    $("#thoracicphotoDiv").hide();
    $("#thoracicPreviousimages").hide();
  }

  if ($("#abdominal_phototaken").is(":checked")) {
    $("#abdominalDiv").show();
    $("#abdominalPreviousimages").show();
  } else {
    $("#abdominalDiv").hide();
    $("#abdominalPreviousimages").hide();
  }

  if ($("#hepatobiliary_phototaken").is(":checked")) {
    $("#hepatobiliaryDiv").show();
    $("#hepatobiliaryPreviousimages").show();
  } else {
    $("#hepatobiliaryDiv").hide();
    $("#hepatobiliaryPreviousimages").hide();
  }

  if ($("#cardio_phototaken").is(":checked")) {
    $("#cardiovascularDiv").show();
    $("#cardiovascularPreviousimages").show();
  } else {
    $("#cardiovascularDiv").hide();
    $("#cardiovascularPreviousimages").hide();
  }

  if ($("#pulmonary_phototaken").is(":checked")) {
    $("#pulmonaryDiv").show();
    $("#pulmonaryPreviousimages").show();
  } else {
    $("#pulmonaryDiv").hide();
    $("#pulmonaryPreviousimages").hide();
  }
  if ($("#lympho_phototaken").is(":checked")) {
    $("#lymphoreticularDiv").show();
    $("#lymphoreticularPreviousimages").show();
  } else {
    $("#lymphoreticularDiv").hide();
    $("#lymphoreticularPreviousimages").hide();
  }

  if ($("#endocrine_phototaken").is(":checked")) {
    $("#endocrineDiv").show();
    $("#endocrinePreviousimages").show();
  } else {
    $("#endocrineDiv").hide();
    $("#endocrinePreviousimages").hide();
  }
  if ($("#UROGENITAL_phototaken").is(":checked")) {
    $("#urogenitalDiv").show();
    $("#urogenitalPreviousimages").show();
  } else {
    $("#urogenitalDiv").hide();
    $("#urogenitalPreviousimages").hide();
  }

  if ($("#Parasite_phototaken").is(":checked")) {
    $("#alimentaryphotoDiv").show();
    $("#alimentaryPreviousimages").show();
  } else {
    $("#alimentaryphotoDiv").hide();
    $("#alimentaryPreviousimages").hide();
  }

  if ($("#muscular_phototaken").is(":checked")) {
    $("#musculoskeletalDiv").show();
    $("#musculoskeletalPreviousimages").show();
  } else {
    $("#musculoskeletalDiv").hide();
    $("#musculoskeletalPreviousimages").hide();
  }
});

// function getCode() {
//   species = $("#species option:selected").val();
//   sp = $("#species option:selected").text();
//   console.log(species);
//   console.log(sp);
//   $("#speciesee").val(sp);
//   $("#code").empty();
//   $("#code").append(new Option("Select Code", "0"));
//   if (species != 0) {
//     $.ajax({
//       url:
//         application_root + "SightingNew.cfc?method=getCetaceansCodeForTracking",
//       Datatype: "json",
//       type: "get",
//       data: {
//         Cetacean_Species: species
//       },
//       success: function(data) {
//         var obj = JSON.parse(data);
//         for (var i = 0; i < obj.DATA.length; i++) {
//           $("#code").append(new Option(obj.DATA[i][0], obj.DATA[i][1]));
//         }
//       }
//     });
//   }
// } 
function getFbAndSex1() {
  $("#sex").val("");
  code = $("#photocode option:selected").val();
  if (code != 0) {
    $.ajax({
      url: application_root + "Stranding.cfc?method=getFbAndSexOfCode",
      Datatype: "json",
      type: "get",
      data: {
        Code_ID: code
      },
      success: function(data) {
        // console.log(data);
        var obj = JSON.parse(data);
        // $('#hera').val(obj.DATA[0][1]);
        // if(obj.DATA[0][0] == 'F')
        // $('#sex').val('female');
        // else if(obj.DATA[0][0] == 'M')
        // $('#sex').val('male');
        // else if(obj.DATA[0][0] == 'U')
        // $('#sex').val('cbd');
        let F = "Female";
        let M = "Male";
        let C = "CBD";
        if (obj.DATA[0][0] == "F")
          $("#sex option:contains(" + F + ")").attr("selected", "selected");
        // $('#sex').val('female');
        else if (obj.DATA[0][0] == "M")
          $("#sex option:contains(" + M + ")").attr("selected", "selected");
        else if (obj.DATA[0][0] == "U")
          $("#sex option:contains(" + C + ")").attr("selected", "selected");
      }
    });
  }
}



$( "#loadMore" ).click(function( event ) {
  event.stopImmediatePropagation();
});

// function fieldnum(){
//     field=$("#fieldList option:selected").text().trim();
//     console.log(field);
//     $("#fielnumb").val(field);
//     $("#fieldform").submit();
// }

// $('#loadMore').click(function(e) {
//     e.stopPropagation();
// });
function addMoreRecords(event)
  {
 
    
    document.getElementById('listDate').size=10;
      value = $('#listDate option:selected').text();
  
        if(value == "Load More" ){

            start = $('#startValue').val();
            end = Number(start) + 1000;
            // console.log(start)
            // console.log(end)

            $.ajax({
                url: application_root + "Stranding.cfc?method=getmaindate",
                type: "post",
                data: {
                    startvalue: start,
                    endValue:end
                },
                success: function (data) {
                    console.log(data);
                    // append options
                    var obj = JSON.parse(data);
                    console.log(obj);

                    for (var i = 0; i < obj.DATA.length; i++) {
                        $(new Option(obj.DATA[i][0], obj.DATA[i][1])).insertBefore ("#loadMore");
                                           
                    }
                    // $('#listDate').select2('open');
                    $('#listDate').val('');
                    $('#listDate').size=10;
                    $('#startValue').val(end);
     
                }
            });
        }else if(value == "Select Date"){
            // alert()
        }else if(value == "Search") {
            $('#search').show();
        }    
        
        else{
          url = $('#Site_url').val();
          $('#dateform').attr('action', url + '&SampleArchive');
            $( "#dateform" ).submit();
            // $('#listDate').append(value).trigger('change');
        }
  }  
function searchData(){
    // document.getElementById('listDate').size=10;
   searchFeildValue = $('#search').val();
   $('#listDate').html('').select2({data: [{id: '', text: ''}]});
   $('#listDate').attr('size',6)

    $.ajax({
        url: application_root + "Stranding.cfc?method=searchData",
        type: "post",
        data: {
            value: searchFeildValue
        },
        success: function (data) {
            // console.log(data);
            // append options
            var obj = JSON.parse(data);
       
            if(obj.DATA.length > 0){
                $('#listDate').select2('destroy');
                for (var i = 0; i < obj.DATA.length; i++) {
                    // $(new Option(obj.DATA[i][0], obj.DATA[i][1])).insertBefore ("#loadMore");
                    $('#listDate').append(new Option(obj.DATA[i][0], obj.DATA[i][1])); 
                    console.log(obj.DATA[i][1]);                                                          
                }
                // $('#listDate').append(new Option('Load More', 'LoadMore'));
                $('#listDate').select2('open');
                document.getElementById("search").focus();
            }else{
                $('#listDate').select2('destroy');
                // $('#listDate').html('').select2({data: [{id: '', text: ''}]});
                   $('#listDate').append(`<option value="norecord">
                        No Record Found!
                       </option>`);
                       $('#listDate').select2('open');
            }
            // // $('#listDate').val('').trigger('change');
          

        }
    });
}

function getFocus() {
    document.getElementById("search").focus();
  }
//end for sampleArchive

$( "#deletCetaceanNecropsyAllRecord" ).click(function() {
  // $('#fieldnumber').val('1235');
  // $("input[name=fieldnumber]").remove();
  $('#date').val('YYYY-MM-DD');
  $("#Fnumber").attr("required", false);
});


function edit_AncillaryRow(id){
  $("#idForUpdate").val(id);
  $("#TestNew").val("Update");
  
  // DiagnosticTest
  if($("#DiagnosticTest_"+id).text() != ''){
    let c=$("#DiagnosticTest_"+id).text();
    $("#DiagnosticTest option:contains("+c+")").attr('selected', 'selected');
  }
  if($("#TestResults_"+id).text() != ''){
      let TestResults=$("#TestResults_"+id).text();
      $("#TestResults option:contains("+TestResults+")").attr('selected', 'selected');
  }
  if($("#DiagnosticLab_"+id).text() != ''){
      let DiagnosticLab=$("#DiagnosticLab_"+id).text();
      $("#DiagnosticLab option:contains("+DiagnosticLab+")").attr('selected', 'selected');
  }
  if($("#AncillaryDate_"+id).text() != ''){
      $('#TestingDate').val($("#AncillaryDate_"+id).text()) ;
      // $("#DiagnosticLab option:contains("+DiagnosticLab+")").attr('selected', 'selected');
  }
//   console.log($("#AAncillaryPDF_"+id).text());
//   if($("#AAncillaryPDF_"+id).text() != '' && $("#AAncillaryPDF_"+id).text() != '0'){
    
//     $('#filesAncillary').html($("#AAncillaryPDF_"+id).text()) ;
//     // let status=$("#L_status"+id).text();
//     // $("#Status option:contains("+status+")").attr('selected', 'selected');
// }
  // alert();
  // return false;
 
}
function delete_AncillaryRow(id){

  AncillaryID=id;
  var ajaxData = new FormData();
  ajaxData.append('ID', AncillaryID);
  $.ajax({
      url : application_root+"Stranding.cfc?method=AncillaryLesion",
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

function showPDFmodal(elem){
  var element = elem;
  $("#embAncillaryDiagnostics").attr("src", element.parentNode.title);
  $("#embAncillaryDiagnosticspdfname").html($(this).attr("title"));
}



// For ceteacen Exam
// var cn=1;
var PDFEXAMArray = [];
if($('#pdfFiles').val() != ''){
  PDFEXAMArray.push($('#pdfFiles').val());
}
function ceteacenExamImg(){
  // alert();
    cn = ++cn;
    pr = cn - 1;
    var files = $('#ExamFiles').prop('files');
    var f = files[0];
    console.log(f.size);
    if(f.size < 10000000){
        if(f.type == 'application/pdf'){    
            $('#startExam').after('<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>');
            $('#ExamFiles').prop('disabled', true);
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
                      PDFEXAMArray.push(data);
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
                    $('#previousimagesExam').append('<span class="pip"><a data-toggle="modal" data-target="#myModalExam" href="#" title="http://cloud.wildfins.org/'+data+'" target="blank"><img id="select'+pr+'" class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="'+f.name+'" onclick="selected(this)"/></a><br/><span class="remove" id="'+data+'" onclick="remov(this)">Remove image</span></span>');
                    $('#ExamFiles').prop('disabled', false);
                    }else{
                        alert('Selected file corrupted PDF');
                        $('.spi').remove();
                        $('#ExamFiles').prop('disabled', false);
                    }
                }
            });
        }else{
            alert('Selected file is not PDF');
            $('#ExamFiles').val("");
        }
    }else{
        alert('Selected file is Large than 10MB');
        $('#ExamFiles').val("");
    }        
}
function remov(el){
  // alert();
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
  $('#embExamPDF').attr('src', element.parentNode.title);
  $('#pdfExamName').html($(this).attr('title'));
  
}
// end ceteacen Exam

// start for hiform

// var cn=1;
var HIPDFArray = [];
if($('#HIFormpdfFiles').val() != ''){
    HIPDFArray.push($('#HIFormpdfFiles').val());

}
function HIFormimg(){
  // alert();
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
                    HIPDFArray.push(data);
                    $('#HIFormpdfFiles').val(HIPDFArray);
                    $('.spi').remove();
                    $('#HIFormPreviousimages').append('<span class="pip"><a data-toggle="modal" data-target="#myHiFormModal" href="#" title="http://cloud.wildfins.org/'+data+'" target="blank"><img id="select'+pr+'" class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="'+f.name+'" onclick="selectedHIForm(this)"/></a><br/><span class="remove" id="'+data+'" onclick="removeHiFormPDF(this)">Remove image</span></span>');
                    $('#files').prop('disabled', false);
                    }else{
                        alert('Selected file corrupted PDF');
                        $('.spi').remove();
                        $('#files').prop('disabled', false);
                    }
                    // $('#remove'+pr).click(function(){
                    //     $(this).parent(".pip").remove();
                    //     $('#files'+pr).remove();

                    // });

                    // $('#select'+pr).click(function(){
                    //     we = $(this).parent().attr('title');
                    //     $('#emb').attr('src', we);
                    //     $('#pdfname').html($(this).attr('title'));
                    // });
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
function removeHiFormPDF(el){
  // alert();
  ID = $('#HIForm_ID').val();
  var element = el;
  pdffile = element.id
  console.log(pdffile);
console.log(ID);
  data = $('#HIFormpdfFiles').val();

  data1 = data.split(",");
  var removeArrayValue = pdffile;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $('#HIFormpdfFiles').val(data2);

console.log(ID);
  $.ajax({
      url: application_root +"Stranding.cfc?method=removepdfHIForm",
      type: "POST",
      data: { ID: ID, pdf: pdffile, imgValue: data2 },
      success: function (data) {
          // PDFArray = PDFArray.filter(e => e !== "Get_Started_With_Smallpdf20.pdf"); 
          // $('#pdfFiles').val(PDFArray);
          element.parentNode.remove();
      }
  });    
}
// function removeHiFormPDF(el){
//     var element = el;
//     pdffile = element.id
//     console.log(pdffile);
//     $.ajax({
//         url: application_root +"Stranding.cfc?method=removepdf",
//         type: "POST",
//         data: {pdf: pdffile},
//         success: function (data) {
//             HIPDFArray = HIPDFArray.filter(e => e !== pdffile); 
//             $('#pdfFiles').val(HIPDFArray);
//             element.parentNode.remove();
//         }
//     });    
// }
function selectedHIForm(elem) {
    var element = elem;
    $('#embHIForm').attr('src', element.parentNode.title);
    $('#HIpdfname').html($(this).attr('title'));
    
}

// end for hiform

// start for Level A Form

// var cn=1;
var LAPDFArray = [];
if($('#LApdfFiles').val() != ''){
    LAPDFArray.push($('#LApdfFiles').val());

}
function levelAFormimg(){
    cn = ++cn;
    pr = cn - 1;
    var files = $('#LevelAFormfiles').prop('files');
    var f = files[0];
    console.log(f.size);
    if(f.size < 10000000){
        if(f.type == 'application/pdf'){    
            $('#LAstart').after('<span class="spi"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span></span>');
            $('#LevelAFormfiles').prop('disabled', true);
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
                    LAPDFArray.push(data);
                    $('#LApdfFiles').val(LAPDFArray);
                    $('.spi').remove();
                    $('#LevelAFormpreviousimages').append('<span class="pip"><a data-toggle="modal" data-target="#myHiFormModal" href="#" title="http://cloud.wildfins.org/'+data+'" target="blank"><img id="select'+pr+'" class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="'+f.name+'" onclick="selectedHIForm(this)"/></a><br/><span class="remove" id="'+data+'" onclick="LevelAFormremove(this)">Remove image</span></span>');
                    $('#files').prop('disabled', false);
                    }else{
                        alert('Selected file corrupted PDF');
                        $('.spi').remove();
                        $('#LevelAFormfiles').prop('disabled', false);
                    }
                    // $('#remove'+pr).click(function(){
                    //     $(this).parent(".pip").remove();
                    //     $('#files'+pr).remove();

                    // });

                    // $('#select'+pr).click(function(){
                    //     we = $(this).parent().attr('title');
                    //     $('#emb').attr('src', we);
                    //     $('#pdfname').html($(this).attr('title'));
                    // });
                }
            });
        }else{
            alert('Selected file is not PDF');
            $('#LevelAFormfiles').val("");
        }
    }else{
        alert('Selected file is Large than 10MB');
        $('#LevelAFormfiles').val("");
    }        
}
function LevelAFormremove(el){
  // alert();
  ID = $('#level_A_ID').val();
  var element = el;
  pdffile = element.id
  console.log(pdffile);
console.log(ID);
  data = $('#LApdfFiles').val();

  data1 = data.split(",");
  var removeArrayValue = pdffile;
  data1.splice($.inArray(removeArrayValue, data1), 1);
  data2 = data1.toString();

  $('#LApdfFiles').val(data2);

console.log(ID);
  $.ajax({
      url: application_root +"Stranding.cfc?method=removepdfLAForm",
      type: "POST",
      data: { ID: ID, pdf: pdffile, imgValue: data2 },
      success: function (data) {
          // PDFArray = PDFArray.filter(e => e !== "Get_Started_With_Smallpdf20.pdf"); 
          // $('#pdfFiles').val(PDFArray);
          element.parentNode.remove();
      }
  });    
}
// function LevelAFormremove(el){
//     var element = el;
//     pdffile = element.id
//     console.log(pdffile);
//     $.ajax({
//         url: application_root +"Stranding.cfc?method=removepdf",
//         type: "POST",
//         data: {pdf: pdffile},
//         success: function (data) {
//             PDFArray = PDFArray.filter(e => e != pdffile); 
//             $('#pdfFiles').val(PDFArray);
//             element.parentNode.remove();
//         }
//     });    
// }

// end for Level A Form