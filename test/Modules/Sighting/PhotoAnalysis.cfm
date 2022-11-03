<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page=200>
<cfparam name="form.searchword" default="">
<cfset today = now()>

<cfif isdefined('FORM.btnSearchSightings')>
    <cfset getDolphinsWithNoSightings = Application.Sighting.getDolphinsWithNoSightings(argumentCollection="#Form#")>
<cfelse>
	<cfset getDolphinsWithNoSightings = Application.Sighting.getDolphinsWithNoSightingsNoFilter()> 
</cfif>
<cfset getAreaName =  Application.Sighting.getAreaName()>
<cfset getSurveyArea = Application.Sighting.getSurveyArea()>
<cfset getSurveyType = Application.Sighting.getType()>
<cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>

<div id="content" class="content">
    <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">Home</a></li>
        <li><a href="javascript:;">Photo Analysis</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Photo Analysis</h1>
   
<div class="section-container section-with-top-border p-b-10">
<div class="row">
    <!-- begin col-6 -->
<div class="col-md-10">
<cfoutput>
        <form class="form-horizontal" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="searchSightings" id="searchSightings" method="post">
        <div class="form-group m-b-10">
            <label class="col-md-3 control-label">Cetacean Species</label>
            <div class="col-md-7">
                <select class="form-control" name="cetaceanSpecies">
                    <option value="">Select Cetacean Species</option>
                    <cfloop query="#qgetCetaceanSpecies#">
                    	<option value="#CetaceanSpeciesName#" <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies eq CetaceanSpeciesName>selected</cfif>>#CetaceanSpeciesName#</option>
                    </cfloop>
                </select>
            </div>
        </div>
        <div class="form-group m-b-10">
            <label class="col-md-3 control-label">Date Range</label>
            <div class="col-md-7">
                <div id="Date-range" class="input-group">
                    <input type="text"  value="<cfif isdefined("form.date") and form.date NEQ "">#form.date#</cfif>" class="form-control" name="date" id="date"placeholder="Select Date Range">
                    <span class="input-group-btn">
                        <button type="button" class="btn btn-primary"onclick="showdate()"><i class="fa fa-calendar"></i></button>
                    </span>
                </div>
            </div>
        </div>
        <div class="form-group m-b-10">
            <label class="col-md-3 control-label">Body of Water</label>
            <div class="col-md-7">
                <select class="form-control" name="bodyOfWater">
                    <option value="">Select Body of Water</option>
                    <cfloop query="#getSurveyArea#">
                    	<option value="#ID#" <cfif isdefined("form.bodyOfWater") and form.bodyOfWater eq ID>selected</cfif>>#AreaName#</option>
                    </cfloop>
                </select>
            </div>
        </div>
        <div class="form-group m-b-10">
            <label class="col-md-3 control-label">Survey Type</label>
            <div class="col-md-7">
                <select class="form-control" name="surveyType">
                    <option value="">Select Survey Type</option>
                    <cfloop query="#getSurveyType#">
                    	<option value="#type#" <cfif isdefined("form.surveyType") and form.surveyType eq type>selected</cfif>>#type#</option>
                    </cfloop>
                </select>
            </div>
        </div>
        <div class="form-group m-b-10">
            <label class="col-md-3 control-label">Photo Review Status</label>
            <div class="col-md-7">
                <select class="form-control" name="photoReviewStatus">
                    <option value="">Select Review Status</option>
                    <option value="To be Entered" <cfif isdefined("form.photoReviewStatus") and form.photoReviewStatus eq "To be Entered">selected</cfif>>To be Entered</option>
                    <option value="To be Initial Reviewed" <cfif isdefined("form.photoReviewStatus") and form.photoReviewStatus eq "To be Initial Reviewed">selected</cfif>>To be Initial Reviewed</option>
                    <option value="To be Final Reviewed" <cfif isdefined("form.photoReviewStatus") and form.photoReviewStatus eq "To be Final Reviewed">selected</cfif>>To be Final Reviewed</option>
                    <option value="Sightings with NO Cetacean Sightings" <cfif isdefined("form.photoReviewStatus") and form.photoReviewStatus eq "Sightings with NO Cetacean Sightings">selected</cfif>>Sightings with NO Cetacean Sightings</option>
                </select>
            </div>
        </div>
        <div class="col-md-7 col-md-offset-3">
            <button type="submit" name="btnSearchSightings" value ="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
            <button class="btn btn-default width-100" type='reset'>Cancel</button>
        </div>
    </form>
</cfoutput>
</div>
    <!-- end col-6 -->
    <!-- begin col-6 -->

</div>
</div>
<div class="section-container section-with-top-border">
    <!---<div class="form-group m-b-10" style="overflow: hidden;"> 
        <div class="row col-md-3">
            <form class="navbar-form form-input-flat" method="post" name="paginationform">
                <div class="form-group">
                        <input type="text" name="searchword" class="form-control"
                        value="<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0><cfoutput>#form.searchword#</cfoutput></cfif>" placeholder="search...">
                    <input type="hidden" name="startHereIndex" value="1" />
                    <button type="submit" class="btn btn-search"><i class="fa fa-search"></i></button>
                </div>
            </form>
        </div>
    </div> --->
    <div class="panel pagination-inverse m-b-0 clearfix">
        <table id="example" data-order='[[5,"desc"]]' class="table table-bordered table-hover">
            <thead>
            <tr class="inverse">
<!---                 <th>Sr#</th> --->
                <th>Survey Number</th>
                <th>Sighting Number</th>
                <th>Cetacean Species</th>
                <th>Body of Water</th> 
                <th>Survey Type</th> 
                <th>Date</th> 
                <th>Actions</th> 
            </tr>
            </thead>
            <tbody>
                <cfoutput query="getDolphinsWithNoSightings" >
                    <tr>
                        <!---<td>#getDolphinsWithNoSightings.currentRow#</td> --->
                        <td>#Project_ID#</td>
                        <td>#SightingNumber#</td>
                        <cfif isdefined("form.photoReviewStatus")  and form.photoReviewStatus  eq "Sightings with NO Cetacean Sightings"><td></td><cfelse><td>#CetaceanSpeciesName#</td></cfif>
                        <td>
                         <cfset bd = listToArray(#BodyOfWater#, ",", false, true)>
                            <cfset d = 1>
                            <cfloop query="getAreaName">
                                <cfif ArrayContains(bd,#ID#)>#AreaName#
                                    <span class="slash_#d#"><cfset d = d+1>
                                        <cfif arrayLen(bd) gt 1>/</cfif>
                                    <span>
                                </cfif>
                            </cfloop>
                        </td> 
                        <td>#SurveyType#</td> 
                        <td>#dateformat(Date,'YYYY-mm-dd')#</td> 
                        <td>
                        <cfif isdefined("form.photoReviewStatus")  and form.photoReviewStatus  eq "Sightings with NO Cetacean Sightings"><button class="btn btn-xs btn-primary update btnShowSurvey" data-id="#Project_ID#,#ID#"><i class="fa fa-eye"></i></button><cfelse><button class="btn btn-xs btn-primary update btnShowSurvey" data-id="#Project_ID#,#Sighting_ID#"><i class="fa fa-eye"></i></button></cfif>
                        
                        </td> 
                    </tr>
                </cfoutput>
            </tbody>
        </table>
         <form name="showSurvey" id="showSurvey" action="/?Module=Sighting&Page=Home" method="post" target="_blank"> 
            <input type="hidden" name="Project_ID" value="" />
            <input type="hidden" name="Sight_ID" value="" />
        </form>
<!---         <cfset qpagination = getDolphinsWithNoSightings> --->
<!---         <cfinclude template="../pagination.cfm">  --->
    </div> 
    <!-- end panel -->
</div>
    <!-- end section-container -->
<div class="footer" id="footer">
    <span class="pull-right">
		<a data-click="scroll-top" class="btn-scroll-to-top" href="javascript:;">
			<i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
		</a>
	</span>
    &copy;
<cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
</div>
    <!-- end row -->
</div>
