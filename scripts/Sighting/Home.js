$(document).ready(function () {
    $('body').on('click', '.viewCetaceanImage', function () {
        $('#imagepreview').attr('src', $(this).data('url'));
        $('#myModalLabel').html($(this).attr('title'));
        $('#imagemodal').modal('show');
    });
    
    
    // let tab_url1 = $(location).attr('href'); 
    // let tab_url =  tab_url1.split('&').pop();
//    console.log(tab_url);
// const histoDirect = tab_url.substring(15, tab_url.indexOf('='));
// if(tab_url != "Page=Home"){
//     var ret = tab_url.replace('SightingId=','');
//     setTimeout(() => {
//         document.getElementById('sightid').value = ret;
//     }, 310);
//     }


    var handleBootstrapCombobox = function () {
        "use strict";
        $('.combobox').combobox();
    };
    setTimeout(function () {
        $(".alert-success").hide();
        $(".alert-danger").hide();
        $(".alert-new").show();
    }, 6000);

    $(document).on('click', '.cetacean_modal_close', function (e) {
        $("#update_cs_Id").val(0);
        $("#primaryOldImage").val("");
        $("#SecondaryOldImage").val("");
        $( ".file-input" ).addClass( "file-input-new" );
        $('#cl_cs_Id').val(0);
        $('#condition_lesions_form').removeClass('is-lesion-form');
        $('#cetacean').removeClass('in');
        $('#cetacean').hide();
        $('#Cetacean_Sighting_Form_Text').html('Cetacean Sighting Form');
        $('#add_cetaceansSighting_btn').html('Submit');
        $(".reset").trigger("click");
        $("#Cetacean_code").select2({
            placeholder: "Select a Cetacean Name/Code",
            value: ""
        });
        $("#alt_images").html("");
    });

    $(document).on('click', '.closeHistoryModal', function (e) {
        $('#dolphin_history').removeClass('in');
        $('#dolphin_history').hide();
    });

    $(document).on('click', '.closeHistoryModal', function (e) {
        $('#dolphin_history').removeClass('in');
        $('#dolphin_history').hide();
    });

    $(document).on('click', '#btn_dolphin_history', function (e) {
        $('#dolphin_history').addClass('in');
        $('#dolphin_history').show();
    });

    $(document).on('click', '.closeLesionHistoryModal', function (e) {
        $('#lesion_history').removeClass('in');
        $('#lesion_history').hide();
    });

    $(document).on('click', '#btn_lesion_history', function (e) {
        // alert();
        // Get the list if CL records
        getlesionsList(true);
    });


    $(document).on('click', '#btn_CS_history', function (e) {
        var Sid = $("#sightid").val();
        var Pid = $("#project_val").val();
        if (Sid == 0 || Pid == 0) {
            bootbox.alert('Please Select Sightings');
        } else {
            $('#CS_history').addClass('in');
            $('#CS_history').show();
        }
    });

    $(document).on('click', '.closeCSHistoryModal', function (e) {
        $('#CS_history').removeClass('in');
        $('#CS_history').hide();
    });

    $(document).on('click', '.closeGoogleMapModal', function (e) {
        $('#google_map').removeClass('in');
        $('#google_map').hide();
    });


    $(".multiple-select2").select2({
        placeholder: "Select a Team Members"
    });

    $(".multiple-select2").select2({
        placeholder: "Select a Cetacean Name/Code"
    });



    handleDateTimePicker = function () {
        "use strict";
        $("#datetimepicker1").datetimepicker({
            format: 'MM/DD/YYYY'
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'Date_p');
        }), $("#datetimepicker2").datetimepicker({
            format: "HH:mm"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'StartTime');
        }), $("#datetimepicker_endtime").datetimepicker({
            format: 'HH:mm'
        }).on('dp.change', function (e) {
            $('#ResetMe').formValidation('revalidateField', 'EndTime');
        }), $("#datetimepicker_srvystrt").datetimepicker({
            format: 'HH:mm'
        }), $("#datetimepicker_sightingstrt").datetimepicker({
            format: 'HH:mm'
        }).on('dp.change', function (e) {
            $('#ResetMe').formValidation('revalidateField', 'Sightingstart');
        }), $("#datetimepicker_sightingend").datetimepicker({
            format: 'HH:mm'
        }).on('dp.change', function (e) {
            $('#ResetMe').formValidation('revalidateField', 'Sightingend');
        }), $("#datetimepicker_srvyend").datetimepicker({
            format: 'HH:mm'
        }), $("#datetimepicker3").datetimepicker(), $("#datetimepicker4").datetimepicker(), $("#datetimepicker3").on("dp.change", function (e) {
            $("#datetimepicker4").data("DateTimePicker").minDate(e.date)
        }), $("#datetimepicker4").on("dp.change", function (e) {
            $("#datetimepicker3").data("DateTimePicker").maxDate(e.date)
        }), $(".datetimepicker").datetimepicker({
            format: 'MM/DD/YYYY'
        }), $("#datetimepicker_enginestart").datetimepicker({
            format: "HH:mm"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'EngineStart');
        }), $("#datetimepicker_engineoff").datetimepicker({
            format: "HH:mm"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'EngineOff');
        }),$("#StratTimeDive1").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'StratTimeDive1');
        }),$("#StratTimeDive2").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'StratTimeDive2');
        }),$("#StratTimeDive3").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'StratTimeDive3');
        }),$("#StratTimeDive4").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'StratTimeDive4');
        }),$("#StratTimeDive5").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'StratTimeDive5');
        }),$("#EndTimeDive1").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'EndTimeDive1');
        }),$("#EndTimeDive2").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'EndTimeDive2');
        }),$("#EndTimeDive3").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'EndTimeDive3');
        }),$("#EndTimeDive4").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'EndTimeDive4');
        }),$("#EndTimeDive5").datetimepicker({
            format: "HH:mm:ss"
        }).on('dp.change', function (e) {
            // Revalidate the date field
            $('#ResetMe').formValidation('revalidateField', 'EndTimeDive5');
        })
    }


    var handleJqueryTagIt = function () {
        "use strict";
        $('#jquery-tagIt-default').tagit({
            availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"],
            fieldName: "Team"

        });
        $('#jquery-tagIt-inverse').tagit({
            availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
        });
        $('#jquery-tagIt-white').tagit({
            availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
        });
        $('#jquery-tagIt-primary').tagit({
            availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
        });
        $('#jquery-tagIt-info').tagit({
            availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
        });
        $('#jquery-tagIt-success').tagit({
            availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
        });
        $('#jquery-tagIt-warning').tagit({
            availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
        });
        $('#jquery-tagIt-danger').tagit({
            availableTags: ["c++", "java", "php", "javascript", "ruby", "python", "c"]
        });

    }

    handleBootstrapCombobox();
    handleDateTimePicker();
    handleJqueryTagIt();

    $(".plateform_value").click(function () {
        var value = $(this).attr('value');
        $("#plateform_value").val(value);
        $('#ResetMe').formValidation('revalidateField', 'Platform');
    });

    $(".area_value").click(function () {
        var value = $(this).attr('value');
        $("#area_value").val(value);
        $('#ResetMe').formValidation('revalidateField', 'SurveyArea');
    });
    $("#area_value").change(function (e) {
        var stock = $(this).find("option:selected").data("stock");
        if (stock != "") {
            $("#stock_value").val(stock);
            $("#stock_value").data('combobox').refresh();
        } else {
            $("#stock_value").find("option:selected").prop("selected", false);
            $('#stock_value').data('combobox').clearTarget();
            $('#stock_value').data('combobox').clearElement();
        }
    });
    $("#SubType").change(function (e) {
        var surverType = $(this).find("option:selected").data("surveytype");
        if (surverType != "") {
            $("#Type").val(surverType);
            $("#Type").data('combobox').refresh();
        } else {
            $("#Type").find("option:selected").prop("selected", false);
            $('#Type').data('combobox').clearTarget();
            $('#Type').data('combobox').clearElement();
        }
    });

    $(".stock_value").click(function () {
        var value = $(this).attr('value');
        $("#stock_value").val(value);
        $('#ResetMe').formValidation('revalidateField', 'Stock');
    });


    $(".Camera_value").click(function () {

        var value = $(this).attr('value');
        var data_id = $(this).attr('data-id');

        $("#Camera_value").val(value);
        $("#Camera_value_id").val(data_id);

        $('#ResetMe').formValidation('revalidateField', 'camera_value');
    });

    $(".Lens_value").click(function () {
        var value = $(this).attr('value');
        var data_id = $(this).attr('data-id');
        $("#Lens_value").val(value);
        $("#Lens_value_id").val(data_id);
    });

    $(".Photographer_value").click(function () {
        var value = $(this).attr('value');
        var data_id = $(this).attr('data-id');
        $("#Photographer_value").val(value);
        $("#Photographer_value_id").val(data_id);
    });

    $(".Driver_value").click(function () {
        var value = $(this).attr('value');
        var data_id = $(this).attr('data-id');
        $("#Driver_value").val(value);
        $("#Driver_value_id").val(data_id);
    });

    $("#input-4").fileinput({
        showCaption: false
    });
    // App.init();



    $("#input-4").change(function () {
        var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
        if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
            alert("Only formats are allowed : " + fileExtension.join(', '));
            $("#input-4").val('');
        }

    });


    var saveValue = [];
    var saveName = [];
    $('.select_activity').change(function () {
        oldValue = "";
        isAttr = 1;
        isVal = 1;
        set = 0;
        var currentValue = $(this).val();
        if (saveValue.length == 0) {
            $(this).attr("data-old", currentValue);
        }
        oldValue = $(this).attr("data-old");
        for (var i = 0; i < saveValue.length; i++) {
            if (currentValue == saveValue[i] && currentValue != '') {
                isVal = 0;
            } else {
                isVal = 1;
            }
            if ($(this).attr("name") == saveName[i] && $(this).attr("name") != '') {
                isAttr = 0;
            } else {
                isAttr = 1;
            }
        }

        if ((isAttr == 1 && isVal == 1) || isAttr == 0 && isVal == 1) {
            set = 1;
        }

        if (currentValue == '') {
            $(this).val('');
            return;
        }

        if (set == 1) {
            for (var i = 0; i < saveValue.length; i++) {
                if (oldValue == saveValue[i] && currentValue != '') {
                    var index = saveValue.indexOf(oldValue);
                    saveValue.splice(index, 1);
                }
            }
            for (var i = 0; i < saveValue.length; i++) {
                if (currentValue == saveValue[i] && currentValue != '') {
                    $(this).val('');
                    alert('You cannot choose the same number twice:' + currentValue);
                    return;
                }
            }
            saveValue.push(currentValue.trim());
            if (isAttr == 1) {
                saveName.push($(this).attr("name"));
            }
            $(this).attr("data-old", currentValue);
        } else {
            $(this).val('');
            alert('You cannot choose the same number twice:' + currentValue);
        }
    });

    $('#shot').val(1);
    $('#door').change(function () {
        var dolphin_id = $('#door').val();

        //$('#door option').prop('disabled', true);

        var sight_id = $('#sightid').val();
        var ShotNum = $('#shot').val();
        if (ShotNum == 1) {
            firstshotdata(1, dolphin_id);
        }
    });
    $('#shotnumber1').click(function () {
        var id = $('#door option:selected').val();
        firstshotdata(1, id);
        $('#shot').show();
        $('#shot').val(1);

    })
    $('#shotnumber2').click(function () {
        var id = $('#door option:selected').val();
        secondshotdata(2, id);
        $('#shot').show();
        $('#shot').val(2);
    })
    $('#shotnumber3').click(function () {
        var id = $('#door option:selected').val();
        thirdshotdata(3, id);
        $('#shot').show();
        $('#shot').val(3);
    })

    function thirdshotdata(ShotNum, dolphin_id) {
        var sight_id = $('#sightid').val();
        $.ajax({
            url: application_root + "Dolphin.cfc?method=thirdShotData",
            type: "POST",
            data: {
                "dolphin_id": dolphin_id,
                "sight_id": sight_id,
                "shotNumber": ShotNum
            },
            success: function (response) {
                var rep = JSON.parse(response)
                $('#bhv1').val(rep[0]["TargetResponseBehavior1"]);
                $('#shttm').val(rep[0]["ShotTime"]);
                $('#bhv2').val(rep[0]["TargetResponseBehavior2"]);
                $('#arba').val(rep[0]["Arbalester"]);
                $('#bhv3').val(rep[0]["TargetResponseBehavior3"]);
                $('#tgtr1').val(rep[0]["TargetLevel"]);
                $('#tgtr2').val(rep[0]["TargetLevel2"]);
                $('#tgtr3').val(rep[0]["TargetLevel3"]);
                $('#shotdist').val(rep[0]["ShotDistance"]);
                $('#grp1').val(rep[0]["GroupLevel1"]);
                $('#smplnbr').val(rep[0]["SampleNumber"]);
                $('#grprp1').val(rep[0]["GroupResponseBehavior"]);
                $('#hitloc').val(rep[0]["HitLocation"]);
                $('#grpsz').val(rep[0]["GroupSize"]);
                $('#process').val(rep[0]["Processor"]);
                $('#subsmpl').val(rep[0]["SubSample"]);
                $('#smplngth').val(rep[0]["SampleLength"]);
                var hitlocation = rep[0]["HitLocation"];

                if (hitlocation >= 1) {
                    $('#hitloc').prop("selected", true);
                }
                var rad = rep[0]["Outcome"];
                if (rad == 0) {
                    $('#missOutcome').prop("checked", true);
                    $('#shotnumber3').css("background-color", "");
                    $('#shotnumber2').css("background-color", "");
                    $('#shotnumber1').css("background-color", "");
                } else if (rad == 1) {
                    $('#hitOutcome').prop("checked", true);
                    $('#shotnumber3').css('background-color', 'green');
                    $('#shotnumber1').css("background-color", "");
                    $('#shotnumber2').css("background-color", "");
                }
                $('#smplnbr').val(rep[0]["SampleNumber"]);
                $('#subsmpl').val(rep[0]["SubSample"])
            }


        });
    }

    function secondshotdata(ShotNum, id) {
        var sights_id = $('#sightid').val();
        $.ajax({
            url: application_root + "Dolphin.cfc?method=secondShotData",
            type: "POST",
            data: {
                "dolphin_id": id,
                "sight_id": sights_id,
                "shotNumber": ShotNum
            },
            success: function (response) {
                var rep = JSON.parse(response)
                $('#bhv1').val(rep[0]["TargetResponseBehavior1"]);
                $('#shttm').val(rep[0]["ShotTime"]);
                $('#bhv2').val(rep[0]["TargetResponseBehavior2"]);
                $('#arba').val(rep[0]["Arbalester"]);
                $('#bhv3').val(rep[0]["TargetResponseBehavior3"]);
                $('#tgtr1').val(rep[0]["TargetLevel"]);
                $('#tgtr2').val(rep[0]["TargetLevel2"]);
                $('#tgtr3').val(rep[0]["TargetLevel3"]);
                $('#grp1').val(rep[0]["GroupLevel1"]);
                $('#shotdist').val(rep[0]["ShotDistance"]);
                $('#smplnbr').val(rep[0]["SampleNumber"]);
                $('#grprp1').val(rep[0]["GroupResponseBehavior"]);
                $('#hitloc').val(rep[0]["HitLocation"]);
                $('#grpsz').val(rep[0]["GroupSize"]);
                $('#subsmpl').val(rep[0]["SubSample"]);
                $('#smplngth').val(rep[0]["SampleLength"]);
                var hitlocation = rep[0]["HitLocation"];
                $('#process').val(rep[0]["Processor"]);
                if (hitlocation >= 1) {
                    $('#hitloc').prop("selected", true);
                }
                var rad = rep[0]["Outcome"];
                if (rad == 0) {
                    $('#missOutcome').prop("checked", true);
                    $('#shotnumber3').css("background-color", "");
                    $('#shotnumber2').css("background-color", "");
                    $('#shotnumber1').css("background-color", "");
                } else if (rad == 1) {
                    $('#hitOutcome').prop("checked", true);
                    $('#shotnumber2').css('background-color', 'green');
                    $('#shotnumber1').css("background-color", "");
                    $('#shotnumber3').css("background-color", "");
                }
                $('#smplnbr').val(rep[0]["SampleNumber"]);
                $('#subsmpl').val(rep[0]["SubSample"])
            }


        });
    }

    function firstshotdata(ShotNum, id) {
        var sights_id = $('#sightid').val();
        $.ajax({
            url: application_root + "Dolphin.cfc?method=firstShotData",
            type: "POST",
            data: {
                "dolphin_id": id,
                "sight_id": sights_id,
                "shotNumber": ShotNum
            },
            success: function (response) {
                var rep = JSON.parse(response)

                $('#bhv1').val(rep[0]["TargetResponseBehavior1"]);
                $('#shttm').val(rep[0]["ShotTime"]);
                $('#bhv2').val(rep[0]["TargetResponseBehavior2"]);
                $('#arba').val(rep[0]["Arbalester"]);
                $('#bhv3').val(rep[0]["TargetResponseBehavior3"]);
                $('#tgtr1').val(rep[0]["TargetLevel"]);
                $('#tgtr2').val(rep[0]["TargetLevel2"]);
                $('#tgtr3').val(rep[0]["TargetLevel3"]);
                $('#grp1').val(rep[0]["GroupLevel1"]);
                $('#shotdist').val(rep[0]["ShotDistance"]);
                $('#smplnbr').val(rep[0]["SampleNumber"]);
                $('#grprp1').val(rep[0]["GroupResponseBehavior"]);
                $('#subsmpl').val(rep[0]["SubSample"]);
                $('#smplngth').val(rep[0]["SampleLength"]);
                $('#htdscrp').val(rep[0]["HitDescriptor"]);
                $('#hitloc').val(rep[0]["HitLocation"]);
                var hitlocation = rep[0]["HitLocation"];
                $('#process').val(rep[0]["Processor"]);
                $('#grpsz').val(rep[0]["GroupSize"]);
                if (hitlocation >= 1) {
                    $('#hitloc').prop("selected", true);
                }
                var rad = rep[0]["Outcome"];
                if (rad == 0) {
                    $('#missOutcome').prop("checked", true);
                    $('#shotnumber3').css("background-color", "");
                    $('#shotnumber2').css("background-color", "");
                    $('#shotnumber1').css("background-color", "");
                } else if (rad == 1) {
                    $('#hitOutcome').prop("checked", true);
                    $('#shotnumber1').css('background-color', 'green');
                    $('#shotnumber3').css("background-color", "");
                    $('#shotnumber2').css("background-color", "");


                }
                $('#smplnbr').val(rep[0]["SampleNumber"]);
                $('#subsmpl').val(rep[0]["SubSample"])
            }


        });
    }



    $('#bhv1').change(function () {
        var value = $("#bhv1 option:selected").text();
        if (value == 'Quiver' || value == 'Startle reaction' || value == 'Deep dive' || value == 'Reposition on bow' || value == 'Slowly submerge') {
            $('#tgtr1').val('Low');
        } else if (value == 'Roll' || value == 'Defecate' || value == 'Forceful breath' || value == 'Accelerate quickly' || value == 'Arched back' || value == 'Tail kick' || value == 'Hesitation') {
            $('#tgtr1').val('Low Moderate');
        } else if (value == 'Change swim direction' || value == 'Tail slap' || value == 'Fast dive' || value == 'Sharking' || value == 'Tense') {
            $('#tgtr1').val('Moderate');
        } else if (value == 'Target animal left bow' || value == 'Entire group left bow' || value == 'Breach and leave bow' || value == 'Breach and remain on bow' || value == 'Startle reaction') {
            $('#tgtr1').val('Moderate Strong');
        } else if (value == 'Multiple breaches') {
            $('#tgtr1').val('Strong');
        } else if (value == 'Reaction not observed') {
            $('#tgtr1').val('N/A');
        } else if (value == null) {
            $('#tgtr1').val('');
        }

    })

    $('#bhv2').change(function () {
        var value = $("#bhv2 option:selected").text();
        if (value == 'Quiver' || value == 'Startle reaction' || value == 'Deep dive' || value == 'Reposition on bow' || value == 'Slowly submerge') {
            $('#tgtr2').val('Low');
        } else if (value == 'Roll' || value == 'Defecate' || value == 'Forceful breath' || value == 'Accelerate quickly' || value == 'Arched back' || value == 'Tail kick' || value == 'Hesitation') {
            $('#tgtr2').val('Low Moderate');
        } else if (value == 'Change swim direction' || value == 'Tail slap' || value == 'Fast dive' || value == 'Sharking' || value == 'Tense') {
            $('#tgtr2').val('Moderate');
        } else if (value == 'Target animal left bow' || value == 'Entire group left bow' || value == 'Breach and leave bow' || value == 'Breach and remain on bow' || value == 'Startle reaction') {
            $('#tgtr2').val('Moderate Strong');
        } else if (value == 'Multiple breaches') {
            $('#tgtr2').val('Strong');
        } else if (value == 'Reaction not observed') {
            $('#tgtr2').val('N/A');
        } else if (value == null) {
            $('#tgtr2').val('');
        }

    })

    $('#bhv3').change(function () {
        var value = $("#bhv3 option:selected").text();
        if (value == 'Quiver' || value == 'Startle reaction' || value == 'Deep dive' || value == 'Reposition on bow' || value == 'Slowly submerge') {
            $('#tgtr3').val('Low');
        } else if (value == 'Roll' || value == 'Defecate' || value == 'Forceful breath' || value == 'Accelerate quickly' || value == 'Arched back' || value == 'Tail kick' || value == 'Hesitation') {
            $('#tgtr3').val('Low Moderate');
        } else if (value == 'Change swim direction' || value == 'Tail slap' || value == 'Fast dive' || value == 'Sharking' || value == 'Tense') {
            $('#tgtr3').val('Moderate');
        } else if (value == 'Target animal left bow' || value == 'Entire group left bow' || value == 'Breach and leave bow' || value == 'Breach and remain on bow' || value == 'Startle reaction') {
            $('#tgtr3').val('Moderate Strong');
        } else if (value == 'Multiple breaches') {
            $('#tgtr3').val('Strong');
        } else if (value == 'Reaction not observed') {
            $('#tgtr3').val('N/A');
        } else if (value == null) {
            $('#tgtr3').val('');
        }

    })

    $('#grprp1').change(function () {
        var value = $("#grprp1 option:selected").text();
        if (value == 'Quiver' || value == 'Startle reaction' || value == 'Deep dive' || value == 'Reposition on bow' || value == 'Slowly submerge') {
            $('#grp1').val('Low');
        } else if (value == 'Roll' || value == 'Defecate' || value == 'Forceful breath' || value == 'Accelerate quickly' || value == 'Arched back' || value == 'Tail kick' || value == 'Hesitation') {
            $('#grp1').val('Low Moderate');
        } else if (value == 'Change swim direction' || value == 'Tail slap' || value == 'Fast dive' || value == 'Sharking' || value == 'Tense') {
            $('#grp1').val('Moderate');
        } else if (value == 'Target animal left bow' || value == 'Entire group left bow' || value == 'Breach and leave bow' || value == 'Breach and remain on bow' || value == 'Startle reaction') {
            $('#grp1').val('Moderate Strong');
        } else if (value == 'Multiple breaches') {
            $('#grp1').val('Strong');
        } else if (value == 'Reaction not observed') {
            $('#grp1').val('N/A');
        } else if (value == null) {
            $('#grp1').val('');
        }

    })

    $('#grprp2').change(function () {
        var value = $("#grprp2 option:selected").text();
        if (value == 'Quiver' || value == 'Startle reaction' || value == 'Deep dive' || value == 'Reposition on bow' || value == 'Slowly submerge') {
            $('#grp2').val('Low');
        } else if (value == 'Roll' || value == 'Defecate' || value == 'Forceful breath' || value == 'Accelerate quickly' || value == 'Arched back' || value == 'Tail kick' || value == 'Hesitation') {
            $('#grp2').val('Low Moderate');
        } else if (value == 'Change swim direction' || value == 'Tail slap' || value == 'Fast dive' || value == 'Sharking' || value == 'Tense') {
            $('#grp2').val('Moderate');
        } else if (value == 'Target animal left bow' || value == 'Entire group left bow' || value == 'Breach and leave bow' || value == 'Breach and remain on bow' || value == 'Startle reaction') {
            $('#grp2').val('Moderate Strong');
        } else if (value == 'Multiple breaches') {
            $('#grp2').val('Strong');
        } else if (value == 'Reaction not observed') {
            $('#grp2').val('N/A');
        } else if (value == null) {
            $('#grp2').val('');
        }

    })
    $('#grprp3').change(function () {
        var value = $("#grprp3 option:selected").text();
        if (value == 'Quiver' || value == 'Startle reaction' || value == 'Deep dive' || value == 'Reposition on bow' || value == 'Slowly submerge') {
            $('#grp3').val('Low');
        } else if (value == 'Roll' || value == 'Defecate' || value == 'Forceful breath' || value == 'Accelerate quickly' || value == 'Arched back' || value == 'Tail kick' || value == 'Hesitation') {
            $('#grp3').val('Low Moderate');
        } else if (value == 'Change swim direction' || value == 'Tail slap' || value == 'Fast dive' || value == 'Sharking' || value == 'Tense') {
            $('#grp3').val('Moderate');
        } else if (value == 'Target animal left bow' || value == 'Entire group left bow' || value == 'Breach and leave bow' || value == 'Breach and remain on bow' || value == 'Startle reaction') {
            $('#grp3').val('Moderate Strong');
        } else if (value == 'Multiple breaches') {
            $('#grp3').val('Strong');
        } else if (value == 'Reaction not observed') {
            $('#grp3').val('N/A');
        } else if (value == null) {
            $('#grp3').val('');
        }

    })

    $('.biopsy-list').click(function () {
        var sights_id = $('#sightid').val();

        $.ajax({
            url: application_root + "SightingNew.cfc?method=getdolphinBYShot",
            type: "get",
            data: {
                "sight_id": sights_id
            },
            success: function (data) {
                var html = '';
                var res = JSON.parse(data);

                // for (var i = 0; i < res.length; i++) {
                //     html += '<tr><td>' + res[i]["DolName"] + '</td>' + '<td>'
                //         + res[i]["DolCod"] + '</td>' + '<td>' + res[i]["Dolshot"] +
                //         '</td>' + '<td>' + res[i]["DolSex"] + '</td></tr>';
                // }

                for (var i = 0; i < res.length; i++) {

                    html += '<div class="row"> <div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;"><div class="col-md-3">' + res[i]["DolName"] + '</div>' +
                        '<div class="col-md-3">' + res[i]["DolCod"] + '</div>' +
                        '<div class="col-md-3">' + res[i]["Dolshot"] + '</div>' +
                        '<div class="col-md-3">' + res[i]["DolSex"] + '</div></div></div>';
                }
                $('.appendhere').html(html);




                $('#listdata').append(html);
            }

        });
    });


    var TIME_PATTERN = /([0-9]+):([0-5][0-9]|60)/;
    /*
     $('#ResetMe').formValidation({

     framework: 'bootstrap',
     err: {
     container: 'tooltip'
     },
     icon: {
     valid: 'glyphicon glyphicon-ok-',
     invalid: 'glyphicon glyphicon-remove-',
     validating: 'glyphicon glyphicon-refresh'
     },
     fields: {
     StartTime: {
     validators: {

     regexp: {
     regexp: TIME_PATTERN,
     message: 'Time Fomrat invalide'
     }
     }
     },
     EndTime: {
     validators: {

     regexp: {
     regexp: TIME_PATTERN,
     message: 'Time Fomrat invalide'
     }
     }
     },
     SurveyStartTime: {
     validators: {

     regexp: {
     regexp: TIME_PATTERN,
     message: 'Time Fomrat invalide'
     }
     }
     },
     SurveyEndTime: {
     validators: {

     regexp: {
     regexp: TIME_PATTERN,
     message: 'Time Fomrat invalide'
     }
     }
     },
     Sightingstart: {
     validators: {

     regexp: {
     regexp: TIME_PATTERN,
     message: 'Time Fomrat invalide'
     }
     }
     },
     Sightingend: {
     validators: {

     regexp: {
     regexp: TIME_PATTERN,
     message: 'Time Fomrat invalide'
     }
     }
     },


     ResearchTeam:{
     validators: {
     notEmpty: {
     message: 'Please select Team member'
     }
     }
     },
     Platform:{
     validators: {
     notEmpty: {
     message: 'Please select Plateform'
     }
     }
     },
     SurveyArea:{
     validators: {
     notEmpty: {
     message: 'Please select Survey Area'
     }
     }
     },
     camera_value:{
     validators: {
     notEmpty: {
     message: 'Please select camera'
     }
     }
     },
     Lens_value:{
     validators: {
     notEmpty: {
     message: 'Please select Lens'
     }
     }
     },
     zone_id:{
     validators: {
     notEmpty: {
     message: 'Please select Zone'
     }
     }
     },
     Stock:{
     validators: {
     notEmpty: {
     message: 'Please select Stock'
     }
     }
     },


     Date_p:{
     validators: {

     date: {
     format: 'MM/DD/YYYY',
     message: 'The date and time is not a valid'
     }
     }
     }


     }
     });
     */

    var xaz = [];
    var cfa = 0;
    var data = [];
    $('.Pre-Biopsy1').change(function () {
        if (cfa < 5) {
            var set = 0;
            for (var i = 0; i < xaz.length; i++) {
                if ($(this).val() == xaz[i] && $(this).val() != -1) {
                    set = 1;
                }
                if ($(this).attr("name") == data[i] && $(this).attr("name") != '') {
                    if ($(this).val() == -1) {
                        xaz.splice(i, 1);
                        data.splice(i, 1);
                        set = 3;
                        cfa = cfa - 1;
                    } else {
                        xaz[i] = $(this).val();
                        set = 2;
                    }
                }
            }
            if (set == 0) {
                xaz.push($(this).val());
                data.push($(this).attr("name"));
                cfa = cfa + 1;
            } else {
                if (set == 2) {

                } else {
                    $(this).val('-1');
                }
            }
        } else {
            if ($(this).val() == -1) {
                for (var j = 0; j < data.length; j++) {
                    if ($(this).attr("name") == data[j] && $(this).attr("name") != '') {
                        xaz.splice(j, 1);
                        data.splice(j, 1);
                        set = 3;
                        cfa = cfa - 1;
                    }
                }
            } else {
                var al = -1;
                for (var k = 0; k < data.length; k++) {
                    if ($(this).attr("name") == data[k] && $(this).attr("name") != '') {
                        var al = k;
                        break;
                    }
                }
                if (al > -1) {
                    var va = -1;
                    for (var t = 0; t < data.length; t++) {
                        if ($(this).val() == xaz[t] && $(this).val() != -1) {
                            va = t;
                        }
                    }
                    if (va > -1) {
                        $(this).val(xaz[al]);
                    } else {
                        xaz[al] = $(this).val();
                    }

                } else {
                    $(this).val('-1');
                    alert('You have alreday selected 5 values');
                }
            }
        }

    });



    $('#convertTemp').click(function () {
        var x;
        degree = document.getElementsByClassName("myCheckbox")[0].value;
        y = document.getElementsByName("WaterTemp")[0].value;
        if (y !== '') {
            if (degree == "C") {
                x = document.getElementsByName("WaterTemp")[0].value * 9 / 5 + 32;
                document.getElementsByName("WaterTemp")[0].value = Math.round(x);
            } else {
                x = (document.getElementsByName("WaterTemp")[0].value - 32) * 5 / 9;
                document.getElementsByName("WaterTemp")[0].value = Math.round(x);
            }
        } else {
            bootbox.alert('Please enter Water Temp');
        }
    });

    $('.myCheckbox').click(function () {
        $(this).siblings('input:checkbox').prop('checked', false);
    });



    var sa = []; //xa
    var sf = 0; //cf
    var sat = []; // dat
    $('.Pre-BiopsyG1').change(function () {
        if (sf < 5) {
            var set = 0;
            for (var i = 0; i < sa.length; i++) {
                if ($(this).val() == sa[i] && $(this).val() != -1) {
                    set = 1;
                }
                if ($(this).attr("name") == sat[i] && $(this).attr("name") != '') {
                    if ($(this).val() == -1) {
                        sa.splice(i, 1);
                        sat.splice(i, 1);
                        set = 3;
                        sf = sf - 1;
                    } else {
                        sa[i] = $(this).val();
                        set = 2;
                    }
                }
            }
            if (set == 0) {
                sa.push($(this).val());
                sat.push($(this).attr("name"));
                sf = sf + 1;
            } else {
                if (set == 2) {

                } else {
                    $(this).val('-1');
                }
            }
        } else {
            if ($(this).val() == -1) {
                for (var j = 0; j < sat.length; j++) {
                    if ($(this).attr("name") == sat[j] && $(this).attr("name") != '') {
                        sa.splice(j, 1);
                        sat.splice(j, 1);
                        set = 3;
                        sf = sf - 1;
                    }
                }
            } else {
                var al = -1;
                for (var k = 0; k < sat.length; k++) {
                    if ($(this).attr("name") == sat[k] && $(this).attr("name") != '') {
                        var al = k;
                        break;
                    }
                }
                if (al > -1) {
                    var va = -1;
                    for (var t = 0; t < sat.length; t++) {
                        if ($(this).val() == sa[t] && $(this).val() != -1) {
                            va = t;
                        }
                    }
                    if (va > -1) {
                        $(this).val(sa[al]);
                    } else {
                        sa[al] = $(this).val();
                    }

                } else {
                    $(this).val('-1');
                    alert('You have alreday selected 5 values');
                }
            }
        }

    });



    var zaaxa = []; //zax
    var aafca = 0; //afc
    var aataa = []; //atad
    $('.Post-Biopsy1').change(function () {
        if (aafca < 5) {
            var set = 0;
            for (var i = 0; i < zaaxa.length; i++) {
                if ($(this).val() == zaaxa[i] && $(this).val() != -1) {
                    set = 1;
                }
                if ($(this).attr("name") == aataa[i] && $(this).attr("name") != '') {
                    if ($(this).val() == -1) {
                        zaaxa.splice(i, 1);
                        aataa.splice(i, 1);
                        set = 3;
                        aafca = aafca - 1;
                    } else {
                        zaaxa[i] = $(this).val();
                        set = 2;
                    }
                }
            }
            if (set == 0) {
                zaaxa.push($(this).val());
                aataa.push($(this).attr("name"));
                aafca = aafca + 1;
            } else {
                if (set == 2) {

                } else {
                    $(this).val('-1');
                }
            }
        } else {
            if ($(this).val() == -1) {
                for (var j = 0; j < aataa.length; j++) {
                    if ($(this).attr("name") == aataa[j] && $(this).attr("name") != '') {
                        zaaxa.splice(j, 1);
                        aataa.splice(j, 1);
                        set = 3;
                        aafca = aafca - 1;
                    }
                }
            } else {
                var al = -1;
                for (var k = 0; k < aataa.length; k++) {
                    if ($(this).attr("name") == aataa[k] && $(this).attr("name") != '') {
                        var al = k;
                        break;
                    }
                }
                if (al > -1) {
                    var va = -1;
                    for (var t = 0; t < aataa.length; t++) {
                        if ($(this).val() == zaaxa[t] && $(this).val() != -1) {
                            va = t;
                        }
                    }
                    if (va > -1) {
                        $(this).val(zaaxa[al]);
                    } else {
                        zaaxa[al] = $(this).val();
                    }

                } else {
                    $(this).val('-1');
                    alert('You have alreday selected 5 values');
                }
            }
        }
    });

    //

    var paz = [];
    var pfa = 0;
    var pata = [];
    $('.Post-BiopsyG1').change(function () {
        if (pfa < 5) {
            var set = 0;
            for (var i = 0; i < paz.length; i++) {
                if ($(this).val() == paz[i] && $(this).val() != -1) {
                    set = 1;
                }
                if ($(this).attr("name") == pata[i] && $(this).attr("name") != '') {
                    if ($(this).val() == -1) {
                        paz.splice(i, 1);
                        pata.splice(i, 1);
                        set = 3;
                        pfa = pfa - 1;
                    } else {
                        paz[i] = $(this).val();
                        set = 2;
                    }
                }
            }
            if (set == 0) {
                paz.push($(this).val());
                pata.push($(this).attr("name"));
                pfa = pfa + 1;
            } else {
                if (set == 2) {

                } else {
                    $(this).val('-1');
                }
            }
        } else {
            if ($(this).val() == -1) {
                for (var j = 0; j < pata.length; j++) {
                    if ($(this).attr("name") == pata[j] && $(this).attr("name") != '') {
                        paz.splice(j, 1);
                        pata.splice(j, 1);
                        set = 3;
                        pfa = pfa - 1;
                    }
                }
            } else {
                var al = -1;
                for (var k = 0; k < pata.length; k++) {
                    if ($(this).attr("name") == pata[k] && $(this).attr("name") != '') {
                        var al = k;
                        break;
                    }
                }
                if (al > -1) {
                    var va = -1;
                    for (var t = 0; t < pata.length; t++) {
                        if ($(this).val() == paz[t] && $(this).val() != -1) {
                            va = t;
                        }
                    }
                    if (va > -1) {
                        $(this).val(paz[al]);
                    } else {
                        paz[al] = $(this).val();
                    }

                } else {
                    $(this).val('-1');
                    alert('You have alreday selected 5 values');
                }
            }
        }

    });

    //


    function decimalPlaces(float, length) {
        ret = "";
        str = float.toString();
        array = str.split(".");
        if (array.length == 2) {
            ret += array[0] + ".";
            for (i = 0; i < length; i++) {
                if (i >= array[1].length) ret += '0';
                else ret += array[1][i];
            }
        } else if (array.length == 1) {
            ret += array[0] + ".";
            for (i = 0; i < length; i++) {
                ret += '0'
            }
        }

        return ret;
    }


    $("#UTMConversion").click(function () {
        Easting_X = $("#Easting_X").val();
        Northing_Y = $("#Northing_Y").val();
        UTM_Zone = $("#UMT_zone_id").val();
        Easting = Easting_X.toString().length;
        Northing = Northing_Y.toString().length;

        if (Easting >= 6 && Northing >= 7) {

            //var utm1 = new UTMRef(Easting_X, Northing_Y, "N", 17);
            var utm1 = new UTMRef(Easting_X, Northing_Y, "N", UTM_Zone);

            var ll3 = utm1.toLatLng();
            lat = ll3.lat;
            lat = decimalPlaces(lat, 5);
            //lat = parseFloat(lat.toFixed(5));
            lng = ll3.lng;
            lng = decimalPlaces(lng, 5);
            //lng = parseFloat(lng.toFixed(5));
            $("#Begin_LAT_Dec").val(lat);
            $("#Begin_LON_Dec").val(lng);

            $.ajax({
                url: application_root + "SightingNew.cfc?method=qGetZone",
                type: "get",
                async: true,
                data: {
                    'Easting': Easting_X,
                    'Northing': Northing_Y
                },
                success: function (result) {
                    coordinates = JSON.parse(result);
                    if (typeof coordinates.DATA[0] != 'undefined') {
                        zone = coordinates.DATA[0][0];
                        //$("#zone_id").val(zone);
                    } else {
                        //$("#zone_id").val(0);
                    }
                }
            });



        }
    });


    /////zone project added

    $(document).on("submit", "#zoneform", function () {
        var zoneid = $("#addZoneID").val();
        var project_id = $("#zoneprojectid").val();
        if (zoneid == 0) {
            bootbox.alert('Please select Zone');
        } else {
            $.ajax({
                url: application_root + "SightingNew.cfc?method=InsertZonesProject",
                type: "post",
                async: true,
                data: {
                    'id': project_id,
                    'zoneid': zoneid
                },
                success: function (result) {

                    $('html, body').animate({
                        scrollTop: 0
                    }, 800);
                    $(".message").html("<div class='alert alert-success'>" + result + ".</div>").show();
                    setTimeout(function () {
                        $(".message").hide();
                    }, 3000);
                }
            });
        }
        return false;
    });

    $("#zone_view_before").click(function () {

        $.ajax({
            url: application_root + "SightingNew.cfc?method=getZoneForSurvey",
            type: "post",
            async: true,
            dataType: "json",
            success: function (result) {
                if (result.length > 0) {
                    $('#zones_list').html('');
                    for (var i = 0; i < result.length; i++) {
                        $('#zones_list').append('<tr role="row" class="odd" id="remov_' + result[i].ID + '"><td class="sorting_1" width="33">' + result[i].ID + '</td><td class="sorting_1" width="33">' + result[i].zone + '</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzoneBefore(' + result[i].ID + ')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>');
                    }
                    $(".dataTables_scroll").show();
                    $(".zoneform").hide();
                    $('#view_zone').modal('show');
                } else {
                    bootbox.alert('Zone not Found');
                }
            }
        });

    });



    $("#zone_add").click(function () {

        BeginZoneID = $("#BeginZoneID").val();
        EndZoneID = $("#EndZoneID").val();
        project_ID = $("#zoneprojectid").val();

        if (EndZoneID == '' || BeginZoneID == '') {
            bootbox.alert('please select Begin Zone and End Zone');
        } else {

            $.ajax({
                url: application_root + "SightingNew.cfc?method=InsertZonesProject",
                type: "post",
                async: true,
                data: {
                    'BeginZone': BeginZoneID,
                    'EndZone': EndZoneID,
                    'project_ID': project_ID
                },

                success: function (result) {

                    result = JSON.parse(result);
                    obj = result.DATA.length;
                    if (obj > 0) {
                        $('#zones_list').html('');
                        for (i = 0; i < obj; i++) {
                            $('#zones_list').append('<tr role="row" class="odd" id="remov_' + result.DATA[i][1] + '"><td class="sorting_1" width="33">' + result.DATA[i][1] + '</td><td class="sorting_1" width="33">' + result.DATA[i][0] + '</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzone(' + project_ID + ',' + result.DATA[i][1] + ')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>')
                        }
                        $(".dataTables_scroll").show();
                        $(".zoneform").hide();
                        $('#view_zone').modal('show');
                    } else {
                        bootbox.alert('Zone not Found');
                    }

                }
            });
        }

    });



    $("#zone_add_before").click(function () {

        BeginZoneID = $("#BeginZoneID").val();
        EndZoneID = $("#EndZoneID").val();
        if (EndZoneID == '' || BeginZoneID == '') {
            bootbox.alert('please select Begin Zone and End Zone');
        } else {

            $.ajax({
                url: application_root + "SightingNew.cfc?method=InsertZonesProjectBefore",
                type: "post",
                async: true,
                data: {
                    'BeginZone': BeginZoneID,
                    'EndZone': EndZoneID
                },
                dataType: "json",
                success: function (result) {
                    if (result.length > 0) {
                        $('#zones_list').html('');
                        for (var i = 0; i < result.length; i++) {
                            $('#zones_list').append('<tr role="row" class="odd" id="remov_' + result[i].ID + '"><td class="sorting_1" width="33">' + result[i].ID + '</td><td class="sorting_1" width="33">' + result[i].zone + '</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzoneBefore(' + result[i].ID + ')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>');
                        }
                        $(".dataTables_scroll").show();
                        $(".zoneform").hide();
                        $('#view_zone').modal('show');
                    } else {
                        bootbox.alert('Zone not Found');
                    }
                }
            });
        }
    });


    $("#zone_view").click(function () {
        var project_id = $("#project_val").val();

        if (project_id == '' || project_id == 0) {
            bootbox.alert('Please select project');
        }
        if (project_id != '' && project_id != 0) {
            $.ajax({
                url: application_root + "SightingNew.cfc?method=ZonesData",
                type: "get",
                async: true,
                data: {
                    'id': project_id
                },
                success: function (result) {
                    result = JSON.parse(result);
                    obj = result.DATA.length;
                    if (obj > 0) {
                        $('#zones_list').html('');
                        for (i = 0; i < obj; i++) {
                            $('#zones_list').append('<tr role="row" class="odd" id="remov_' + result.DATA[i][1] + '"><td class="sorting_1" width="33">' + result.DATA[i][1] + '</td><td class="sorting_1" width="33">' + result.DATA[i][0] + '</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzone(' + project_id + ',' + result.DATA[i][1] + ')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>')
                        }
                        $(".dataTables_scroll").show();
                        $(".zoneform").hide();
                        $('#view_zone').modal('show');
                    } else {
                        bootbox.alert('Zone not Found');
                    }

                }
            });
        }

    });

    $('input.zonefilter').on('change', function () {
        $('input.zonefilter').not(this).prop('checked', false);
        var zonetype = $(this).val();
        $.ajax({
            url: application_root + "SightingNew.cfc?method=getZoneByType",
            type: "post",
            async: true,
            data: {
                'zonetype': zonetype
            },
            success: function (result) {
                result = JSON.parse(result);
                obj = result.DATA.length;
                if (obj > 0) {
                    $('#BeginZoneID').html('');
                    $('#EndZoneID').html('');
                    $("#BeginZoneID").append('<option value=""></option>');
                    $("#EndZoneID").append('<option value=""></option>');
                    for (i = 1; i < obj; i++) {
                        $("#BeginZoneID").append('<option value="' + result.DATA[i][1] + '">' + result.DATA[i][1] + '</option>');
                        $("#EndZoneID").append('<option value="' + result.DATA[i][1] + '">' + result.DATA[i][1] + '</option>');
                    }
                }
            }
        });
    });

    $(document).on('submit', '#ncsgform', function () {
        var data = $(this).serialize();
        $.ajax({
            type: "post",
            url: application_root + "SightingNew.cfc?method=save_NCSG",
            async: true,
            data: data,
            success: function () {

                $('#ncsgModal').animate({
                    scrollTop: 0
                }, 800);
                $(".message").show();
                setTimeout(function () {
                    $(".message").hide();
                }, 3000);
            }

        });
        return false;
    });
    $("#hitOutcome").click(function () {
        $("#missHeight").css('display', 'none');
        $("#missWidth").css('display', 'none');
        $("#missDistance").css('display', 'none');
        $("#missDescriptor").css('display', 'block');
        $("#hitDescriptor").css('display', 'block');
        $('#hitlocati').css('display', 'block');
    });
    $("#missOutcome").click(function () {
        $("#missHeight").css('display', 'block');
        $("#missWidth").css('display', 'block');
        $("#missDistance").css('display', 'block');
        $("#missDescriptor").css('display', 'none');
        $("#hitDescriptor").css('display', 'block');
        $('#hitlocati').css('display', 'none');
    });

    $("#wMom").click(function () {
        var checkMom = $("#wMom").is(':checked');
        if (checkMom == true) {
            $("select#wMomDropDown>option:eq(0)").hide();
        } else {
            $("select#wMomDropDown>option:eq(0)").show();
        }
    });

    // if ($("#ResearchTeam").length) {
    //     var getMember = $("#ResearchTeam").select2('data').length;
    //     if (getMember != 0) {
    //         var member_name = $("#ResearchTeam").select2('data');
    //         $("#EnteredBy").val(member_name[0].text);
    //     }
    // }
    var paltform = $("#plateform_value").val();
    var surType = $("#Type").val();
    if ($.trim(paltform) == "Land Survey" || $.trim(paltform) == "Land" || $.trim(surType) == "Trail Camera") {
        $("#EngineOn").val('');
        $("#EngineOff").val('');
    }
    
});
function deleteRecordzoneBefore(zoneID) {

    bootbox.confirm("Are you sure?", function (result) {
        if (result == true) {
            $.ajax({
                url: application_root + "SightingNew.cfc?method=DeleteZoneBeforePro",
                type: "post",
                data: {
                    zoneID: zoneID
                },
                dataType: "json",
                success: function (result) {

                    $('html, body').animate({
                        scrollTop: 0
                    }, 800);

                    $(".message").html("<div class='alert alert-success'> <strong>Success!</strong> Zone Deleted.</div>").show();
                    $("#remov_" + zoneID).remove();
                    setTimeout(function () {
                        $(".message").hide();
                    }, 5000);



                    $('#zones_list').html('');
                    for (var i = 0; i < result.length; i++) {
                        $('#zones_list').append('<tr role="row" class="odd" id="remov_' + result[i].ID + '"><td class="sorting_1" width="33">' + result[i].ID + '</td><td class="sorting_1" width="33">' + result[i].zone + '</td><td class="sorting_1" width="33"><button onclick="return deleteRecordzoneBefore(' + result[i].ID + ')" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button></td> </tr>');
                    }
                    $(".dataTables_scroll").show();
                    $(".zoneform").hide();
                    $('#view_zone').modal('show');


                }
            });
        }
    });
}

function deleteRecordzone(projectID, zoneID) {

    bootbox.confirm("Are you sure?", function (result) {
        if (result == true) {
            $.ajax({
                url: application_root + "SightingNew.cfc?method=DeleteZoneproject",
                type: "get",
                data: {
                    id: projectID,
                    zoneID: zoneID
                },
                success: function (data) {

                    $('html, body').animate({
                        scrollTop: 0
                    }, 800);

                    $(".message").html("<div class='alert alert-success'> <strong>Success!</strong> Zone Deleted.</div>").show();
                    $("#remov_" + zoneID).remove();
                    setTimeout(function () {
                        $(".message").hide();
                    }, 5000);

                }
            });
        }
    });
}


function makeTeam(id) {
    val = $("#team_value").val();
    if (val !== '') {
        $("#team_value").val(val + ' ' + ($("#member-" + id).text()));
    } else {
        $("#team_value").val($("#member-" + id).text());
    }
    $("#member-" + id).remove();
    $('#ResetMe').formValidation('revalidateField', 'ResearchTeam');
}

function sendForm() {
    var id = document.getElementById('project_val').value;
    document.getElementById("myform").submit();

}

function submitsightForm() {
    var id = document.getElementById('sightid').value;
    if (id == 0) {
        document.getElementById("myform").submit();
    } else {
        document.getElementById("sightform").submit();
    }
    var sght = $('#sightid').val();
    $('#sighting_hiddeid').val(sght)
}

function sightingDelete() {

    bootbox.confirm("Are you sure?", function (result) {
        if (result == true) {
            document.getElementById("sightingDelete").submit();
        }
    });
}

function ResetAll() {
    var elements = document.getElementsByTagName("input");
    for (var ii = 0; ii < elements.length; ii++) {
        if (elements[ii].type == "text") {
            elements[ii].value = "";
        }
        $("textarea").val();
        $("#update").val("submit");
        $("#update").attr("name", "add_data");
        $("#update2").hide();
    }

    $("input:radio").attr("checked", false);

    $('.selectCustomReset').val('').change();
    $('.search-box').val('').change();

    var element = document.getElementsByTagName('textarea');
    for (var i = 0; i < element.length; i++) {
        element[i].value = "";
    }

    document.getElementById("sightform").style.display = "none";
}
function commentsCount() {
    var message = $('textarea#comments').val();
    var n = message.length;
    n=512-n
    $('#count').html('Remaining Characters ' + n);
}
function EngOnOff()
{
    var paltform = $("#plateform_value").val();
    var surType = $("#Type").val();
    if ($.trim(paltform) == "Land Survey" || $.trim(paltform) == "Land" || $.trim(surType) == "Trail Camera") {
        $("#EngineOn").val('');
        $("#EngineOff").val('');
    }
}
function validateMyForm(e){

    var stsur = $("#datetimepicker_srvystrt").find("input").val();
    st = stsur.split(':');
    var ensur = $("#datetimepicker_srvyend").find("input").val();
    en = ensur.split(':');
    if(st[0] > en[0]){
        console.log('if');
        alert('Survey Start time must be less than Survey End Time');
        $('html, body').animate({scrollTop : 0},800);
        e.preventDefault(e);
    }else if(st[0] == en[0] && st[1] >= en[1]){
        console.log('esleif');
        alert('Survey Start time must be less than Survey End Time');
        $('html, body').animate({scrollTop : 0},800);
        e.preventDefault(e);
    }
    else{
        console.log('else');
        $('#ResetMe').submit();
    }
}
