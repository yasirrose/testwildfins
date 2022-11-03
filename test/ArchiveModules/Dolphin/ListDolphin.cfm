<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page=500>
<cfparam name="form.searchword" default=" ">
<cfset getdolphin = Application.Dolphin.get_Dolphinlist(form.searchword)>
<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
    <cfset   getdolphin=Application.Dolphin.get_Dolphinlist(form.searchword)>
</cfif>

<!-- begin #content -->
<div id="content" class="content">
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">Home</a></li>
        <li><a href="javascript:;">Dolphin List</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Dolphin List</h1>



    <!-- begin section-container -->

<div class="section-container section-with-top-border">

    <!-- begin panel -->
<div class="form-group m-b-10" style="overflow: hidden;">
<div class="col-md-12">
<div class="col-md-3">
<form class="navbar-form form-input-flat" method="post" name="searchfrom">
<div class="form-group">
        <input type="text" name="searchword" class="form-control"
        value="<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0><cfoutput>#form.searchword#</cfoutput></cfif>" placeholder="Enter Name/code...">
    <input type="hidden" name="startHereIndex" value="1" />
    <button type="submit" class="btn btn-search"><i class="fa fa-search"></i></button>
</div>
</form>
</div>
</div>
</div>

    <div class="form-group">
        <div class="alert alert-success message" style="display:none">
            <strong>Success!</strong> Dolphin Deleted.
        </div>
    </div>

<div class="panel pagination-inverse m-b-0 clearfix">
<table id="example" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
    <thead>
    <tr class="inverse">
        <th>Sr#</th>
        <th>Code</th>
        <th>Name</th>
        <th>Sex</th>
        <th>Distinct Date</th>
        <th>DScore</th>
        <th>Actions</th>
    </tr>
    </thead>
<tbody>
<cfoutput query="getdolphin" startrow="#startHereIndex#"  maxrows="#Application.record_per_page#">
    <tr class="inverse" id="remov_#ID#">
<td>#getdolphin.currentRow#</td>
<td>#Code#</td>
<td>#Name#</td>
<td>#Sex#</td>
<td>#DateFormat(DistinctDate, "mm-dd-yyyy")#</td>
<td>#DScore#</td>
<td>


<div class="col-mad-6" style="display:inline-block">
        <form action="#Application.superadmin#?ArchiveModule=Dolphin&Page=EditDolphin&Archive" method="post">
        <input type="hidden" value="#ID#" name="id" />
    <button class="btn btn-xs btn-primary update" type="submit"><i class="fa fa-pencil-square-o"></i></button>
</form>
</div>
<div class="col-mad-6" style="display:inline-block">
        <button class="btn btn-xs btn-primary" onclick="deleteRecord(#ID#)"><i class="glyphicon glyphicon-trash"></i></button></td>

</div>
    </tr>
</cfoutput>

    </tbody>
    </table>
<cfset qpagination = getdolphin >
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
    &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
</div>
</div>
<!-- end #content -->
