<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">
<cfif isdefined('FORM.addSourceSex')>
    <cfset qInsertaddDscore = Application.StaticData.addSourceSex(argumentCollection="#Form#")>
<cfelse>
</cfif>

<cfset getdeaddolphins = Application.Dolphin.getDeadDolphins()>
<cfif isdefined('FORM.editSourceSex')>

    <cfset EditDscore = Application.StaticData.editSourceSex(argumentCollection="#Form#")>
<cfelse>
</cfif>
<cfset getsourceSex = Application.StaticData.getsourceSex()>

<div id="content" class="content">
    <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">Dolphin</a></li>
        <li><a href="javascript:;">Dead Dolphins</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Dead Dolphins</h1>
<cfif isdefined('qInsertaddDscore') and qInsertaddDscore.recordcount eq 1 >
        <div class="alert alert-success fade in m-b-10" id="sucess-div">
            <strong>Successfully Added!</strong>
            <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
        </div>
</cfif>

<!---<cfif isdefined('editDscore') and EditDscore.recordcount eq 1 >--->
<!---<div class="alert alert-success fade in m-b-10" id="sucess-div">--->
<!---<strong>Successfully Updated!</strong>--->
<!---<span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>--->
<!---</div>--->
<!---</cfif>--->


<div class="section-container section-with-top-border">
<div class="panel pagination-inverse m-b-0 clearfix">
<table id="example" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
    <thead>
    <tr class="inverse">
        <th>Sr#</th>
        <th>Code</th>
        <th>Name</th>
        <th>Sex</th>
        <th>Actions</th>
    </tr>
    </thead>
<tbody>
<cfoutput query="getdeaddolphins" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
    <tr class="inverse" id="remov_#ID#">
<td>#getdeaddolphins.currentRow#</td>
        <td>#Code#</td>
        <td>#Name#</td>
        <td>#sex#</td>
            <input type="hidden" name="seletecActiveValue-#ID#" id="seletecActiveValue-#ID#">
<td>
        <form action="#Application.superadmin#?Module=Dolphin&Page=DeadDolphinList" method="post">
        <input type="hidden" value="#ID#" name="break_id" />
    <button class="btn btn-xs btn-primary update" type="submit"><i class="fa fa-pencil-square-o"></i></button>
</form>

        </td>
</tr>
</cfoutput>
</tbody>
</table>


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