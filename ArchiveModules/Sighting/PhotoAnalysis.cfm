<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page=200>
<cfparam name="form.searchword" default="">
<cfset today = now()>
<cfif isdefined('FORM.btnSearchSightings')>
    <cfset getDolphinsWithNoSightings = Application.Sighting.getDolphinsWithNoSightings(argumentCollection="#Form#")>
<cfelse>
	<cfset getDolphinsWithNoSightings = Application.Sighting.getDolphinsWithNoSightings()>    
</cfif>

<cfset getSurveyArea = Application.Sighting.getSurveyArea()>
<cfset getSurveyType = Application.Sighting.getType()>

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
            <label class="col-md-3 control-label">Date Range</label>
            <div class="col-md-7">
                <div id="Date-range" class="input-group">
                    <input type="text"  value="<cfif isdefined("form.date") and form.date NEQ "">#form.date#</cfif>" class="form-control" name="date" placeholder="Select Date Range">
                    <span class="input-group-btn">
                        <button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
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
                    	<option value="#AreaName#" <cfif isdefined("form.bodyOfWater") and form.bodyOfWater eq AreaName>selected</cfif>>#AreaName#</option>
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
            <label class="col-md-3 control-label">Sightings to be Reviewed</label>
            <div class="col-md-1">
                <input type="checkbox" name="toBeReviewed" value="To be Reviewed" <cfif isdefined("Form.toBeReviewed")>checked</cfif>>
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
    <div class="form-group m-b-10" style="overflow: hidden;display:none;">
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
    </div>
    <div class="panel pagination-inverse m-b-0 clearfix">
        <table id="example" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
            <thead>
            <tr class="inverse">
                <th>Sr##</th>
                <th>Survey ID</th>
                <th>Sighting ID</th>
                <th>Body of Water</th>
                <th>Survey Type</th>
                <th>Date</th>
               <cfif isdefined("Form.toBeReviewed")><th>Entered By</th></cfif>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
                <cfoutput query="getDolphinsWithNoSightings" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                    <tr class="inverse" id="remov_#id#">
                        <td>#getDolphinsWithNoSightings.currentRow#</td>
                        <td>#Project_ID#</td>
                        <td><cfif SightingNumber NEQ ''>#SightingNumber# - </cfif>#ID#</td>
                        <td>#SurveyArea#</td>
                        <td>#Type#</td>
                        <td>#dateformat(Date,'YYYY-mm-dd')#</td>
                        <cfif isdefined("Form.toBeReviewed")><td>#entered_by#</td></cfif>
                        <td>
                            <button class="btn btn-xs btn-primary update btnShowSurvey" data-id="#Project_ID#,#ID#"><i class="fa fa-eye"></i></button>
                        </td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>
        <form name="showSurvey" id="showSurvey" action="/?ArchiveModule=Sighting&Page=Home&Archive" method="post" target="_blank">
            <input type="hidden" name="Project_ID" value="" />
            <input type="hidden" name="Sight_ID" value="" />
        </form>
        <cfset qpagination = getDolphinsWithNoSightings>
        <cfinclude template="../pagination.cfm">
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
