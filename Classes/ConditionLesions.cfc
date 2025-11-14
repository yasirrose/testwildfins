<cfcomponent>
<cfheader name="Access-Control-Allow-Origin" value="*" />
<cfset variables.dsn = "wildfins_new">
    <cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
      <cfargument name="dsn" type="string" required="true" hint="datasource">
      <cfset variables.dsn = arguments.dsn>
      <cfreturn this>
    </cffunction>

    <cffunction name="getHeadNuchalCrest" returntype="any" output="false" access="public" >
        <cfquery name="qgetHeadNuchalCrest" datasource="#variables.dsn#" >
            SELECT * from TLU_HeadNuchalCrest
        </cfquery>
        <cfreturn qgetHeadNuchalCrest>
    </cffunction>

     <cffunction name="getHeadLateralCervicalReg" returntype="any" output="false" access="public" >
        <cfquery name="qgetHeadLateralCervicalReg" datasource="#variables.dsn#" >
            SELECT * from TLU_HeadLateralCervicalReg
        </cfquery>
        <cfreturn qgetHeadLateralCervicalReg>
    </cffunction>

    <cffunction name="getHeadFacialBones" returntype="any" output="false" access="public" >
        <cfquery name="qgetHeadFacialBones" datasource="#variables.dsn#" >
            SELECT * from TLU_HeadFacialBones
        </cfquery>
        <cfreturn qgetHeadFacialBones>
    </cffunction>

    <cffunction name="getHeadEarOS" returntype="any" output="false" access="public" >
        <cfquery name="qgetHeadEarOS" datasource="#variables.dsn#" >
            SELECT * from TLU_HeadEarOS
        </cfquery>
        <cfreturn qgetHeadEarOS>
    </cffunction>

    <cffunction name="getHeadChinSkinFolds" returntype="any" output="false" access="public" >
        <cfquery name="qgetHeadChinSkinFolds" datasource="#variables.dsn#" >
            SELECT * from TLU_HeadChinSkinFolds
        </cfquery>
        <cfreturn qgetHeadChinSkinFolds>
    </cffunction>

     <cffunction name="getBodyEpaxialMuscle" returntype="any" output="false" access="public" >
        <cfquery name="qgetBodyEpaxialMuscle" datasource="#variables.dsn#" >
            SELECT * from TLU_BodyEpaxialMuscle
        </cfquery>
        <cfreturn qgetBodyEpaxialMuscle>
    </cffunction>

    <cffunction name="getBodyDorsalRidgeScapula" returntype="any" output="false" access="public" >
        <cfquery name="qgetBodyDorsalRidgeScapula" datasource="#variables.dsn#" >
            SELECT * from TLU_BodyDorsalRidgeScapula
        </cfquery>
        <cfreturn qgetBodyDorsalRidgeScapula>
    </cffunction>

     <cffunction name="getBodyRibs" returntype="any" output="false" access="public" >
        <cfquery name="qgetBodyRibs" datasource="#variables.dsn#" >
            SELECT * from TLU_BodyRibs
        </cfquery>
        <cfreturn qgetBodyRibs>
    </cffunction>

     <cffunction name="getTailTransversePro" returntype="any" output="false" access="public" >
        <cfquery name="qgetTailTransversePros" datasource="#variables.dsn#" >
            SELECT * from TLU_TailTransversePro
        </cfquery>
        <cfreturn qgetTailTransversePros>
    </cffunction>

   <cffunction name="getRegions" returntype="any" output="false" access="public" >
        <cfquery name="qgetRegions" datasource="#variables.dsn#" >
            SELECT * from TLU_Regions
        </cfquery>
        <cfreturn qgetRegions>
    </cffunction>

    <cffunction name="CheckCetaceans_sight" returnformat="plain" output="false" access="remote" >
        <cfquery name="CheckCetaceans_sightt" datasource="#Application.dsn#">
            SELECT  Cetacean_Sightings.*,Cetacean_Sightings.ID,Cetaceans.*,TLU_CetaceanSpecies.CetaceanSpeciesName FROM Cetacean_Sightings left JOIN Cetaceans on Cetacean_Sightings.Cetaceans_ID=Cetaceans.ID  
            left join TLU_CetaceanSpecies on TLU_CetaceanSpecies.ID=Cetaceans.CetaceanSpecies  WHERE Cetacean_Sightings.Sighting_ID = #form.sight_idd# and Cetaceans_ID = #form.cetaceanCodeId# order by Cetacean_Sightings.Sighting_ID;
        </cfquery>
        <cfif CheckCetaceans_sightt.RecordCount eq '0'>
            <cfreturn "false">
        <cfelse>
            <cfreturn "true">
        </cfif>
     
     </cffunction>

        <!--- add add_lesions --->
    <cffunction name="add_lesions" access="remote" returnformat="plain" output="true">
        
        
        
        <cfquery name="qgetCetacean_code" datasource="#variables.dsn#">
            select ID from  Cetacean_Sightings 
            where 
            Sighting_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Sighting_ID#">
            and
            Cetaceans_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Cetacean_NameORcode#">
       </cfquery> 
             
        <cfif isDefined('qgetCetacean_code.ID') and qgetCetacean_code.ID neq ''>
            <cfset Cetacean_SightingID = '#qgetCetacean_code.ID#'>
        <cfelse>
            <cfset Cetacean_SightingID = '0'>
        </cfif>

        
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">

        <cfoutput>
            <cfparam name="cl_cs_code" default="0">
            <cfparam name="Sighting_ID" default="0">
            <cfparam name="LesionPresent" default="No">
            <cfparam name="Region" default="">
            <cfparam name="LesionType" default="">
            <cfparam name="Side" default="">
            <cfparam name="Status" default="">
            <cfparam name="PhotoNumber" default="">
            <cfparam name="Comments" default="">
            <cfparam name="TypeName" default="">
            <cfparam name="EnterDate" default="">
            <cfparam name="permanentcheck" default="off">
            <cfparam name="permanentScar_date" default="">
            <cfparam name="sightingtext" default="">

            <!--- <cfdump var="#form.sightingtext#" abort="true"> --->
            
                <cfif isDefined('form.permanentcheck') >
                    <cfset permanentcheck = 'on'>
                <cfelse>
                    <cfset permanentcheck = 'off'>
                </cfif>

                <!--- <cfset permanentScar_date_null = IIF(isDefined("form.permanentScar_date") AND len(trim(form.permanentScar_date)), form.permanentScar_date, DE(""))> --->


            <!--- <cfdump var="#permanentcheck#" abort="true"> --->
            <!--- <cfdump var="#form.permanentScar_date#" > --->
            
            <!--- <cfif isdefined('form.permanentScar_date') >
                <cfset permanentScar_date = form.permanentScar_date>
            <cfelse>
                <cfset permanentScar_date = ''>
            </cfif> --->

            <cfif isdefined('form.PermanentScar_date') AND len(trim(form.PermanentScar_date)) GT 0>
                <cfset permanentScar_date = form.PermanentScar_date>
                <cfset isNullPermanentScar = false>
            <cfelse>
                <cfset permanentScar_date = "">
                <cfset isNullPermanentScar = true>
            </cfif>

            <cfquery name="insert_lesions" datasource="#variables.dsn#" result='get_res'>
                insert into Condition_Lesions (
                 Cetaceans_ID,
                 Sighting_ID,
                 LesionPresent,
                 LesionType,
                 Region,
                 Side_L_R,
                 Status,
                 PhotoNumber,
                 Comments,
                 Cetacean_SightingsID,
                 User_Name,
                 TypeName,
                 EnterDate,
                 PermanentScar_date,
                 Permanentcheck,
                 SightingText
                 
                )
                values(
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#cl_cs_code#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Sighting_ID#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#LesionPresent#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#LesionType#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Region#' null="#IIF(Region EQ "" AND Region EQ " ", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Side#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Status#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#PhotoNumber#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Comments#'>,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Cetacean_SightingID#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#userinfo.USER_ID# _ #CompletedBy#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#form.TypeName#'>,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
                <cfqueryparam cfsqltype="cf_sql_date" value="#permanentScar_date#" null="#isNullPermanentScar#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#permanentcheck#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#sightingtext#">
                
            )
            </cfquery>
            <cfif get_res.RECORDCOUNT eq 1 >
                <div class='alert alert-success'>
                    <strong>Success!</strong> Condition Lesions Inserted.
                </div>
                <cfelse>
                <div class="alert alert-danger">
                    <strong>Error!</strong> Insertion Failed.
                </div>
            </cfif>

        </cfoutput>
    </cffunction>

    <!---  update_lesions--->
    <cffunction name="update_lesions" access="remote" returnformat="plain" output="true">
        <cfoutput>
            <cfparam name="lesion_Id" default="0">
            <cfparam name="Region" default="">

            <cfif isDefined('form.LesionType') and LesionType NEQ ''>
                <cfset LesionScar = form.LesionType>
            <cfelse>
                    <cfset LesionScar = form.scarType>
            </cfif>

            <cfif isDefined('form.permanentcheck') >
                <cfset permanentcheck = 'on'>
            <cfelse>
                <cfset permanentcheck = 'off'>
            </cfif>

            <!--- <cfset permanentScar_date = IIF(isDefined("form.permanentScar_date") AND len(trim(form.permanentScar_date)), form.permanentScar_date, now())> --->

            <cfif isdefined('form.permanentScar_date') >
                <cfset permanentScar_date = form.permanentScar_date>
            <cfelse>
                <cfset permanentScar_date = ''>
            </cfif>
                
            <cfquery name="update_lesions" datasource="#variables.dsn#" result='get_res'>
                update  Condition_Lesions set
                 LesionPresent =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#LesionPresent#'>,
                 LesionType =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#LesionScar#'>,
                 Region =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Region#' null="#IIF(Region EQ "" AND Region EQ " ", true, false)#">,
                 Side_L_R =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Side#'>,
                 Status  = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Status#'>,
                 PhotoNumber = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#PhotoNumber#'>,
                 Comments =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Comments#'>,
                 SightingText =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SightingText#'>,
                 PermanentScar_date = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#permanentScar_date#" null="#IIF(len(trim(permanentScar_date)), false, true)#">,
                 Permanentcheck =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#Permanentcheck#">
                
                 where ID =<cfqueryparam  cfsqltype="cf_sql_integer" value='#lesion_Id#'>
            </cfquery>

            <cfif get_res.RECORDCOUNT eq 1 >
                <div class='alert alert-success'>
                    <strong>Success!</strong> Condition Lesions Updated.
                </div>
                <cfelse>
                <div class="alert alert-danger">
                    <strong>Error!</strong> Updation Failed.
                </div>
            </cfif>
        </cfoutput>
    </cffunction>
    
    <cffunction name="del_conditionLesion" access="remote" returnformat="plain" output="true">
        <cfargument name="Lesion_ID" type="any" required="true" default="0">
        <cfquery name="delete" datasource="#variables.dsn#">
            delete from Condition_Lesions where ID = #Lesion_ID#
        </cfquery>
        <cfoutput>
            Condition Lesions Removed successfully.
        </cfoutput>
    </cffunction>

    <cffunction name="getLesionById" access="remote" output="true" returnFormat="JSON">
        <cfargument name="Lesion_ID" type="any" required="true" default="0">
        <cfquery name="getLesion" datasource="#variables.dsn#">
            select * from Condition_Lesions where ID = #Lesion_ID#
        </cfquery>
        
        <cfset response = StructNew()>
        <cfset response["ID"] = #getLesion.ID#>
        <!--- <cfset response["BodyCondition"] = #getLesion.BodyCondition#>  --->
        <cfset response["LesionPresent"] = #getLesion.LesionPresent#> 
        <cfset response["TypeName"] = #getLesion.TypeName#>
        <cfset response["LesionType"] = #getLesion.LesionType#>
        <cfset response["Region"] = #getLesion.Region#>
        <cfset response["Side_L_R"] = #getLesion.Side_L_R#>
        <cfset response["Status"] = #getLesion.Status#>
        <cfset response["Sighting_ID"] = #getLesion.Sighting_ID#>
        <cfset response["PhotoNumber"] = #getLesion.PhotoNumber#>
        <cfset response["Comments"] = #getLesion.Comments#>
        <cfset response["permanentcheck"] = #getLesion.permanentcheck#>
        <cfset response["permanentScar_date"] = #getLesion.permanentScar_date#>
        <cfset response["SightingText"] = #getLesion.SightingText#>
        <!--- <cfset response["Head_NuchalCrest"] = #getLesion.Head_NuchalCrest#>
        <cfset response["Head_LateralCervicalReg"] = #getLesion.Head_LateralCervicalReg#>
        <cfset response["Head_FacialBones"] = #getLesion.Head_FacialBones#>
        <cfset response["Head_EarOS"] = #getLesion.Head_EarOS#>
        <cfset response["Head_ChinSkinFolds"] = #getLesion.Head_ChinSkinFolds#>
        <cfset response["Body_EpaxialMuscle"] = #getLesion.Body_EpaxialMuscle#>
        <cfset response["Body_DorsalRidgeScapula"] = #getLesion.Body_DorsalRidgeScapula#>
        <cfset response["Body_Ribs"] = #getLesion.Body_Ribs#>
        <cfset response["Tail_TransversePro"] = #getLesion.Tail_TransversePro#> --->
        <cfreturn response>
    </cffunction>

      <cffunction name="getRegionNamebyId" access="remote" returnformat="plain" output="true">
        <cfargument name="RegionID" type="any" required="true" default=""> 
        <cfset selectedRegions = "">

        <cfif #getConditionLesions.Region# NEQ "">
            <cfquery name="getRegionNames" datasource="#variables.dsn#">
                    SELECT RegionName from TLU_Regions WHERE ID in (#RegionID#)
            </cfquery>
            <cfset selectedRegions = ValueList(getRegionNames.RegionName,", ")>
        </cfif>
        <cfreturn selectedRegions> 
        
    </cffunction>  

    <cffunction name="getRegionNamebyIdWithSDRs" access="remote" returnformat="plain" output="true">
        <cfargument name="RegionID" type="any" required="true" default=""> 
        <cfset selectedRegions = "">

        <cfif #RegionID# NEQ "">
            <cfquery name="getRegionNames" datasource="#variables.dsn#">
                    SELECT RegionName from TLU_Regions WHERE ID in (#RegionID#)
            </cfquery>
            <cfset selectedRegions = ValueList(getRegionNames.RegionName,", ")>
        </cfif>
        <cfreturn selectedRegions> 
        
    </cffunction>  

    <cffunction name="getRegionNamebyIdJSON" access="remote"  output="true">
        <cfargument name="RegionID" type="any" required="true" default="0">
        <cfif #RegionID# eq "">
            <cfset RegionID= 0>
        </cfif> 
            <cfquery name="getRegionNames" datasource="#variables.dsn#">
                    SELECT RegionName from TLU_Regions WHERE ID in (#RegionID#)
            </cfquery>
        <cfreturn getRegionNames.RegionName> 
    </cffunction>  


      <cffunction name="getlesionsList" access="remote" returnformat="plain" output="true">
        <cfargument name="cl_cs_Id" type="any" required="true" default=""> 
        <cfargument name="Sightningid" type="any" required="true" default=""> 
        <cfoutput> 
            <cfset  permissions ="#session['userdetails']['permissions']#">
            <cfquery name="getConditionLesions" datasource="#variables.dsn#">
               
                select * from Condition_Lesions 
                INNER JOIN Cetacean_Sightings on Cetacean_Sightings.Sighting_ID = Condition_Lesions.Sighting_ID
                where Condition_Lesions.Sighting_ID  = #Sightningid#
                and 
                Cetacean_Sightings.Cetaceans_ID = #cl_cs_Id#
            </cfquery>

            <!--- <cfdump var="testingg222" abort="true"> --->
          
                <div id="lesion_history" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close closeLesionHistoryModal">&times;</button>
                        <h4 class="modal-title">Lesion History Table</h4>
                        <div class="del_lesion" style="display:none"></div>
                    </div>
                    
                    <div class="modal-body" style="overflow:hidden">
                        <cfif getConditionLesions.recordcount gt 0>
                        <cfset lastRow = getConditionLesions.recordcount>
                        
                            <div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff">
                                <div class="col-md-1">Sr##</div>
                                <div class="col-md-1">Lesion Present</div>
                                <div class="col-md-3">Lesion Type</div>
                                <div class="col-md-2">Region</div>
                                <div class="col-md-1">Side</div>
                                <div class="col-md-2">Status</div>
                                <div class="col-md-2">Actions</div>
                            </div>
                            
                            <cfset i=0>
                            <div class="history_section">
                                <cfloop query="getConditionLesions">
                                <cfset i=i+1>
                                <div class="row" id="lesionHistory_#i#">
                                    <div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;">
                                        <div class="col-md-1 CL" >#i#</div>
                                        <div class="col-md-1 CL" id="LesionPresent_#getConditionLesions.ID#">#getConditionLesions.LesionPresent#</div>
                                        <div class="col-md-3 CL" id="LesionType_#getConditionLesions.ID#">#getConditionLesions.LesionType#</div> 
                                        <div class="col-md-2 CL" id="Region_#getConditionLesions.ID#">#getRegionNamebyId(getConditionLesions.Region)#</div> 
                                        <div class="col-md-1 CL" id="Side_L_R_#getConditionLesions.ID#">#getConditionLesions.Side_L_R#</div> 
                                        <div class="col-md-2 CL" id="Status_#getConditionLesions.ID#">#getConditionLesions.Status#</div>
                                        <div class="col-md-2 CL">
                                            <div class="col-mad-6" style="display:inline-block">
                                            <button class="btn btn-xs btn-primary" type="button"<cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0> onclick="getSingleLesion_Record(#ID#)" </cfif>><i class="fa fa-pencil-square-o"></i></button>
                                            </div>
                                            <div class="col-mad-6" style="display:inline-block">
                                            <button class="btn btn-xs btn-primary"<cfif permissions eq "full_access" or findNoCase("Delete S-S-C", permissions) neq 0> onclick="deleteLesion_Record(#ID#, #i#)"</cfif>><i class="glyphicon glyphicon-trash"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </cfloop>
                            </div>
                          
                        <cfelse>
                            <h2 style="text-align:center;color:red">There is no Lesions added yet!</h2>
                        </cfif>
                    </div>
                
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default closeLesionHistoryModal">Close</button>
                    </div>
                    </div>
                </div>
            </div>
        </cfoutput>
    </cffunction>

    <cffunction name="getlesionsListHistory" access="remote" returnformat="plain" output="true">
        <cfargument name="cl_cs_Id" type="any" required="true" default=""> 
        <cfargument name="Sightningid" type="any" required="true" default=""> 
        <cfoutput> 
        <cfset  permissions ="#session['userdetails']['permissions']#">

        <cfset currentDateOnly = DateFormat(Now(), "yyyy-mm-dd")>
                <!--- <cfdump var="#currentDateOnly#" abort="true"> --->
                
            <!--- <cfquery name="query" datasource="#variables.dsn#">
                SELECT Survey_Sightings.ID,Survey_Sightings.SIGHTINGNUMBER
                from Survey_Sightings where Project_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.PROJECT_ID#'> 
                    and Survey_Sightings.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
                    and Survey_Sightings.SightingNumber != ''
                    ORDER BY Survey_Sightings.ID
            </cfquery> --->
            <cfquery name="getConditionLesions" datasource="#variables.dsn#">
                select  Condition_Lesions.*, 
                    Survey_Sightings.SightingNumber as sighting_Number
                FROM 
                    Condition_Lesions
                INNER JOIN 
                    Survey_Sightings 
                    ON Condition_Lesions.Sighting_ID = Survey_Sightings.id
                where Condition_Lesions.Sighting_ID  = '#Sightningid#'
                and 
                Condition_Lesions.Cetaceans_ID = '#cl_cs_code#'
               
            </cfquery>

        <!--- <cfdump var="#getConditionLesions#" > --->

            <div class="">
                <hr>
                    <h3>Body Condition and Lesions History Table</h3>
                    <cfif getConditionLesions.recordcount gt 0>
                <div class="comdition-lesions">
                    <div class="condition-details">
                
                <cfset lastRow = getConditionLesions.recordcount>
                    <table class="table table-bordered table-striped" id="body_lesionssss" >
                        
                        <thead>
                            <!--- <div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff"> --->
                            <tr>
                        
                                <!--- <div class="col-md-1">Sr##</div> --->
                                <th style="background-color:##011A35; color:white;" >Lesion Present</th>
                                <th style="background-color:##011A35; color:white;" >Sighting Number</th>
                                <th style="background-color:##011A35; color:white;"> Type </th>
                                <th style="background-color:##011A35; color:white;">Lesion/Scar Type</th>
                                <th style="background-color:##011A35; color:white;">Region</th>
                                <th style="background-color:##011A35; color:white;">Side</th>
                                <th style="background-color:##011A35; color:white;">Status</th>
                                <th style="background-color:##011A35; color:white;">Photo Number</th>
                                <th style="background-color:##011A35; color:white;">Comments</th>
                                <th style="background-color:##011A35; color:white;">Actions</th>
                            
                            </tr>
                            <!--- </div> --->
                        </thead>
                

                    <tbody>
                    <cfset i=0>
                    <div class="history_section1">
                        <cfloop query="getConditionLesions">
                        <cfset i=i+1>
                        <div class="row" id="lesionHistoryNew_#i#">
                            <!--- <div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;"> --->
                            <tr>
                            
                                <!--- <div class="col-md-1 CL" >#i#</div> --->
                                <td class=" CL" id="LesionPresent_#getConditionLesions.ID#" style="background-color:##ccc;">#getConditionLesions.LesionPresent#</td>
                                <td class=" CL" id="sightingtext_#getConditionLesions.ID#" style="background-color:##ccc;">
                                    <cfif getConditionLesions.sightingtext NEQ ''>
                                        #getConditionLesions.sightingtext#
                                    <cfelse>
                                        #getConditionLesions.sighting_Number#
                                    </cfif>
                                    <!--- #getConditionLesions.sighting_Number# --->
                                </td>
                                <td class=" CL" id="TypeName_#getConditionLesions.ID#" style="background-color:##ccc;">#getConditionLesions.TypeName#</td> 
                                <td class=" CL" id="LesionType_#getConditionLesions.ID#" style="background-color:##ccc;">#getConditionLesions.LesionType#  </td> 
                                <td class=" CL" id="Region_#getConditionLesions.ID#" style="background-color:##ccc;">#getRegionNamebyId(getConditionLesions.Region)#</td> 
                                <td class=" CL" id="Side_L_R_#getConditionLesions.ID#" style="background-color:##ccc;">#getConditionLesions.Side_L_R#</td> 
                                <td class=" CL" id="Status_#getConditionLesions.ID#" style="background-color:##ccc;">#getConditionLesions.Status#</td>
                                <td class=" CL" id="PhotoNumber_#getConditionLesions.ID#" style="background-color:##ccc;">#getConditionLesions.PhotoNumber#</td>
                                <td class=" CL" id="Comments_#getConditionLesions.ID#" style="background-color:##ccc;">#Left(getConditionLesions.Comments,10)#<cfif len(getConditionLesions.Comments) gt 10>
                                ...</cfif></td>
                                <td class=" CL" style="background-color:##ccc;">
                                    <div class="col-mad-6" style="display:inline-block;padding-right: 3px;">
                                    <button class="btn btn-xs btn-primary" type="button" <cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0>onclick="getSingleLesion_Record(#ID#)"</cfif> id="add_model_class"><i class="fa fa-pencil-square-o"></i></button><br>
                                    </div> 
                                    <div class="col-mad-6" style="display:inline-block">
                                    <button type="button" class="btn btn-xs btn-primary" <cfif permissions eq "full_access" or findNoCase("Delete S-S-C", permissions) neq 0> onclick="deleteLesion_Record_New(#ID#, #i#)"</cfif>><i class="glyphicon glyphicon-trash"></i></button>
                                    </div>
                                </td>
                            
                            </tr>
                            <!--- </div> --->
                        </div>
                    </cfloop>
                </tbody>
                </table>
                </div>
                <cfelse>
                    <h2 style="text-align:center;color:red">There is no Lesions added yet!</h2>
                </cfif>
                    </div>
                </div>
            </div>
        </cfoutput>
    </cffunction>



    <cffunction name="getlesionsListHistoryWithSDRs" access="remote" returnformat="plain" output="true">
        <cfargument name="cl_cs_Id" type="any" required="true" default=""> 
        <cfargument name="Sightningid" type="any" required="true" default=""> 
        <cfoutput> 
        <cfset  permissions ="#session['userdetails']['permissions']#">

        <cfset currentDateOnly = DateFormat(Now(), "yyyy-mm-dd")>
                <!--- <cfdump var="#currentDateOnly#" abort="true"> --->

            <cfquery name="getConditionLesionsWithSDRs" datasource="#variables.dsn#">
              select  Condition_Lesions.*, 
                    Survey_Sightings.SightingNumber as sighting_Number
                FROM 
                    Condition_Lesions
                INNER JOIN 
                    Survey_Sightings 
                    ON Condition_Lesions.Sighting_ID = Survey_Sightings.id
                where Condition_Lesions.Sighting_ID  = '#Sightningid#'
                and 
                Condition_Lesions.Cetaceans_ID = '#cl_cs_code#'
                and Condition_Lesions.EnterDate = '#currentDateOnly#'
            </cfquery>

                            
                        <!--- <cfdump var="test" abort="true"> --->
                    <div class="">
                        <hr>
                         <h3>Body Condition and Lesions History Table</h3>
                         <cfif getConditionLesionsWithSDRs.recordcount gt 0>
                        <div class="comdition-lesions">
                            <div class="condition-details">
                        
                        <cfset lastRow = getConditionLesionsWithSDRs.recordcount>
                            <table class="table table-bordered table-striped" id="body_lesionssss" >
                                
                                <thead>
                                    <!--- <div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff"> --->
                                    <tr>
                           
                                <!--- <div class="col-md-1">Sr##</div> --->
                                <th style="background-color:##011A35; color:white;" >Lesion Present</th>
                                <th style="background-color:##011A35; color:white;" >Sighting Number</th>
                                <th style="background-color:##011A35; color:white;"> Type </th>
                                <th style="background-color:##011A35; color:white;">Lesion/Scar Type</th>
                                <th style="background-color:##011A35; color:white;">Region</th>
                                <th style="background-color:##011A35; color:white;">Side</th>
                                <th style="background-color:##011A35; color:white;">Status</th>
                                <th style="background-color:##011A35; color:white;">Photo Number</th>
                                <th style="background-color:##011A35; color:white;">Comments</th>
                                <th style="background-color:##011A35; color:white;">Actions</th>
                            
                            </tr>
                        <!--- </div> --->
                            </thead>
                        

                            <tbody>
                            <cfset i=0>
                            <div class="history_section1">
                                <cfloop query="getConditionLesionsWithSDRs">
                                <cfset i=i+1>
                                <div class="row" id="lesionHistoryNew_#i#">
                                    <!--- <div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;"> --->
                                    <tr>
                                    
                                        <!--- <div class="col-md-1 CL" >#i#</div> --->
                                        <td class=" CL" id="LesionPresent_#getConditionLesionsWithSDRs.ID#" style="background-color:##ccc;">#getConditionLesionsWithSDRs.LesionPresent#</td>
                                        <td class=" CL" id="sightingtext_#getConditionLesionsWithSDRs.ID#" style="background-color:##ccc;">
                                            <cfif getConditionLesionsWithSDRs.sightingtext NEQ ''>
                                                #getConditionLesionsWithSDRs.sightingtext#
                                            <cfelse>
                                                #getConditionLesionsWithSDRs.sighting_Number#
                                            </cfif>
                                            <!--- #getConditionLesionsWithSDRs.sightingtext# --->
                                        </td>
                                        <td class=" CL" id="TypeName_#getConditionLesionsWithSDRs.ID#" style="background-color:##ccc;">#getConditionLesionsWithSDRs.TypeName#</td> 
                                        <td class=" CL" id="LesionType_#getConditionLesionsWithSDRs.ID#" style="background-color:##ccc;">#getConditionLesionsWithSDRs.LesionType#</td> 
                                        <td class=" CL" id="Region_#getConditionLesionsWithSDRs.ID#" style="background-color:##ccc;">#getRegionNamebyIdWithSDRs(getConditionLesionsWithSDRs.Region)#</td> 
                                        <td class=" CL" id="Side_L_R_#getConditionLesionsWithSDRs.ID#" style="background-color:##ccc;">#getConditionLesionsWithSDRs.Side_L_R#</td> 
                                        <td class=" CL" id="Status_#getConditionLesionsWithSDRs.ID#" style="background-color:##ccc;">#getConditionLesionsWithSDRs.Status#</td>
                                        <td class=" CL" id="PhotoNumber_#getConditionLesionsWithSDRs.ID#" style="background-color:##ccc;">#getConditionLesionsWithSDRs.PhotoNumber#</td>
                                        <td class=" CL" id="Comments_#getConditionLesionsWithSDRs.ID#" style="background-color:##ccc;">#Left(getConditionLesionsWithSDRs.Comments,10)#<cfif len(getConditionLesionsWithSDRs.Comments) gt 10>
                                        ...</cfif></td>
                                        <td class=" CL" style="background-color:##ccc;">
                                            <div class="col-mad-6" style="display:inline-block;padding-right: 3px;">
                                            <button class="btn btn-xs btn-primary" type="button" <cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0>onclick="getSingleLesion_Record(#ID#)"</cfif> id="add_model_class"><i class="fa fa-pencil-square-o"></i></button><br>
                                            </div> 
                                            <div class="col-mad-6" style="display:inline-block">
                                            <button type="button" class="btn btn-xs btn-primary" <cfif permissions eq "full_access" or findNoCase("Delete S-S-C", permissions) neq 0> onclick="deleteLesion_Record_New(#ID#, #i#)"</cfif>><i class="glyphicon glyphicon-trash"></i></button>
                                            </div>
                                        </td>
                                    
                                    </tr>
                                  <!--- </div> --->
                                </div>
                            </cfloop>
                        </tbody>
                        </table>
                        </div>
                        <cfelse>
                            <h2 style="text-align:center;color:red">There is no Lesions added yet!</h2>
                        </cfif>
                            </div>
                        </div>
                    </div>
        </cfoutput>
    </cffunction>



</cfcomponent>

