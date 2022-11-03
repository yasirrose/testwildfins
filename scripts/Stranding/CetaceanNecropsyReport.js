$(document).ready(function() {
  handleDateTimePicker = function() {
    "use strict";

    $("#first_date")
      .datetimepicker({ format: "MM/DD/YYYY" })
      .on("dp.change", function(e) {
        // Revalidate the date field
        var name = $(this).attr("name");
        $("#birthday").formValidation("revalidateField", name);
      });
    $("#LevelA_Date")
      .datetimepicker({ format: "MM/DD/YYYY" })
      .on("dp.change", function(e) {
        // Revalidate the date field
        var name = $(this).attr("name");
        $("#Level_A_Date").formValidation("revalidateField", name);
      });
    $("#Necropsy_Date")
      .datetimepicker({ format: "MM/DD/YYYY" })
      .on("dp.change", function(e) {
        // Revalidate the date field
        var name = $(this).attr("name");
        $("#NecropsyDate").formValidation("revalidateField", name);
      });
    $("#Chem_date_picker")
      .datetimepicker({ format: "MM/DD/YYYY" })
      .on("dp.change", function(e) {
        // Revalidate the date field
        var name = $(this).attr("name");
        $("#Chem_date").formValidation("revalidateField", name);
      });
  };
  handleDateTimePicker();
});

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
function changeimg() {
  species = $("#species option:selected").val();
  console.log(species);
  if (species == 6 || species == 12) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Tursiops_Diagram.png"
    );
    $("#measureImg").val("Tursiops_Diagram.png");
  }
  if (species == 6) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Humpback_Diagram.png"
    );
    $("#measureImg").val("Humpback_Diagram.png");
  }
  if (species == 7 || species == 15) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Kogia_Diagram.png"
    );
    $("#measureImg").val("Kogia_Diagram.png");
    $("#DorsalFinHeight").show();
    $("#RostrumtoBlowhole").show();
  }
  if (species == 8 || species == 9) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Globicephala_Diagram.png"
    );
    $("#measureImg").val("Globicephala_Diagram.png");
  }
  if (species == 10) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Rissos_Diagram.png"
    );
    $("#measureImg").val("Rissos_Diagram.png");
  }
  if (
    species == 11 ||
    species == 13 ||
    species == 22 ||
    species == 23 ||
    species == 24
  ) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Stenella_Species_Diagram.png"
    );
    $("#measureImg").val("Stenella_Species_Diagram.png");
  }
  if (species == 14) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/melon_headed_whale_measurement_diagram.png"
    );
    $("#measureImg").val("melon_headed_whale_measurement_diagram.png");
  }
  if (species == 16) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/SpermWhale_Diagram.png"
    );
    $("#measureImg").val("SpermWhale_Diagram.png");
  }
  if (species == 17) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Steno_Diagram.png"
    );
    $("#measureImg").val("Steno_Diagram.png");
  }
  if (species == 18 || species == 19) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Mesoplodon_Species_Diagram.png"
    );
    $("#measureImg").val("Mesoplodon_Species_Diagram.png");
  }
  if (species == 20) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Cuviers_Diagram.png"
    );
    $("#measureImg").val("Cuviers_Diagram.png");
  }
  if (species == 21) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/FalseKillerWhale_Diagram.png"
    );
    $("#measureImg").val("FalseKillerWhale_Diagram.png");
  }
  if (species == 25) {
    $("#measureImage").attr(
      "src",
      "http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/NARW_Diagram.png"
    );
    $("#measureImg").val("NARW_Diagram.png");
  }

  // workig start
  species = $("#species option:selected").val();
  sp = $("#species option:selected").text();
  // console.log(species);
  // console.log(sp);

  $("#speciesee").val(sp);
  $("#photocode").empty();
  $("#photocode").append(new Option("Select Code", "0"));
  if (species != 0) {
    $.ajax({
      url:
        application_root + "SightingNew.cfc?method=getCetaceansCodeForTracking",
      Datatype: "json",
      type: "get",
      data: {
        Cetacean_Species: species
      },
      success: function(data) {
        console.log(data);
        var obj = JSON.parse(data);
        for (var i = 0; i < obj.DATA.length; i++) {
          $("#photocode").append(new Option(obj.DATA[i][0], obj.DATA[i][1]));
        }
      }
    });
  }
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
                data +
                '" title="' +
                data +
                '"/></a><br/><span class="remove" id="' +
                data +
                '" onclick="remov(this)">Remove image</span></span>'
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
function checkfield() {
  var field = $("#fieldnumber")
    .val()
    .trim();
  if (field == "0") {
    // $('#delete_btn').hide();
    $("#report").val("emptys");
    $(
      '<input class="input-label" id="myInput" name="fieldnumber" placeholder="field number" type="text" required/>'
    ).insertBefore(".apend");
    $("select#fieldnumber").attr("required", false);
    $("select#fieldnumber").attr("name", "fieldnumber1");

    $("#myform")
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

    $("#fieldnumber").val("0");

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
    $("input[name=fieldnumber]").remove();
    $("select#fieldnumber").attr("name", "fieldnumber");
  }
  $("#fieldno").val(field);

  if (field !== "0" && field !== "") {
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
          $("#myform").submit();
        } else {
          $("#myform").submit();
        }
      }
    });
  }
}
$("#savebutton").click(function(){
    fieldNumber = $('#fieldnumber').val();
    if(fieldNumber == ''){
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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
              '<span class="pip"><a data-toggle="modal" data-target="#myModal" title="http://cloud.wildfins.org/' +
                data +
                '" target="blank"><img id="select' +
                data +
                '" class="imageThumb imag" onclick="selected(this)" class="image-fluid" src="http://cloud.wildfins.org/' +
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

function getCode() {
  species = $("#species option:selected").val();
  sp = $("#species option:selected").text();
  $("#speciesee").val(sp);
  $("#code").empty();
  $("#code").append(new Option("Select Code", "0"));
  if (species != 0) {
    $.ajax({
      url:
        application_root + "SightingNew.cfc?method=getCetaceansCodeForTracking",
      Datatype: "json",
      type: "get",
      data: {
        Cetacean_Species: species
      },
      success: function(data) {
        var obj = JSON.parse(data);
        for (var i = 0; i < obj.DATA.length; i++) {
          $("#code").append(new Option(obj.DATA[i][0], obj.DATA[i][1]));
        }
      }
    });
  }
}
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

$( "#deletCetaceanNecropsyAllRecord" ).click(function() {
  // $('#fieldnumber').val('1235');
  // $("input[name=fieldnumber]").remove();
  $('#date').val('mm/dd/yyyy');
  $("select#fieldnumber").attr("required", false);
});