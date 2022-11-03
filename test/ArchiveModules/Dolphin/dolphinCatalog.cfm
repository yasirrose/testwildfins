<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page=50>
<cfset today = now()>
<cfset getcatalog    = Application.Dolphin.getCatalog()>
<cfif isdefined('FORM.Catalog') and FORM.Catalog neq "">
    <cfdirectory action = "list" directory = "#Application.CloudDirectory#/dolphins_thumbnail/#form.Catalog#" name = "images">
</cfif>
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
                                <select class="form-control" name="Catalog" required>
                                    <option value="">Select Catalog</option>
                                    <cfloop query="getCatalog">
                                        <option value="#getCatalog.Catalog#" <cfif isdefined("form.Catalog") and getCatalog.Catalog EQ form.Catalog> selected </cfif>>#getCatalog.Catalog#</option>
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
    </div>
</div>
<cfif isdefined('FORM.Catalog') and FORM.Catalog neq "">
    <div class="section-container section-with-top-border">
        <div class="panel pagination-inverse m-b-0 clearfix">
            <ul class="dolphin_images">
                <cfoutput>
                <cfset count = 0>
                <cfloop query="images" startrow="#startHereIndex#">
                    <cfset count ++>
                    <li>
                        <a href="javascript:void(0);" data-url="#Application.CloudRoot#dolphins_thumbnail/#form.Catalog#/#images.Name#" class="preview viewDolphinImage<cfif count mod 4 eq 0> rowLast</cfif>" title="#images.Name#">
                            <img src="#Application.CloudRoot#dolphins_thumbnail/#form.Catalog#/#images.Name#" alt="gallery thumbnail" />
                        </a>
                        <span class="removeDolphin">x</span>
                    </li>
                    <cfif count mod 50 eq 0><cfbreak></cfif>
                </cfloop>
                </cfoutput>
            </ul>  
            <cfset qpagination = images>
            <cfinclude template="../pagination.cfm">
        </div>
    </div>
</cfif>
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
