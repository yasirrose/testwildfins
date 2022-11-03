<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page=50>
<cfset today = now()>
<cfif isdefined('FORM.btnDolphinCatalog')>
    <cfset getDolphins = Application.Dolphin.getDolphinCatalog(argumentCollection="#Form#")>
<cfelse>
	<cfset getDolphins = Application.Dolphin.getDolphinCatalog()>    
</cfif>
<cfif cgi.REMOTE_ADDR eq '202.141.226.196'>
    <!---<cfdirectory 
      action = "list"
      directory = "#Application.CloudDirectory#"
      name = "images"
      >
    <cfloop query="#images#">
        <cfif (Name contains '.jpg' or Name contains '.png') and Name NEQ '113observedvideoplayback.jpg' and Name NEQ 'chinese.jpg'>
            <cfimage action="read" source="#Application.CloudDirectory##Name#" name="myImage"> 
            <cfset ImageScaleToFit(myImage,200,200,"bilinear")> 
            <cfset namee = listtoarray(Name,'.')>
            <cfset newImageName = "#Application.CloudDirectory#\dolphins_thumbnail\#namee[1]#_thumbnail.#namee[2]#">
            <cfimage source="#myImage#" action="write" destination="#newImageName#" overwrite="yes">
        </cfif>
    </cfloop>--->
</cfif>
<cfset getcatalog    = Application.Dolphin.getCatalog()>
<cfset getDscoreCode = Application.Dolphin.getDscoreDropdown()>
<cfset getSurveyArea = Application.Sighting.getSurveyArea()>
<style>

#preview{
	position:fixed;
	border:1px solid #ccc;
	background:#333;
	padding:5px;
	display:none;
	color:#fff;
	top:10%;
	z-index:999;
	}
	ul.dolphin_images {
	display: inline-block;
	width: 100%;
	margin: 0 auto;
	padding: 20px 15px;
	margin-top: 15px;
	text-align:center;
	}
	.dolphin_images li {
    position: relative;
    width: 20%;
    margin-bottom: 20px;
    margin-left: 0.5%;
    list-style: none;
    float: none;
    display: inline-block;
    margin-right: 0.8%;
    border: 1px solid #ddd;
    text-align: center;
    padding: 5px 5px;
    border-radius: 4px;
    background-color: #fafafa;
    box-shadow: 0 0 6px 0 #eee;
	}
	.dolphin_images li:nth-child(4n+4) {
	margin-right: 0px;
	}
	.dolphin_images img {
	width: 100%;
	border:none;
	}
	span.removeDolphin {
	position: absolute;
	right: -7px;
	top: -10px;
	background: red;
	font-size: 20px;
	line-height: normal;
	width: 20px;
	height: 20px;
	text-align: center;
	border-radius: 50%;
	line-height: 15px;
	color: #fff;
	font-weight: normal;
	border: 1px solid red;
	cursor: pointer;
	}
/*  */
</style>
<div id="content" class="content">
    <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">Home</a></li>
        <li><a href="javascript:;">Dolphin Catalog</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Dolphin Catalog</h1>
   
<div class="section-container section-with-top-border p-b-10">
<div class="row">
    <!-- begin col-6 -->
<div class="col-md-10">
<cfoutput>
        <form class="form-horizontal" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="dolphinCatalog" id="dolphinCatalog" method="post">
            <div class="form-group m-b-10">
                <label class="col-md-3 control-label">Catalog Descriptor</label>
                <div class="col-md-7">
                    <select class="form-control" name="catalog">
                        <option value="">Select Catalog</option>
                        <cfloop query="getCatalog">
                            <option value="#getCatalog.Catalog#" <cfif isdefined("form.catalog") and getCatalog.Catalog EQ form.Catalog> selected </cfif>>#getCatalog.Catalog#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
            <div class="form-group m-b-10">
                <label class="col-md-3 control-label">DScore:</label>
                <div class="col-md-7">
                    <select class="form-control" name="dscore">
                        <option value="">Select DScore</option>
                        <cfloop query="getDscoreCode">
                        	<option value="#getDscoreCode.Dscore#" <cfif isdefined("form.dscore") and getDscoreCode.DScore eq form.dscore>selected</cfif>>#getDscoreCode.Dscore#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
            <div class="form-group m-b-10">
                <label class="col-md-3 control-label">Body Of Water:</label>
                <div class="col-md-7">
                    <select class="form-control" name="bodyOfWater">
                        <option value="">Select Body of Water</option>
                        <cfloop query="getSurveyArea">
                            <option value="#AreaName#" <cfif isdefined("form.bodyOfWater") and form.bodyOfWater eq AreaName>selected</cfif>>#AreaName#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
            
            <div class="col-md-7 col-md-offset-3">
            	<input type="hidden" name="startHereIndex" value="1" />
                <button type="submit" name="btnDolphinCatalog" value="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
                <button class="btn btn-default" type="button" onclick="window.location.href=window.location.href;">Reset</button>
            </div>
    	</form>
</cfoutput>
</div>
    <!-- end col-6 -->
    <!-- begin col-6 -->

</div>
</div>
<div class="section-container section-with-top-border">
    <div class="panel pagination-inverse m-b-0 clearfix">
        <ul class="dolphin_images">
        	<cfset count = 0>
            <cfoutput>
            <cfloop query="getDolphins" startrow="#startHereIndex#">
                <cfset dolphinSightings = Application.Dolphin.getDolphinSightings(#ID#)>
                <cfif getDolphins.ImageName NEQ '' and FileExists('#Application.CloudRoot##getDolphins.ImageName#')>
					<cfset  Fin = '#getDolphins.ImageName#'>
                <cfelse>
                    <cfloop query='dolphinSightings'>
                        <cfset  Fin  = 'N/A'>
                        <cfif dolphinSightings.DATESEEN NEQ ''>
                            <cfif DAY(DATESEEN) lt 10 >
                                <cfset dayy = '0#DAY(DATESEEN)#'>
                            <cfelse>
                                <cfset dayy  = DAY(DATESEEN)>  
                            </cfif>
                            
                            <cfif MONTH(DATESEEN) lt 10 >
                                <cfset monthh = '0#MONTH(DATESEEN)#'>
                            <cfelse>
                                <cfset monthh  = MONTH(DATESEEN)>  
                            </cfif>
                            
                            <cfset Fin_Left = '#getDolphins.Code#(L) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
                            <cfset Fin_Right = '#getDolphins.Code#(R) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
                            
                            <cfif FileExists('#Application.CloudDirectory##Fin_Left#')>
                                <cfset  Fin = '#Fin_Left#'>
                                <cfbreak>
                            <cfelseif FileExists('#Application.CloudDirectory##Fin_Right#')>
                                <cfset  Fin  = '#Fin_Right#'>
                                <cfbreak>
                            </cfif>	
                         </cfif>                       
                    </cfloop>
				</cfif>
                <cfif Fin NEQ 'N/A'>
                    <cfset Fin_thumbnail = listtoarray(Fin,'.')>
                    <cfset Fin_thumbnail = #Application.CloudRoot#&'dolphins_thumbnail/'&#Fin_thumbnail[1]#&'_thumbnail.'&#Fin_thumbnail[2]#>
                    <cfif not FileExists('#Fin_thumbnail#')>
                    	<cfset Fin_thumbnail = #Application.CloudRoot#&#Fin#>
                    </cfif>
                    <cfset count ++>
                    <li>
                        <a href="javascript:void(0);" data-url="#Application.CloudRoot##Fin#" class="preview viewDolphinImage<cfif count mod 4 eq 0> rowLast</cfif>" title="#Code#">
                            <img src="#Fin_thumbnail#" alt="gallery thumbnail" />
                         </a>
                         <span class="removeDolphin">x</span>
                    </li>
                    <cfif count mod 50 eq 0><cfbreak></cfif>
                </cfif>
            </cfloop>
            </cfoutput>
            <cfif getDolphins.recordcount eq 0 or count eq 0><li>No Record found.</li></cfif>
        </ul>    
        <cfset qpagination = getDolphins>
        <cfinclude template="../pagination.cfm">
    </div>
</div>
<!-- Creates the bootstrap modal where the image will appear -->
<div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:48%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Fin preview</h4>
      </div>
      <div class="modal-body">
        <img src="" id="imagepreview" style="width: auto; height: auto;" >
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
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
