
      <cfdump  var="#directoryExists('#Application.CloudDirectory#/dolphins_thumbnail_new')#">
      
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
<cfif isdefined('FORM.btnDolphinCatalog')>
    <cffile action="uploadAll" fileField="images" destination="#Application.CloudDirectory#/dolphins_thumbnail_new" result="returnBestImage" nameconflict="overwrite">
    <cfloop array="#returnBestImage#" item="item">
       <cfset name =  #item.SERVERFILENAME#>
       <cfset na = name.split(' ')[1]&".jpg">
       <cffile action = "rename" source = "#Application.CloudDirectory#dolphins_thumbnail_new\#item.serverfile#" destination = "#Application.CloudDirectory#/dolphins_thumbnail_new/#na#"> 
    </cfloop>
    
            
</cfif>
 
<cfoutput>
        <form class="form-horizontal"  method="post" enctype="multipart/form-data" > 
            	<input type="file" name="images" multiple />
            
            <div class="col-md-7 col-md-offset-3">
                <button type="submit" name="btnDolphinCatalog" value="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
            </div>
    	</form>
</cfoutput>
</div>
    <!-- end col-6 -->
    <!-- begin col-6 -->

</div>
</div>

