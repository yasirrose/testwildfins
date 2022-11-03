<cfset showForm = true>
<cfset counter = 0>
<cfset missing =''>
<cfif structKeyExists(form, "xlsfile") and len(form.xlsfile)>

<!--- Destination outside of web root --->

    <cffile action="upload" destination="#Application.CloudDirectory#" filefield="xlsfile" result="upload" nameconflict="makeunique">
    <cfif upload.fileWasSaved>
        <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
        <cfif right(theFile,3) eq 'xls'>
            <cfspreadsheet action="read" src="#theFile#" query="exceldata" headerrow="1">
            <cfset showForm = false>
        <cfelse>
            <cfset errors = "The file was not an Excel file.">
            <cffile action="delete" file="#theFile#">
        </cfif>
    <cfelse>
        <cfset errors="the file was not uploaded successfully">
    </cfif>
</cfif>

<cfif showForm>
    <cfif structKeyExists(variables, "errors")>
        <cfoutput>
            <p>
            <b style="text-align: center;">Error: #variables.errors#</b>
        </p>
        </cfoutput>
    </cfif>
    <form action="" enctype="multipart/form-data" method="post" style="margin-left: 300px">
        <div class="form-group">
            <label for=""> Upload Utility </label>
            <input id="upload-utility-4" class="file-loading" type="file"  name="xlsfile"  required>
        </div>
        <br>
        <div class="form-group">
            <input type="submit" class="btn btn-success" value="Upload XLS File">
        </div>
    </form>
    <br>
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-8">
                <div class="download-butns-custom">
                    <button type="button" style="margin-left: 300px" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal" id="excelval">Export to Excel</button>
                    <button type="button" style="margin-left: 300px" class="btn btn-primary btn-md" data-toggle="modal" id="exceltmp" data-target="#myModal">Download Template</button>
                    <button type="button" style="margin-left: 300px" class="btn btn-primary btn-md" data-toggle="modal" id="exceldel" data-target="#myModal">Delete Data</button>
                </div>
            </div>

            <div class="col-md-4">
            </div>
            <div class="col-md-4">

            </div>
        </div>
    </div>

    <br>
<cfelse>
    <cfif exceldata.recordCount is 1>
        <p>no recrod</p>
    <cfelse>
        <cftry>
        <cfloop query="exceldata" startrow="2">
            <cfif #Sighting_ID# eq '' or  #Dolphin_ID# eq ''>
                <cfset missing ='Sighting ID or Dolphin ID'>
                <cfset counter =2>
                <cfbreak>
            </cfif>
            <cfquery name="qru"  datasource="#Application.dsn#" result="insert">
                       insert into BIOPSY_SHOTS(
                         Sighting_ID,Dolphin_ID,ShotNumber,Hit,Miss,Sample,SampleNumber,Enter_Date,ShotTime,
                         Arbalester,TargetAnimalBehavior,ShotDistance,TargetLevel,TABPre_Activity_Mill,
                         TABPre_Activity_Feed,TABPre_Activity_ProbFeed,TABPre_Activity_Travel,TABPre_Activity_Play,
                         TABPre_ACTIVITY_REST,TABPre_Activity_Leap_tailslap_chuff,TABPre_Activity_Social,TABPre_ACTIVITY_WITHBOAT,
                         TABPre_Activity_Other,TABPre_Activity_Avoid_Boat,TABPre_Depredation,TABPre_Herding,TABPost_Activity_Mill,
                         TABPost_Activity_Feed,TABPost_Activity_ProbFeed,TABPost_Activity_Travel,TABPost_Activity_Play,
                         TABPost_ACTIVITY_REST,TABPost_Activity_Leap_tailslap_chuff,TABPost_Activity_Social,TABPost_ACTIVITY_WITHBOAT,
                         TABPost_Activity_Other,TABPost_Activity_Avoid_Boat,TABPost_Herding,GBPre_Activity_Mill,GBPre_Activity_Feed,
                         GBPre_Activity_ProbFeed,GBPre_Activity_Travel,GBPre_Activity_Play,GBPre_ACTIVITY_REST,GBPre_Activity_Leap_tailslap_chuff,
                         GBPre_Activity_Social,GBPre_ACTIVITY_WITHBOAT,GBPre_Activity_Other,GBPre_Activity_Avoid_Boat,GBPre_Depredation,
                         GBPre_Herding,GBPost_Activity_Mill,GBPost_Activity_Feed,GBPost_Activity_ProbFeed,GBPost_Activity_Travel,
                         GBPost_Activity_Play,GBPost_ACTIVITY_REST,GBPost_Activity_Leap_tailslap_chuff,GBPost_Activity_Social,GBPost_ACTIVITY_WITHBOAT,
                         GBPost_Activity_Other,GBPost_Activity_Avoid_Boat,GBPost_Depredation,GBPost_Herding,HitLocation,SubSample,
                         Processor,SampleLength,TABPost_Depredation,TargetResponseBehavior1,TargetResponseBehavior2,TargetResponseBehavior3,
                         GroupResponseBehavior,GroupSize,MissDistance,MissHeight,MissWidth,HitDescriptor,MissDescriptor,Samplehead,SampleCollected,
                         BlubberTeflonVial,BlubberCryovialRed,BlubberCryovialBlue,SkinDMSO,SkinRNAlater,SkinDCryovial,SampleTaken,Outcome,
                         TABPre_Activity_Mill2,TABPre_Activity_Feed2,TABPre_Activity_ProbFeed2,TABPre_Activity_Travel2,TABPre_Activity_Play2,
                         TABPre_ACTIVITY_REST2,TABPre_Activity_Leap_tailslap_chuff2,TABPre_Activity_Social2,TABPre_ACTIVITY_WITHBOAT2,
                         TABPre_Activity_Other2,TABPre_Activity_Avoid_Boat2,TABPre_Depredation2,TABPre_Herding2,TABPre_Activity_Mill3,
                         TABPre_Activity_Feed3,TABPre_Activity_ProbFeed3,TABPre_Activity_Travel3,TABPre_Activity_Play3,TABPre_ACTIVITY_REST3,
                         TABPre_Activity_Leap_tailslap_chuff3,TABPre_Activity_Social3,TABPre_ACTIVITY_WITHBOAT3,TABPre_Activity_Other3,
                         TABPre_Activity_Avoid_Boat3,TABPre_Depredation3,TABPre_Herding3,TABPost_Activity_Mill2,TABPost_Activity_Feed2,
                         TABPost_Activity_ProbFeed2,TABPost_Activity_Travel2,TABPost_Activity_Play2,TABPost_ACTIVITY_REST2,TABPost_Activity_Leap_tailslap_chuff2,
                         TABPost_Activity_Social2,TABPost_ACTIVITY_WITHBOAT2,TABPost_Activity_Other2,TABPost_Activity_Avoid_Boat2,
                         TABPost_Depredation2,TABPost_Herding2,TABPost_Activity_Mill3,TABPost_Activity_Feed3,TABPost_Activity_ProbFeed3,
                         TABPost_Activity_Travel3,TABPost_Activity_Play3,TABPost_ACTIVITY_REST3,TABPost_Activity_Leap_tailslap_chuff3,
                         TABPost_Activity_Social3,TABPost_ACTIVITY_WITHBOAT3,TABPost_Activity_Other3,TABPost_Activity_Avoid_Boat3,
                         TABPost_Depredation3,TABPost_Herding3,GBPre_Activity_Mill2,GBPre_Activity_Feed2,GBPre_Activity_ProbFeed2,
                         GBPre_Activity_Travel2,GBPre_Activity_Play2,GBPre_ACTIVITY_REST2,GBPre_Activity_Leap_tailslap_chuff2,GBPre_Activity_Social2,
                         GBPre_ACTIVITY_WITHBOAT2,GBPre_Activity_Other2,GBPre_Activity_Avoid_Boat2,GBPre_Depredation2,GBPre_Herding2,GBPre_Activity_Mill3,
                         GBPre_Activity_Feed3,GBPre_Activity_ProbFeed3,GBPre_Activity_Travel3,GBPre_Activity_Play3,GBPre_ACTIVITY_REST3,
                         GBPre_Activity_Leap_tailslap_chuff3,GBPre_Activity_Social3,GBPre_ACTIVITY_WITHBOAT3,GBPre_Activity_Other3,
                         GBPre_Activity_Avoid_Boat3,GBPre_Depredation3,GBPre_Herding3,GBPost_Activity_Mill2,GBPost_Activity_Feed2,
                         GBPost_Activity_ProbFeed2,GBPost_Activity_Travel2,GBPost_Activity_Play2,GBPost_ACTIVITY_REST2,
                         GBPost_Activity_Leap_tailslap_chuff2,GBPost_Activity_Social2,GBPost_ACTIVITY_WITHBOAT2,GBPost_Activity_Other2,
                         GBPost_Activity_Avoid_Boat2,GBPost_Depredation2,GBPost_Herding2,GBPost_Activity_Mill3,GBPost_Activity_Feed3,
                         GBPost_Activity_ProbFeed3,GBPost_Activity_Travel3,GBPost_Activity_Play3,GBPost_ACTIVITY_REST3,GBPost_Activity_Leap_tailslap_chuff3,
                         GBPost_Activity_Social3,GBPost_ACTIVITY_WITHBOAT3,GBPost_Activity_Other3,GBPost_Activity_Avoid_Boat3,GBPost_Depredation3,
                         GBPost_Herding3,TargetPre_Behavior1,TargetPre_Behavior2,TargetPre_Behavior3,TargetPost_Behavior1,TargetPost_Behavior2,
                         TargetPost_Behavior3,GroupPre_Behavior1,GroupPre_Behavior2,GroupPre_Behavior3,GroupPost_Behavior1,GroupPost_Behavior2,
                         GroupPost_Behavior3,TargetLevel2,TargetLevel3,GroupResponseBehavior2,GroupResponseBehavior3,GroupLevel1,probable_dolphin,
                         ShotCount
                        )
                       values(
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.Sighting_ID#'>,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.Dolphin_ID#'>,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.ShotNumber#' null="#IIF(exceldata.ShotNumber EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_bit" value='#exceldata.Hit#' null="#IIF(exceldata.Hit EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_bit" value='#exceldata.Miss#' null="#IIF(exceldata.Miss EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.Sample#' null="#IIF(exceldata.Sample EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.SampleNumber#' null="#IIF(exceldata.SampleNumber EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_timestamp" value='#exceldata.Enter_Date#' null="#IIF(exceldata.Enter_Date EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_timestamp" value='#exceldata.ShotTime#' null="#IIF(exceldata.ShotTime EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.Arbalester#' null="#IIF(exceldata.Arbalester EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TargetAnimalBehavior#' null="#IIF(exceldata.TargetAnimalBehavior EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.ShotDistance#' null="#IIF(exceldata.ShotDistance EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetLevel#' null="#IIF(exceldata.TargetLevel EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Mill#' null="#IIF(exceldata.TABPre_Activity_Mill EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Feed#' null="#IIF(exceldata.TABPre_Activity_Feed EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_ProbFeed#' null="#IIF(exceldata.TABPre_Activity_ProbFeed EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Travel#' null="#IIF(exceldata.TABPre_Activity_Travel EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Play#' null="#IIF(exceldata.TABPre_Activity_Play EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_ACTIVITY_REST#' null="#IIF(exceldata.TABPre_ACTIVITY_REST EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Leap_tailslap_chuff#' null="#IIF(exceldata.TABPre_Activity_Leap_tailslap_chuff EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Social#' null="#IIF(exceldata.TABPre_Activity_Social EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_ACTIVITY_WITHBOAT#' null="#IIF(exceldata.TABPre_ACTIVITY_WITHBOAT EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Other#' null="#IIF(exceldata.TABPre_Activity_Other EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Avoid_Boat#' null="#IIF(exceldata.TABPre_Activity_Avoid_Boat EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Depredation#' null="#IIF(exceldata.TABPre_Depredation EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Herding#' null="#IIF(exceldata.TABPre_Herding EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Mill#' null="#IIF(exceldata.TABPost_Activity_Mill EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Feed#' null="#IIF(exceldata.TABPost_Activity_Feed EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_ProbFeed#' null="#IIF(exceldata.TABPost_Activity_ProbFeed EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Travel#' null="#IIF(exceldata.TABPost_Activity_Travel EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Play#' null="#IIF(exceldata.TABPost_Activity_Play EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_ACTIVITY_REST#' null="#IIF(exceldata.TABPost_ACTIVITY_REST EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Leap_tailslap_chuff#' null="#IIF(exceldata.TABPost_Activity_Leap_tailslap_chuff EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Social#' null="#IIF(exceldata.TABPost_Activity_Social EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_ACTIVITY_WITHBOAT#' null="#IIF(exceldata.TABPost_ACTIVITY_WITHBOAT EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Other#' null="#IIF(exceldata.TABPost_Activity_Other EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Avoid_Boat#' null="#IIF(exceldata.TABPost_Activity_Avoid_Boat EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Herding#' null="#IIF(exceldata.TABPost_Herding EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Mill#' null="#IIF(exceldata.GBPre_Activity_Mill EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Feed#' null="#IIF(exceldata.GBPre_Activity_Feed EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_ProbFeed#' null="#IIF(exceldata.GBPre_Activity_ProbFeed EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Travel#' null="#IIF(exceldata.GBPre_Activity_Travel EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Play#' null="#IIF(exceldata.GBPre_Activity_Play EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_ACTIVITY_REST#' null="#IIF(exceldata.GBPre_ACTIVITY_REST EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Leap_tailslap_chuff#' null="#IIF(exceldata.GBPre_Activity_Leap_tailslap_chuff EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Social#' null="#IIF(exceldata.GBPre_Activity_Social EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_ACTIVITY_WITHBOAT#' null="#IIF(exceldata.GBPre_ACTIVITY_WITHBOAT EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Other#' null="#IIF(exceldata.GBPre_Activity_Other EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Avoid_Boat#' null="#IIF(exceldata.GBPre_Activity_Avoid_Boat EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Depredation#' null="#IIF(exceldata.GBPre_Depredation EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Herding#' null="#IIF(exceldata.GBPre_Herding EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Mill#' null="#IIF(exceldata.GBPost_Activity_Mill EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Feed#' null="#IIF(exceldata.GBPost_Activity_Feed EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_ProbFeed#' null="#IIF(exceldata.GBPost_Activity_ProbFeed EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Travel#' null="#IIF(exceldata.GBPost_Activity_Travel EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Play#' null="#IIF(exceldata.GBPost_Activity_Play EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_ACTIVITY_REST#' null="#IIF(exceldata.GBPost_ACTIVITY_REST EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Leap_tailslap_chuff#' null="#IIF(exceldata.GBPost_Activity_Leap_tailslap_chuff EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Social#' null="#IIF(exceldata.GBPost_Activity_Social EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_ACTIVITY_WITHBOAT#' null="#IIF(exceldata.GBPost_ACTIVITY_WITHBOAT EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Other#' null="#IIF(exceldata.GBPost_Activity_Other EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Avoid_Boat#' null="#IIF(exceldata.GBPost_Activity_Avoid_Boat EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Depredation#' null="#IIF(exceldata.GBPost_Depredation EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Herding#' null="#IIF(exceldata.GBPost_Herding EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.HitLocation#' null="#IIF(exceldata.HitLocation EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.SubSample#' null="#IIF(exceldata.SubSample EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.Processor#' null="#IIF(exceldata.Processor EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.SampleLength#' null="#IIF(exceldata.SampleLength EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Depredation#' null="#IIF(exceldata.TABPost_Depredation EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetResponseBehavior1#' null="#IIF(exceldata.TargetResponseBehavior1 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetResponseBehavior2#' null="#IIF(exceldata.TargetResponseBehavior2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetResponseBehavior3#' null="#IIF(exceldata.TargetResponseBehavior3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupResponseBehavior#' null="#IIF(exceldata.GroupResponseBehavior EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupSize#' null="#IIF(exceldata.GroupSize EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.MissDistance#' null="#IIF(exceldata.MissDistance EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.MissHeight#' null="#IIF(exceldata.MissHeight EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.MissWidth#' null="#IIF(exceldata.MissWidth EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.HitDescriptor#' null="#IIF(exceldata.HitDescriptor EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.MissDescriptor#' null="#IIF(exceldata.MissDescriptor EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.Samplehead#' null="#IIF(exceldata.Samplehead EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.SampleCollected#' null="#IIF(exceldata.SampleCollected EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.BlubberTeflonVial#' null="#IIF(exceldata.BlubberTeflonVial EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.BlubberCryovialRed#' null="#IIF(exceldata.BlubberCryovialRed EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.BlubberCryovialBlue#' null="#IIF(exceldata.BlubberCryovialBlue EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.SkinDMSO#' null="#IIF(exceldata.SkinDMSO EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.SkinRNAlater#' null="#IIF(exceldata.SkinRNAlater EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.SkinDCryovial#' null="#IIF(exceldata.SkinDCryovial EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.SampleTaken#' null="#IIF(exceldata.SampleTaken EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.Outcome#' null="#IIF(exceldata.Outcome EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Mill2#' null="#IIF(exceldata.TABPre_Activity_Mill2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Feed2#' null="#IIF(exceldata.TABPre_Activity_Feed2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_ProbFeed2#' null="#IIF(exceldata.TABPre_Activity_ProbFeed2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Travel2#' null="#IIF(exceldata.TABPre_Activity_Travel2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Play2#' null="#IIF(exceldata.TABPre_Activity_Play2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_ACTIVITY_REST2#' null="#IIF(exceldata.TABPre_ACTIVITY_REST2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Leap_tailslap_chuff2#' null="#IIF(exceldata.TABPre_Activity_Leap_tailslap_chuff2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Social2#' null="#IIF(exceldata.TABPre_Activity_Social2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_ACTIVITY_WITHBOAT2#' null="#IIF(exceldata.TABPre_ACTIVITY_WITHBOAT2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Other2#' null="#IIF(exceldata.TABPre_Activity_Other2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Avoid_Boat2#' null="#IIF(exceldata.TABPre_Activity_Avoid_Boat2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Depredation2#' null="#IIF(exceldata.TABPre_Depredation2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Herding2#' null="#IIF(exceldata.TABPre_Herding2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Mill3#' null="#IIF(exceldata.TABPre_Activity_Mill3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Feed3#' null="#IIF(exceldata.TABPre_Activity_Feed3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_ProbFeed3#' null="#IIF(exceldata.TABPre_Activity_ProbFeed3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Travel3#' null="#IIF(exceldata.TABPre_Activity_Travel3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Play3#' null="#IIF(exceldata.TABPre_Activity_Play3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_ACTIVITY_REST3#' null="#IIF(exceldata.TABPre_ACTIVITY_REST3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Leap_tailslap_chuff3#' null="#IIF(exceldata.TABPre_Activity_Leap_tailslap_chuff3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Social3#' null="#IIF(exceldata.TABPre_Activity_Social3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_ACTIVITY_WITHBOAT3#' null="#IIF(exceldata.TABPre_ACTIVITY_WITHBOAT3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Other3#' null="#IIF(exceldata.TABPre_Activity_Other3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Activity_Avoid_Boat3#' null="#IIF(exceldata.TABPre_Activity_Avoid_Boat3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Depredation3#' null="#IIF(exceldata.TABPre_Depredation3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPre_Herding3#' null="#IIF(exceldata.TABPre_Herding3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Mill2#' null="#IIF(exceldata.TABPost_Activity_Mill2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Feed2#' null="#IIF(exceldata.TABPost_Activity_Feed2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_ProbFeed2#' null="#IIF(exceldata.TABPost_Activity_ProbFeed2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Travel2#' null="#IIF(exceldata.TABPost_Activity_Travel2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Play2#' null="#IIF(exceldata.TABPost_Activity_Play2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_ACTIVITY_REST2#' null="#IIF(exceldata.TABPost_ACTIVITY_REST2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Leap_tailslap_chuff2#' null="#IIF(exceldata.TABPost_Activity_Leap_tailslap_chuff2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Social2#' null="#IIF(exceldata.TABPost_Activity_Social2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_ACTIVITY_WITHBOAT2#' null="#IIF(exceldata.TABPost_ACTIVITY_WITHBOAT2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Other2#' null="#IIF(exceldata.TABPost_Activity_Other2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Avoid_Boat2#' null="#IIF(exceldata.TABPost_Activity_Avoid_Boat2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Depredation2#' null="#IIF(exceldata.TABPost_Depredation2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Herding2#' null="#IIF(exceldata.TABPost_Herding2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Mill3#' null="#IIF(exceldata.TABPost_Activity_Mill3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Feed3#' null="#IIF(exceldata.TABPost_Activity_Feed3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_ProbFeed3#' null="#IIF(exceldata.TABPost_Activity_ProbFeed3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Travel3#' null="#IIF(exceldata.TABPost_Activity_Travel3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Play3#' null="#IIF(exceldata.TABPost_Activity_Play3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_ACTIVITY_REST3#' null="#IIF(exceldata.TABPost_ACTIVITY_REST3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Leap_tailslap_chuff3#' null="#IIF(exceldata.TABPost_Activity_Leap_tailslap_chuff3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Social3#' null="#IIF(exceldata.TABPost_Activity_Social3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_ACTIVITY_WITHBOAT3#' null="#IIF(exceldata.TABPost_ACTIVITY_WITHBOAT3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Other3#' null="#IIF(exceldata.TABPost_Activity_Other3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Activity_Avoid_Boat3#' null="#IIF(exceldata.TABPost_Activity_Avoid_Boat3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Depredation3#' null="#IIF(exceldata.TABPost_Depredation3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.TABPost_Herding3#' null="#IIF(exceldata.TABPost_Herding3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Mill2#' null="#IIF(exceldata.GBPre_Activity_Mill2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Feed2#' null="#IIF(exceldata.GBPre_Activity_Feed2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_ProbFeed2#' null="#IIF(exceldata.GBPre_Activity_ProbFeed2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Travel2#' null="#IIF(exceldata.GBPre_Activity_Travel2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Play2#' null="#IIF(exceldata.GBPre_Activity_Play2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_ACTIVITY_REST2#' null="#IIF(exceldata.GBPre_ACTIVITY_REST2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Leap_tailslap_chuff2#' null="#IIF(exceldata.GBPre_Activity_Leap_tailslap_chuff2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Social2#' null="#IIF(exceldata.GBPre_Activity_Social2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_ACTIVITY_WITHBOAT2#' null="#IIF(exceldata.GBPre_ACTIVITY_WITHBOAT2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Other2#' null="#IIF(exceldata.GBPre_Activity_Other2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Avoid_Boat2#' null="#IIF(exceldata.GBPre_Activity_Avoid_Boat2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Depredation2#' null="#IIF(exceldata.GBPre_Depredation2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Herding2#' null="#IIF(exceldata.GBPre_Herding2 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Mill3#' null="#IIF(exceldata.GBPre_Activity_Mill3 EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Feed3#' null="#IIF(exceldata.GBPre_Activity_Feed3   EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_ProbFeed3#' null="#IIF(exceldata.GBPre_Activity_ProbFeed3   EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Travel3#' null="#IIF(exceldata.GBPre_Activity_Travel3   EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Play3#' null="#IIF(exceldata.GBPre_Activity_Play3   EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_ACTIVITY_REST3#' null="#IIF(exceldata.GBPre_ACTIVITY_REST3   EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Leap_tailslap_chuff3#' null="#IIF(exceldata.GBPre_Activity_Leap_tailslap_chuff3   EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Social3#' null="#IIF(exceldata.GBPre_Activity_Social3   EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_ACTIVITY_WITHBOAT3#' null="#IIF(exceldata.GBPre_ACTIVITY_WITHBOAT3   EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Other3#' null="#IIF(exceldata.GBPre_Activity_Other3   EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Activity_Avoid_Boat3#' null="#IIF(exceldata.GBPre_Activity_Avoid_Boat3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Depredation3#' null="#IIF(exceldata.GBPre_Depredation3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPre_Herding3#' null="#IIF(exceldata.GBPre_Herding3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Mill2#' null="#IIF(exceldata.GBPost_Activity_Mill2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Feed2#' null="#IIF(exceldata.GBPost_Activity_Feed2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_ProbFeed2#' null="#IIF(exceldata.GBPost_Activity_ProbFeed2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Travel2#' null="#IIF(exceldata.GBPost_Activity_Travel2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Play2#' null="#IIF(exceldata.GBPost_Activity_Play2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_ACTIVITY_REST2#' null="#IIF(exceldata.GBPost_ACTIVITY_REST2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Leap_tailslap_chuff2#' null="#IIF(exceldata.GBPost_Activity_Leap_tailslap_chuff2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Social2#' null="#IIF(exceldata.GBPost_Activity_Social2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_ACTIVITY_WITHBOAT2#' null="#IIF(exceldata.GBPost_ACTIVITY_WITHBOAT2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Other2#' null="#IIF(exceldata.GBPost_Activity_Other2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Avoid_Boat2#' null="#IIF(exceldata.GBPost_Activity_Avoid_Boat2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Depredation2#' null="#IIF(exceldata.GBPost_Depredation2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Herding2#' null="#IIF(exceldata.GBPost_Herding2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Mill3#' null="#IIF(exceldata.GBPost_Activity_Mill3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Feed3#' null="#IIF(exceldata.GBPost_Activity_Feed3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_ProbFeed3#' null="#IIF(exceldata.GBPost_Activity_ProbFeed3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Travel3#' null="#IIF(exceldata.GBPost_Activity_Travel3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Play3#' null="#IIF(exceldata.GBPost_Activity_Play3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_ACTIVITY_REST3#' null="#IIF(exceldata.GBPost_ACTIVITY_REST3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Leap_tailslap_chuff3#' null="#IIF(exceldata.GBPost_Activity_Leap_tailslap_chuff3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Social3#' null="#IIF(exceldata.GBPost_Activity_Social3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_ACTIVITY_WITHBOAT3#' null="#IIF(exceldata.GBPost_ACTIVITY_WITHBOAT3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Other3#' null="#IIF(exceldata.GBPost_Activity_Other3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Activity_Avoid_Boat3#' null="#IIF(exceldata.GBPost_Activity_Avoid_Boat3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Depredation3#' null="#IIF(exceldata.GBPost_Depredation3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.GBPost_Herding3#' null="#IIF(exceldata.GBPost_Herding3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetPre_Behavior1#' null="#IIF(exceldata.TargetPre_Behavior1  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetPre_Behavior2#' null="#IIF(exceldata.TargetPre_Behavior2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetPre_Behavior3#' null="#IIF(exceldata.TargetPre_Behavior3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetPost_Behavior1#' null="#IIF(exceldata.TargetPost_Behavior1  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetPost_Behavior2#' null="#IIF(exceldata.TargetPost_Behavior2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetPost_Behavior3#' null="#IIF(exceldata.TargetPost_Behavior3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupPre_Behavior1#' null="#IIF(exceldata.GroupPre_Behavior1  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupPre_Behavior2#' null="#IIF(exceldata.GroupPre_Behavior2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupPre_Behavior3#' null="#IIF(exceldata.GroupPre_Behavior3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupPost_Behavior1#' null="#IIF(exceldata.GroupPost_Behavior1  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupPost_Behavior2#' null="#IIF(exceldata.GroupPost_Behavior2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupPost_Behavior3#' null="#IIF(exceldata.GroupPost_Behavior3  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetLevel2#' null="#IIF(exceldata.TargetLevel2  EQ "", true, false)#">,
                       <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.TargetLevel3#' null="#IIF(exceldata.TargetLevel3  EQ "", true, false)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupResponseBehavior2#' null="#IIF(exceldata.GroupResponseBehavior2  EQ "", true, false)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupResponseBehavior3#' null="#IIF(exceldata.GroupResponseBehavior3  EQ "", true, false)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#exceldata.GroupLevel1#' null="#IIF(exceldata.GroupLevel1  EQ "", true, false)#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.probable_dolphin#' null="#IIF(exceldata.probable_dolphin  EQ "", true, false)#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value='#exceldata.ShotCount#' null="#IIF(exceldata.ShotCount  EQ "", true, false)#">
                       )
                          </cfquery>
                    <cfif #insert.recordcount# eq 1>
                        <cfset counter= 1>
                    </cfif>
                    </cfloop>
            <cfcatch type="any">
                <form action="" enctype="multipart/form-data" method="post" style="margin-left: 300px">
                    <div class="form-group">
                        <label for=""> Upload Utility </label>
                        <input id="upload-utility-4" class="file-loading" type="file"  name="xlsfile"  required>
                    </div>
                    <br>
                    <div class="form-group">
                        <input type="submit" class="btn btn-success" value="Upload XLS File">
                    </div>
                </form>
                <h3 style="text-align: center">Error ! Data is incomplete or Please Select the correct file.</h3>
            </cfcatch>
        </cftry>
    </cfif>
</cfif>
<cfif counter eq 1>
    <cfoutput><h3 style="text-align: center"> data inserted Successfully  into Biopsy_Shots Table!</h3></cfoutput>
    <cfelseif counter eq 2>
    <cfoutput><h3 style="text-align: center"> Complete data is not inserted, missing <cfloop> #missing# </cfloop> !</h3></cfoutput>
</cfif>

<div class="container">
    <div class="modal fade project-model-custom-main" id="myModal" role="dialog">
        <div class="modal-dialog project-model-custom modal-sm">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Enter Password to Continue</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input type="password" class="form-control" name="pas" id="passss">
                    </div>
                    <ul>
                        <li style="display: none" id="listerror">Please give correct password !</li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="subsight">Submit</button>
                </div>
            </div>

        </div>
    </div>
</div>