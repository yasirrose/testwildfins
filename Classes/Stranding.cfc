<cfcomponent displayName="Stranding" output="false">
    <cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
      <cfargument name="dsn" type="string" required="true" hint="datasource">
      <cfset variables.dsn = arguments.dsn>
      <cfreturn this>
    </cffunction>
    <!---   Cetacean Exam Section   --->
    <cffunction name="LiveCetaceanExamInsert" returntype="any" output="false" access="public" >
        
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.ECG')>
            <cfset FORM.ECG = "">
        </cfif>
        <cfif NOT isDefined('FORM.Ultrasound')>
            <cfset FORM.Ultrasound = "">
        </cfif>
        <cfif NOT isDefined('FORM.SputumSample')>
            <cfset FORM.SputumSample = "">
        </cfif>
        <cfif NOT isDefined('FORM.SkinLesion')>
            <cfset FORM.SkinLesion = "">
        </cfif>
        <cfif NOT isDefined('FORM.BloodSamples')>
            <cfset FORM.BloodSamples = "">
        </cfif>
        <cfif NOT isDefined('FORM.Entangled')>
            <cfset FORM.Entangled = "">
        </cfif>
        <cfif NOT isDefined('FORM.Taged')>
            <cfset FORM.Taged = "">
        </cfif>
        <cfif NOT isDefined('FORM.Released')>
            <cfset FORM.Released = "">
        </cfif>
        <cfif NOT isDefined('FORM.SSCollectedFor')>
            <cfset FORM.SSCollectedFor = "">
        </cfif>
        <cfif NOT isDefined('FORM.SLCollectedFor')>
            <cfset FORM.SLCollectedFor = "">
        </cfif>
        <cfif NOT isDefined('FORM.BSCollectedFor')>
            <cfset FORM.BSCollectedFor = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO ST_LiveCetaceanExam 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,species
            ,BodyOfWater
            ,NOAAStock
            ,StTpye
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,lat
            ,lon
            ,ECG
            ,ECGresults
            ,Ultrasound
            ,Ultrasoundresults
            ,mmc
            ,crt
            ,SputumSample
            ,SSCollectedFor
            ,SkinLesion
            ,SLCollectedFor
            ,BloodSamples
            ,BSCollectedFor
            ,BSBloodVolume
            ,BSNotes
            ,BodyCondition
            ,Head_NuchalCrest
            ,Head_LateralCervicalReg
            ,Head_FacialBones
            ,Head_EarOS
            ,Head_ChinSkinFolds
            ,Body_EpaxialMuscle
            ,Body_DorsalRidgeScapula
            ,Body_Ribs
            ,Tail_TransversePro
            ,Entangled
            ,TagedType
            ,TagedLocation
            ,TagedLon
            ,TagedLat
            ,Released
            ,RLD
            ,General
            ,SNM
            ,Mentation
            ,Palpation
            ,Proprioception
            ,Reflexes
            ,Taged
            ,county
            ,InitialCondition
            ,FinalCondition
            ,BriefHistory
            ,CompletedBy
            ,pdfFiles
            ,affiliatedID
            ,actualClass
            ,euthanizedCB
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ECG#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ECGresults#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ultrasound#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ultrasoundresults#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.mmc#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.crt#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SputumSample#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SSCollectedFor#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SkinLesion#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SLCollectedFor#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BloodSamples#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BSCollectedFor#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BSBloodVolume#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BSNotes#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_NuchalCrest#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_LateralCervicalReg#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_FacialBones#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_EarOS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_ChinSkinFolds#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Body_EpaxialMuscle#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Body_DorsalRidgeScapula#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Body_Ribs#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Tail_TransversePro#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Entangled#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagedType#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagedLocation#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagedLon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagedLat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Released#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RLD#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.General#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SNM#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Mentation#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Palpation#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Proprioception#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Reflexes#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Taged#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pdfFiles#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <!--- <cfdump var="#LCE_ID#" abort="true"> --->
        <cfreturn LCE_ID>
    </cffunction>

    <cffunction name="CetaceanExamUpdate" returntype="any" output="false" access="public" >
        
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.ECG')>
            <cfset FORM.ECG = "">
        </cfif>
        <cfif NOT isDefined('FORM.Ultrasound')>
            <cfset FORM.Ultrasound = "">
        </cfif>
        <cfif NOT isDefined('FORM.SputumSample')>
            <cfset FORM.SputumSample = "">
        </cfif>
        <cfif NOT isDefined('FORM.SkinLesion')>
            <cfset FORM.SkinLesion = "">
        </cfif>
        <cfif NOT isDefined('FORM.BloodSamples')>
            <cfset FORM.BloodSamples = "">
        </cfif>
        <cfif NOT isDefined('FORM.Entangled')>
            <cfset FORM.Entangled = "">
        </cfif>
        <cfif NOT isDefined('FORM.Taged')>
            <cfset FORM.Taged = "">
        </cfif>
        <cfif NOT isDefined('FORM.Released')>
            <cfset FORM.Released = "">
        </cfif>
        <cfif NOT isDefined('FORM.SSCollectedFor')>
            <cfset FORM.SSCollectedFor = "">
        </cfif>
        <cfif NOT isDefined('FORM.SLCollectedFor')>
            <cfset FORM.SLCollectedFor = "">
        </cfif>
        <cfif NOT isDefined('FORM.BSCollectedFor')>
            <cfset FORM.BSCollectedFor = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#variables.dsn#"  result="return_data" >
            UPDATE  ST_LiveCetaceanExam SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
           ,ECG = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ECG#'>
           ,ECGresults = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ECGresults#'>
           ,Ultrasound = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ultrasound#'>
           ,Ultrasoundresults = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ultrasoundresults#'>
           ,mmc = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.mmc#'>
           ,crt = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.crt#'>
           ,SputumSample = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SputumSample#'>
           ,SSCollectedFor = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SSCollectedFor#'>
           ,SkinLesion = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SkinLesion#'>
           ,SLCollectedFor = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SLCollectedFor#'>
           ,BloodSamples = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BloodSamples#'>
           ,BSCollectedFor = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BSCollectedFor#'>
           ,BSBloodVolume = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BSBloodVolume#'>
           ,BSNotes = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BSNotes#'>
           ,BodyCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyCondition#'>
           ,Head_NuchalCrest = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_NuchalCrest#'>
           ,Head_LateralCervicalReg = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_LateralCervicalReg#'>
           ,Head_FacialBones = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_FacialBones#'>
           ,Head_EarOS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_EarOS#'>
           ,Head_ChinSkinFolds = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Head_ChinSkinFolds#'>
           ,Body_EpaxialMuscle = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Body_EpaxialMuscle#'>
           ,Body_DorsalRidgeScapula = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Body_DorsalRidgeScapula#'>
           ,Body_Ribs = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Body_Ribs#'>
           ,Tail_TransversePro = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Tail_TransversePro#'>
           ,Entangled = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Entangled#'>
           ,TagedType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagedType#'>
           ,TagedLocation = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagedLocation#'>
           ,TagedLon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagedLon#'>
           ,TagedLat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagedLat#'>
           ,Released = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Released#'>
           ,RLD = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RLD#'>
           ,General = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.General#'>
           ,SNM = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SNM#'>
           ,Mentation = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Mentation#'>
           ,Palpation = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Palpation#'>
           ,Proprioception = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Proprioception#'>
           ,Reflexes = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Reflexes#'>
           ,Taged = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Taged#'>
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,pdfFiles = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pdfFiles#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
           ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- <cfset UpdateLevelA_HI(argumentCollection="#Form#")> --->
        <cfreturn TRUE>
    </cffunction>
   
    <cffunction name="InsertHeartData"  returntype="any" output="false" access="remote" >
        <cfargument name="heartRate" type="string" required="false">
        <cfargument name="heartRateTime" type="string" required="false">
        <cfargument name="LCE_ID" type="numeric" required="false" default="0">
        
            <cfif len(trim(heartRate)) GT 0 >
			<cfloop from="1" to="#ListLen(heartRate)#" index="i">
                <cfquery name="update" datasource="#variables.dsn#" result="updating" >
                    Insert into ST_HeartRate (LCE_ID,heartRate,heartRateTime)values
                    (<cfqueryparam cfsqltype="cf_sql_integer" value='#LCE_ID#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(heartRate,i)#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(heartRateTime,i)#'>
                    )
                </cfquery>
            </cfloop>
		    </cfif>
		<cfreturn true>
	</cffunction>

    <cffunction name="InsertDrugData"  returntype="any" output="false" access="remote" >
        <cfargument name="Drugtype" type="string" required="false">
        <cfargument name="DrugMethod" type="string" required="false">
        <cfargument name="DrugTime" type="string" required="false">
        <cfargument name="DrugDosage" type="string" required="false">
        <cfargument name="DrugVolume" type="string" required="false">
        <cfargument name="LCE_ID" type="numeric" required="false">
        <cfif len(trim(Drugtype)) GT 0 >
			<cfloop from="1" to="#ListLen(Drugtype)#" index="i">
                <cfquery name="qInsertDrugData" datasource="#variables.dsn#">
                   Insert into ST_DrugsAdministered  (Drugtype,DrugMethod,DrugTime,DrugDosage,DrugVolume,LCE_ID)
                    values
                    (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(Drugtype,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(DrugMethod,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(DrugTime,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(DrugDosage,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(DrugVolume,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_integer" value='#LCE_ID#'>
                    )
                </cfquery>
            </cfloop>
		</cfif>
		<cfreturn True>
	</cffunction>

    <cffunction name="InsertRespData"  returntype="any" output="false" access="remote" >
        <cfargument name="respRate" type="string" required="false">
        <cfargument name="respRateTime" type="string" required="false">
        <cfargument name="LCE_ID" type="numeric" required="false">
        <cfif len(trim(respRate)) GT 0 >
			<cfloop from="1" to="#ListLen(respRate)#" index="i">
                <cfquery name="qInsertRespData" datasource="#variables.dsn#">
                   Insert into ST_RespRate (respRate,respRateTime,LCE_ID)
                    values
                    (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(respRate,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(respRateTime,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_integer" value='#LCE_ID#'>
                    )
                </cfquery>
            </cfloop>
		</cfif>
		<cfreturn True>
	</cffunction>

    <cffunction name="InsertBiopsyData"  returntype="any" output="false" access="remote" >
        <cfargument name="BiopsyType" type="string" required="false">
        <cfargument name="BiopsyLocation" type="string" required="false">
        <cfargument name="BiopsySize" type="string" required="false">
        <cfargument name="LCE_ID" type="numeric" required="false" default="0">
        
            <cfif len(trim(BiopsyType)) GT 0 >
			<cfloop from="1" to="#ListLen(BiopsyType)#" index="i">
                <cfquery name="InsertBiopsyData" datasource="#variables.dsn#">
                    Insert into ST_Biopsy (LCE_ID,BiopsyType,BiopsyLocation,BiopsySize)values
                    (<cfqueryparam cfsqltype="cf_sql_integer" value='#LCE_ID#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(BiopsyType,i)#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(BiopsyLocation,i)#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(BiopsySize,i)#'>
                    )
                </cfquery>
            </cfloop>
		    </cfif>
		<cfreturn true>
	</cffunction>

    <cffunction name="InsertLesionData"  returntype="any" output="false" access="remote" >
        <cfargument name="LesionPresent" type="string" required="false" default="">
        <cfargument name="LesionType" type="string" required="false" default="">
        <cfargument name="Region" type="string" required="false" default="">
        <cfargument name="Side" type="string" required="false" default="">
        <cfargument name="Status" type="string" required="false" default="">
        <cfargument name="LCE_ID" type="numeric" required="false">
        <cfif len(trim(LesionPresent)) GT 0 >
			<cfloop from="1" to="#ListLen(LesionPresent)#" index="i">
                <cfquery name="qInsertLesionData" datasource="#variables.dsn#">
                   Insert into ST_Lesion (LesionPresent,LesionType,Region,Side,Status,LCE_ID)
                    values
                    (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(LesionPresent,i)#'>
                        <cfif ListGetAt(LesionType,i) eq 0>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value=''>
                        <cfelse>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(LesionType,i)#'>
                        </cfif>    
                        <cfif ListGetAt(Region,i) eq 0>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value=''>
                        <cfelse>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(Region,i)#'>
                        </cfif>    
                        <cfif ListGetAt(Side,i) eq 0>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value=''>
                        <cfelse>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(Side,i)#'>
                        </cfif>    
                        <cfif ListGetAt(Status,i) eq 0>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value=''>
                        <cfelse>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(Status,i)#'>
                        </cfif>    
                        ,<cfqueryparam cfsqltype="cf_sql_integer" value='#LCE_ID#'>
                    )
                </cfquery>
            </cfloop>
		</cfif>
		<cfreturn True>
	</cffunction>

    <cffunction name="InsertNotesData"  returntype="any" output="false" access="remote" >
        <cfargument name="LCE_ID" type="numeric" required="false">
        <cfargument name="maxNotes" type="numeric" required="false">
        <cfloop from="1" to="#maxNotes#" index="i">
        <cfset lp = 'extraNotes'&#i#>
        <cfquery name="qInsertNotesData" datasource="#variables.dsn#">

            Insert into ST_PhysicalExamNotes (LCE_ID,New_Secion)values
            (<cfqueryparam cfsqltype="cf_sql_integer" value='#LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#evaluate(lp)#'>
            )
        </cfquery>

        </cfloop>
		<cfreturn true>
	</cffunction>

    <cffunction name="UpdateNotesData"  returntype="any" output="false" access="remote" >
        <cfargument name="LCE_ID" type="numeric" required="false">
        
        <cfquery name="qst" datasource="#variables.dsn#">
           select * from ST_PhysicalExamNotes where LCE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#LCE_ID#'>
        </cfquery>
        <cfloop query="qst">
            <cfset lp = 'extraNotes'&#qst.currentrow#>
            <cfquery name="qUpdateNotesData" datasource="#variables.dsn#">
                Update  ST_PhysicalExamNotes set 
                New_Secion = <cfqueryparam cfsqltype="cf_sql_varchar" value='#evaluate(lp)#'>
                where
                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#qst.ID#'>
            </cfquery>
        </cfloop>
        <cfif form.maxNotes neq "">
            <cfset newadd = #qst.recordcount#+1>
            <cfloop index="index" from="#newadd#" to="#form.maxNotes#">
                <cfset lp = 'extraNotes'&#index#>
                <cfquery name="qInsertNotesData" datasource="#variables.dsn#">
                    Insert into ST_PhysicalExamNotes (LCE_ID,New_Secion)values
                    (<cfqueryparam cfsqltype="cf_sql_integer" value='#LCE_ID#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#evaluate(lp)#'>
                    )
                </cfquery>
            </cfloop>
        </cfif>
		<cfreturn true>
	</cffunction>

    <cffunction name="getFbAndSexOfCode" returnformat="JSON" returntype="any" output="false" access="remote" >
		
        <cfquery name="qgetFbAndSexOfCode" datasource="#Application.dsn#">
            SELECT Sex,FB_Number FROM Cetaceans  where ID = #Code_ID# 
        </cfquery>
		<cfreturn qgetFbAndSexOfCode>
	</cffunction>

    <cffunction name="getLCEID" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetLCEID" datasource="#variables.dsn#"  >
            SELECT ID,date from ST_LiveCetaceanExam where deleted != '1' order by ID DESC 
        </cfquery>
        <cfreturn qgetLCEID>
    </cffunction>

    <cffunction name="getLCEDate" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetLCEDate" datasource="#variables.dsn#"  >
            SELECT ID,date from ST_LiveCetaceanExam where deleted != '1' order by DATE DESC
        </cfquery>
        <cfreturn qgetLCEDate>
    </cffunction>

    <cffunction name="deleteCE" returntype="any" output="false" access="public" >
	
        <cfquery name="qdeleteCE" datasource="#variables.dsn#"  >
            Update ST_LiveCetaceanExam 
            set deleted = '1'
            where ID = #ID#
        </cfquery>
        <cfreturn True>
    </cffunction>
    <!--- <cffunction name="deleteCE" returntype="any" output="false" access="public" >
        <cfquery name="qdeleteCE" datasource="#variables.dsn#"  >
            Update ST_LiveCetaceanExam 
            set deleted = '1'
            where ID = #LCE_ID#
        </cfquery>
        <cfreturn True>
    </cffunction> --->
    <cffunction name="deleteCetaceanExamAllrecord" returntype="any" output="false" access="public" >
        <!--- ST_PhysicalExamNotes --->
        <!--- ST_HeartRate --->
        <!--- ST_RespRate --->
        <!--- ST_DrugsAdministered --->
        <!--- ST_Biopsy --->
        <!--- ST_Lesion ---> 
        <cfquery name="qdeleteCE" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_LiveCetaceanExam             
        </cfquery>
        <cfquery name="qdeleteCE1" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_PhysicalExamNotes             
        </cfquery>
        <cfquery name="qdeleteCE1" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_HeartRate             
        </cfquery>
        <cfquery name="qdeleteCE1" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_RespRate             
        </cfquery>
        <cfquery name="qdeleteCE1" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_DrugsAdministered             
        </cfquery>
        <cfquery name="qdeleteCE1" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_Biopsy             
        </cfquery>
        <cfquery name="qdeleteCE1" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_Lesion             
        </cfquery>
        <cfreturn True>
    </cffunction>

    <cffunction name="getLCEFBNumber" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetLCEFBNumber" datasource="#variables.dsn#"  >
            SELECT ID,Fnumber from ST_LiveCetaceanExam where deleted != '1' order by Fnumber ASC
        </cfquery>
        <cfreturn qgetLCEFBNumber>
    </cffunction>

    <cffunction name="getLiveCetaceanExamData" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetLiveCetaceanExamData" datasource="#variables.dsn#"  >
            SELECT * from ST_LiveCetaceanExam where ID = #LCEID# 
        </cfquery>
        <cfreturn qgetLiveCetaceanExamData>
    </cffunction>

    <cffunction name="getLCE_ten" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetLCE_ten" datasource="#variables.dsn#">
            SELECT *  FROM ST_LiveCetaceanExam where ID = 0
        </cfquery>
        <cfreturn qgetLCE_ten>
    </cffunction>

    <cffunction name="getHeartData" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetHeartData" datasource="#variables.dsn#">
            SELECT *  FROM ST_HeartRate where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetHeartData>
    </cffunction>

    <cffunction name="getRespData" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetRespData" datasource="#variables.dsn#">
            SELECT *  FROM ST_RespRate where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetRespData>
    </cffunction>

    <cffunction name="getDrugData" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetDrugData" datasource="#variables.dsn#">
            SELECT *  FROM ST_DrugsAdministered where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetDrugData>
    </cffunction>

    <cffunction name="getBiopsyData" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetBiopsyData" datasource="#variables.dsn#">
            SELECT *  FROM ST_Biopsy where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetBiopsyData>
    </cffunction>

    <cffunction name="getLesionData" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetLesionData" datasource="#variables.dsn#">
            SELECT *  FROM ST_Lesion where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetLesionData>
    </cffunction>
    <cffunction name="getNewSectionData" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetNewSectionData" datasource="#variables.dsn#">
            SELECT *  FROM ST_PhysicalExamNotes where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetNewSectionData>
    </cffunction>
    <!--- working  --->


    <cffunction name="uploadImage" returntype="any" output="false" access="remote" returnformat="plain">
<!---      <cfdump var="#name#" abort="true">  --->
        
        <CFTRY>       
        <cffile action = "upload"  
        fileField = "pdf"  
        destination = "#Application.CloudDirectory#/#name#"  
        accept="image/png,image/gif,image/jpeg,image/jpg,.png,.gif,.jpeg,.jpg"
        nameConflict = "MAKEUNIQUE"
        result="fileUploaded"
        > 
<!---     <cfdump var="#fileUploaded#" abort="true">  --->
        
        <CFSET BGFile = #fileUploaded.serverfile#>
        <CFCATCH type="any">
            <!--- <cfdump var="#CFCATCH#" abort="true"> --->
            <CFSET BGFile = "">
        </CFCATCH>
    </CFTRY>
<cfreturn BGFile>
</cffunction>
<!--- working --->
    <cffunction name="uploadpdf" returntype="string" output="false" access="remote" returnformat="plain">
        
        <cfif cgi.content_length LTE 10000000>
            <CFTRY>
                <cffile action = "upload"  
                fileField = "pdf"  
                destination = "#Application.CloudDirectory#"  
                accept = "application/pdf"  
                nameConflict = "MAKEUNIQUE"
                result="fileUploaded"
                > 
                <CFSET BGFile = #fileUploaded.serverfile#>
                <CFCATCH type="any">
                    <CFSET BGFile = "">
                </CFCATCH>
            </CFTRY>
        <cfelse>
            <CFSET BGFile = "False">
        </cfif>
        <cfreturn BGFile>
    </cffunction>

    <cffunction name="removepdf" returntype="string" output="false" access="remote" returnformat="plain">
        <cfquery name="removePdfFiles" datasource="#Application.dsn#" result = "results">
                update ST_LiveCetaceanExam set
                pdfFiles=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
        
                    where
                    ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                    
                </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
               
        <cfif len(trim(#pdf#))>
            <cfif FileExists("#Application.CloudDirectory&pdf#")>
                <cffile action = "delete" file = "#Application.CloudDirectory&pdf#">
            </cfif>
        </cfif>
        <cfreturn True>
    </cffunction>
    <cffunction name="removepdfHIForm" returntype="string" output="false" access="remote" returnformat="plain">
        <cfquery name="removePdfFiles" datasource="#Application.dsn#" result = "results">
                update ST_HIForm set
                pdfFiles=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
        
                    where
                    ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                    
                </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
               
        <cfif len(trim(#pdf#))>
            <cfif FileExists("#Application.CloudDirectory&pdf#")>
                <cffile action = "delete" file = "#Application.CloudDirectory&pdf#">
            </cfif>
        </cfif>
        <cfreturn True>
    </cffunction>
    <cffunction name="removepdfLAForm" returntype="string" output="false" access="remote" returnformat="plain">
        <cfquery name="removePdfFiles" datasource="#Application.dsn#" result = "results">
                update ST_LevelAForm set
                pdfFiles=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
        
                    where
                    ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                    
                </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
               
        <cfif len(trim(#pdf#))>
            <cfif FileExists("#Application.CloudDirectory&pdf#")>
                <cffile action = "delete" file = "#Application.CloudDirectory&pdf#">
            </cfif>
        </cfif>
        <cfreturn True>
    </cffunction>

    <cffunction name="removeToxifiles" returntype="string" output="false" access="remote" returnformat="plain">
        <cfquery name="removePdfFiles" datasource="#Application.dsn#" result = "results">
                update ST_Toxicology set
                pdfFiles=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
        
                    where
                    ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                    
                </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
               
        <cfif len(trim(#pdf#))>
            <cfif FileExists("#Application.CloudDirectory&pdf#")>
                <cffile action = "delete" file = "#Application.CloudDirectory&pdf#">
            </cfif>
        </cfif>
        <cfreturn True>
    </cffunction>

    <cffunction name="getCetaceanSpecies" returntype="any" output="false" access="public" >
         
        <cfquery name="qgetCetaceanSpecies" datasource="#variables.dsn#"  >
            SELECT * from TLU_CetaceanSpecies
        </cfquery>
        <cfreturn qgetCetaceanSpecies>
    </cffunction>

    <!---   HIForm Section    --->

    <cffunction name="HIFormInsert" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.GearCollected')>
            <cfset FORM.GearCollected = "">
        </cfif>
        <cfif NOT isDefined('FORM.TypeofHI')>
            <cfset FORM.TypeofHI = "">
        </cfif>
        <cfif NOT isDefined('FORM.LocationofHI')>
            <cfset FORM.LocationofHI = "">
        </cfif>
        <cfif NOT isDefined('FORM.TypeofGearCollected')>
            <cfset FORM.TypeofGearCollected = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        <!--- <cfif NOT isDefined('FORM.LCE_ID')>
            <cfset FORM.LCE_ID = "0">
        </cfif> --->
      
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_HIForm 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,species
            ,BodyOfWater
            ,NOAAStock
            ,StTpye
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,lat
            ,lon
            ,county
            ,InitialCondition
            ,FinalCondition
            ,BriefHistory
            ,CompletedBy
            ,pdfFiles
            ,Examtype
            ,ContributedtoStrandingEvent
            ,Hifindings
            ,affiliatedID
            ,actualClass
            ,LCE_ID            
            ,euthanizedCB            
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HIFormpdfFiles#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Examtype#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ContributedtoStrandingEvent#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hifindings#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
            )
        </cfquery>

        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LC = "#return_data.generatedkey#">
        
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn LC>
    </cffunction>
    <!--- working start --->

    <cffunction name="InsertHiExampData"  returntype="any" output="false" access="remote" >

            
        <cfargument name="HiType" type="string" required="false" default="">
        <cfargument name="HiLocation" type="string" required="false" default="">
        <cfargument name="gearCollected" type="string" required="false" default="">
        <cfargument name="typeOfGearCollected" type="string" required="false" default="">
        <cfargument name="gearDeposition" type="string" required="false" default="">
        <!--- <cfargument name="LCE_ID" type="numeric" required="false"> --->
        <!--- <cfdump var="#form.HiType#" abort="true"> --->
        <cfif len(trim(HiType)) GT 0 >
            
			<cfloop from="1" to="#ListLen(HiType)#" index="i">
                <cfquery name="qInsertHiExampData" datasource="#variables.dsn#">
                   Insert into ST_DynamicHI (TypeofHI,LocationofHI,GearCollected,TypeofGearCollected,GearDeposition,HI_ID)
                    values
                    (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(HiType,i)#'>
  
                        <cfif ListGetAt(HiLocation,i) eq 0>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value=''>
                        <cfelse>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(HiLocation,i)#'>
                        </cfif>    
                        
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(gearCollected,i)#'>
                           
                        <cfif ListGetAt(typeOfGearCollected,i) eq 0>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value=''>
                        <cfelse>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(typeOfGearCollected,i)#'>
                        </cfif>    
                        <cfif ListGetAt(gearDeposition,i) eq 0>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value=''>
                        <cfelse>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(gearDeposition,i)#'>
                        </cfif>
                        ,<cfqueryparam cfsqltype="cf_sql_integer" value='#form.LCE#'>
                    )
                </cfquery>
            </cfloop>
		</cfif>
		<cfreturn True>
	</cffunction>
    



    <cffunction name="getHiExamData" returntype="any" output="false" access="public" >
		
        <cfquery name="qgetHiExamData" datasource="#variables.dsn#">
            SELECT *  FROM ST_DynamicHI where HI_ID = #LCEID#
        </cfquery>
        
        <cfreturn qgetHiExamData>
    </cffunction>

    <cffunction name="deleteHiExam"  returntype="any" output="false" access="remote" returnformat="json">
        <!--- <cfdump var="#ID#" abort="true"> --->
        <cfquery name="qdeleteHiExam" datasource="#Application.dsn#">
            delete from ST_DynamicHI
            where ID = '#ID#'
        </cfquery>
        <!--- <cfdump var="#deleteLesion#"> --->
		<cfreturn True>
    </cffunction>
     
    <cffunction name="updateHiExam" access="remote" returntype="any" returnformat="json">
        <!--- <cfdump var="#ID#" abort="true"> --->
        <!--- <cfargument name="samplDate" type="any" required="yes"> --->
        <!--- <cfdump var="#TypeofHI#"> --->
        <!--- <cfdump var="#form.LesionPresent#">
        <cfdump var="#form.LesionType#">
        <cfdump var="#form.Side#">
        <cfdump var="#form.ID#">
        <cfabort> --->
        <!--- <cfexit> --->
        <cfquery name="qupdateHiExam" datasource="#Application.dsn#" >

            update ST_DynamicHI set
            TypeofHI=<cfqueryparam cfsqltype="cf_sql_varchar" value='#TypeofHI#' >
            ,LocationofHI=<cfqueryparam cfsqltype="cf_sql_varchar" value='#LocationofHI#'>
            ,TypeofGearCollected=<cfqueryparam cfsqltype="cf_sql_varchar" value='#TypeofGearCollected#'>
            ,GearDeposition=<cfqueryparam cfsqltype="cf_sql_varchar" value='#GearDeposition#'>
            ,GearCollected=<cfqueryparam cfsqltype="cf_sql_varchar" value='#GearCollected#'>
           
            
            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
            
        </cfquery>
      
		<cfreturn True>
    </cffunction>


    <cffunction name="updateAncillaryDiagnostics" access="remote" returntype="any" returnformat="json">
        
        <cfset DiagnosticTest = '#form.DiagnosticTest#'>
        <cfset TestResults = '#form.TestResults#'>
        <!--- <cfdump var="#form.name#" abort="true"> --->
        <cfif isDefined('form.pdf') and form.pdf neq 'undefined'>
            <cffile action = "upload"  
            fileField = "pdf"  
            destination = "#Application.CloudDirectory#"  
            accept = "application/pdf"  
            nameConflict = "MAKEUNIQUE"
            result="fileUploaded"
            >
            <cfset fileName = '#fileUploaded.serverfile#'>
        <cfelse>
          
            <cfset fileName = '#form.name#'>        
        </cfif>
        <cfquery name="qupdateupdateAncillaryDiagnostics" datasource="#Application.dsn#" result="resultss">

            update ST_Ancillary_Report set
           DiagnosticTest=<cfqueryparam cfsqltype="cf_sql_varchar" value='#DiagnosticTest#' >
           ,ADSampleType=<cfqueryparam cfsqltype="cf_sql_varchar" value='#AncillaryDiagnosticsSampleType#' >
            ,TestResults=<cfqueryparam cfsqltype="cf_sql_varchar" value='#TestResults#'>
            ,DiagnosticLab=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.DiagnosticLab#'>
            ,TestingDate=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TestingDate#'>         
            ,pdfFiles=<cfqueryparam cfsqltype="cf_sql_varchar" value='#fileName#'>           
            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
            
        </cfquery>

        
        <!--- <cfdump var="#resultss#"> --->
		<cfreturn True>
    </cffunction>
    
    <cffunction name="removeImage" returntype="string" output="false" access="remote" returnformat="plain">
        <cfquery name="updateImagesValue" datasource="#Application.dsn#" result = "results">
            update ST_CetaceanNecropsyReport set
                images=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
    
                where
                ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
    
            </cfquery>
        <cfif len(trim(#image#))>
            <cfif FileExists("#Application.CloudDirectory&image#")>
                <cffile action = "delete" file = "#Application.CloudDirectory&image#">
            </cfif>
        </cfif>
        <cfreturn True>
    </cffunction>
    <cffunction name="removeIntegumentImage" returntype="string" output="false" access="remote" returnformat="plain">
        <!--- <cfdump var=#ID# abort="true"> --->
        <cfquery name="updateImagesValue1" datasource="#Application.dsn#" result = "results">
        update ST_CetaceanNecropsyReport set
        integumentImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >

            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>

 </cfquery>
         <!--- <cfdump var=#results# abort="true"> --->
        <cfif len(trim(#image#))>
            <cfif FileExists("#Application.CloudDirectory&image#")>
                <cffile action = "delete" file = "#Application.CloudDirectory&image#">
            </cfif>
        </cfif>
        <cfreturn True>
    </cffunction>


    <cffunction name="removeIntenalExamImage" returntype="string" output="false" access="remote" returnformat="plain">
        <!--- <cfdump var=#ID# abort="true"> --->
        <cfquery name="IntenalExamImageValue" datasource="#Application.dsn#" result = "results">
        update ST_CetaceanNecropsyReport set
        IntenalExamImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >

            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
            
        </cfquery>
         <!--- <cfdump var=#results# abort="true"> --->
        <cfif len(trim(#image#))>
            <cfif FileExists("#Application.CloudDirectory&image#")>
                <cffile action = "delete" file = "#Application.CloudDirectory&image#">
            </cfif>
        </cfif>
        <cfreturn True>
    </cffunction>

    <cffunction name="removeHistoExamImage" returntype="string" output="false" access="remote" returnformat="plain">
        <!--- <cfdump var=#ID# abort="true"> --->
        <cfquery name="histoImageValue" datasource="#Application.dsn#" result = "results">
        update ST_CetaceanNecropsyReport set
        HistoImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >

            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
            
        </cfquery>
         <!--- <cfdump var=#results# abort="true"> --->
        <cfif len(trim(#image#))>
            <cfif FileExists("#Application.CloudDirectory&image#")>
                <cffile action = "delete" file = "#Application.CloudDirectory&image#">
            </cfif>
        </cfif>
        <cfreturn True>
    </cffunction>

    <cffunction name="historemovepdf" returntype="string" output="false" access="remote" returnformat="plain">

    <cfquery name="histoImageValue" datasource="#Application.dsn#" result = "results">
            update ST_CetaceanNecropsyReport set
            HistoImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
    
                where
                ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                
            </cfquery>
                <!--- <cfdump var=#results# abort="true"> --->
            <cfif len(trim(#image#))>
                <cfif FileExists("#Application.CloudDirectory&image#")>
                    <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                </cfif>
            </cfif>
          <cfreturn True>
    </cffunction>


        <cffunction name="removeThoracicImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="ThoracicImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    thoracictImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>


        <cffunction name="removeAbdominalImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="AbdominalImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    abdominalImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>

        <cffunction name="removeHepatobiliaryImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="AbdominalImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    hepatobiliaryImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>
        <cffunction name="removeCardiovascularImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="AbdominalImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    cardiovascularImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>
        <cffunction name="removePulmonaryImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="pulmonaryImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    pulmonaryImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>
        <cffunction name="removeLymphoreticularImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="LymphoreticularImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    lymphoreticularImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>
        <cffunction name="removeEndocrineImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="EndocrineImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    endocrineImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>
        <cffunction name="removeUrogenitalImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="UrogenitalImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    urogenitalImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>
        <cffunction name="removeAlimentaryImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="AlimentaryImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    alimentaryImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>
        <cffunction name="removeCentralNervousImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="centralNervousImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    centralNervousImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>
        <cffunction name="removemusculoskeletalImage" returntype="string" output="false" access="remote" returnformat="plain">

            <cfquery name="centralNervousImageValue" datasource="#Application.dsn#" result = "results">
                    update ST_CetaceanNecropsyReport set
                    musculoskeletalImages=<cfqueryparam cfsqltype="cf_sql_varchar" value='#imgValue#' >
            
                        where
                        ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
                        
                    </cfquery>
                        <!--- <cfdump var=#results# abort="true"> --->
                    <cfif len(trim(#image#))>
                        <cfif FileExists("#Application.CloudDirectory&image#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&image#">
                        </cfif>
                    </cfif>
                  <cfreturn True>
            </cffunction>

    <!--- working end --->



    <cffunction name="HIFormUpdate" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        
        <cfif NOT isDefined('FORM.TypeofHI')>
            <cfset FORM.TypeofHI = "">
        </cfif>
        <cfif NOT isDefined('FORM.LocationofHI')>
            <cfset FORM.LocationofHI = "">
        </cfif>
        <cfif NOT isDefined('FORM.TypeofGearCollected')>
            <cfset FORM.TypeofGearCollected = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
       
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif>     --->
        <cftry>
        <cfquery name="qHIFormUpdate" datasource="#variables.dsn#"  result="return_data" >
            UPDATE  ST_HIForm SET
            date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
            ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
            ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
            ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
            ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
            ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
            ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
            ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
            ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>
            ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
            ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
            ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,pdfFiles = <cfqueryparam cfsqltype="cf_sql_varchar" value='#HIFormpdfFiles#'>
            ,Examtype = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Examtype#'>
            ,TypeofHI = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TypeofHI#'>
            ,LocationofHI = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LocationofHI#'>
            ,ContributedtoStrandingEvent = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ContributedtoStrandingEvent#'>
            ,TypeofGearCollected = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TypeofGearCollected#'>
            ,GearDeposition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GearDeposition#'>
            ,GearCollected = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GearCollected#'>
            ,Hifindings = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hifindings#'>
            ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
            ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
            ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
            ,Deleted = <cfqueryparam cfsqltype="cf_sql_varchar" value='0'>
           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.HIForm_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- commented for now  this code for trail functionality--->
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif>     --->
        <cfreturn True>
    </cffunction>
    <cffunction name="getHIID" returntype="any" output="false" access="public" >
        <cfquery name="qgetHIID" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_HIForm where deleted != '1' order by ID DESC 
        </cfquery>
        <cfreturn qgetHIID>
    </cffunction>
    <cffunction name="getHIDate" returntype="any" output="false" access="public" >
        <cfquery name="qgetHIDate" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_HIForm where deleted != '1' order by DATE DESC
        </cfquery>
        <cfreturn qgetHIDate>
    </cffunction>
    <cffunction name="getHIFBNumber" returntype="any" output="false" access="public" >
        <cfquery name="qgetHIFBNumber" datasource="#Application.dsn#"  >
            SELECT ID,Fnumber from ST_HIForm where deleted != '1' order by Fnumber ASC
        </cfquery>
        <cfreturn qgetHIFBNumber>
    </cffunction>
    <cffunction name="getHIData" returntype="any" output="false" access="public" >
        <!--- <cfdump var="#HI_ID#" abort="true"> --->
        <cfquery name="qHIData" datasource="#Application.dsn#"  >
            SELECT * from ST_HIForm where ID = #HI_ID#
        </cfquery>
        <cfreturn qHIData>
    </cffunction>
    <!--- <cffunction name="getHIData" returntype="any" output="false" access="public" >
        <cfquery name="qHIData" datasource="#Application.dsn#"  >
            SELECT * from ST_HIForm where ID = #LCEID#
        </cfquery>
        <cfreturn qHIData>
    </cffunction> --->

    <cffunction name="getIdOfHI" returntype="any" output="false" access="public" >
        <cfquery name="qgetHIID" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_HIForm where ID = #ID#
        </cfquery>
        <cfreturn qgetHIID>
    </cffunction>
    <cffunction name="getIdOfLevelA" returntype="any" output="false" access="public" >
        <cfquery name="qgetLAID" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_LevelAForm where ID = #ID#
        </cfquery>
        <cfreturn qgetHIID>
    </cffunction>

    <cffunction name="deleteHI" returntype="any" output="false" access="public" >		
        <cfquery name="qdeleteHI" datasource="#variables.dsn#"  >
            Update ST_HIForm 
            set deleted = '1'
            where ID = #HIForm_ID#
        </cfquery>
        <cfreturn True>
    </cffunction>
    <cffunction name="deleteHiFormAllRecord" returntype="any" output="false" access="public" >		
    
        <cfquery name="qdeleteHiFormAllRecord" datasource="#variables.dsn#"  >
        TRUNCATE Table ST_HIForm             
        </cfquery>
        <cfquery name="qdeleteHiFormAllRecord1" datasource="#variables.dsn#"  >
        TRUNCATE Table ST_DynamicHI             
        </cfquery>
        <cfreturn True>
    </cffunction>
    <cffunction name="getHIDataByLCE" returntype="any" output="false" access="public" >
        <cfquery name="qgetHIDataByLCE" datasource="#Application.dsn#"  >
            SELECT * from ST_HIForm where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetHIDataByLCE>
    </cffunction>
    <cffunction name="getHI_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetHI_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_HIForm where ID = 0
        </cfquery>
        <cfreturn qgetHI_ten>
    </cffunction>
    <!---   Level A Section    --->

    <cffunction name="LevelAFormInsert" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.GroupEvent')>
            <cfset FORM.GroupEvent = "">
        </cfif>
        
        <cfif NOT isDefined('FORM.Restrand')>
            <cfset FORM.Restrand = "">
        </cfif>
        <cfif NOT isDefined('FORM.TagsWere')>
            <cfset FORM.TagsWere = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        

        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qLevelAFormInsert" datasource="#Application.dsn#"  result="return_data" >
                INSERT INTO ST_LevelAForm
                (
                date
                ,ResearchTeam
                ,Veterinarian
                ,species
                ,BodyOfWater
                ,NOAAStock
                ,StTpye
                ,Fnumber
                ,NMFS
                ,NDB
                ,NAA
                ,code
                ,hera
                ,sex
                ,ageClass
                ,Location
                ,lat
                ,lon
                ,county
                ,InitialCondition
                ,FinalCondition
                ,BriefHistory
                ,CompletedBy
                ,pdfFiles
                ,ILAD
                ,ILADComment
                ,CarcassStatus
                ,CarcassStatusLat
                ,CarcassStatusLon
                ,GroupEvent
                ,GroupEventType
                ,noOfAnimals
                ,TagsWere
                ,Restrand
                ,affiliatedID
                ,LCE_ID
                ,actualClass
                ,euthanizedCB
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LApdfFiles#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ILAD#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ILADComment#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CarcassStatus#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CarcassStatusLat#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CarcassStatusLon#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GroupEvent#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GroupEventType#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.noOfAnimals#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagsWere#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Restrand#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
                )
            </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset levelAForm = "#return_data.generatedkey#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn levelAForm>
    </cffunction>
    <cffunction name="LevelAFormUpdate" returntype="any" output="false" access="public" >
    <!--- <cfdump var="#Form#" abort="true"> --->
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.GroupEvent')>
            <cfset FORM.GroupEvent = "">
        </cfif>
        <cfif NOT isDefined('FORM.Restrand')>
            <cfset FORM.Restrand = "">
        </cfif>
        <cfif NOT isDefined('FORM.TagsWere')>
            <cfset FORM.TagsWere = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif>   --->
       
        <cftry>
        <cfquery name="qLevelAUpdateAll" datasource="#variables.dsn#">
             UPDATE  ST_LevelAForm SET
             date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
            ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
            ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
            ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
            ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
            ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
            ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
            ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
            ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>
            ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
            ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
            ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,pdfFiles = <cfqueryparam cfsqltype="cf_sql_varchar" value='#LApdfFiles#'>
            ,ILAD = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ILAD#'>
            ,ILADComment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ILADComment#'>
            ,CarcassStatus = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CarcassStatus#'>
            ,CarcassStatusLat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CarcassStatusLat#'>
            ,CarcassStatusLon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CarcassStatusLon#'>
            ,GroupEvent = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GroupEvent#'>
            ,GroupEventType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GroupEventType#'>
            ,noOfAnimals = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.noOfAnimals#'>
            ,TagsWere = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TagsWere#'>
            ,Restrand = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Restrand#'>
            ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
            ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
            ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
            ,Deleted = <cfqueryparam cfsqltype="cf_sql_varchar" value='0'>
           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LA_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn true>
    </cffunction>
    <cffunction name="getLevelAID" returntype="any" output="false" access="public" >
        <cfquery name="qgetLevelAID" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_LevelAForm where deleted != '1' order by ID DESC 
        </cfquery>
        <cfreturn qgetLevelAID>
    </cffunction>
    <cffunction name="getLevelADate" returntype="any" output="false" access="public" >
        <cfquery name="qgetLevelADate" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_LevelAForm where deleted != '1' order by DATE DESC
        </cfquery>
        <cfreturn qgetLevelADate>
    </cffunction>
    <cffunction name="getLevelAFBNumber" returntype="any" output="false" access="public" >
        <cfquery name="qgetLevelAFBNumber" datasource="#Application.dsn#"  >
            SELECT ID,Fnumber from ST_LevelAForm where deleted != '1' order by Fnumber ASC
        </cfquery>
        <cfreturn qgetLevelAFBNumber>
    </cffunction>
    <cffunction name="getLevelAData" returntype="any" output="false" access="public" >
        <cfquery name="qgetLevelAData" datasource="#Application.dsn#"  >
            SELECT * from ST_LevelAForm where ID = #LA_ID#
        </cfquery>
        <cfreturn qgetLevelAData>
    </cffunction>
    <!--- <cffunction name="getLevelAData" returntype="any" output="false" access="public" >
        <cfquery name="qgetLevelAData" datasource="#Application.dsn#"  >
            SELECT * from ST_LevelAForm where ID = #LCEID#
        </cfquery>
        <cfreturn qgetLevelAData>
    </cffunction> --->
    <cffunction name="getLevelADataByLCE" returntype="any" output="false" access="public" >
        <cfquery name="qgetLevelADataByLCE" datasource="#Application.dsn#"  >
            SELECT * from ST_LevelAForm where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetLevelADataByLCE>
    </cffunction>
    <cffunction name="getLevelA_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetLevelA_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_LevelAForm where ID = 0
        </cfquery>
        <cfreturn qgetLevelA_ten>
    </cffunction>
     <cffunction name="deleteLA" returntype="any" output="false" access="public" >
		
        <cfquery name="qdeleteLA" datasource="#variables.dsn#"  >
            Update ST_LevelAForm 
            set deleted = '1'
            where ID = #level_A_ID#
        </cfquery>
        <cfreturn True>
    </cffunction>
     <cffunction name="deleteAllLevelAFormRecord" returntype="any" output="false" access="public" >		
        <cfquery name="qdeleteAllLevelAFormRecord" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_LevelAForm  
        </cfquery>

        <cfreturn True>
    </cffunction>

    <!---   General Functions for Stranding Module   --->
    <cffunction name="UpdateLevelA_HI" returntype="any" output="false" access="public" >
        <!--- <cfdump var="#FORM#" abort="true"> --->
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLevelAUpdate4" datasource="#Application.dsn#">
                UPDATE  ST_LevelAForm SET
                <cfif not isdefined('bloodvalue_fields')>
                    date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>,
                    NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>,
                    NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>,
                    NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>,
                </cfif>                    
                <cfif not isdefined('histopathology_fields') and not isdefined('bloodvalue_fields')>
                    code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>,
                    hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>,
                    sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>,
                    ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>,
                    Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>,
                    lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>,
                    lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>,
                    county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>,
                    InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>,
                    FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>,
                    BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>,
                    pdfFiles = <cfqueryparam cfsqltype="cf_sql_varchar" value='#pdfFiles#'>,
                    affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>,
                </cfif>
                ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>,
                Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>,
                species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>,
                Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>,
                BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>,
                NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>,
                StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>,
                CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                WHERE
                LCE_ID = <cfqueryparam  value='#FORM.ID#'>
            </cfquery>
            <cfquery name="qHIUpdate4" datasource="#Application.dsn#">
                UPDATE  ST_HIForm SET
                <cfif not isdefined('bloodvalue_fields')>
                    date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>,
                    NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>,
                    NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>,
                    NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>,
                </cfif>    
                <cfif not isdefined('histopathology_fields') and not isdefined('bloodvalue_fields')>
                    code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>,
                    hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>,
                    sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>,
                    ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>,
                    Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>,
                    lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>,
                    lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>,
                    county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>,
                    InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>,
                    FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>,
                    BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>,
                    pdfFiles = <cfqueryparam cfsqltype="cf_sql_varchar" value='#pdfFiles#'>,
                    affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>,
                </cfif>
                ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>,
                Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>,
                species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>,
                Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>,
                BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>,
                NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>,
                StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                WHERE
                LCE_ID = <cfqueryparam  value='#FORM.ID#'>
            </cfquery>

            <cfquery name="qAncillaryUpdate4" datasource="#variables.dsn#">
            
                UPDATE  ST_Ancillary_Diagnostics SET
                <cfif not isdefined('bloodvalue_fields')>
                     date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>,
                    NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>,
                    NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>,
                    NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>,
                </cfif>
                ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>,
                Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>,
                species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>,
                BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>,
                NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>,
                StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>,
                Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>,
                CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                WHERE
                LCE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.ID#'>
            </cfquery>

            <cfquery name="qBloodValuesUpdate4" datasource="#variables.dsn#">
                UPDATE  ST_Blood_Values SET
                <cfif isdefined('blood_toxi')>
                    Analysis_date=<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Analysis_date#' null="#IIF(Analysis_date EQ "", true, false)#">,
                    Collection_Date=<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Collection_Date#' null="#IIF(Collection_Date EQ "", true, false)#">,
                    Diagnostic_Lab=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LabSentto#'>,
                    Lab_Number=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lab_num#'>,
                </cfif>
                ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                WHERE
                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.ID#'>
            </cfquery>

            <cfquery name="qToxicologyUpdate" datasource="#variables.dsn#"  result="return_data" >
                UPDATE  ST_Toxicology SET
                <cfif isdefined('blood_toxi')>
                    Analysis_date =<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Analysis_date#' null="#IIF(Analysis_date EQ "", true, false)#">,
                    Collection_Date=<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Collection_Date#' null="#IIF(Collection_Date EQ "", true, false)#">,
                    Diagnostic_Lab=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LabSentto#'>,
                    Lab_Number=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lab_num#'>,
                </cfif>
                ResearchTeam=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,Veterinarian=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,species=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,BodyOfWater=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,NOAAStock=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,StTpye=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,Fnumber=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                WHERE
                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.ID#'>
            </cfquery>
            <cfquery name="qHistoUpdate4" datasource="#variables.dsn#">
                UPDATE  ST_HistoForm SET
                <cfif not isdefined('bloodvalue_fields')>
                    date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>,
                    NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>,
                    NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>,
                    NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>,
                </cfif>
                ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>,
                Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>,
                species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>,
                BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>,
                NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>,
                StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>,
                Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>,
                CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                WHERE
                LCE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.ID#'>
            </cfquery>
            <cfquery name="qSmpleUpdate4" datasource="#variables.dsn#">
                UPDATE  ST_SampleArchive SET
                
                ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>,
                Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>,
                species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>,                
                BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>,
                NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>,
                StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>,               
                Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>,               
                CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                WHERE
                LCE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.ID#'>
            </cfquery>
            <cfcatch type="any">
                <cfif #cfcatch.Detail# neq '[Macromedia][SQLServer JDBC Driver][SQLServer]String or binary data would be truncated.'>
                    <cfdump  var="#cfcatch#"><cfabort>
                </cfif>
            </cfcatch>
        </cftry>
        <cfreturn true>
    </cffunction>
    <!--- <cffunction name="UpdateCetacean4Sections" returntype="any" output="false" access="public" >
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qUpdateCetacean4Sections" datasource="#Application.dsn#">
            UPDATE  ST_LiveCetaceanExam SET
           ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>,
           Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>,
           species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>,
           Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>,
           BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>,
           NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>,
           StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
           <cfif !isDefined('Form.bloodvalue_fields')>
                , date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>,
                NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>,
                NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>,
                NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>,
                CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
            </cfif>
           
            <cfif !isDefined('FORM.check')>
                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>,
                hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>,
                sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>,
                ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>,
                Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>,
                lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>,
                lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>,
                county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>,
                InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>,
                FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>,
                BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>,
                pdfFiles = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pdfFiles#'>,
                affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
            </cfif>
           WHERE
           ID = <cfqueryparam  value='#FORM.LCE_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfreturn true>
    </cffunction> --->

    <!-------Histopathology form insert---------->

    <cffunction name="HistoFormInsert" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.GroupEvent')>
            <cfset FORM.GroupEvent = "">
        </cfif>
        <cfif NOT isDefined('FORM.Restrand')>
            <cfset FORM.Restrand = "">
        </cfif>
        <cfif NOT isDefined('FORM.TagsWere')>
            <cfset FORM.TagsWere = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0 >
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qHistopathologyFormInsert" datasource="#Application.dsn#"  result="return_data" >
                INSERT INTO ST_HistoForm
                (
                date
                ,ResearchTeam
                ,Veterinarian
                ,species
                ,BodyOfWater
                ,NOAAStock
                ,StTpye
                ,Fnumber
                ,NMFS
                ,NDB
                ,NAA
                ,LCE_ID
                ,histoDate
                ,PathologistAccession                
                ,SampleComments
                ,code
                ,hera
                ,sex
                ,ageClass
                ,Location
                ,lat
                ,lon
                ,county
                ,InitialCondition
                ,FinalCondition
                ,affiliatedID
                ,actualClass
                ,BriefHistory
                ,euthanizedCB
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                ,<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.HISTOPATHOLOGYDATE#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PATHOLOGISTACCESSION#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Trim(FORM.SAMPLECOMMENTSS)#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
                )
            </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset HI_ID = "#return_data.generatedkey#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn HI_ID>
    </cffunction>
    <!---update Histopathology form --->
    <cffunction name="HistoFormUpdate" returntype="any" output="false" access="public" >

        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.GroupEvent')>
            <cfset FORM.GroupEvent = "">
        </cfif>
        <cfif NOT isDefined('FORM.Restrand')>
            <cfset FORM.Restrand = "">
        </cfif>
        <cfif NOT isDefined('FORM.TagsWere')>
            <cfset FORM.TagsWere = "">
        </cfif>
        <cfif NOT isDefined('FORM.species')>
            <cfset FORM.species = "">
        </cfif>
        <cfif NOT isDefined('FORM.StTpye')>
            <cfset FORM.StTpye = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>

         <!--- <cfdump var="#form#" abort="true"> --->
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!---this logic will update the data in all stranding forms,however u do change something in anyone form--->
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif>     --->
        <cftry>
        <cfquery name="qHistoFormUpdate" datasource="#variables.dsn#"  result="return_data" >
            UPDATE  ST_HistoForm SET
            date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
            ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
            ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
            ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
            ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
            ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
            ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
            ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
            ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>
            ,histoDate = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.HISTOPATHOLOGYDATE#'>
            ,PathologistAccession = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PATHOLOGISTACCESSION#'>
            ,SampleComments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Trim(FORM.SAMPLECOMMENTSS)#'>
            ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
            ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
            ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
            ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
            ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
            ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.Histo_ID#'>
        </cfquery>
        
        <cfcatch>
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn true>
      <!--- <cfreturn True> --->
    </cffunction>
        <!--- Insert Histo Sample data --->
    <cffunction name="InsertHistopathologySampleData"  returntype="any" output="false" access="remote" >
        <cfargument name="SampleType" type="string" required="false">
        <cfargument name="SampleNote" type="string" required="false">
        <cfargument name="DLID" type="string" required="false">
        <cfargument name="HI_ID" type="numeric" required="false">
        <cfif len(trim(SampleType)) GT 0 >
			<cfloop from="1" to="#ListLen(SampleType)#" index="i">
                <cfquery name="qInsertHistopathologySampleData" datasource="#variables.dsn#">
                   Insert into ST_HistoSampleData  (SampleType,SampleNote,DiagnosticLab,HI_ID)
                    values
                    (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(SampleType,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(SampleNote,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(DLID,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_integer" value='#HI_ID#'>
                    )
                </cfquery>
            </cfloop>
		</cfif>
		<cfreturn True>
    </cffunction>

    <!--- get Histo Sample data --->
    <cffunction name="getHistoSampleData" returntype="any" output="false" access="public" >
        <cfquery name="qgetHistoSampleData" datasource="#variables.dsn#">
            SELECT *  FROM ST_HistoSampleData where HI_ID = #HI_ID#
        </cfquery>
        <cfreturn qgetHistoSampleData>
    </cffunction>
    
    <cffunction name="getHistoID" returntype="any" output="false" access="public" >
        <cfquery name="qgetHistoID" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_HistoForm where deleted != '1' order by ID DESC 
        </cfquery>
        <cfreturn qgetHistoID>
    </cffunction>
    <cffunction name="getHistoDate" returntype="any" output="false" access="public" >
        <cfquery name="qgetHistoDate" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_HistoForm where deleted != '1' order by DATE DESC
        </cfquery>
        <cfreturn qgetHistoDate>
    </cffunction>
    <cffunction name="getHistoFBNumber" returntype="any" output="false" access="public" >
        <cfquery name="qgetHistoFBNumber" datasource="#Application.dsn#"  >
            SELECT ID,Fnumber from ST_HistoForm where deleted != '1' order by Fnumber ASC
        </cfquery>
        <cfreturn qgetHistoFBNumber>
    </cffunction>
    <cffunction name="getHistoData" returntype="any" output="false" access="public" >
        <cfquery name="qHistoData" datasource="#Application.dsn#"  >
            SELECT * from ST_HistoForm where ID = #His_ID#
        </cfquery>
        <cfreturn qHistoData>
    </cffunction>
    <!--- <cffunction name="getHistoData" returntype="any" output="false" access="public" >
        <cfquery name="qHistoData" datasource="#Application.dsn#"  >
            SELECT * from ST_HistoForm where ID = #LCEID#
        </cfquery>
        <cfreturn qHistoData>
    </cffunction> --->
    <cffunction name="getHisto_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetHisto_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_HistoForm where ID = 0
        </cfquery>
        <cfreturn qgetHisto_ten>
    </cffunction>
    <cffunction name="getHistoDataByLCE" returntype="any" output="false" access="public" >
        <cfquery name="qgetHistoDataByLCE" datasource="#Application.dsn#"  >
            SELECT * from ST_HistoForm where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetHistoDataByLCE>
    </cffunction>
    <cffunction name="deleteHisto" returntype="any" output="false" access="public" >
        <cfquery name="qdeleteHisto" datasource="#variables.dsn#"  >
            Update ST_HistoForm 
            set deleted = '1'
            where ID = #Histo_ID#
        </cfquery>
        <cfreturn True>
    </cffunction>
    <cffunction name="deleteHIstoRecord" returntype="any" output="false" access="public" >
        <cfquery name="qdeleteHIstoRecord" datasource="#variables.dsn#"  >
          TRUNCATE Table ST_HistoForm  
        </cfquery>
        <cfquery name="qdeleteHIstoRecord1" datasource="#variables.dsn#"  >
          TRUNCATE Table ST_HistoSampleData  
        </cfquery>
        <cfreturn True>
    </cffunction>

    <!-------Blood Values form insert---------->

    <cffunction name="Blood_VFormInsert" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.GroupEvent')>
            <cfset FORM.GroupEvent = "">
        </cfif>
        <cfif NOT isDefined('FORM.Restrand')>
            <cfset FORM.Restrand = "">
        </cfif>
        <cfif NOT isDefined('FORM.TagsWere')>
            <cfset FORM.TagsWere = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>

        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0 >
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qBloodValuesFormInsert" datasource="#Application.dsn#"  result="return_data" >
                INSERT INTO ST_Blood_Values
                (
                Analysis_date
                ,ResearchTeam
                ,Veterinarian
                ,species
                ,Collection_Date
                ,BodyOfWater
                ,NOAAStock
                ,StTpye
                ,Diagnostic_Lab
                ,Fnumber
                ,Lab_Number
                ,LCE_ID
                ,NMFS
                ,NDB
                ,NAA
		        ,code
                ,hera
                ,sex
                ,ageClass
                ,Location
                ,lat
                ,lon
                ,county
                ,InitialCondition
                ,FinalCondition
                ,affiliatedID
                ,actualClass
                ,date
                ,BriefHistory
                ,euthanizedCB
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Analysis_date#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Collection_Date#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LabSentto#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lab_num#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
		        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>  
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
                )
            </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset BV_ID = "#return_data.generatedkey#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn BV_ID>
    </cffunction>
    <!--- Insert Toxicology form --->
    <cffunction name="Toxicology_FormInsert" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0 >
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qToxicology_FormInsert" datasource="#Application.dsn#"  result="return_data" >
                INSERT INTO ST_Toxicology
                (
                Analysis_date
                ,ResearchTeam
                ,Veterinarian
                ,species
                ,Collection_Date
                ,BodyOfWater
                ,NOAAStock
                ,StTpye
                ,Diagnostic_Lab
                ,Fnumber
                ,Lab_Number
                ,LCE_ID
                ,NMFS
                ,NDB
                ,NAA
		        ,code
                ,hera
                ,sex
                ,ageClass
                ,Location
                ,lat
                ,lon
                ,county
                ,InitialCondition
                ,FinalCondition
                ,affiliatedID
                ,actualClass
                ,date
                ,BriefHistory
                ,euthanizedCB
                ,pdfFiles
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Analysis_date#' null="#IIF(Analysis_date EQ "", true, false)#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Collection_Date#' null="#IIF(Collection_Date EQ "", true, false)#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LabSentto#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lab_num#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
		        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.toxipdfFiles#'>
                )
            </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset Toxi_ID = "#return_data.generatedkey#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn Toxi_ID>
    </cffunction>
    <!--- update toxicology form --->
    <cffunction name="Toxicology_FormUpdate" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!---this logic will update the data in all stranding forms,however u do change something in anyone form--->
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qToxicologyUpdate" datasource="#variables.dsn#"  result="return_data" >
                UPDATE  ST_Toxicology SET
                Analysis_date =<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Analysis_date#' null="#IIF(Analysis_date EQ "", true, false)#">
                ,ResearchTeam=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,Veterinarian=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,species=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,Collection_Date=<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Collection_Date#' null="#IIF(Collection_Date EQ "", true, false)#">
                ,BodyOfWater=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,NOAAStock=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,StTpye=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,Diagnostic_Lab=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LabSentto#'>
                ,Fnumber=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,Lab_Number=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lab_num#'>
                ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
                ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
                ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>
                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
                ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
                ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
                ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
                ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
                ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
                ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
                ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
                ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
                ,pdfFiles = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.toxipdfFiles#'>
                WHERE
                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TX_ID#'>
            </cfquery>
            <cfcatch>
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn true>
    </cffunction>
    <!--- get toxiform --->
    <cffunction name="gettoxiform" returntype="any" output="false" access="public" >
        <cfquery name="qtoxiform" datasource="#Application.dsn#"  >
            SELECT * from ST_Toxicology where ID = #Toxicology_ID#
        </cfquery>
        <cfreturn qtoxiform>
    </cffunction>
    
      <cffunction name="gettoxiform_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgettoxiform_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_Toxicology where ID = 0
        </cfquery>
        <cfreturn qgettoxiform_ten>
    </cffunction>
    <!--- get toxiform by id fn,date --->
    <cffunction name="gettoxiform_ID" returntype="any" output="false" access="public" >
        <cfquery name="qgettoxiformID" datasource="#Application.dsn#"  >
            SELECT ID,Analysis_date from ST_Toxicology where deleted != '1' order by ID DESC 
        </cfquery>
        <cfreturn qgettoxiformID>
    </cffunction>
    
    <cffunction name="gettoxiformDate" returntype="any" output="false" access="public" >
        <cfquery name="qgettoxiformDate" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_Toxicology where deleted != '1' order by date DESC
        </cfquery>
        <cfreturn qgettoxiformDate>
    </cffunction>

    <cffunction name="gettoxifNumber" returntype="any" output="false" access="public" >
        <cfquery name="qgettoxifNumber" datasource="#Application.dsn#"  >
            SELECT ID,Fnumber from ST_Toxicology where deleted != '1' order by Fnumber ASC
        </cfquery>
        <cfreturn qgettoxifNumber>
    </cffunction>
    <!--- get toxi type --->
     <cffunction name="getToxitype" returntype="any" output="false" access="public" >
        <cfquery name="qgetToxitype" datasource="#Application.dsn#">
            SELECT * from ST_ToxiType where Tissue_type = '#Tissue_type#' and Toxi_ID = '#TX_ID#'
        </cfquery>
        <cfreturn qgetToxitype>
    </cffunction>
     <cffunction name="getTissueTypeForTable" returntype="any" output="false" access="public" >
        <cfquery name="qgetTissueTypeForTable" datasource="#Application.dsn#">
            SELECT * from ST_ToxiType where Toxi_ID = '#Toxicology_ID#'
        </cfquery>
        <cfreturn qgetTissueTypeForTable>
    </cffunction>

    <cffunction name="getToxitype_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetToxitype_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_ToxiType where ID = 0
        </cfquery>
        <cfreturn qgetToxitype_ten>
    </cffunction>
    <!--- insert toxicology type form --->
    <cffunction name="ToxiType_Insert" returntype="any" output="false" access="public">
    
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT ID,Type from TLU_Sample_Type where ID = '#Tissue_type#'
        </cfquery>
        <!--- <cfdump var="#form#" abort="true"> --->
        <cfset FORM.LCE_ID = '0'>
        <cfif isDefined('FORM.Tissue_type') and FORM.Tissue_type neq ''>
        <cftry>
            <cfquery name="qToxiType_Insert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO ST_ToxiType
            (
                Tissue_type
                ,Arsenic
                ,quantity_toxi
                ,Cadmium
                ,Lead
                ,Mercury
                ,Thallium
                ,Selenium
                ,Iron
                ,Copper
                ,Zinc
                ,Molybdenum
                ,Manganese
                ,Cobalt
                ,LCE_ID
                ,Toxi_ID
                ,toxiTypeName
            )
            VALUES
            (   
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Tissue_type#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Arsenic#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.quantity_toxi#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cadmium#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lead#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Mercury#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Thallium#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Selenium#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Iron#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Copper#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Zinc#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Molybdenum#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Manganese#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cobalt#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.Toxi_ID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#qgetType.Type#'>
            )   
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset TT_ID = "#return_data.generatedkey#">
        <cfreturn TT_ID>
        </cfif>
    </cffunction>
    <!--- update toxi type --->
    <cffunction name="ToxiType_FormUpdate" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT ID,Type from TLU_Sample_Type where ID = '#Tissue_type#'
        </cfquery>
            <!--- <cfdump var="#qgetType#" abort="true"> --->
        <cftry>
            <cfquery name="qToxiType_FormUpdate" datasource="#variables.dsn#"  result="return_data" >
                UPDATE  ST_ToxiType SET
                Tissue_type =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Tissue_type#'>
                ,Arsenic = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Arsenic#'>
                ,quantity_toxi = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.quantity_toxi#'>
                ,Cadmium = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cadmium#'>
                ,Lead = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lead#'>
                ,Mercury = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Mercury#'>
                ,Thallium = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Thallium#'>
                ,Selenium = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Selenium#'>
                ,Iron = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Iron#'>
                ,Copper = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Copper#'>
                ,Zinc = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Zinc#'>
                ,Molybdenum = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Molybdenum#'>
                ,Manganese = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Manganese#'>
                ,Cobalt = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cobalt#'>
                WHERE
                Tissue_type = <cfqueryparam cfsqltype="cf_sql_integer" value='#Tissue_type#'> and
                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#toxi_type_ID#'>
            </cfquery>
            <cfcatch>
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn true>
    </cffunction>
    <!--- delete toxicology form --->
    <cffunction name="deletToxicology" returntype="any" output="false" access="public" >
        <cfquery name="qdeletToxicology" datasource="#variables.dsn#"  >
            Update ST_Toxicology 
            set deleted = '1'
            where ID = #TX_ID#
        </cfquery>
        <cfreturn True>
    </cffunction>
    <cffunction name="deleteToxicologyAllRecord" returntype="any" output="false" access="public" >
        <cfquery name="qdeleteToxicologyAllRecord" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_Toxicology  
        </cfquery>
        <cfquery name="qdeleteToxicologyAllRecord1" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_ToxiType  
        </cfquery>
        <cfquery name="qdeleteToxicologyAllRecord2" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_Dynamic_toxi  
        </cfquery>
        <cfreturn True>
    </cffunction>
    <!--- Insert dynamic toxi type--->
    <cffunction name="DynamicToxiType_Insert" returntype="any" output="false" access="public">

        <!--- <cfdump var="#form#"> --->
        <cfargument name="toxi_label" type="string" default="" required="false">
        <cfargument name="toxi_type" type="string" default="" required="false">
        <cfargument name="toxi_range" type="string" default="" required="false">
        <cfargument name="toxi_report" type="string" default="" required="false">
        <cftry>
            <cfif len(trim(toxi_label)) GT 0 >
                <cfloop from="1" to="#ListLen(toxi_label)#" index="i">
                    <cfquery name="qDynamicToxiType_Insert" datasource="#variables.dsn#"  result="return_data" >
                        INSERT INTO ST_Dynamic_toxi
                        (
                            Label
                            ,Toxi_type
                            ,Tissue_type
                            ,LCE_ID
                            ,Toxi_ID
                        )
                        VALUES
                        (   
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(toxi_label,i)#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(toxi_type,i)#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Tissue_type#'>
                            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.Toxi_ID#'>
                        )   
                    </cfquery>
                </cfloop>
            </cfif>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
<!---         <cfset DT_ID = "#return_data.generatedkey#"> --->
<!---         <cfreturn DT_ID> --->
    </cffunction>
    <!--- Update dynamic toxi type --->
    <cffunction name="Update_DynamicToxiType" returntype="any" output="false" access="public">
        <!--- <cfargument name="toxilabel" type="string" default="" required="false">
        <cfargument name="toxitype" type="string" default="" required="false">
        <cfargument name="toxirange" type="string" default="" required="false">
        <cfargument name="toxireport" type="string" default="" required="false"> --->
  
        <cftry>
            <cfquery name="qstoxi" datasource="#variables.dsn#">
                select * from ST_Dynamic_toxi 
                where Tissue_type = '#Tissue_type#' and Toxi_Id = '#TX_ID#'
             </cfquery>
             <cfdump var="#qstoxi#">
             <cfloop query="qstoxi">
                <cfset lp = 'toxitype'&#qstoxi.ID#>
                <cfdump var ="#lp#">
                <cfquery name="qUpdate_DynamicToxiType" datasource="#variables.dsn#"  result="return_data" >
                    UPDATE  ST_Dynamic_toxi SET
                        Toxi_type= <cfqueryparam cfsqltype="cf_sql_varchar" value='#evaluate(lp)#'>
                        ,LCE_ID= <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                        Where
                        ID= <cfqueryparam cfsqltype="cf_sql_integer" value='#qstoxi.ID#'> 
                </cfquery>
            </cfloop>
            
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn true>
    </cffunction>
    <!--- get dynamic toxi type --->
    <cffunction name="getDynamicToxitype" returntype="any" output="false" access="public" >
        <cfquery name="qgetDynamicToxitype" datasource="#Application.dsn#">
            SELECT * from ST_Dynamic_toxi where Tissue_type = '#Tissue_type#' and Toxi_ID = '#TX_ID#'
        </cfquery>
        <cfreturn qgetDynamicToxitype>
    </cffunction>

    <cffunction name="getDynamicToxitype_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetDynamicToxitype_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_Dynamic_toxi where ID = 0
        </cfquery>
        <cfreturn qgetDynamicToxitype_ten>
    </cffunction>
    <!--- Insert CBC form  (Blood Values) --->
    <cffunction name="CBCInsert" returntype="any" output="false" access="public" >
        <!--- <cfdump var="#form#" abort="true"> --->
        <cftry>
            <cfquery name="qCBCInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO ST_CBC
            (
            wbc_count
            ,RBC_count
            ,Hemoglobin
            ,Hematocrit
            ,MCV
            ,MCH
            ,MCHC
            ,Segmented_Neutrophils_Abs
            ,Band_Neutrophils_Abs
            ,Lymphocytes_Abs
            ,Monocytes_Abs
            ,Eosinophils_Abs
            ,Basophils_Abs
            ,NRBC
            ,RBC_Morphology
            ,Platelet_Count
            ,Platelet_Morphology
            ,WBC_Morphology
            ,LCE_ID
            ,BV_ID
            ,wbc_report
            ,wbc_comment
            ,RBC_report  
            ,RBC_comment
            ,Hemoglobin_report
            ,Hemoglobin_comment
            ,Hematocrit_report
            ,Hematocrit_comment
            ,MCV_report
            ,MCV_comment
            ,MCH_report
            ,MCH_comment
            ,MCHC_report
            ,MCHC_comment
            ,Segmented_report
            ,Segmented_comment
            ,Band_Neutrophils_report
            ,Band_Neutrophils_comment
            ,Lymphocytes_report
            ,Lymphocytes_comment
            ,Monocytes_report
            ,Monocytes_comment
            ,Eosinophils_report	
            ,Eosinophils_comment
            ,Basophils_report
            ,Basophils_comment
            ,NRBC_report
            ,NRBC_comment
            ,RBC_count_report
            ,RBC_count_comment
            ,Platelet_Count_report
            ,Platelet_Count_comment
            ,Platelet_report
            ,Platelet_comment
            ,WBCMorphology_report
            ,WBCMorphology_comment
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.wbc_count#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_count#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hemoglobin#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hematocrit#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCV#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCH#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCHC#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Segmented_Neutrophils_Abs#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Band_Neutrophils_Abs#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lymphocytes_Abs#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Monocytes_Abs#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Eosinophils_Abs#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Basophils_Abs#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NRBC#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_Morphology#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_Count#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_Morphology#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.WBC_Morphology#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.wbc_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.wbc_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hemoglobin_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hemoglobin_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hematocrit_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hematocrit_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCV_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCV_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCH_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCH_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCHC_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCHC_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Segmented_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Segmented_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Band_Neutrophils_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Band_Neutrophils_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lymphocytes_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lymphocytes_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Monocytes_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Monocytes_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Eosinophils_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Eosinophils_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Basophils_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Basophils_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NRBC_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NRBC_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_count_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_count_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_Count_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_Count_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_comment#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.WBCMorphology_report#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.WBCMorphology_comment#'>
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset CBC_ID = "#return_data.generatedkey#">
        <cfreturn CBC_ID>
    </cffunction>
    <!--- Update CBC --->
    <cffunction name="CBCUpdate" returntype="any" output="false" access="public" >
            
        <cfquery name="qgetBloodValueinsert" datasource="#Application.dsn#">
            SELECT ID from ST_CBC where BV_ID = #form.bloodValues_ID#
        </cfquery>

        <cfif isDefined('qgetBloodValueinsert.ID') and qgetBloodValueinsert.ID eq "">
            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                INSERT INTO ST_CBC
                (
                    BV_ID                                 
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bloodValues_ID#'>
                )
            </cfquery>
        </cfif>

        <cftry>
        <cfquery name="qCBCUpdate" datasource="#variables.dsn#"  result="return_data" >
            UPDATE  ST_CBC SET
            wbc_count = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.wbc_count#'>
            ,RBC_count = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_count#'>
            ,Hemoglobin = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hemoglobin#'>
            ,Hematocrit =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hematocrit#'>
            ,MCV =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCV#'>
            ,MCH =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCH#'>
            ,MCHC =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCHC#'>
            ,Segmented_Neutrophils_Abs =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Segmented_Neutrophils_Abs#'>
            ,Band_Neutrophils_Abs =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Band_Neutrophils_Abs#'>
            ,Lymphocytes_Abs =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lymphocytes_Abs#'>
            ,Monocytes_Abs =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Monocytes_Abs#'>
            ,Eosinophils_Abs =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Eosinophils_Abs#'>
            ,Basophils_Abs =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Basophils_Abs#'>
            ,NRBC =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NRBC#'>
            ,RBC_Morphology =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_Morphology#'>
            ,Platelet_Count =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_Count#'>
            ,Platelet_Morphology =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_Morphology#'>
            ,WBC_Morphology =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.WBC_Morphology#'>
            ,wbc_report =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.wbc_report#'>
            ,wbc_comment =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.wbc_comment#'>
            ,RBC_report   =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_report#'>
            ,RBC_comment =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_comment#'>
            ,Hemoglobin_report =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hemoglobin_report#'>
            ,Hemoglobin_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hemoglobin_comment#'>
            ,Hematocrit_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hematocrit_report#'>
            ,Hematocrit_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hematocrit_comment#'>
            ,MCV_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCV_report#'>
            ,MCV_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCV_comment#'>
            ,MCH_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCH_report#'>
            ,MCH_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCH_comment#'>
            ,MCHC_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCHC_report#'>
            ,MCHC_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MCHC_comment#'>
            ,Segmented_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Segmented_report#'>
            ,Segmented_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Segmented_comment#'>
            ,Band_Neutrophils_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Band_Neutrophils_report#'>
            ,Band_Neutrophils_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Band_Neutrophils_comment#'>
            ,Lymphocytes_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lymphocytes_report#'>
            ,Lymphocytes_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lymphocytes_comment#'>
            ,Monocytes_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Monocytes_report#'>
            ,Monocytes_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Monocytes_comment#'>
            ,Eosinophils_report	 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Eosinophils_report#'>
            ,Eosinophils_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Eosinophils_comment#'>
            ,Basophils_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Basophils_report#'>
            ,Basophils_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Basophils_comment#'>
            ,NRBC_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NRBC_report#'>
            ,NRBC_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NRBC_comment#'>
            ,RBC_count_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_count_report#'>
            ,RBC_count_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RBC_count_comment#'>
            ,Platelet_Count_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_Count_report#'>
            ,Platelet_Count_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_Count_comment#'>
            ,Platelet_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_report#'>
            ,Platelet_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Platelet_comment#'>
            ,WBCMorphology_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.WBCMorphology_report#'>
            ,WBCMorphology_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.WBCMorphology_comment#'>
           WHERE
           BV_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.bloodValues_ID#'>
        </cfquery>
        <cfcatch>
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
      <cfreturn True>
    </cffunction>
    <!--- get data CBC form --->
    <cffunction name="getCBC_Data" returntype="any" output="false" access="public" >
        <cfquery name="qgetCBC_Data" datasource="#Application.dsn#">
            SELECT * from ST_CBC where BV_ID = #bloodID#
        </cfquery>
        <cfreturn qgetCBC_Data>
    </cffunction>

    <cffunction name="getCBC_Data_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetCBC_Data_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_CBC where ID = 0
        </cfquery>
        <cfreturn qgetCBC_Data_ten>
    </cffunction>
    <!--- update Fibrinogen --->
    <cffunction name="FibrinogenUpdate" returntype="any" output="false" access="public" >
        <cfquery name="qgetBloodValueinsert" datasource="#Application.dsn#">
            SELECT ID from ST_Fibrinogen where BV_ID = #form.bloodValues_ID#
        </cfquery>

        <cfif isDefined('qgetBloodValueinsert.ID') and qgetBloodValueinsert.ID eq "">
            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                INSERT INTO ST_Fibrinogen
                (
                    BV_ID                                 
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bloodValues_ID#'>
                )
            </cfquery>
        </cfif>
        <cftry>
        <cfquery name="qFibrinogenUpdate" datasource="#variables.dsn#"  result="return_data" >
            UPDATE  ST_Fibrinogen SET
            Fibrinogen=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fibrinogen#'>
            ,Fibrinogen_report=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fibrinogen_report#'>
            ,Fibrinogen_comment=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fibrinogen_comment#'>
           WHERE
           BV_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.bloodValues_ID#'>
        </cfquery>
        <cfcatch>
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
      <cfreturn True>
    </cffunction>
    <!--- get Fibrinogen form --->
    <cffunction name="getFibrinogen" returntype="any" output="false" access="public" >
        <cfquery name="qgetFibrinogen" datasource="#Application.dsn#">
            SELECT * from ST_Fibrinogen where BV_ID = #bloodID#
        </cfquery>
        <cfreturn qgetFibrinogen>
    </cffunction>

    <cffunction name="getFibrinogen_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetFibrinogen_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_Fibrinogen where ID = 0
        </cfquery>
        <cfreturn qgetFibrinogen_ten>
    </cffunction>
    <!--- update chimestry --->
    <cffunction name="ChemisteryUpdate" returntype="any" output="false" access="public" >
        <!--- <cfdump var="#form#" abort="true"> --->
        <cfquery name="qgetBloodValueinsert" datasource="#Application.dsn#">
            SELECT ID from ST_chemistry where BV_ID = #form.bloodValues_ID#
        </cfquery>

        <cfif isDefined('qgetBloodValueinsert.ID') and qgetBloodValueinsert.ID eq "">
            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                INSERT INTO ST_chemistry
                (
                    BV_ID                                 
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bloodValues_ID#'>
                )
            </cfquery>
        </cfif>
        <cftry>
            <cfquery name="qChemisteryUpdate" datasource="#variables.dsn#"  result="return_data" >
                UPDATE  ST_chemistry SET
                Total_protein_refractometer = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Total_protein_refractometer #'>
                ,protein_refractometer_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.protein_refractometer_report#'>
                ,protein_refractometer_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.protein_refractometer_comment#'>
                ,Hemolysis_Index = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hemolysis_Index#'>
                ,Hemolysis_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hemolysis_report#'>
                ,Hemolysis_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hemolysis_comment#'>
                ,Lipemia_Index = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lipemia_Index#'>
                ,Lipemia_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lipemia_report#'>
                ,Lipemia_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lipemia_comment#'>
                ,Glucose = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glucose#'>
                ,Glucose_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glucose_report#'>
                ,Glucose_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glucose_comment#'>
                ,BUNf = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BUNf#'>
                ,Bunf_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Bunf_report#'>
                ,BUNf_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BUNf_comment#'>
                ,CREA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CREA#'>
                ,CREA_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CREA_report#'>
                ,CREA_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CREA_comment#'>
                ,BUN_CREA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BUN_CREA#'>
                ,Bun_Crea_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Bun_Crea_report#'>
                ,BUN_CREA_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BUN_CREA_comment#'>
                ,Sodium = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sodium#'>
                ,Sodium_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sodium_report#'>
                ,Sodium_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sodium_comment#'>
                ,Potassium = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Potassium#'>
                ,Potassium_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Potassium_report#'>
                ,Potassium_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Potassium_comment#'>
                ,Chloride = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Chloride#'>
                ,Chloride_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Chloride_report#'>
                ,Chloride_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Chloride_comment#'>
                ,Magnesium = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Magnesium#'>
                ,Magnesium_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Magnesium_report#'>
                ,Magnesium_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Magnesium_comment#'>
                ,Calcium = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Calcium#'>
                ,Calcium_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Calcium_report#'>
                ,Calcium_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Calcium_comment#'>
                ,Phosphorus = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Phosphorus#'>
                ,Phosphurs_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Phosphurs_report#'>
                ,Phosphorus_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Phosphorus_comment#'>
                ,Ca_Phos = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ca_Phos#'>
                ,Ca_Phos_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ca_Phos_report#'>
                ,Ca_Phos_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ca_Phos_comment#'>
                ,CO = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CO#'>
                ,Co_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Co_report#'>
                ,CO_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CO_comment#'>
                ,Amylase = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Amylase#'>
                ,Amylase_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Amylase_report#'>
                ,Amylase_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Amylase_comment#'>
                ,Lipase = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lipase#'>
                ,Lipase_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lipase_report#'>
                ,Lipase_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lipase_comment#'>
                ,Cholesterol = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cholesterol#'>
                ,Cholesterol_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cholesterol_report#'>
                ,Cholesterol_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cholesterol_comment#'>
                ,Uric_Acid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Uric_Acid#'>
                ,Uric_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Uric_report#'>
                ,Uric_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Uric_comment#'>
                ,Total_Protein = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Total_Protein#'>
                ,Protein2_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Protein2_report#'>
                ,Protein2_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Protein2_comment#'>
                ,Albumin = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Albumin#'>
                ,Albumin_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Albumin_report#'>
                ,Albumin_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Albumin_comment#'>
                ,A_G = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.A_G#'>
                ,A_G_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.A_G_report#'>
                ,A_G_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.A_G_comment#'>
                ,AST = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AST#'>
                ,AST_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AST_report#'>
                ,AST_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AST_comment#'>
                ,ALT = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ALT#'>
                ,ALT_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ALT_report#'>
                ,ALT_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ALT_comment#'>
                ,LDH = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LDH#'>
                ,LDH_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LDH_report#'>
                ,LDH_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LDH_comment#'>
                ,CPK = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CPK#'>
                ,CPK_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CPK_report#'>
                ,CPK_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CPK_comment#'>
                ,Alkaline_Phosphatase = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Alkaline_Phosphatase#'>
                ,Alkaline_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Alkaline_report#'>
                ,Alkaline_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Alkaline_comment#'>
                ,GGT = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GGT#'>
                ,GGT_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GGT_report#'>
                ,GGT_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GGT_comment#'>
                ,Total_Bilirubin = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Total_Bilirubin#'>
                ,Bilirubin_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Bilirubin_report#'>
                ,Bilirubin_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Bilirubin_comment#'>
                ,Direct_Bilirubin = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Direct_Bilirubin#'>
                ,D_Bilirubin_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.D_Bilirubin_report#'>
                ,D_Bilirubin_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.D_Bilirubin_comment#'>
                WHERE
                BV_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.bloodValue_ID#'>
            </cfquery>
            <cfcatch>
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
      <cfreturn True>
    </cffunction>
    <!--- get Chemistry form --->
    <cffunction name="getchemistry" returntype="any" output="false" access="public" >
        <cfquery name="qgetchemistry" datasource="#Application.dsn#">
            SELECT * from ST_chemistry where BV_ID = #bloodID#
        </cfquery>
        <cfreturn qgetchemistry>
    </cffunction>

    <cffunction name="getchemistry_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetchemistry_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_chemistry where ID = 0
        </cfquery>
        <cfreturn qgetchemistry_ten>
    </cffunction>
    <!--- update Capillary Zone Electrophoresis --->
    <cffunction name="CapillaryUpdate" returntype="any" output="false" access="public" >
        <cfquery name="qgetBloodValueinsert" datasource="#Application.dsn#">
            SELECT ID from ST_Capillary where BV_ID = #form.bloodValues_ID#
        </cfquery>

        <cfif isDefined('qgetBloodValueinsert.ID') and qgetBloodValueinsert.ID eq "">
            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                INSERT INTO ST_Capillary
                (
                    BV_ID                                 
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bloodValues_ID#'>
                )
            </cfquery>
        </cfif>
        <cftry>
            <cfquery name="qCapillaryUpdate" datasource="#variables.dsn#"  result="return_data" >
                UPDATE  ST_Capillary SET
                Total_Protein_cap = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Total_Protein_cap#'> 
                ,Total_Protein_cap_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Total_Protein_cap_report#'> 
                ,Total_Protein_cap_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Total_Protein_cap_comment#'> 
                ,A_G_ration = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.A_G_ration#'> 
                ,A_G_ration_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.A_G_ration_report#'> 
                ,A_G_ration_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.A_G_ration_comment#'> 
                ,Pre_Albumin = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pre_Albumin#'> 
                ,Pre_Albumin_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pre_Albumin_report#'> 
                ,Pre_Albumin_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pre_Albumin_comment#'> 
                ,Albumin2 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Albumin2#'> 
                ,Albumin2_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Albumin2_report#'> 
                ,Albumin2_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Albumin2_comment#'> 
                ,Alpha_1 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Alpha_1#'> 
                ,Alpha_1_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Alpha_1_report#'> 
                ,Alpha_1_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Alpha_1_comment#'> 
                ,Alpha_2 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Alpha_2#'> 
                ,Alpha_2_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Alpha_2_report#'> 
                ,vAlpha_2_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Alpha_2_comment#'> 
                ,Beta_1 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beta_1#'> 
                ,Beta_1_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beta_1_report#'> 
                ,Beta_1_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beta_1_comment#'> 
                ,Beta_2 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beta_2#'> 
                ,Beta_2_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beta_2_report#'> 
                ,Beta_2_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beta_2_comment#'> 
                ,Beta_Total = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beta_Total#'> 
                ,Beta_Total_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beta_Total_report#'> 
                ,Beta_Total_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beta_Total_comment#'> 
                ,Gamma = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Gamma#'> 
                ,Gamma_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Gamma_report#'> 
                ,Gamma_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Gamma_comment#'>
                WHERE
                BV_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.bloodValues_ID#'>
            </cfquery>
            <cfcatch>
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
      <cfreturn True> 
    </cffunction>
    <!--- get Capillary Zone Electrophoresis --->
    <cffunction name="getCapillary" returntype="any" output="false" access="public" >
        <cfquery name="qgetCapillary" datasource="#Application.dsn#">
            SELECT * from ST_Capillary where BV_ID = #bloodID#
        </cfquery>
        <cfreturn qgetCapillary>
    </cffunction>

    <cffunction name="getCapillary_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetCapillary_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_Capillary where ID = 0
        </cfquery>
        <cfreturn qgetCapillary_ten>
    </cffunction>
    <!--- update Dolphin SAA --->
    <cffunction name="DolphinUpdate" returntype="any" output="false" access="public" >
        <cfquery name="qgetBloodValueinsert" datasource="#Application.dsn#">
            SELECT ID from ST_Dolphin where BV_ID = #form.bloodValues_ID#
        </cfquery>

        <cfif isDefined('qgetBloodValueinsert.ID') and qgetBloodValueinsert.ID eq "">
            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                INSERT INTO ST_Dolphin
                (
                    BV_ID                                 
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bloodValues_ID#'>
                )
            </cfquery>
        </cfif>
        <cftry>
            <cfquery name="qDolphinUpdate" datasource="#variables.dsn#"  result="return_data" >
                UPDATE  ST_Dolphin SET
                    Dolphin_SAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Dolphin_SAA#'>
                    ,Dolphin_SAA_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Dolphin_SAA_report#'>
                    ,Dolphin_SAA_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Dolphin_SAA_comment#'>
                WHERE
                BV_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.bloodValues_ID#'>
            </cfquery>
            <cfcatch>
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
      <cfreturn True> 
    </cffunction>
    <!--- get Dolphin SAA --->
    <cffunction name="getDolphin" returntype="any" output="false" access="public" >
        <cfquery name="qgetDolphin" datasource="#Application.dsn#">
            SELECT * from ST_Dolphin where BV_ID = #bloodID#
        </cfquery>
        <cfreturn qgetDolphin>
    </cffunction>

    <cffunction name="getDolphin_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetDolphin_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_Dolphin where ID = 0
        </cfquery>
        <cfreturn qgetDolphin_ten>
    </cffunction>
    <!--- update ISTAT- Chem 8+ --->
    <cffunction name="iSTAT_ChemUpdate" returntype="any" output="false" access="public" >
        <cfquery name="qgetBloodValueinsert" datasource="#Application.dsn#">
            SELECT ID from ST_iSTAT_Chem where BV_ID = #form.bloodValues_ID#
        </cfquery>

        <cfif isDefined('qgetBloodValueinsert.ID') and qgetBloodValueinsert.ID eq "">
            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                INSERT INTO ST_iSTAT_Chem
                (
                    BV_ID                                 
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bloodValues_ID#'>
                )
            </cfquery>
        </cfif>
        <cftry>
        <cfquery name="qiSTAT_ChemUpdate" datasource="#variables.dsn#"  result="return_data" >
            UPDATE  ST_iSTAT_Chem SET
            Chem_date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Chem_date#' null="#IIF(Chem_date EQ "", true, false)#">
            ,Chem_dateTime = <cfqueryparam cfsqltype="CF_SQL_TIME" value='#FORM.Chem_dateTime#' null="#IIF(Chem_dateTime EQ "", true, false)#">
            ,Operator_che = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Operator_chem#'>
            ,Na = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Na#'>
            ,Na_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Na_report#'>
            ,Na_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Na_comment#'>
            ,K = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.K#'>
            ,K_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.K_report#'>
            ,K_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.K_comment#'>
            ,Cl = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cl#'>
            ,Cl_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cl_report#'>
            ,Cl_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Cl_comment#'>
            ,iCa = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.iCa#'>
            ,iCa_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.iCa_report#'>
            ,iCa_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.iCa_comment#'>
            ,TCO2 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TCO2#'>
            ,TCO2_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TCO2_report#'>
            ,TCO2_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TCO2_comment#'>
            ,Glu = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glu#'>
            ,Glu_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glu_report#'>
            ,Glu_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glu_comment#'>
            ,BUN = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BUN#'>
            ,BUN_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BUN_report#'>
            ,BUN_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BUN_comment#'>
            ,Crea2 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Crea2#'>
            ,Crea2_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Crea2_report#'>
            ,Crea2_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Crea2_comment#'>
            ,Hct = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hct#'>
            ,Hct_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hct_report#'>
            ,Hct_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hct_comment#'>
            ,Hb = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hb#'>
            ,Hb_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hb_report#'>
            ,Hb_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Hb_comment#'>
            ,AnGap = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AnGap#'>
            ,AnGap_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AnGap_report#'>
            ,AnGap_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AnGap_comment#'>
           WHERE
           BV_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.bloodValues_ID#'>
        </cfquery>
        <cfcatch>
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
      <cfreturn True> 
    </cffunction>
    <!--- get ISTAT- Chem 8+ --->
    <cffunction name="getiSTAT_Chem" returntype="any" output="false" access="public" >
        <cfquery name="qgetiSTAT_Chem" datasource="#Application.dsn#">
            SELECT * from ST_iSTAT_Chem where BV_ID = #bloodID#
        </cfquery>
        <cfreturn qgetiSTAT_Chem>
    </cffunction>

    <cffunction name="getiSTAT_Chem_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetiSTAT_Chem_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_iSTAT_Chem where ID = 0
        </cfquery>
        <cfreturn qgetiSTAT_Chem_ten>
    </cffunction>
    <!--- update iSTAT- CG4+ --->
    <cffunction name="CG4Update" returntype="any" output="false" access="public" >
        <cfquery name="qgetBloodValueinsert" datasource="#Application.dsn#">
            SELECT ID from ST_iSTAT_CG4 where BV_ID = #form.bloodValues_ID#
        </cfquery>

        <cfif isDefined('qgetBloodValueinsert.ID') and qgetBloodValueinsert.ID eq "">
            <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                INSERT INTO ST_iSTAT_CG4
                (
                    BV_ID                                 
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bloodValues_ID#'>
                )
            </cfquery>
        </cfif>
        <cftry>
            <cfquery name="qCG4Update" datasource="#variables.dsn#"  result="return_data" >
                UPDATE  ST_iSTAT_CG4 SET
                ISTAT_CG4_date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.ISTAT_CG4_date#' null="#IIF(ISTAT_CG4_date EQ "", true, false)#">
                ,tTime = <cfqueryparam cfsqltype="CF_SQL_TIME" value='#FORM.tTime#' null="#IIF(tTime EQ "", true, false)#">
                ,Operator = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Operator#'>
                ,Temperature = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Temperature#'>
                ,Temperature_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Temperature_report#'>
                ,Temperature_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Temperature_comment#'>
                ,pH = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pH#'>
                ,pH_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pH_report#'>
                ,pH_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pH_comment#'>
                ,PCO2 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PCO2#'>
                ,PCO2_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PCO2_report#'>
                ,PCO2_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PCO2_comment#'>
                ,PO2 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PO2#'>
                ,PO2_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PO2_report#'>
                ,PO2_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PO2_comment#'>
                ,BEecf = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BEecf#'>
                ,BEecf_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BEecf_report#'>
                ,BEecf_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BEecf_comment#'>
                ,HCO3 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HCO3#'>
                ,HCO3_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HCO3_report#'>
                ,HCO3_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HCO3_comment#'>
                ,TCO2cg = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TCO2cg#'>
                ,TCO2cg_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TCO2cg_report#'>
                ,TCO2cg_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TCO2cg_comment#'>
                ,sO2 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sO2#'>
                ,sO2_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sO2_report#'>
                ,sO2_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sO2_comment#'>
                ,Lac = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lac#'>
                ,Lac_report = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lac_report#'>
                ,Lac_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lac_comment#'>
                WHERE
                BV_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.bloodValues_ID#'>
            </cfquery>
            <cfcatch>
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
      <cfreturn True> 
    </cffunction>
    <!--- get ISTAT- CG4+ --->
    <cffunction name="getiSTAT_CG4" returntype="any" output="false" access="public" >
        <cfquery name="qgetiSTAT_CG4" datasource="#Application.dsn#">
            SELECT * from ST_iSTAT_CG4 where BV_ID = #bloodID#
        </cfquery>
        <cfreturn qgetiSTAT_CG4>
    </cffunction>

    <cffunction name="getiSTAT_CG4_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetiSTAT_CG4_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_iSTAT_CG4 where ID = 0
        </cfquery>
        <cfreturn qgetiSTAT_CG4_ten>
    </cffunction>
    <!--- Fibrinogen Insert  --->
    <cffunction name="Fibrinogeninsert" returntype="any" output="false" access="public">
        <cftry>
            <cfquery name="qFibInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO ST_Fibrinogen
            (
                Fibrinogen
                ,Fibrinogen_report
                ,Fibrinogen_comment
                ,LCE_ID
                ,BV_ID
            )
            VALUES
            (   
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fibrinogen#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fibrinogen_report#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fibrinogen_comment#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>
            )   
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset Fib_ID = "#return_data.generatedkey#">
        <cfreturn Fib_ID>
    </cffunction>
     <!--- Insert Chemistry form  (Blood Values) --->
     <cffunction name="Chemistryinsert" returntype="any" output="false" access="public">
        <cftry>
            <cfquery name="qChemistryInsert" datasource="#variables.dsn#"  result="return_data" >
                INSERT INTO ST_Chemistry
                (
                    Total_protein_refractometer
                    ,protein_refractometer_report
                    ,protein_refractometer_comment
                    ,Hemolysis_Index
                    ,Hemolysis_report
                    ,Hemolysis_comment
                    ,Lipemia_Index
                    ,Lipemia_report
                    ,Lipemia_comment
                    ,Glucose
                    ,Glucose_report
                    ,Glucose_comment
                    ,BUNf
                    ,Bunf_report
                    ,BUNf_comment
                    ,CREA
                    ,CREA_report
                    ,CREA_comment
                    ,BUN_CREA
                    ,Bun_Crea_report
                    ,BUN_CREA_comment
                    ,Sodium
                    ,Sodium_report
                    ,Sodium_comment
                    ,Potassium
                    ,Potassium_report
                    ,Potassium_comment
                    ,Chloride
                    ,Chloride_report
                    ,Chloride_comment
                    ,Magnesium
                    ,Magnesium_report
                    ,Magnesium_comment
                    ,Calcium
                    ,Calcium_report
                    ,Calcium_comment
                    ,Phosphorus
                    ,Phosphurs_report
                    ,Phosphorus_comment
                    ,Ca_Phos
                    ,Ca_Phos_report
                    ,Ca_Phos_comment
                    ,CO
                    ,Co_report
                    ,CO_comment
                    ,Amylase
                    ,Amylase_report
                    ,Amylase_comment
                    ,Lipase
                    ,Lipase_report
                    ,Lipase_comment
                    ,Cholesterol
                    ,Cholesterol_report
                    ,Cholesterol_comment
                    ,Uric_Acid
                    ,Uric_report
                    ,Uric_comment
                    ,Total_Protein
                    ,Protein2_report
                    ,Protein2_comment
                    ,Albumin
                    ,Albumin_report
                    ,Albumin_comment
                    ,A_G
                    ,A_G_report
                    ,A_G_comment
                    ,AST
                    ,AST_report
                    ,AST_comment
                    ,ALT
                    ,ALT_report
                    ,ALT_comment
                    ,LDH
                    ,LDH_report
                    ,LDH_comment
                    ,CPK
                    ,CPK_report
                    ,CPK_comment
                    ,Alkaline_Phosphatase
                    ,Alkaline_report
                    ,Alkaline_comment
                    ,GGT
                    ,GGT_report
                    ,GGT_comment
                    ,Total_Bilirubin
                    ,Bilirubin_report
                    ,Bilirubin_comment
                    ,Direct_Bilirubin
                    ,D_Bilirubin_report
                    ,D_Bilirubin_comment
                    ,LCE_ID
                    ,BV_ID
                ) 
                VALUES
                (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Total_protein_refractometer#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.protein_refractometer_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.protein_refractometer_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Hemolysis_Index#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Hemolysis_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Hemolysis_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Lipemia_Index#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Lipemia_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Lipemia_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Glucose#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Glucose_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Glucose_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.BUNf#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Bunf_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.BUNf_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CREA#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CREA_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CREA_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.BUN_CREA#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Bun_Crea_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.BUN_CREA_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sodium#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sodium_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sodium_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Potassium#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Potassium_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Potassium_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Chloride#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Chloride_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Chloride_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Magnesium#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Magnesium_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Magnesium_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Calcium#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Calcium_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Calcium_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Phosphorus#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Phosphurs_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Phosphorus_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Ca_Phos#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Ca_Phos_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Ca_Phos_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CO#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Co_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CO_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Amylase#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Amylase_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Amylase_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Lipase#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Lipase_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Lipase_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cholesterol#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cholesterol_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cholesterol_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Uric_Acid#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Uric_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Uric_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Total_Protein#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Protein2_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Protein2_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Albumin#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Albumin_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Albumin_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.A_G#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.A_G_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.A_G_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.AST#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.AST_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.AST_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ALT#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ALT_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ALT_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.LDH#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.LDH_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.LDH_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CPK#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CPK_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CPK_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Alkaline_Phosphatase#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Alkaline_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Alkaline_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.GGT#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.GGT_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.GGT_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Total_Bilirubin#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Bilirubin_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Bilirubin_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Direct_Bilirubin#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.D_Bilirubin_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.D_Bilirubin_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.LCE_ID#">
                    ,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.BV_ID#">
                )
            </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset Chem_ID = "#return_data.generatedkey#">
        <cfreturn Chem_ID>
    </cffunction>
    <!--- Capillary Zone Electrophoresis Insert  --->
    <cffunction name="Capillaryinsert" returntype="any" output="false" access="public">
        <cftry>
            <cfquery name="qCapillary" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO ST_Capillary
            (
                Total_Protein_cap
                ,Total_Protein_cap_report
                ,Total_Protein_cap_comment
                ,A_G_ration
                ,A_G_ration_report
                ,A_G_ration_comment
                ,Pre_Albumin
                ,Pre_Albumin_report
                ,Pre_Albumin_comment
                ,Albumin2
                ,Albumin2_report
                ,Albumin2_comment
                ,Alpha_1
                ,Alpha_1_report
                ,Alpha_1_comment
                ,Alpha_2
                ,Alpha_2_report
                ,vAlpha_2_comment
                ,Beta_1
                ,Beta_1_report
                ,Beta_1_comment
                ,Beta_2
                ,Beta_2_report
                ,Beta_2_comment
                ,Beta_Total
                ,Beta_Total_report
                ,Beta_Total_comment
                ,Gamma
                ,Gamma_report
                ,Gamma_comment
                ,LCE_ID
                ,BV_ID
            )
            VALUES
            (   
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Total_Protein_cap#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Total_Protein_cap_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Total_Protein_cap_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.A_G_ration#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.A_G_ration_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.A_G_ration_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Pre_Albumin#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Pre_Albumin_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Pre_Albumin_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Albumin2#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Albumin2_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Albumin2_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Alpha_1#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Alpha_1_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Alpha_1_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Alpha_2#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Alpha_2_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Alpha_2_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Beta_1#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Beta_1_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Beta_1_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Beta_2#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Beta_2_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Beta_2_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Beta_Total#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Beta_Total_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Beta_Total_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Gamma#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Gamma_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Gamma_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>
            )   
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset Chap_ID = "#return_data.generatedkey#">
        <cfreturn Chap_ID>
    </cffunction>
    <!--- Insert Dolphin SAA form --->
    <cffunction name="Dolphininsert" returntype="any" output="false" access="public">
        <cftry>
            <cfquery name="qDolphin" datasource="#variables.dsn#"  result="return_data" >
                INSERT INTO ST_Dolphin
                (
                    Dolphin_SAA
                    ,Dolphin_SAA_report
                    ,Dolphin_SAA_comment
                    ,LCE_ID
                    ,BV_ID
                )
                VALUES
                (   
                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Dolphin_SAA#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Dolphin_SAA_report#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Dolphin_SAA_comment#'>
                    ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                    ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>
                )   
            </cfquery>
            <cfcatch type="any">
             <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfset Dol_ID = "#return_data.generatedkey#">
        <cfreturn Dol_ID>
    </cffunction>
    <!--- iSTAT- Chem 8+ insert --->
    <cffunction name="iSTAT_Cheminsert" returntype="any" output="false" access="public">
        <cfargument default="" name="Chem_date">
        <cfargument default="" name="Chem_dateTime">
        <cftry>
            <cfquery name="qiSTAT_Chem" datasource="#variables.dsn#"  result="return_data" >
                INSERT INTO ST_iSTAT_Chem
                (
                    Chem_date
                    ,Chem_dateTime
                    ,Operator_che
                    ,Na
                    ,Na_report
                    ,Na_comment
                    ,K
                    ,K_report
                    ,K_comment
                    ,Cl
                    ,Cl_report
                    ,Cl_comment
                    ,iCa
                    ,iCa_report
                    ,iCa_comment
                    ,TCO2
                    ,TCO2_report
                    ,TCO2_comment
                    ,Glu
                    ,Glu_report
                    ,Glu_comment
                    ,BUN
                    ,BUN_report
                    ,BUN_comment
                    ,Crea2
                    ,Crea2_report
                    ,Crea2_comment
                    ,Hct
                    ,Hct_report
                    ,Hct_comment
                    ,Hb
                    ,Hb_report
                    ,Hb_comment
                    ,AnGap
                    ,AnGap_report
                    ,AnGap_comment
                    ,LCE_ID
                    ,BV_ID
                )
                VALUES
                ( 
                    <cfqueryparam cfsqltype="cf_sql_Date" value="#Chem_date#" null="#IIF(Chem_date EQ "", true, false)#">
                    ,<cfqueryparam cfsqltype="cf_sql_Time" value="#Chem_dateTime#" null="#IIF(Chem_dateTime EQ "", true, false)#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Operator_chem#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Na#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Na_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Na_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#K#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#K_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#K_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Cl#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Cl_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Cl_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#iCa#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#iCa_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#iCa_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#TCO2#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#TCO2_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#TCO2_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Glu#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Glu_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Glu_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#BUN#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#BUN_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#BUN_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Crea2#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Crea2_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Crea2_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Hct#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Hct_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Hct_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Hb#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Hb_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Hb_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#AnGap#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#AnGap_report#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#AnGap_comment#">
                    ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                    ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>
                )   
            </cfquery>
            <cfcatch type="any">
             <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfset iSTAT_ID = "#return_data.generatedkey#">
        <cfreturn iSTAT_ID>
    </cffunction>
    <!--- insert iSTAT- CG4+ --->
    <cffunction name="CG4_Cheminsert" returntype="any" output="false" access="public">
        <cfargument default="" name="ISTAT_CG4_date">
        <cfargument default="" name="tTime">
        <cftry>
            <cfquery name="qCapillary" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO ST_iSTAT_CG4
            (
                ISTAT_CG4_date
                ,tTime
                ,Operator
                ,Temperature
                ,Temperature_report
                ,Temperature_comment
                ,pH
                ,pH_report
                ,pH_comment
                ,PCO2
                ,PCO2_report
                ,PCO2_comment
                ,PO2
                ,PO2_report
                ,PO2_comment
                ,BEecf
                ,BEecf_report
                ,BEecf_comment
                ,HCO3
                ,HCO3_report
                ,HCO3_comment
                ,TCO2cg
                ,TCO2cg_report
                ,TCO2cg_comment
                ,sO2
                ,sO2_report
                ,sO2_comment
                ,Lac
                ,Lac_report
                ,Lac_comment
                ,LCE_ID
                ,BV_ID
            )
            VALUES
            (   
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#Form.ISTAT_CG4_date#" null="#IIF(ISTAT_CG4_date EQ "", true, false)#">
                ,<cfqueryparam cfsqltype="CF_SQL_TIME" value="#Form.tTime#" null="#IIF(tTime EQ "", true, false)#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.Operator#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.Temperature#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.Temperature_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.Temperature_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.pH#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.pH_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.pH_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.PCO2#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.PCO2_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.PCO2_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.PO2#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.PO2_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.PO2_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.BEecf#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.BEecf_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.BEecf_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.HCO3#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.HCO3_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.HCO3_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.TCO2cg#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.TCO2cg_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.TCO2cg_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.sO2#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.sO2_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.sO2_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.Lac#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.Lac_report#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.Lac_comment#">
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>
            )   
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset CG4_ID = "#return_data.generatedkey#">
        <cfreturn CG4_ID>
    </cffunction>
    <!---update Blood Value form --->
    <cffunction name="Blood_VFormUpdate" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!---this logic will update the data in all stranding forms,however u do change something in anyone form--->
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
        <cfquery name="qBloodValuesUpdate" datasource="#variables.dsn#"  result="return_data" >
            UPDATE  ST_Blood_Values SET
                Analysis_date=<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Analysis_date#'>
                ,ResearchTeam=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,Veterinarian=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,species=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,Collection_Date=<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.Collection_Date#'>
                ,BodyOfWater=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,NOAAStock=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,StTpye=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,Diagnostic_Lab=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LabSentto#'>
                ,Fnumber=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,Lab_Number=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lab_num#'>
                ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
                ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
                ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>
 	            ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
                ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
                ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
                ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
                ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
                ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
                ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
                ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
                ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.bloodValues_ID#'>
        </cfquery>
        <cfcatch>
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif>     --->
        <cfreturn true>
    </cffunction>

    <cffunction name="getBlood_VID" returntype="any" output="false" access="public" >
        <cfquery name="qgetBloodValuesID" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_Blood_Values where deleted != '1' order by ID DESC 
        </cfquery>
        <cfreturn qgetBloodValuesID>
    </cffunction>
    
    <cffunction name="getBlood_VDate" returntype="any" output="false" access="public" >
        <cfquery name="qgetBloodValuesDate" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_Blood_Values where deleted != '1' order by date DESC
        </cfquery>
        <cfreturn qgetBloodValuesDate>
    </cffunction>

    <cffunction name="getBlood_VBNumber" returntype="any" output="false" access="public" >
        <cfquery name="qgetBloodValuesFBNumber" datasource="#Application.dsn#"  >
            SELECT ID,Fnumber from ST_Blood_Values where deleted != '1' order by Fnumber ASC
        </cfquery>
        <cfreturn qgetBloodValuesFBNumber>
    </cffunction>

    <cffunction name="getBlood_VData" returntype="any" output="false" access="public" >
        <cfquery name="qBloodValuesData" datasource="#Application.dsn#"  >
            SELECT * from ST_Blood_Values where ID = #bloodValue_ID#
        </cfquery>
        <cfreturn qBloodValuesData>
    </cffunction>
    <!--- <cffunction name="getBlood_VData" returntype="any" output="false" access="public" >
        <cfquery name="qBloodValuesData" datasource="#Application.dsn#"  >
            SELECT * from ST_Blood_Values where ID = #LCEID#
        </cfquery>
        <cfreturn qBloodValuesData>
    </cffunction> --->
    
      <cffunction name="getBlood_V_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetBloodValues_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_Blood_Values where ID = 0
        </cfquery>
        <cfreturn qgetBloodValues_ten>
    </cffunction>
    <cffunction name="getBlood_ValuesDataByLCE" returntype="any" output="false" access="public" >
        <cfquery name="qgetBlood_ValuesDataByLCE" datasource="#Application.dsn#"  >
            SELECT * from ST_Blood_Values where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetBlood_ValuesDataByLCE>
    </cffunction>
        <cffunction name="gettoxiByLCE" returntype="any" output="false" access="public" >
            <cfquery name="qgettoxiByLCE" datasource="#Application.dsn#"  >
                SELECT * from ST_Toxicology where LCE_ID = #LCEID#
            </cfquery>
            <cfreturn qgettoxiByLCE>
    </cffunction>
    <cffunction name="deletBlood_V" returntype="any" output="false" access="public" >
        <cfquery name="qdeleteBlood_V" datasource="#variables.dsn#"  >
            Update ST_Blood_Values 
            set deleted = '1'
            where ID = #bloodValues_ID#
        </cfquery>
        <cfreturn True>
    </cffunction>
    <cffunction name="deleteBloodValuesRecord" returntype="any" output="false" access="public" >
        <cfquery name="qdeleteBloodValuesRecord" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_Blood_Values  
        </cfquery>
        <cfquery name="qdeleteBloodValuesRecord1" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_CBC  
        </cfquery>
        <cfquery name="qdeleteBloodValuesRecord2" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_Fibrinogen  
        </cfquery>
        <cfquery name="qdeleteBloodValuesRecord3" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_chemistry  
        </cfquery>
        <cfquery name="qdeleteBloodValuesRecord4" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_Capillary  
        </cfquery>
        <cfquery name="qdeleteBloodValuesRecord5" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_Dolphin  
        </cfquery>
        <cfquery name="qdeleteBloodValuesRecord6" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_iSTAT_Chem  
        </cfquery>
        <cfquery name="qdeleteBloodValuesRecord7" datasource="#variables.dsn#"  >
         TRUNCATE Table ST_iSTAT_CG4  
        </cfquery>
        <cfreturn True>
    </cffunction>

    <!-------Ancillary Diagnostics form insert---------->

    <cffunction name="AncillaryFormInsert" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.GroupEvent')>
            <cfset FORM.GroupEvent = "">
        </cfif>
        <cfif NOT isDefined('FORM.Restrand')>
            <cfset FORM.Restrand = "">
        </cfif>
        <cfif NOT isDefined('FORM.TagsWere')>
            <cfset FORM.TagsWere = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0 >
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qHistopathologyFormInsert" datasource="#Application.dsn#"  result="return_data" >
                INSERT INTO ST_Ancillary_Diagnostics
                (
                date
                ,ResearchTeam
                ,Veterinarian
                ,species
                ,BodyOfWater
                ,NOAAStock
                ,StTpye
                ,Fnumber
                ,NMFS
                ,NDB
                ,NAA
                ,LCE_ID
                ,code
                ,hera
                ,sex
                ,ageClass
                ,Location
                ,lat
                ,lon
                ,county
                ,InitialCondition
                ,FinalCondition
                ,affiliatedID
                ,actualClass
                ,BriefHistory
                ,euthanizedCB
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
               
                )
            </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset AD_ID = "#return_data.generatedkey#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn AD_ID>
    </cffunction>
    <!---update Ancillary Diagnostics form --->
    <cffunction name="AncillaryFormUpdate" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!---this logic will update the data in all stranding forms,however u do change something in anyone form--->
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qAncillaryFormUpdate" datasource="#variables.dsn#" result="return_data" >
                UPDATE  ST_Ancillary_Diagnostics SET
                date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
                ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
                ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
                ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>
                ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
                ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
                ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
                ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
                ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
                ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
                ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
                ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
                WHERE
                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.ADID#'>
            </cfquery>
            <cfcatch>
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn true>
    </cffunction>

    <cffunction name="getAncillaryID" returntype="any" output="false" access="public" >
        <cfquery name="qgetHistoID" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_Ancillary_Diagnostics where deleted != '1' order by ID DESC 
        </cfquery>
        <cfreturn qgetHistoID>
    </cffunction>
    
    <cffunction name="getAncillaryDate" returntype="any" output="false" access="public" >
        <cfquery name="qgetHistoDate" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_Ancillary_Diagnostics where deleted != '1' order by DATE DESC
        </cfquery>
        <cfreturn qgetHistoDate>
    </cffunction>

    <cffunction name="getNecropsyDate" returntype="any" output="false" access="public" >
        <cfquery name="qgetNecropsyDate" datasource="#Application.dsn#"  >
            SELECT ID,date,Fnumber from ST_CetaceanNecropsyReport where date != '' order by DATE DESC
        </cfquery>
        <cfreturn qgetNecropsyDate>
    </cffunction>

    <cffunction name="getMorphometricsBNumber" returntype="any" output="false" access="public" >
        <cfquery name="MorphometricsoFBNumber" datasource="#Application.dsn#"  >
            SELECT ID,Fnumber from ST_Morphometrics order by Fnumber ASC
        </cfquery>
        <cfreturn MorphometricsoFBNumber>
    </cffunction>

    <cffunction name="getMorphometricsDate" returntype="any" output="false" access="public" >
        <cfquery name="MorphometricsDate" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_Morphometrics order by date ASC
        </cfquery>
        <cfreturn MorphometricsDate>
    </cffunction>

    <cffunction name="getMorphometricsAllData" returntype="any" output="false" access="public" >
        <cfquery name="qMorphometricsData" datasource="#Application.dsn#"  >
            SELECT * from ST_Morphometrics where ID = #Morphometrics_ID#
        </cfquery>
        <cfreturn qMorphometricsData>
    </cffunction>

    <cffunction name="getAncillaryBNumber" returntype="any" output="false" access="public" >
        <cfquery name="qgetHistoFBNumber" datasource="#Application.dsn#"  >
            SELECT ID,Fnumber from ST_Ancillary_Diagnostics where deleted != '1' order by Fnumber ASC
        </cfquery>
        <cfreturn qgetHistoFBNumber>
    </cffunction>

    <cffunction name="getAncillaryData" returntype="any" output="false" access="public" >
        <cfquery name="qHistoData" datasource="#Application.dsn#"  >
            SELECT * from ST_Ancillary_Diagnostics where ID = #AD_ID#
        </cfquery>
        <cfreturn qHistoData>
    </cffunction>
    
    <cffunction name="getAncillary_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetHisto_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_Ancillary_Diagnostics where ID = 0
        </cfquery>
        <cfreturn qgetHisto_ten>
    </cffunction>
    <cffunction name="getAncillaryDataByLCE" returntype="any" output="false" access="public" >
        <cfquery name="qgetAncillaryDataByLCE" datasource="#Application.dsn#"  >
            SELECT * from ST_Ancillary_Diagnostics where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetAncillaryDataByLCE>
    </cffunction>
    <cffunction name="deleteAncillary" returntype="any" output="false" access="public" >
        <cfquery name="qdeleteAncillary" datasource="#variables.dsn#"  >
            Update ST_Ancillary_Diagnostics 
            set deleted = '1'
            where ID = #ADID#
        </cfquery>
        <cfreturn True>
    </cffunction>
    <cffunction name="deleteAncillaryAllRecord" returntype="any" output="false" access="public" >
        <cfquery name="qdeleteAncillaryAllRecord" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_Ancillary_Diagnostics
        </cfquery>
        <cfquery name="qdeleteAncillaryAllRecord" datasource="#variables.dsn#"  >
            TRUNCATE Table ST_Ancillary_Report
        </cfquery>

        <cfreturn True>
    </cffunction>
    <cffunction name="AncillaryReportInsert"  returntype="any" output="false" access="remote" >
        
        <cfargument name="TestingDate" type="string" required="false">
        <cfargument name="AncillaryDiagnosticsSampleType" type="string" required="false">
        <cfargument name="DiagnosticTest" type="string" required="false">
        <cfargument name="TestResults" type="string" required="false">
        <cfargument name="DiagnosticLab" type="string" required="false">
        <cfargument name="pdfFilesAncillary" type="string" required="false">
        <cfargument name="ADID" type="string" required="false">
        <cfset pd = listToArray(pdfFilesAncillary)>
        <!--- <cfdump var="#pdfFilesAncillary#" abort="true"> --->
        <CFTRY>
            <cffile action = "uploadAll"  
            fileField = "pdf" 
            destination = "#Application.CloudDirectory#"  
            accept = "application/pdf"  
            nameConflict = "MAKEUNIQUE"
            result="fileUploaded"
            > 
            <cfloop array="#fileUploaded#" item="item">
                <cfif arrayFind(pd,#item.clientfile#) neq 0>
                    <cfset ArraySet(pd,arrayFind(pd,#item.clientfile#),arrayFind(pd,#item.clientfile#),#item.serverfile#)>
                </cfif>
            </cfloop>
            <CFCATCH type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </CFCATCH>
        </CFTRY>
        <cfset fil = arrayToList(pd)>
        <cfif len(trim(DiagnosticTest)) GT 0 >
			<cfloop from="1" to="#ListLen(DiagnosticTest)#" index="i">
                <cfquery name="qAncillaryReportInsert" datasource="#variables.dsn#">
                   Insert into ST_Ancillary_Report  (TestingDate,ADSampleType,DiagnosticTest,TestResults,DiagnosticLab,pdfFiles,AD_ID)
                    values
                    (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(TestingDate,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(AncillaryDiagnosticsSampleType,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(DiagnosticTest,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(TestResults,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(DiagnosticLab,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(fil,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ADID#'>
                    )
                </cfquery>
            </cfloop>
		</cfif>
		<cfreturn True>
	</cffunction>
    <cffunction name="AncillaryReportGet"  returntype="any" output="false" access="remote" >
       <cfquery name="qAncillaryReportGet" datasource="#variables.dsn#">
            Select * from  ST_Ancillary_Report  
            where 
            AD_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#AD_ID#'>
        </cfquery>
		<cfreturn qAncillaryReportGet>
	</cffunction>

     <!---   Sample Archive Section   --->
    <cffunction name="SampleArchiveInsert" returntype="any" output="false" access="public" >
        
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
       
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0 >
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qSampleArchiveInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO ST_SampleArchive
            (
             ResearchTeam
            ,Veterinarian
            ,species
            ,BodyOfWater
            ,NOAAStock
            ,StTpye
            ,Fnumber
            ,LCE_ID
            ,Deleted
            ,CompletedBy
            ,NMFS
            ,NDB
            ,NAA
		    ,code
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,lat
            ,lon
            ,county
            ,InitialCondition
            ,FinalCondition
            ,affiliatedID
            ,actualClass
            ,date
            ,BriefHistory
            ,euthanizedCB
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
            ,<cfqueryparam  value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='0'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
		    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
            ,<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn LCE_ID>
    </cffunction>
    <cffunction name="SampleTypeInsert" returntype="any" output="false" access="public" >
        <cftry>
            <cfquery name="qSampleTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO ST_SampleType
            (
            SampleID
            ,Sample_Date
            ,Sample_Location
            ,BinNumber
            ,SampleType
            ,PreservationMethod
            ,AmountofSample
            ,UnitofSample
            ,StorageType
            ,SampleComments
            ,LCE_ID
            ,SA_ID
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SampleID#'>
            ,<cfqueryparam cfsqltype="cf_sql_date" value='#FORM.Sample_Date#'null="#IIF(Sample_Date EQ "", true, false)#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sample_Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BinNumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SampleType#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PreservationMethod#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AmountofSample#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UnitofSample#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StorageType#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SampleComments#'>
            ,<cfqueryparam  value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.SA_ID#'>
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset ST_ID = "#return_data.generatedkey#">
        <cfreturn ST_ID>
    </cffunction>
    <!--- insert sample excel file data --->
    <cffunction name="insertfiledata" returntype="any" output="false" access="public" >
        <!--- <cfdump var ="#colList#"> --->
        <cftry>
            <cfquery name="qinsertFile" datasource="#variables.dsn#"  result="return_data" >
                INSERT INTO ST_SampleType
                (
                SampleID
                ,Sample_Location
                ,PreservationMethod
                ,StorageType
                ,SampleComments
                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(SampleID,c)#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(Sample_Location,c)#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(PreservationMethod,c)#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(StorageType,c)#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(SampleComments,c)#'>
                )
            </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset test = "#return_data.generatedkey#">
        <cfreturn test>
    </cffunction>
    <!---  --->
    <cffunction name="SampleTypeUpdate" returntype="any" output="false" access="public" >
        <cfset FORM.LCE_ID = '0'>
        <cftry>
            <cfquery name="qSampleTypeUpdate" datasource="#variables.dsn#"  result="return_data" >
            Update  ST_SampleType  SET
            SampleID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SampleID#'>
            ,Sample_Date = <cfqueryparam cfsqltype="cf_sql_date" value='#FORM.Sample_Date#'null="#IIF(Sample_Date EQ "", true, false)#">
            ,Sample_Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sample_Location#'>
            ,BinNumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BinNumber#'>
            ,SampleType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SampleType#'>
            ,PreservationMethod = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PreservationMethod#'>
            ,AmountofSample = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AmountofSample#'>
            ,UnitofSample = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UnitofSample#'>
            ,StorageType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StorageType#'>
            ,SampleComments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SampleComments#'>
            ,LCE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
            Where 
            ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.ST_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfreturn TRUE>
    </cffunction>

    <cffunction name="getSampleType_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetSampleType_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_SampleType where ID = 0
        </cfquery>
        <cfreturn qgetSampleType_ten>
    </cffunction>
    <cffunction name="getSampleTypeIByID" returntype="any" output="false" access="public" >
        <cfquery name="qgetSampleTypeIByID" datasource="#Application.dsn#">
            SELECT *  FROM ST_SampleType where SA_ID = #SEID# order by ID Desc
        </cfquery>
        <cfreturn qgetSampleTypeIByID>
    </cffunction>
    <cffunction name="getSampleTypeDataSingle" returntype="any" output="false" access="public" >
        <cfquery name="qgetSampleTypeDataSingle" datasource="#Application.dsn#">
            SELECT *  FROM ST_SampleType where ID = #STID# order by ID Desc
        </cfquery>
        <cfreturn qgetSampleTypeDataSingle>
    </cffunction>
    <cffunction name="getSampleArchive_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetSampleArchive_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_SampleArchive where ID = 0
        </cfquery>
        <cfreturn qgetSampleArchive_ten>
    </cffunction>

    <cffunction name="getSampleArchiveData" returntype="any" output="false" access="public" >
        <cfquery name="qgetSampleArchiveData" datasource="#Application.dsn#"  >
            SELECT * from ST_SampleArchive where ID = #SEID#
        </cfquery>
        <cfreturn qgetSampleArchiveData>
    </cffunction>

    <cffunction name="getSampleArchiveFBNumber" returntype="any" output="false" access="remote" returnformat="json" >
        <cfargument name="a"  required="false" default= 1>
        <cfargument name="b"  required="false" default= 100>
        <cfquery name="qgetSampleArchiveFBNumber" datasource="#Application.dsn#"  >
            SELECT ID,Fnumber from ST_SampleArchive where deleted != '1' order by Fnumber ASC 
        </cfquery>
        <cfreturn qgetSampleArchiveFBNumber>
    </cffunction>
    <cffunction name="getSampleFBNumberList" returntype="any" output="false" access="remote" returnformat="json">
        <cfquery name="qgetSampleFBNumberList" datasource="#Application.dsn#"  >
            SELECT ID,Fnumber from ST_SampleArchive where deleted != '1'  order by Fnumber ASC
        </cfquery>
        <cfreturn qgetSampleFBNumberList>
    </cffunction>
    <cffunction name="getSampleArchiveDate" returntype="any" output="false" access="remote" returnformat="json">
        <cfargument name="a"  required="false" default= 1>
        <cfargument name="b"  required="false" default= 100>
        <cfquery name="qgetSampleArchiveDate" datasource="#Application.dsn#"  >
            SELECT ID,ISNULL(CONVERT(varchar,date,101),'') AS Date from ST_SampleArchive where deleted != '1' order by DATE DESC 
        </cfquery>
        <cfreturn qgetSampleArchiveDate>
    </cffunction>

    <cffunction name="getSampleArchiveID" returntype="any" output="false" access="remote" returnformat="json">
        <cfargument name="a"  required="false" default= 1>
        <cfargument name="b"  required="false" default= 100>
        <cfquery name="qgetSampleArchiveID" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_SampleArchive where deleted != '1' order by ID DESC 
        </cfquery>
        <cfreturn qgetSampleArchiveID>
    </cffunction>
    <!--- working --->
    <cffunction name="getmaindate" returntype="any" output="false" access="remote" returnformat="json">
        <cfif NOT isDefined('startvalue')>
            <cfset startvalue = "1">
            <cfset endValue = "2000">
            
        </cfif>
        <!--- <cfdump var="#startvalue#" abort="true"> --->

        <cfquery name="qgetmaindate" datasource="#Application.dsn#"  >
            select maindate,SA_ID,ID from ST_SampleType WHERE maindate != '' AND ID BETWEEN #startvalue# AND #endValue# ORDER BY SA_ID asc
        </cfquery>
        <cfreturn qgetmaindate>
    </cffunction>

    <cffunction name="searchData" returntype="any" output="false" access="remote" returnformat="json">
       <!--- <cfset value = CONVERT(INT, CONVERT(VARCHAR(12), value))> --->
            <!--- <cfdump var="#value#" abort="true"> --->
        <cfquery name="qgetmaindate1" datasource="#Application.dsn#"  result="res">
            select maindate,SA_ID from ST_SampleType WHERE maindate LIKE '%#(value)#%' ORDER BY SA_ID asc
        </cfquery>
        <cfreturn qgetmaindate1>
    </cffunction>
<!--- working end --->


    <cffunction name="getSampleList" returntype="any" output="false" access="remote" returnformat="json">
        <cfquery name="qgetSampleList" datasource="#Application.dsn#"  >
            SELECT ID,date from ST_SampleArchive where deleted != '1'  order by ID DESC
        </cfquery>
        <cfreturn qgetSampleList>
    </cffunction>
    
    <cffunction name="getSampleDataByLCE" returntype="any" output="false" access="public" >
        <cfquery name="qgetSampleDataByLCE" datasource="#Application.dsn#"  >
            SELECT * from ST_SampleArchive where LCE_ID = #LCEID#
        </cfquery>
        <cfreturn qgetSampleDataByLCE>
    </cffunction>
    <cffunction name="InsertSampleData"  returntype="any" output="false" access="remote" >
        <cfargument name="SADate" type="string" required="false">
        <cfargument name="SampleLocation" type="string" required="false">
        <cfargument name="LabSentto" type="string" required="false">
        <cfargument name="SampleArchiveNote" type="string" required="false">
        <cfargument name="SampleTracking" type="string" required="false">
        <cfargument name="subsample" type="string" required="false">
        <cfargument name="Thawed" type="string" required="false">
        <cfargument name="subsampleDate" type="string" required="false">
        <cfargument name="ST_ID" type="numeric" required="false">
        <!--- <cfdump var="#arguments#"><cfabort> --->
        <cfif len(trim(SADate)) GT 0 >
			<cfloop from="1" to="#ListLen(SADate)#" index="i">
                <cfquery name="qInsertSampleData" datasource="#variables.dsn#">
                   Insert into ST_SampleDetail  (SADate,SampleLocation,LabSentto,SampleNote,SampleTracking,Sample_available,Thawed,subsampleDate,ST_ID)
                    values
                    (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(SADate,i)#' null="#IIF(SADate EQ "", true, false)#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(SampleLocation,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(LabSentto,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(SampleArchiveNote,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(SampleTracking,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(subsample,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(Thawed,i)#'>
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(subsampleDate,i)#' null="#IIF(subsampleDate EQ "", true, false)#">
                        ,<cfqueryparam cfsqltype="cf_sql_integer" value='#ST_ID#'>
                    )
                </cfquery>
            </cfloop>
		</cfif>
		<cfreturn True>
    </cffunction>
    
    <cffunction name="updatesampleDetail"  returntype="any" output="false" access="remote" >
       
        <!--- <cfdump var="#form.samplDate#"><cfabort> --->

        <cfquery name="qupdateSampleData" datasource="#Application.dsn#" >
            update ST_SampleDetail set
            SADate=<cfqueryparam cfsqltype="cf_sql_varchar" value='#samplDate#' null="#IIF(SADate EQ "", true, false)#">
            ,SampleLocation=<cfqueryparam cfsqltype="cf_sql_varchar" value='#locat#'>
            ,LabSentto=<cfqueryparam cfsqltype="cf_sql_varchar" value='#sent#'>
            ,SampleNote=<cfqueryparam cfsqltype="cf_sql_varchar" value='#note#'>
            ,SampleTracking=<cfqueryparam cfsqltype="cf_sql_varchar" value='#track#'>
            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
            
        </cfquery>
        <cfdump var="#qupdateSampleData#">
		<cfreturn True>
	</cffunction>


    <cffunction name="deletesampleDetail"  returntype="any" output="false" access="remote" returnformat="json">
        
        <cfquery name="qdeleteSampleData" datasource="#Application.dsn#">
            delete from ST_SampleDetail
            where ID = '#ID#'
        </cfquery>
        <!--- <cfdump var="#deletesampleDetail#"> --->
		<cfreturn True>
    </cffunction>
    
    
    <cffunction name="deleteLesion"  returntype="any" output="false" access="remote" returnformat="json">
        
        <cfquery name="qdeleteLesion" datasource="#Application.dsn#">
            delete from ST_Lesion
            where ID = '#ID#'
        </cfquery>
		<cfreturn True>
    </cffunction>
    
    <cffunction name="AncillaryLesion"  returntype="any" output="false" access="remote" returnformat="json">
        
        <cfquery name="qAncillaryLesion" datasource="#Application.dsn#">
            delete from ST_Ancillary_Report
            where ID = '#ID#'
        </cfquery>
		<cfreturn True>
	</cffunction>

    <cffunction name="getSampleDetailDataSingle" returntype="any" output="false" access="public" >
        <cfquery name="qgetSampleData" datasource="#variables.dsn#">
            SELECT *  FROM ST_SampleDetail where ST_ID = #STID#
        </cfquery>
        <cfreturn qgetSampleData>
    </cffunction>
    

    <cffunction name="SampleArchiveUpdate" returntype="any" output="false" access="public" >
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>

        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset UpdateCetacean4Sections(argumentCollection="#Form#")>
        </cfif> --->
        <cftry>
            <cfquery name="qSampleArchiveUpdate" datasource="#variables.dsn#">
                UPDATE  ST_SampleArchive SET
                ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
                ,Deleted = <cfqueryparam cfsqltype="cf_sql_varchar" value='0'>
                ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
                ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
                ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>
 	            ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
                ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
                ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
                ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
                ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
                ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
                ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
                ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
                ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
                ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
                ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
                WHERE
                ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.SEID#'>
            </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        
        <!--- <cfif isDefined('form.LCE_ID') and form.LCE_ID neq 0>
            <cfset form.ID = form.LCE_ID>
            <cfset UpdateLevelA_HI(argumentCollection="#Form#")>
        </cfif> --->
        <cfreturn True>
    </cffunction>
    <cffunction name="DeleteSampleType" returntype="any" output="false" access="public" >
        <cfquery name="qDeleteSampleType" datasource="#variables.dsn#">
            Delete from ST_SampleArchive 
            where ID = #SampleArchiveSEID#
        </cfquery>
        <cfreturn True>
    </cffunction>
    <cffunction name="deleteallSampleArchiveRecord" returntype="any" output="false" access="public" >
        <cfquery name="qdeleteallSampleArchiveRecord" datasource="#variables.dsn#">
            TRUNCATE Table ST_SampleType   
        </cfquery>
        <cfquery name="qdeleteallSampleArchiveRecord" datasource="#variables.dsn#">
            TRUNCATE Table ST_SampleArchive   
        </cfquery>
        <cfquery name="qdeleteallSampleArchiveRecord" datasource="#variables.dsn#">
            TRUNCATE Table ST_SampleDetail   
        </cfquery>
        <cfreturn True>
    </cffunction>
    <cffunction name="deleteMorphometricsAllRecord" returntype="any" output="false" access="public" >        
          <cfquery name="qdeleteallMorphometricsRecord" datasource="#variables.dsn#">
            TRUNCATE Table ST_Morphometrics   
        </cfquery>      
        <cfreturn True>
    </cffunction>
    <cffunction name="deleteMorphometrics" returntype="any" output="false" access="public" >        
          <cfquery name="qdeleteMorphometrics" datasource="#variables.dsn#">
            delete from ST_Morphometrics
            where ID = '#form.Morphometricss_ID#'       
        </cfquery>      
        <cfreturn True>
    </cffunction>
    <!--- getcetaceanexamDate --->
    <cffunction name="getcetaceanexamDate" returntype="any" output="false" access="public">
        <cfquery name="qgetcetaceanexamDate" datasource="#Application.dsn#"  >
             SELECT cnr.CNRDATE as cnrdate  from ST_SampleArchive sa 
            left JOIN ST_CetaceanNecropsyReport cnr on cnr.fnumber = sa.Fnumber
            where sa.ID = #SEID#
        </cfquery>
        <cfreturn qgetcetaceanexamDate>
    </cffunction>
    <cffunction name="getcetaceanNecropsyDate" returntype="any" output="false" access="public">
        <cfquery name="qgetcetaceanNecropsyDate" datasource="#Application.dsn#"  >
            SELECT cn.CNRDATE as cnrdate  from ST_LiveCetaceanExam sa 
            left JOIN ST_CetaceanNecropsyReport cn on cn.Fnumber = sa.Fnumber
            where sa.ID = '#form.LCEID#'            
        </cfquery>
        <cfreturn qgetcetaceanNecropsyDate>
    </cffunction>
    <cffunction name="getHIFormNecropsyDate" returntype="any" output="false" access="public">
        <cfquery name="qgetHIFormNecropsyDate" datasource="#Application.dsn#"  >
            SELECT cn.CNRDATE as cnrdate  from ST_HIForm sa 
            left JOIN ST_CetaceanNecropsyReport cn on cn.Fnumber = sa.Fnumber
            where sa.ID = '#form.LCEID#'            
        </cfquery>
        <cfreturn qgetHIFormNecropsyDate>
    </cffunction>
    <cffunction name="getLevelAFormNecropsyDate" returntype="any" output="false" access="public">
        <cfquery name="qgetLevelAFormNecropsyDate" datasource="#Application.dsn#"  >
            SELECT cn.CNRDATE as cnrdate  from ST_LevelAForm sa 
            left JOIN ST_CetaceanNecropsyReport cn on cn.Fnumber = sa.Fnumber
            where sa.ID = '#form.LA_ID#'            
        </cfquery>
        <cfreturn qgetLevelAFormNecropsyDate>
    </cffunction>
    <cffunction name="getHistopathologyNecropsyDate" returntype="any" output="false" access="public">
        <cfquery name="qgetHistopathologyNecropsyDate" datasource="#Application.dsn#"  >
            SELECT cn.CNRDATE as cnrdate  from ST_HistoForm sa 
            left JOIN ST_CetaceanNecropsyReport cn on cn.Fnumber = sa.Fnumber
            where sa.ID = '#form.His_ID#'            
        </cfquery>
        <cfreturn qgetHistopathologyNecropsyDate>
    </cffunction>
    <cffunction name="getBloodValueNecropsyDate" returntype="any" output="false" access="public">
        <cfquery name="qgetBloodValueNecropsyDate" datasource="#Application.dsn#"  >
            SELECT cn.CNRDATE as cnrdate  from ST_Blood_Values sa 
            left JOIN ST_CetaceanNecropsyReport cn on cn.Fnumber = sa.Fnumber
            where sa.ID = '#form.bloodValue_ID#'            
        </cfquery>
        <cfreturn qgetBloodValueNecropsyDate>
    </cffunction>
    <cffunction name="getToxicologyNecropsyDate" returntype="any" output="false" access="public">
        <cfquery name="qgetToxicologyNecropsyDate" datasource="#Application.dsn#"  >
            SELECT cn.CNRDATE as cnrdate  from ST_Toxicology sa 
            left JOIN ST_CetaceanNecropsyReport cn on cn.Fnumber = sa.Fnumber
            where sa.ID = '#form.Toxicology_ID#'            
        </cfquery>
        <cfreturn qgetToxicologyNecropsyDate>
    </cffunction>
    <cffunction name="getAncillaryDiagnosticsNecropsyDate" returntype="any" output="false" access="public">
        <cfquery name="qgetAncillaryDiagnosticsNecropsyDate" datasource="#Application.dsn#"  >
            SELECT cn.CNRDATE as cnrdate  from ST_Ancillary_Diagnostics sa 
            left JOIN ST_CetaceanNecropsyReport cn on cn.Fnumber = sa.Fnumber
            where sa.ID = '#form.AD_ID#'            
        </cfquery>
        <cfreturn qgetAncillaryDiagnosticsNecropsyDate>
    </cffunction>
    <cffunction name="getMorphometricsNecropsyDate" returntype="any" output="false" access="public">
        <cfquery name="qgetMorphometricsNecropsyDate" datasource="#Application.dsn#"  >
            SELECT cn.CNRDATE as cnrdate  from ST_Morphometrics sa 
            left JOIN ST_CetaceanNecropsyReport cn on cn.Fnumber = sa.Fnumber
            where sa.ID = '#form.Morphometrics_ID#'            
        </cfquery>
        <cfreturn qgetMorphometricsNecropsyDate>
    </cffunction>


    <cffunction name="getcetaceanNecropsyDate_ten" returntype="any" output="false" access="public">
        <cfquery name="qgetcetaceanNecropsyDate_ten" datasource="#Application.dsn#"  >
             SELECT cn.date as cnrdate  from ST_LiveCetaceanExam sa 
            left JOIN ST_CetaceanNecropsyReport cn on cn.fnumber = sa.Fnumber
            where sa.ID = 0
        </cfquery>
        <cfreturn qgetcetaceanNecropsyDate_ten>
    </cffunction>
    
    <!--- getcetaceanexamDate_ten --->
    <cffunction name="getcetaceanexamDate_ten" returntype="any" output="false" access="public">
        <cfquery name="qgetcetaceanexamDate_ten" datasource="#Application.dsn#"  >
             SELECT lc.date,cnr.date as cnrdate  from ST_SampleArchive sa 
            left Join ST_LiveCetaceanExam lc on sa.Fnumber = lc.Fnumber
            left JOIN ST_CetaceanNecropsyReport cnr on cnr.fnumber = sa.Fnumber
            where sa.ID = 0
        </cfquery>
        <cfreturn qgetcetaceanexamDate_ten>
    </cffunction>
    
    <!--- Necropsy --->
    <cffunction name="CetaceanNecropsyinsert" returntype="any" output="false" access="public" >
       
        <cfif NOT isDefined('FORM.attendingVeterinarian')>
            <cfset FORM.attendingVeterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.CENTRALBrainFindings')>
            <cfset FORM.CENTRALBrainFindings = "">
        </cfif>
        <cfif NOT isDefined('FORM.CENTRALSpinalCordfinding')>
            <cfset FORM.CENTRALSpinalCordfinding = "">
        </cfif>
        <cfif NOT isDefined('FORM.Prosectors')>
            <cfset FORM.Prosectors = "">
        </cfif>
        <cfif NOT isDefined('FORM.NxLocation')>
            <cfset FORM.NxLocation = "">
        </cfif>
        <cfif NOT isDefined('FORM.eyeleft')>
            <cfset FORM.eyeleft = "">
        </cfif>
        <cfif NOT isDefined('FORM.eyeright')>
            <cfset FORM.eyeright = "">
        </cfif>
        <cfif NOT isDefined('FORM.Skeletal_Findings')>
            <cfset FORM.Skeletal_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.Musculature_Findings')>
            <cfset FORM.Musculature_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.ABDOMINAL_Lining')>
            <cfset FORM.ABDOMINAL_Lining = "">
        </cfif>
        <cfif NOT isDefined('FORM.Liver_Findings')>
            <cfset FORM.Liver_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.Overall_Findings')>
            <cfset FORM.Overall_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.Lungs_Findings')>
            <cfset FORM.Lungs_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.Kidney_left')>
            <cfset FORM.Kidney_left = "">
        </cfif>
        <cfif NOT isDefined('FORM.Kidney_right')>
            <cfset FORM.Kidney_right = "">
        </cfif>
        <cfif NOT isDefined('FORM.GIFOREIGNMATERIAL')>
            <cfset FORM.GIFOREIGNMATERIAL = "">
        </cfif>
        
        <cfif NOT isDefined('FORM.new')>
            <cfset FORM.new = "">
        </cfif>
        <cfif NOT isDefined('FORM.hera')>
            <cfset FORM.hera = "">
        </cfif>
        <cfif NOT isDefined('FORM.lessionphototaken')>
            <cfset FORM.lessionphototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.internal_phototaken')>
            <cfset FORM.internal_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.muscular_phototaken')>
            <cfset FORM.muscular_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.thoratic_phototaken')>
            <cfset FORM.thoratic_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.abdominal_phototaken')>
            <cfset FORM.abdominal_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.hepatobiliary_phototaken')>
            <cfset FORM.hepatobiliary_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.cardio_phototaken')>
            <cfset FORM.cardio_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.pulmonary_phototaken')>
            <cfset FORM.pulmonary_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.lympho_phototaken')>
            <cfset FORM.lympho_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.endocrine_phototaken')>
            <cfset FORM.endocrine_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.UROGENITAL_phototaken')>
            <cfset FORM.UROGENITAL_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.Parasite_phototaken')>
            <cfset FORM.Parasite_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.nervoussystemphototaken')>
            <cfset FORM.nervoussystemphototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.Parasites_Location')>
            <cfset FORM.Parasites_Location = "">
        </cfif>
        <cfif NOT isDefined('FORM.GIForeignMaterialType')>
            <cfset FORM.GIForeignMaterialType = "">
        </cfif>
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>  
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>

        <cfquery name="qcheckfieldnumber" datasource="#Application.dsn#">
            SELECT fnumber FROM ST_CetaceanNecropsyReport
            WHERE fnumber ='#form.Fnumber#'
        </cfquery>
        
            <cftry>
                <!--- <cfdump var="awan" abort="true"> --->
                <cfquery name="qinsertCetaceanNecropsy" datasource="#variables.dsn#"  result="return_data">
                    INSERT INTO ST_CetaceanNecropsyReport
                    (

                    fnumber
                    ,date
                    ,species
                    ,location
                    ,new
                    ,hera
                    ,InitialCondition
                    ,sex
                    ,ageClass
                    ,briefhistory
                    ,attendingVeterinarian
                    ,Prosectors
                    ,Tentative
                    ,deathcause
                    ,historemark
                    ,totalLength
                    ,rostrum
                    ,blowhole
                    ,fluke
                    ,girth
                    ,maxium
                    ,blubber
                    ,midlateral
                    ,Lateralupperleft
                    ,Laterallowerleft
                    ,Ventralupperleft
                    ,Ventrallowerright
                    ,Necropsycondition
                    ,Euthanized
                    ,LevelADate
                    ,AnimalRenderings
                    ,NxLocation
                    ,ExternalExamphoto
                    ,Lesionform
                    ,HIForm
                    ,cutterwounds
                    ,cutterscars
                    ,eyeleft
                    ,eyeright
                    ,lessiondescribe
                    ,lessioncomments
                    ,lessionphototaken
                    ,Integumentphoto
                    ,Fat_Blubber
                    ,heart
                    ,mesentery
                    ,kidney
                    ,internal_comments
                    ,internal_phototaken
                    ,intenalExamphoto
                    ,Joint_Fluid
                    ,Skeletal_Findings
                    ,Musculature_Findings
                    ,muscular_comments
                    ,muscular_phototaken
                    ,THORACIC
                    ,fluidVolume
                    ,ml
                    ,THORACIC_Fluid
                    ,THORACIC_Lining
                    ,thoratic_comments
                    ,thoratic_phototaken
                    ,ABDOMINAL
                    ,abdominal_fluidVolume
                    ,ABDOMINAL_ml
                    ,ABDOMINAL_Fluid
                    ,ABDOMINAL_Lining
                    ,abdominal_comments
                    ,abdominal_phototaken
                    ,HEPATOBILIARY
                    ,Liver_Findings
                    ,Biliary_Findings
                    ,hepatobiliary_comments
                    ,hepatobiliary_phototaken
                    ,CARDIOVASCULAR
                    ,Chambers
                    ,cardio_describe
                    ,Pericardial_Fluid
                    ,cardio_comments
                    ,cardio_phototaken
                    ,PULMONARY
                    ,Froth_in_Airway
                    ,If_Present
                    ,Foam_Amount
                    ,Color_of_Foam
                    ,Sand_Sediment
                    ,Trachea_Bronchi
                    ,Lungs_Findings
                    ,Lungs_Float
                    ,pulmonary_comments
                    ,pulmonary_phototaken
                    ,PULMONARYParasites
                    ,Parasites_Location
                    ,pulmonary_textarea
                    ,LYMPHORETICULAR
                    ,Spleen
                    ,Spleen_Findings
                    ,lympho_other
                    ,lympho_comments
                    ,lympho_phototaken
                    ,ENDOCRINE
                    ,Adrenal_Glands
                    ,adrenal_leftLength
                    ,adrenal_rightLength
                    ,adrenal_leftwidth
                    ,adrenal_rightwidth
                    ,Thyroid
                    ,thyroid_length
                    ,thyroid_width
                    ,Pituitary_Gland
                    ,Pituitary_length
                    ,Pituitary_width
                    ,endocrine_comments
                    ,endocrine_phototaken
                    ,UROGENITAL
                    ,Kidney_left
                    ,Kidney_right
                    ,Urinary_Bladder
                    ,urin_volume
                    ,UROGENITAL_color
                    ,Consistancy
                    ,Abnormalities
                    ,Abnormalities_describe
                    ,Reproductive_Organs
                    ,Identified_As
                    ,Lesions
                    ,Gonads_Identified
                    ,Testes_Length_LEFT
                    ,Testes_Length_width
                    ,Glands_LEFT
                    ,Testes_Length_right
                    ,Testes_width_right
                    ,Glands_RIGHT
                    ,Ovary_Length_LEFT
                    ,Ovary_Width_LEFT
                    ,Follicles_Present_Left
                    ,Ovary_Length_right
                    ,Ovary_width_right
                    ,Follicles_Present_right
                    ,UROGENITAL_Comments
                    ,UROGENITAL_phototaken
                    ,ALIMENTARYSYSTEM
                    ,ESOPHAGUSUlcers
                    ,ESOPHAGUSTrauma
                    ,ESOPHAGUSMasses
                    ,ESOPHAGUSImpaction
                    ,ESOPHAGUSObstruction
                    ,ESOPHAGUSlntussusception
                    ,ESOPHAGUSParasites
                    ,ESOPHAGUSOther
                    ,ESOPHAGUSContents
                    ,FORESTOMACHUlcers
                    ,FORESTOMACHTrauma
                    ,FORESTOMACHMasses
                    ,FORESTOMACHImpaction
                    ,FORESTOMACHObstruction
                    ,FORESTOMACHlntussusception
                    ,FORESTOMACHParasites
                    ,FORESTOMACHOther
                    ,FORESTOMACHContents
                    ,GLANDULARSTOMACHUlcers
                    ,GLANDULARSTOMACHTrauma
                    ,GLANDULARSTOMACHMasses
                    ,GLANDULARSTOMACHImpaction
                    ,GLANDULARSTOMACHObstruction
                    ,GLANDULARSTOMACHlntussusception
                    ,GLANDULARSTOMACHParasites
                    ,GLANDULARSTOMACHOther
                    ,GLANDULARSTOMACHContents
                    ,PYLORUSUlcers
                    ,PYLORUSTrauma
                    ,PYLORUSMasses
                    ,PYLORUSImpaction
                    ,PYLORUSObstruction
                    ,PYLORUSlntussusception
                    ,PYLORUSParasites
                    ,PYLORUSOther
                    ,PYLORUSContents
                    ,SMALLINTESTINEUlcers
                    ,SMALLINTESTINETrauma
                    ,SMALLINTESTINEMasses
                    ,SMALLINTESTINEImpaction
                    ,SMALLINTESTINEObstruction
                    ,SMALLINTESTINElntussusception
                    ,SMALLINTESTINEParasites
                    ,SMALLINTESTINEOther
                    ,SMALLINTESTINEContents
                    ,COLONUlcers
                    ,COLONTrauma
                    ,COLONMasses
                    ,COLONImpaction
                    ,COLONObstruction
                    ,COLONlntussusception
                    ,COLONParasites
                    ,COLONOther
                    ,COLONContents
                    ,PANCREAS
                    ,PancreasFindings
                    ,PANCREASOthers
                    ,GIFOREIGNMATERIAL
                    ,InjuryLesionAssociated 
                    ,InjuryLesionAssociatedContents
                    ,GIForeignMaterialType
                    ,MaterialLesionLocation
                    ,MaterialCollected
                    ,DispositionofMaterialCollected
                    ,Parasitecomments
                    ,Parasite_phototaken
                    ,CENTRALbrain
                    ,CENTRALBrainFindings
                    ,brainother
                    ,CENTRALSpinalCord
                    ,CENTRALSpinalCordfinding
                    ,spinalother
                    ,nervoussystemcomments
                    ,nervoussystemphototaken
                    ,midVentral
                    ,axillary 
                    ,Overall_Findings
                    ,images
                    ,integumentImages
                    ,IntenalExamImages
                    ,HistoImages
                    ,abdominalImages
                    ,thoracictImages
                    ,hepatobiliaryImages
                    ,cardiovascularImages
                    ,pulmonaryImages
                    ,lymphoreticularImages
                    ,endocrineImages
                    ,urogenitalImages
                    ,alimentaryImages
                    ,centralNervousImages
                    ,musculoskeletalImages
                    ,affiliatedID
                    ,ResearchTeam
                    ,Veterinarian
                    ,BodyOfWater
                    ,NOAAStock
                    ,StTpye
                    ,NMFS
                    ,NDB
                    ,NAA
                    ,code
                    ,lat
                    ,lon
                    ,county
                    ,FinalCondition
                    ,actualClass
                    ,Bodycondition
                    ,MUSCULOSKELETAL
                    ,Muscle_Status
                    ,euthanizedCB
                    ,CNRDATE
                    ) 
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.date#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.location#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.new#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.briefhistory#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.attendingVeterinarian#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Prosectors#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Tentative#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.deathcause#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.historemark#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.totalLength#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.rostrum#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.blowhole#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.fluke#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.girth#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.maxium#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.blubber#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.midlateral#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lateralupperleft#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Laterallowerleft#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ventralupperleft#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ventrallowerright#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Necropsycondition#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Euthanized#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LevelADate#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AnimalRenderings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NxLocation#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ExternalExamphoto#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lesionform#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HIForm#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cutterwounds#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cutterscars#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.eyeleft#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.eyeright#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lessiondescribe#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lessioncomments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lessionphototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Integumentphoto#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fat_Blubber#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.heart#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.mesentery#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.kidney#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.internal_comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.internal_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.intenalExamphoto#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Joint_Fluid#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Skeletal_Findings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Musculature_Findings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.muscular_comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.muscular_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.THORACIC#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.fluidVolume#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ml#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.THORACIC_Fluid#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.THORACIC_Lining#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thoratic_comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thoratic_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ABDOMINAL#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.abdominal_fluidVolume#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ABDOMINAL_ml#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ABDOMINAL_Fluid#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ABDOMINAL_Lining#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.abdominal_comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.abdominal_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HEPATOBILIARY#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Liver_Findings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Biliary_Findings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hepatobiliary_comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hepatobiliary_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CARDIOVASCULAR#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Chambers#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cardio_describe#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pericardial_Fluid#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cardio_comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cardio_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PULMONARY#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Froth_in_Airway#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.If_Present#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Foam_Amount#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Color_of_Foam#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sand_Sediment#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Trachea_Bronchi#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lungs_Findings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lungs_Float#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pulmonary_comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pulmonary_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PULMONARYParasites#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Parasites_Location#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pulmonary_textarea#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LYMPHORETICULAR#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Spleen#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Spleen_Findings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lympho_other#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lympho_comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lympho_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ENDOCRINE#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Adrenal_Glands#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.adrenal_leftLength#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.adrenal_rightLength#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.adrenal_leftwidth#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.adrenal_rightwidth#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Thyroid#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thyroid_length#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thyroid_width#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pituitary_Gland#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pituitary_length#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pituitary_width#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.endocrine_comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.endocrine_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UROGENITAL#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Kidney_left#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Kidney_right#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Urinary_Bladder#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.urin_volume#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UROGENITAL_color#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Consistancy#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Abnormalities#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Abnormalities_describe#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Reproductive_Organs#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Identified_As#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lesions#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Gonads_Identified#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Testes_Length_LEFT#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Testes_Length_width#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glands_LEFT#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Testes_Length_right#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Testes_width_right#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glands_RIGHT#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ovary_Length_LEFT#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ovary_Width_LEFT#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Follicles_Present_Left#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ovary_Length_right#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ovary_width_right#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Follicles_Present_right#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UROGENITAL_Comments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UROGENITAL_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ALIMENTARYSYSTEM#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSUlcers#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSTrauma#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSMasses#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSImpaction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSObstruction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSlntussusception#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSParasites#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSOther#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSContents#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHUlcers#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHTrauma#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHMasses#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHImpaction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHObstruction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHlntussusception#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHParasites#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHOther#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHContents#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHUlcers#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHTrauma#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHMasses#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHImpaction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHObstruction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHlntussusception#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHParasites#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHOther#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHContents#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSUlcers#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSTrauma#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSMasses#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSImpaction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSObstruction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSlntussusception#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSParasites#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSOther#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSContents#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEUlcers#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINETrauma#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEMasses#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEImpaction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEObstruction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINElntussusception#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEParasites#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEOther#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEContents#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONUlcers#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONTrauma#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONMasses#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONImpaction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONObstruction#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONlntussusception#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONParasites#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONOther#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONContents#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PANCREAS#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PancreasFindings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PANCREASOthers#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GIFOREIGNMATERIAL#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InjuryLesionAssociated #'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InjuryLesionAssociatedContents#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GIForeignMaterialType#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MaterialLesionLocation#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MaterialCollected#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.DispositionofMaterialCollected#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Parasitecomments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Parasite_phototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CENTRALbrain#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CENTRALBrainFindings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.brainother#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CENTRALSpinalCord#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CENTRALSpinalCordfinding#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.spinalother#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.nervoussystemcomments#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.nervoussystemphototaken#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.midVentral#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.axillary #'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Overall_Findings#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.imagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.integumentImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.intenalExamImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.histoImages#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.abdominalImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thoracicImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hepatobiliaryImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cardiovascularImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pulmonaryImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cardiovascularImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.endocrineImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.urogenitalImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.alimentaryImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.centralNervousImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.musculoskeletalImagesFile#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NecropsyBodycondition#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MUSCULOSKELETALNecropsy#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Muscle_Status#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.necropsyDateID#'>
                    )
                </cfquery>
                <cfcatch type="any">
                    <cfdump  var="#cfcatch#"><cfabort>
                </cfcatch>
            </cftry>
        <!--- <cfdump var="#return_data#" abort="true"> --->
        <cfset test = "#FORM.Fnumber#">
        <cfreturn test>
    </cffunction>
    <!--- updateCetaceanNecropsy --->
    <cffunction name="updateCetaceanNecropsy" returntype="any" output="false" access="public">
        <cfif NOT isDefined('FORM.attendingVeterinarian')>
            <cfset FORM.attendingVeterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.CENTRALBrainFindings')>
            <cfset FORM.CENTRALBrainFindings = "">
        </cfif>
        <cfif NOT isDefined('FORM.CENTRALSpinalCordfinding')>
            <cfset FORM.CENTRALSpinalCordfinding = "">
        </cfif>
        <cfif NOT isDefined('FORM.Prosectors')>
            <cfset FORM.Prosectors = "">
        </cfif>
        <cfif NOT isDefined('FORM.NxLocation')>
            <cfset FORM.NxLocation = "">
        </cfif>
        <cfif NOT isDefined('FORM.eyeleft')>
            <cfset FORM.eyeleft = "">
        </cfif>
        <cfif NOT isDefined('FORM.eyeright')>
            <cfset FORM.eyeright = "">
        </cfif>
        <cfif NOT isDefined('FORM.Skeletal_Findings')>
            <cfset FORM.Skeletal_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.Musculature_Findings')>
            <cfset FORM.Musculature_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.ABDOMINAL_Lining')>
            <cfset FORM.ABDOMINAL_Lining = "">
        </cfif>
        <cfif NOT isDefined('FORM.Liver_Findings')>
            <cfset FORM.Liver_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.Overall_Findings')>
            <cfset FORM.Overall_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.Lungs_Findings')>
            <cfset FORM.Lungs_Findings = "">
        </cfif>
        <cfif NOT isDefined('FORM.Kidney_left')>
            <cfset FORM.Kidney_left = "">
        </cfif>
        <cfif NOT isDefined('FORM.Kidney_right')>
            <cfset FORM.Kidney_right = "">
        </cfif>
        <cfif NOT isDefined('FORM.GIFOREIGNMATERIAL')>
            <cfset FORM.GIFOREIGNMATERIAL = "">
        </cfif>
        
        <cfif NOT isDefined('FORM.new')>
            <cfset FORM.new = "">
        </cfif>
        <cfif NOT isDefined('FORM.hera')>
            <cfset FORM.hera = "">
        </cfif>
        <cfif NOT isDefined('FORM.lessionphototaken')>
            <cfset FORM.lessionphototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.internal_phototaken')>
            <cfset FORM.internal_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.muscular_phototaken')>
            <cfset FORM.muscular_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.thoratic_phototaken')>
            <cfset FORM.thoratic_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.abdominal_phototaken')>
            <cfset FORM.abdominal_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.hepatobiliary_phototaken')>
            <cfset FORM.hepatobiliary_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.cardio_phototaken')>
            <cfset FORM.cardio_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.pulmonary_phototaken')>
            <cfset FORM.pulmonary_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.lympho_phototaken')>
            <cfset FORM.lympho_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.endocrine_phototaken')>
            <cfset FORM.endocrine_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.UROGENITAL_phototaken')>
            <cfset FORM.UROGENITAL_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.Parasite_phototaken')>
            <cfset FORM.Parasite_phototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.nervoussystemphototaken')>
            <cfset FORM.nervoussystemphototaken = "">
        </cfif>
        <cfif NOT isDefined('FORM.Parasites_Location')>
            <cfset FORM.Parasites_Location = "">
        </cfif>
        <cfif NOT isDefined('FORM.GIForeignMaterialType')>
            <cfset FORM.GIForeignMaterialType = "">
        </cfif>
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        <cftry>
            <cfquery name="qupdateCetaceanNecropsy" datasource="#variables.dsn#"  result="return_data" >
                UPDATE  ST_CetaceanNecropsyReport SET 
               
                 date =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.date#'>
                ,species =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
                ,location =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.location#'>
                ,new =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.new#'>
                ,hera =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
                ,InitialCondition =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
                ,sex =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
                ,ageClass =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
                ,briefhistory =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.briefhistory#'>
                ,attendingVeterinarian =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.attendingVeterinarian#'>
                ,Prosectors =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Prosectors#'>
                ,Tentative =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Tentative#'>
                ,deathcause =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.deathcause#'>
                ,historemark =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.historemark#'>
                ,totalLength =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.totalLength#'>
                ,rostrum =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.rostrum#'>
                ,blowhole =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.blowhole#'>
                ,fluke =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.fluke#'>
                ,girth =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.girth#'>
                ,maxium =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.maxium#'>
                ,blubber =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.blubber#'>
                ,midlateral =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.midlateral#'>
                ,Lateralupperleft =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lateralupperleft#'>
                ,Laterallowerleft =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Laterallowerleft#'>
                ,Ventralupperleft =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ventralupperleft#'>
                ,Ventrallowerright =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ventrallowerright#'>
                ,Necropsycondition =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Necropsycondition#'>
                ,Euthanized =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Euthanized#'>
                ,LevelADate =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LevelADate#'>
                ,AnimalRenderings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AnimalRenderings#'>
                ,NxLocation =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NxLocation#'>
                ,Lesionform =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lesionform#'>
                ,HIForm =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HIForm#'>
                ,cutterwounds =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cutterwounds#'>
                ,cutterscars =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cutterscars#'>
                ,eyeleft =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.eyeleft#'>
                ,eyeright =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.eyeright#'>
                ,lessiondescribe =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lessiondescribe#'>
                ,lessioncomments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lessioncomments#'>
                ,lessionphototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lessionphototaken#'>
                ,Fat_Blubber =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fat_Blubber#'>
                ,heart =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.heart#'>
                ,mesentery =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.mesentery#'>
                ,kidney =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.kidney#'>
                ,internal_comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.internal_comments#'>
                ,internal_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.internal_phototaken#'>
                ,Joint_Fluid =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Joint_Fluid#'>
                ,Skeletal_Findings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Skeletal_Findings#'>
                ,Musculature_Findings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Musculature_Findings#'>
                ,muscular_comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.muscular_comments#'>
                ,muscular_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.muscular_phototaken#'>
                ,THORACIC =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.THORACIC#'>
                ,fluidVolume =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.fluidVolume#'>
                ,ml =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ml#'>
                ,THORACIC_Fluid =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.THORACIC_Fluid#'>
                ,THORACIC_Lining =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.THORACIC_Lining#'>
                ,thoratic_comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thoratic_comments#'>
                ,thoratic_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thoratic_phototaken#'>
                ,ABDOMINAL =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ABDOMINAL#'>
                ,abdominal_fluidVolume =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.abdominal_fluidVolume#'>
                ,ABDOMINAL_ml =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ABDOMINAL_ml#'>
                ,ABDOMINAL_Fluid =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ABDOMINAL_Fluid#'>
                ,ABDOMINAL_Lining =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ABDOMINAL_Lining#'>
                ,abdominal_comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.abdominal_comments#'>
                ,abdominal_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.abdominal_phototaken#'>
                ,HEPATOBILIARY =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HEPATOBILIARY#'>
                ,Liver_Findings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Liver_Findings#'>
                ,Biliary_Findings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Biliary_Findings#'>
                ,hepatobiliary_comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hepatobiliary_comments#'>
                ,hepatobiliary_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hepatobiliary_phototaken#'>
                ,CARDIOVASCULAR =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CARDIOVASCULAR#'>
                ,Chambers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Chambers#'>
                ,cardio_describe =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cardio_describe#'>
                ,Pericardial_Fluid =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pericardial_Fluid#'>
                ,cardio_comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cardio_comments#'>
                ,cardio_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cardio_phototaken#'>
                ,PULMONARY =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PULMONARY#'>
                ,Froth_in_Airway =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Froth_in_Airway#'>
                ,If_Present =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.If_Present#'>
                ,Foam_Amount =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Foam_Amount#'>
                ,Color_of_Foam =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Color_of_Foam#'>
                ,Sand_Sediment =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sand_Sediment#'>
                ,Trachea_Bronchi =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Trachea_Bronchi#'>
                ,Lungs_Findings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lungs_Findings#'>
                ,Lungs_Float =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lungs_Float#'>
                ,pulmonary_comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pulmonary_comments#'>
                ,pulmonary_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pulmonary_phototaken#'>
                ,PULMONARYParasites =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PULMONARYParasites#'>
                ,Parasites_Location =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Parasites_Location#'>
                ,pulmonary_textarea =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pulmonary_textarea#'>
                ,LYMPHORETICULAR =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LYMPHORETICULAR#'>
                ,Spleen =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Spleen#'>
                ,Spleen_Findings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Spleen_Findings#'>
                ,lympho_other =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lympho_other#'>
                ,lympho_comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lympho_comments#'>
                ,lympho_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lympho_phototaken#'>
                ,ENDOCRINE =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ENDOCRINE#'>
                ,Adrenal_Glands =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Adrenal_Glands#'>
                ,adrenal_leftLength =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.adrenal_leftLength#'>
                ,adrenal_rightLength =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.adrenal_rightLength#'>
                ,adrenal_leftwidth =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.adrenal_leftwidth#'>
                ,adrenal_rightwidth =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.adrenal_rightwidth#'>
                ,Thyroid =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Thyroid#'>
                ,thyroid_length =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thyroid_length#'>
                ,thyroid_width =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thyroid_width#'>
                ,Pituitary_Gland =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pituitary_Gland#'>
                ,Pituitary_length =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pituitary_length#'>
                ,Pituitary_width =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Pituitary_width#'>
                ,endocrine_comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.endocrine_comments#'>
                ,endocrine_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.endocrine_phototaken#'>
                ,UROGENITAL =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UROGENITAL#'>
                ,Kidney_left =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Kidney_left#'>
                ,Kidney_right =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Kidney_right#'>
                ,Urinary_Bladder =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Urinary_Bladder#'>
                ,urin_volume =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.urin_volume#'>
                ,UROGENITAL_color =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UROGENITAL_color#'>
                ,Consistancy =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Consistancy#'>
                ,Abnormalities =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Abnormalities#'>
                ,Abnormalities_describe =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Abnormalities_describe#'>
                ,Reproductive_Organs =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Reproductive_Organs#'>
                ,Identified_As =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Identified_As#'>
                ,Lesions =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lesions#'>
                ,Gonads_Identified =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Gonads_Identified#'>
                ,Testes_Length_LEFT =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Testes_Length_LEFT#'>
                ,Testes_Length_width =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Testes_Length_width#'>
                ,Glands_LEFT =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glands_LEFT#'>
                ,Testes_Length_right =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Testes_Length_right#'>
                ,Testes_width_right =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Testes_width_right#'>
                ,Glands_RIGHT =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Glands_RIGHT#'>
                ,Ovary_Length_LEFT =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ovary_Length_LEFT#'>
                ,Ovary_Width_LEFT =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ovary_Width_LEFT#'>
                ,Follicles_Present_Left =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Follicles_Present_Left#'>
                ,Ovary_Length_right =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ovary_Length_right#'>
                ,Ovary_width_right =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ovary_width_right#'>
                ,Follicles_Present_right =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Follicles_Present_right#'>
                ,UROGENITAL_Comments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UROGENITAL_Comments#'>
                ,UROGENITAL_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.UROGENITAL_phototaken#'>
                ,ALIMENTARYSYSTEM =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ALIMENTARYSYSTEM#'>
                ,ESOPHAGUSUlcers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSUlcers#'>
                ,ESOPHAGUSTrauma =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSTrauma#'>
                ,ESOPHAGUSMasses =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSMasses#'>
                ,ESOPHAGUSImpaction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSImpaction#'>
                ,ESOPHAGUSObstruction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSObstruction#'>
                ,ESOPHAGUSlntussusception =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSlntussusception#'>
                ,ESOPHAGUSParasites =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSParasites#'>
                ,ESOPHAGUSOther =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSOther#'>
                ,ESOPHAGUSContents =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ESOPHAGUSContents#'>
                ,FORESTOMACHUlcers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHUlcers#'>
                ,FORESTOMACHTrauma =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHTrauma#'>
                ,FORESTOMACHMasses =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHMasses#'>
                ,FORESTOMACHImpaction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHImpaction#'>
                ,FORESTOMACHObstruction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHObstruction#'>
                ,FORESTOMACHlntussusception =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHlntussusception#'>
                ,FORESTOMACHParasites =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHParasites#'>
                ,FORESTOMACHOther =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHOther#'>
                ,FORESTOMACHContents =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FORESTOMACHContents#'>
                ,GLANDULARSTOMACHUlcers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHUlcers#'>
                ,GLANDULARSTOMACHTrauma =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHTrauma#'>
                ,GLANDULARSTOMACHMasses =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHMasses#'>
                ,GLANDULARSTOMACHImpaction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHImpaction#'>
                ,GLANDULARSTOMACHObstruction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHObstruction#'>
                ,GLANDULARSTOMACHlntussusception =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHlntussusception#'>
                ,GLANDULARSTOMACHParasites =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHParasites#'>
                ,GLANDULARSTOMACHOther =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHOther#'>
                ,GLANDULARSTOMACHContents =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GLANDULARSTOMACHContents#'>
                ,PYLORUSUlcers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSUlcers#'>
                ,PYLORUSTrauma =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSTrauma#'>
                ,PYLORUSMasses =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSMasses#'>
                ,PYLORUSImpaction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSImpaction#'>
                ,PYLORUSObstruction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSObstruction#'>
                ,PYLORUSlntussusception =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSlntussusception#'>
                ,PYLORUSParasites =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSParasites#'>
                ,PYLORUSOther =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSOther#'>
                ,PYLORUSContents =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PYLORUSContents#'>
                ,SMALLINTESTINEUlcers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEUlcers#'>
                ,SMALLINTESTINETrauma =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINETrauma#'>
                ,SMALLINTESTINEMasses =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEMasses#'>
                ,SMALLINTESTINEImpaction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEImpaction#'>
                ,SMALLINTESTINEObstruction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEObstruction#'>
                ,SMALLINTESTINElntussusception =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINElntussusception#'>
                ,SMALLINTESTINEParasites =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEParasites#'>
                ,SMALLINTESTINEOther =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEOther#'>
                ,SMALLINTESTINEContents =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SMALLINTESTINEContents#'>
                ,COLONUlcers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONUlcers#'>
                ,COLONTrauma =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONTrauma#'>
                ,COLONMasses =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONMasses#'>
                ,COLONImpaction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONImpaction#'>
                ,COLONObstruction =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONObstruction#'>
                ,COLONlntussusception =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONlntussusception#'>
                ,COLONParasites =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONParasites#'>
                ,COLONOther =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONOther#'>
                ,COLONContents =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.COLONContents#'>
                ,PANCREAS =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PANCREAS#'>
                ,PancreasFindings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PancreasFindings#'>
                ,PANCREASOthers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PANCREASOthers#'>
                ,GIFOREIGNMATERIAL =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GIFOREIGNMATERIAL#'>
                ,InjuryLesionAssociated  =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InjuryLesionAssociated#'>
                ,InjuryLesionAssociatedContents =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InjuryLesionAssociatedContents#'>
                ,GIForeignMaterialType =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GIForeignMaterialType#'>
                ,MaterialLesionLocation =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MaterialLesionLocation#'>
                ,MaterialCollected =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MaterialCollected#'>
                ,DispositionofMaterialCollected =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.DispositionofMaterialCollected#'>
                ,Parasitecomments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Parasitecomments#'>
                ,Parasite_phototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Parasite_phototaken#'>
                ,CENTRALbrain =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CENTRALbrain#'>
                ,CENTRALBrainFindings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CENTRALBrainFindings#'>
                ,brainother =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.brainother#'>
                ,CENTRALSpinalCord =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CENTRALSpinalCord#'>
                ,CENTRALSpinalCordfinding =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CENTRALSpinalCordfinding#'>
                ,spinalother =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.spinalother#'>
                ,nervoussystemcomments =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.nervoussystemcomments#'>
                ,nervoussystemphototaken =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.nervoussystemphototaken#'>
                ,midVentral =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.midVentral#'>
                ,axillary  =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.axillary#'>
                ,Overall_Findings =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Overall_Findings#'>
                ,images =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.imagesFile#'>
                ,integumentImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.integumentImagesFile#'>
                ,IntenalExamImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.intenalExamImagesFile#'>
                ,HistoImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.histoImages#'>
                ,abdominalImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.abdominalImagesFile#'>
                ,thoracictImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.thoracicImagesFile#'>
                ,hepatobiliaryImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hepatobiliaryImagesFile#'>
                ,cardiovascularImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cardiovascularImagesFile#'>
                ,pulmonaryImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.pulmonaryImagesFile#'>
                ,lymphoreticularImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lymphoreticularImagesFile#'>
                ,endocrineImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.endocrineImagesFile#'>
                ,urogenitalImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.urogenitalImagesFile#'>
                ,alimentaryImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.alimentaryImagesFile#'>
                ,centralNervousImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.centralNervousImagesFile#'>
                ,musculoskeletalImages =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.musculoskeletalImagesFile#'>
                ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
                ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
                ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
                ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
                ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
                ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
                ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
                ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
                ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NAA#'>
 	            ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
                ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
                ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
                ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
                ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
                ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
                ,Bodycondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NecropsyBodycondition#'>
                ,MUSCULOSKELETAL = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MUSCULOSKELETALNecropsy#'>
                ,Muscle_Status = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Muscle_Status#'>
                ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
                ,CNRDATE = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.necropsyDateID#'>
                WHERE
                fnumber =<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
            </cfquery>
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn TRUE>
    </cffunction>
    <!--- DynamicNutritioninsert --->
    <cffunction name="DynamicNutritioninsert" returntype="any" output="false" access="public">
        <cfargument name="organs_label" type="string" default="" required="false">
        <cfargument name="newNUTRI" type="string" default="" required="false">
        <cftry>
            <cfif len(trim(organs_label)) GT 0 >
                <cfloop from="1" to="#ListLen(organs_label)#" index="i">
                    <cfquery name="qDynamicNutritioninsert" datasource="#variables.dsn#"  result="return_data">
                        INSERT INTO ST_DynamicNutrition
                        (
                            fnumber
                            ,organs_label
                            ,newNUTRI
                        )
                        VALUES
                        (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                            , <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(organs_label,i)#'>
                            , <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(newNUTRI,i)#'>
                        )
                    </cfquery>
                </cfloop>
            </cfif>
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <!--- <cfset DN = "#return_data.generatedkey#">
        <cfreturn DN> --->
    </cffunction>
    <!--- DynamicLymphoreticular --->
    <cffunction name="DynamicLymphoreticularinsert" returntype="any" output="false" access="public">
        
        <cfargument name="lymphnode" type="string" default="" required="false">
        <cfargument name="nodelength" type="string" default="" required="false">
        <cfargument name="nodewidth" type="string" default="" required="false">
        <!--- <cfdump var="#form#" abort="true"> --->
        <cftry>
            <cfif len(trim(lymphnode)) GT 0 >
                <cfloop from="1" to="#ListLen(lymphnode)#" index="i">
                    <cfquery name="qDynamicLymphoreticularinsert" datasource="#variables.dsn#"  result="return_data">
                        INSERT INTO ST_DynamicLymphoreticular
                        (
                            fnumber
                            ,lymphnode
                            ,nodelength
                            ,nodewidth
                        )
                        VALUES
                        (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                            , <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(lymphnode,i)#'>
                            , <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(nodelength,i)#'>
                            , <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(nodewidth,i)#'>
                        )
                    </cfquery>
                </cfloop>
            </cfif>
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <!--- <cfset DL = "#return_data.generatedkey#">
        <cfreturn DL> --->
    </cffunction>
    <!--- DynamicParasites --->
    <cffunction name="DynamicParasitesinsert" returntype="any" output="false" access="public">
        <cfargument name="PARASITES" type="string" default="" required="false">
        <cfargument name="ParasiteType" type="string" default="" required="false">
        <cfargument name="Parasitelocation" type="string" default="" required="false">
        <cftry>
            <cfif len(trim(PARASITES)) GT 0 >
                <cfloop from="1" to="#ListLen(PARASITES)#" index="i">
                    <cfquery name="qDynamicParasitesinsert" datasource="#variables.dsn#"  result="return_data">
                        INSERT INTO ST_DynamicParasites
                        (
                            fnumber
                            ,PARASITES
                            ,ParasiteType
                            ,Parasitelocation
                        )
                        VALUES
                        (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
                            , <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(PARASITES,i)#'>
                            , <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(ParasiteType,i)#'>
                            , <cfqueryparam cfsqltype="cf_sql_varchar" value='#ListGetAt(Parasitelocation,i)#'>
                        )
                    </cfquery>
                </cfloop>
            </cfif>
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <!--- <cfset DL = "#return_data.generatedkey#">
        <cfreturn DL> --->
    </cffunction>
    <!--- getCetaceanNecropsy --->
    <cffunction name="getCetaceanNecropsy" returntype="any" output="false" access="public" >

        <cftry>
            <cfquery name="qgetCetaceanNecropsy" datasource="#Application.dsn#"  >
                SELECT * from ST_CetaceanNecropsyReport where fnumber = '#Nfieldnumber#'
            </cfquery>
           
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn qgetCetaceanNecropsy>
    </cffunction>
    <cffunction name="getAllData" returntype="any" output="false" access="public" >

        <cftry>
            <!--- <cfquery name="qgetAllData" datasource="#Application.dsn#"  >
                SELECT * from ST_CetaceanNecropsyReport where fnumber = '#field#'
            </cfquery> --->
                   <!--- <cfquery name="qgetNutritional" datasource="#Application.dsn#"  >
                SELECT * from ST_Blood_Values where fnumber = '#field#'
            </cfquery> --->
            <cfquery name="qgetAllData" datasource="#Application.dsn#" maxRows = "1"> 
                SELECT Fnumber,species,affiliatedID,date,Location FROM ST_LiveCetaceanExam where fnumber = '#field#'
                UNION
                SELECT Fnumber,species,affiliatedID,date,Location FROM ST_HIForm where fnumber = '#field#'
                UNION
                SELECT Fnumber ,species,ResearchTeam,date,SampleComments FROM ST_HistoForm where fnumber = '#field#'
                UNION
                SELECT Fnumber ,species,affiliatedID,date,Location FROM ST_LevelAForm where fnumber = '#field#'
                UNION
                SELECT Fnumber ,species,ResearchTeam,date,BodyOfWater FROM ST_Ancillary_Diagnostics where fnumber = '#field#'
                UNION
                SELECT Fnumber ,species,ResearchTeam,Analysis_date,BodyOfWater FROM ST_Blood_Values where fnumber = '#field#'
                UNION
                SELECT Fnumber ,species,ResearchTeam,Analysis_date,Veterinarian FROM ST_Toxicology where fnumber = '#field#'
                UNION
                SELECT Fnumber ,species,ResearchTeam,date,BodyOfWater FROM ST_SampleArchive where fnumber = '#field#'               
                ORDER BY Fnumber;
            </cfquery>
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn qgetAllData>
    </cffunction>
    <!---getCetaceanNecropsy_ten --->
    <cffunction name="getCetaceanNecropsy_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetCetaceanNecropsy_ten" datasource="#Application.dsn#">
            SELECT * FROM ST_CetaceanNecropsyReport where ID = 0
        </cfquery>
        <cfreturn qgetCetaceanNecropsy_ten>
    </cffunction>
    <cffunction name="getMorphomatrics_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetMorphomatrics_ten" datasource="#Application.dsn#">
            SELECT * FROM ST_Morphometrics where ID = 0
        </cfquery>
        <cfreturn qgetMorphomatrics_ten>
    </cffunction>
    <!--- getLymphoreticular --->
    <cffunction name="getLymphoreticular" returntype="any" output="false" access="public" >
        <cftry>
            <cfquery name="qgetLymphoreticular" datasource="#Application.dsn#"  >
                SELECT * from ST_DynamicLymphoreticular where fnumber = '#field#'
            </cfquery>
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn qgetLymphoreticular>
    </cffunction>
    <!--- getParasites --->
    <cffunction name="getParasites" returntype="any" output="false" access="public" >
        <cftry>
            <cfquery name="qgetParasites" datasource="#Application.dsn#"  >
                SELECT * from ST_DynamicParasites where fnumber = '#field#'
            </cfquery>
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn qgetParasites>
    </cffunction>
    <!--- getNutritional --->
    <cffunction name="getNutritional" returntype="any" output="false" access="public" >

        <cftry>
            <cfquery name="qgetNutritional" datasource="#Application.dsn#"  >
                SELECT * from ST_DynamicNutrition where fnumber = '#field#'
            </cfquery>
     
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <!--- <cfif field eq "ie">
            <cfdump var="#qgetNutritional#" abort="true">   
        </cfif> --->
        <!--- <cfdump var="#qgetNutritional#" abort="true"> --->
        <cfreturn qgetNutritional>
    </cffunction>
    <!--- getLymphoreticular_ten --->
    <cffunction name="getLymphoreticular_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetLymphoreticular_ten" datasource="#Application.dsn#">
            SELECT * FROM ST_DynamicLymphoreticular where ID = 0
        </cfquery>
        <cfreturn qgetLymphoreticular_ten>
    </cffunction>
    <!--- getNutritional_ten --->
    <cffunction name="getNutritional_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetNutritional_ten" datasource="#Application.dsn#">
            SELECT * FROM ST_DynamicNutrition where ID = 0
        </cfquery>
        <cfreturn qgetNutritional_ten>
    </cffunction>
    <!--- getParasites_ten --->
    <cffunction name="getParasites_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetParasites_ten" datasource="#Application.dsn#">
            SELECT * FROM ST_DynamicParasites where ID = 0
        </cfquery>
        <cfreturn qgetParasites_ten>
    </cffunction>
    <!--- getallfieldnumber --->
    <cffunction name="getallfieldnumber" returntype="any" output="false" access="public" >
        <cfquery name="qgetallfieldnumber" datasource="#Application.dsn#">
            SELECT Fnumber FROM ST_LiveCetaceanExam where deleted != '1'
            UNION
            SELECT Fnumber FROM ST_HIForm where deleted != '1'
            UNION
            SELECT Fnumber FROM ST_HistoForm where deleted != '1'
            UNION
            SELECT Fnumber FROM ST_LevelAForm where deleted != '1'
            UNION
            SELECT Fnumber FROM ST_Ancillary_Diagnostics where deleted != '1'
            UNION
            SELECT Fnumber FROM ST_Blood_Values where deleted != '1'
            UNION
            SELECT Fnumber FROM ST_Toxicology where deleted != '1'
            UNION
            SELECT Fnumber FROM ST_SampleArchive where deleted != '1'
            UNION
            SELECT Fnumber FROM ST_CetaceanNecropsyReport
            ORDER BY Fnumber;
        </cfquery>
        <cfreturn qgetallfieldnumber>
    </cffunction>
    <!--- match field number  --->
    <cffunction name="getmatchFnumb" returnformat="JSON" returntype="any" output="false" access="remote">
        <cfquery name="qgetmatchFnumb" datasource="#Application.dsn#">
            SELECT Fnumber from ST_CetaceanNecropsyReport where fnumber = '#fieldno#' 
        </cfquery>
        <cfset count= qgetmatchFnumb.recordcount>
		<cfreturn count>
    </cffunction>
    <!--- update  --->
    <cffunction name="updateDynamicNutrition" returntype="any" output="false" access="public">
        
        <cftry>
            <cfquery name="qNutrition" datasource="#variables.dsn#">
                select * from ST_DynamicNutrition 
                where fnumber = '#Fnumber#'
             </cfquery>
             <!--- <cfdump var="#qNutrition#" abort="true"> --->
             <cfloop query="qNutrition">
                <cfset lp = 'organlabel'&#qNutrition.ID#>
                <cfdump var ="#lp#">
                <cfset lpr = 'NUTRI'&#qNutrition.ID#>
                <cfdump var ="#lpr#">
                
                <cfquery name="qupdateDynamicNutrition" datasource="#variables.dsn#"  result="return_data" >
                    UPDATE  ST_DynamicNutrition SET
                    organs_label= <cfqueryparam cfsqltype="cf_sql_varchar" value='#evaluate(lp)#'>
                    ,newNUTRI= <cfqueryparam cfsqltype="cf_sql_varchar" value='#evaluate(lpr)#'>
                    Where
                    ID= <cfqueryparam cfsqltype="cf_sql_integer" value='#qNutrition.ID#'> 
                </cfquery>
            </cfloop>
            
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn true>
    </cffunction>
    <!--- updateDynamicLymphoreticular  --->
    <cffunction name="updateDynamicLymphoreticular" returntype="any" output="false" access="public">
        
        <cftry>
            <cfquery name="qLympho" datasource="#variables.dsn#">
                select * from ST_DynamicLymphoreticular 
                where fnumber = '#Fnumber#'
             </cfquery>
            
             <cfloop query="qLympho">
                <cfset lp = 'nodewidth'&#qLympho.ID#>
                <cfdump var ="#evaluate(lp)#">
                <cfset lpr = 'nodelength'&#qLympho.ID#>
                <cfdump var ="#evaluate(lpr)#">
                <cfset ln = 'lymphnode'&#qLympho.ID#>
                <cfdump var ="#evaluate(ln)#">
                
                <cfquery name="qupdateDynamicLymphoreticular" datasource="#variables.dsn#"  result="return_data" >
                    UPDATE  ST_DynamicLymphoreticular SET

                    nodewidth = <cfqueryparam cfsqltype="cf_sql_varchar" value= "#evaluate(lp)#">
                    ,nodelength = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate(lpr)#">
                    ,lymphnode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate(ln)#">

                    Where
                    ID= <cfqueryparam cfsqltype="cf_sql_integer" value="#qLympho.ID#"> 
                </cfquery>
            </cfloop>
            
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn true>
    </cffunction>
    <!--- updateDynamicParasites  --->
    <cffunction name="updateDynamicParasites" returntype="any" output="false" access="public">
        
        <cftry>
            <cfquery name="qLympho" datasource="#variables.dsn#">
                select * from ST_DynamicParasites 
                where fnumber = '#Fnumber#'
             </cfquery>
            
             <cfloop query="qLympho">
                <cfset lp = 'PARASITES'&#qLympho.ID#>
                <cfdump var ="#evaluate(lp)#">
                <cfset lpr = 'ParasiteType'&#qLympho.ID#>
                <cfdump var ="#evaluate(lpr)#">
                <cfset ln = 'Parasitelocation'&#qLympho.ID#>
                <cfdump var ="#evaluate(ln)#">
                
                <cfquery name="qupdateDynamicParasites" datasource="#variables.dsn#"  result="return_data" >
                    UPDATE  ST_DynamicParasites SET

                    PARASITES = <cfqueryparam cfsqltype="cf_sql_varchar" value= "#evaluate(lp)#">
                    ,ParasiteType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate(lpr)#">
                    ,Parasitelocation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate(ln)#">

                    Where
                    ID= <cfqueryparam cfsqltype="cf_sql_integer" value="#qLympho.ID#"> 
                </cfquery>
            </cfloop>
            
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
        </cftry>
        <cfreturn true>
    </cffunction>
     <!--- delete Cetacean Necropsy --->
     <cffunction name="deletcetaceannecropsy" returntype="any" output="false" access="public" >
        <cfquery name="qdeletcetaceannecropsy" datasource="#variables.dsn#"  >
            delete from ST_CetaceanNecropsyReport
            where ID = '#report_ID#'
        </cfquery>
        <cfreturn True>
    </cffunction>
     <cffunction name="deletCetaceanNecropsyAllRecord" returntype="any" output="false" access="public" >
        <cfquery name="qdeletCetaceanNecropsyAllRecord" datasource="#variables.dsn#"  >
           TRUNCATE Table ST_CetaceanNecropsyReport  
        </cfquery>
        <cfquery name="qdeletCetaceanNecropsyAllRecord1" datasource="#variables.dsn#"  >
           TRUNCATE Table ST_DynamicNutrition  
        </cfquery>
        <cfquery name="qdeletCetaceanNecropsyAllRecord2" datasource="#variables.dsn#"  >
           TRUNCATE Table ST_DynamicLymphoreticular  
        </cfquery>
        <cfquery name="qdeletCetaceanNecropsyAllRecord3" datasource="#variables.dsn#"  >
           TRUNCATE Table ST_DynamicParasites  
        </cfquery>
        <cfreturn True>
    </cffunction>
    <!--- Morphometrics --->
    <cffunction name="MorphometricsFormInsert" returntype="any" output="false" access="public" >
        
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>
        <cfif NOT isDefined('FORM.code')>
            <cfset FORM.code = "">
        </cfif>
        <cfif NOT isDefined('FORM.DorsalFinHeight')>
            <cfset FORM.DorsalFinHeight = "">
        </cfif>
        <cfif NOT isDefined('FORM.RostrumtoBlowhole')>
            <cfset FORM.RostrumtoBlowhole = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        <!--- <cfif NOT isDefined('FORM.ECG')>
            <cfset FORM.ECG = "">
        </cfif> --->
 
        <!--- <cfdump var="#form#" abort="true"> --->
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO ST_Morphometrics 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,species
            ,BodyOfWater
            ,NOAAStock
            ,StTpye
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,lat
            ,lon
            ,county
            ,InitialCondition
            ,FinalCondition
            ,BriefHistory
            ,CompletedBy
            ,affiliatedID
            ,actualClass
            ,totalLength
            ,rostrum
            ,blowhole
            ,fluke
            ,girth
            ,axillary
            ,maxium
            ,blubber
            ,midlateral
            ,midVentral
            ,Laterallowerleft
            ,Ventrallowerright
            ,Lateralupperleft
            ,Ventralupperleft
            ,EstimatedWeight
            ,EstimatedWeightUnit
            ,DorsalFinHeight
            ,RostrumtoBlowhole
            ,weight_values
            ,euthanizedCB
            ,lengthWeight_values
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.totalLength#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.rostrum#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.blowhole#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.fluke#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.girth#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.axillary#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.maxium#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.blubber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.midlateral#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.midVentral#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Laterallowerleft#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ventrallowerright#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lateralupperleft#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ventralupperleft#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.EstimatedWeight#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.EstimatedWeightUnit#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.DorsalFinHeight#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RostrumtoBlowhole#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.weight_values#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lengthWeight_values#'>
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
    </cffunction>

    <cffunction name="MorphometricsFormUpdate" returntype="any" output="false" access="public" >
        
        <cfif NOT isDefined('FORM.ResearchTeam')>
            <cfset FORM.ResearchTeam = "">
        </cfif>
        <cfif NOT isDefined('FORM.Veterinarian')>
            <cfset FORM.Veterinarian = "">
        </cfif>
        <cfif NOT isDefined('FORM.BodyOfWater')>
            <cfset FORM.BodyOfWater = "">
        </cfif>
        <cfif NOT isDefined('FORM.NOAAStock')>
            <cfset FORM.NOAAStock = "">
        </cfif>      
       
        <cfif NOT isDefined('FORM.code')>
            <cfset FORM.code = "">
        </cfif>
        <cfif NOT isDefined('FORM.DorsalFinHeight')>
            <cfset FORM.DorsalFinHeight = "">
        </cfif>
        <cfif NOT isDefined('FORM.RostrumtoBlowhole')>
            <cfset FORM.RostrumtoBlowhole = "">
        </cfif>
        <cfif NOT isDefined('FORM.euthanizedCB')>
            <cfset FORM.euthanizedCB = "">
        </cfif>
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#variables.dsn#"  result="return_data" >
            UPDATE  ST_Morphometrics SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.date#'>
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ResearchTeam#'>
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarian#'>
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.species#'>
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BodyOfWater#'>
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NOAAStock#'>
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.StTpye#'>
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.NAA#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lon#'>
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.actualClass#'>
           ,totalLength = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.totalLength#'>
           ,rostrum = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.rostrum#'>
           ,blowhole = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.blowhole#'>
           ,fluke = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.fluke#'>
           ,girth = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.girth#'>
           ,axillary = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.axillary#'>
           ,maxium = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.maxium#'>
           ,blubber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.blubber#'>
           ,midlateral = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.midlateral#'>
           ,midVentral = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.midVentral#'>
           ,Laterallowerleft = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Laterallowerleft#'> 
           ,Ventrallowerright = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ventrallowerright#'> 
           ,Lateralupperleft = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lateralupperleft#'> 
           ,Ventralupperleft = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Ventralupperleft#'> 
           ,EstimatedWeight = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.EstimatedWeight#'> 
           ,EstimatedWeightUnit = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.EstimatedWeightUnit#'> 
           ,DorsalFinHeight = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.DorsalFinHeight#'> 
           ,RostrumtoBlowhole = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RostrumtoBlowhole#'> 
           ,weight_values = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.weight_values#'> 
           ,euthanizedCB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.euthanizedCB#'> 
           ,lengthWeight_values = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.lengthWeight_values#'> 

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.Morphometricss_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        
        <cfreturn TRUE>
    </cffunction>

    <cffunction name="findLCEID" returntype="any" output="false" access="remote" returnformat="plain">            
       
                      
             <cfquery name="qgetHistoLCEID" datasource="#Application.dsn#">
                SELECT ID from ST_HistoForm where deleted != '1' and Fnumber = '#Fnumber#' 
            </cfquery>
        <!--- <cfdump var="#qgetHistoLCEID.ID#" abort="true"> --->
        <cfreturn qgetHistoLCEID.ID>
    </cffunction>

    <cffunction name="findCetaceanLCEID" returntype="any" output="false" access="remote" returnformat="plain">            
       
                      
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_LiveCetaceanExam where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <!--- <cfdump var="#qgetHistoLCEID.ID#" abort="true"> --->
        <cfreturn qgetLCEID.ID>
    </cffunction>


    <!--- auto save --->

    <cffunction name="AjaxCetaceanExamdup" returntype="any" output="false" access="remote" returnformat="plain">
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_LiveCetaceanExam where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <cfreturn qgetLCEID.ID>
    </cffunction>

    <cffunction name="AjaxLiveCetaceanExamInsert" returntype="any" output="false" access="remote" returnformat="plain">
        <!--- <cfif LCEID eq ''> --->
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_LiveCetaceanExam where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <!--- <cfelse>
            <cfset qgetLCEID.ID = '0'>
        </cfif> --->
        <!--- <cfdump var="#form#" abort="true"> --->
        <!--- <cfreturn qgetLCEID.ID> --->
        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>
          
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_LiveCetaceanExam 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,BodyOfWater
            ,species
            ,StTpye
            ,NOAAStock
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code  
            ,affiliatedID
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,county
            ,InitialCondition
            ,FinalCondition          
            ,lat
            ,lon
            ,actualClass
            ,BriefHistory
            ,CompletedBy       

            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
       
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
        <cfelse>
            <cfset ID = #qgetLCEID.ID#>
            <cfset LCE_ID = "#qgetLCEID.ID#">
            <cfreturn LCE_ID>
            <!--- <cfset AjaxLiveCetaceanExamUpdate(argumentCollection="#ID#")> --->
    </cfif>

    </cffunction>


    <cffunction name="AjaxLiveCetaceanExamUpdate" returntype="any" output="false" access="remote" returnformat="plain">
            
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_LiveCetaceanExam SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- <cfset UpdateLevelA_HI(argumentCollection="#Form#")> --->
        <cfreturn ID>
    </cffunction>

    <cffunction name="AjaxHIFormInsert" returntype="any" output="false" access="remote" returnformat="plain">

        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_HIForm where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_HIForm 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,BodyOfWater
            ,species
            ,StTpye
            ,NOAAStock
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code  
            ,affiliatedID
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,county
            ,InitialCondition
            ,FinalCondition          
            ,lat
            ,lon
            ,actualClass
            ,BriefHistory
            ,CompletedBy       

            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
       
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
    <cfelse>
        <cfset ID = #qgetLCEID.ID#>
        <cfset LCE_ID = "#qgetLCEID.ID#">
        <cfreturn LCE_ID>
        <!--- <cfset AjaxLiveCetaceanExamUpdate(argumentCollection="#ID#")> --->
</cfif>

    </cffunction>

    <cffunction name="AjaxHIFormUpdate" returntype="any" output="false" access="remote" returnformat="plain">
            
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_HIForm SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#HIForm_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- <cfset UpdateLevelA_HI(argumentCollection="#Form#")> --->
        <cfreturn HIForm_ID>
    </cffunction>

    <cffunction name="AjaxLevelAFormInsert" returntype="any" output="false" access="remote" returnformat="plain">
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_LevelAForm where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
  
  <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>

        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_LevelAForm 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,BodyOfWater
            ,species
            ,StTpye
            ,NOAAStock
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code  
            ,affiliatedID
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,county
            ,InitialCondition
            ,FinalCondition          
            ,lat
            ,lon
            ,actualClass
            ,BriefHistory
            ,CompletedBy       

            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
       
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
    <cfelse>
        <cfset ID = #qgetLCEID.ID#>
        <cfset LCE_ID = "#qgetLCEID.ID#">
        <cfreturn LCE_ID>
        <!--- <cfset AjaxLiveCetaceanExamUpdate(argumentCollection="#ID#")> --->
</cfif>

    </cffunction>

    <cffunction name="AjaxLevelAFormUpdate" returntype="any" output="false" access="remote" returnformat="plain">
            
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_LevelAForm SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#level_A_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- <cfset UpdateLevelA_HI(argumentCollection="#Form#")> --->
        <cfreturn level_A_ID>
    </cffunction>


    <cffunction name="AjaxHistopathologyInsert" returntype="any" output="false" access="remote" returnformat="plain">
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_HistoForm where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_HistoForm 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,BodyOfWater
            ,species
            ,StTpye
            ,NOAAStock
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code  
            ,affiliatedID
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,county
            ,InitialCondition
            ,FinalCondition          
            ,lat
            ,lon
            ,actualClass
            ,BriefHistory
            ,CompletedBy       

            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
       
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
    <cfelse>
        <cfset ID = #qgetLCEID.ID#>
        <cfset LCE_ID = "#qgetLCEID.ID#">
        <cfreturn LCE_ID>
</cfif>
    </cffunction>

    <cffunction name="AjaxHistopathologyUpdate" returntype="any" output="false" access="remote" returnformat="plain">
            
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_HistoForm SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#Histo_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- <cfset UpdateLevelA_HI(argumentCollection="#Form#")> --->
        <cfreturn Histo_ID>
    </cffunction>


    <cffunction name="AjaxbloodValueInsert" returntype="any" output="false" access="remote" returnformat="plain">
        <!--- <cfdump var="#Fnumber#" abort="true"> --->
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_Blood_Values where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>
            <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
            <cfset fname = userinfo.first_name>
            <cfset lname = userinfo.last_name>
            <cfset CompletedBy = "#fname# #lname#">
            <cftry>
                <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
                INSERT INTO ST_Blood_Values 
                (
                date
                ,ResearchTeam
                ,Veterinarian
                ,BodyOfWater
                ,species
                ,StTpye
                ,NOAAStock
                ,Fnumber
                ,NMFS
                ,NDB
                ,NAA
                ,code  
                ,affiliatedID
                ,hera
                ,sex
                ,ageClass
                ,Location
                ,county
                ,InitialCondition
                ,FinalCondition          
                ,lat
                ,lon
                ,actualClass
                ,BriefHistory
                ,CompletedBy       

                ) 
                VALUES
                (
                <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
        
                )
                </cfquery>
                <cfcatch type="any">
                    <cfdump  var="#cfcatch#"><cfabort>
                </cfcatch>
            </cftry>
            <cfset LCE_ID = "#return_data.generatedkey#">
            <cfset form.LCE_ID = "0">
            <cfset form.BV_ID = "#LCE_ID#">
            
            <cfset CBCInserta(argumentCollection="#Form#")>
            <cfset Fibrinogeninserta(argumentCollection="#Form#")>
            <!--- <cfset Chemistryinsert(argumentCollection="#Form#")>
            <cfset Capillaryinsert(argumentCollection="#Form#")>
            <cfset Dolphininsert(argumentCollection="#Form#")>
            <cfset iSTAT_Cheminsert(argumentCollection="#Form#")>
            <cfset CG4_Cheminsert(argumentCollection="#Form#")> --->
            <cfreturn LCE_ID>
        <cfelse>
            <cfset ID = #qgetLCEID.ID#>
            <cfset LCE_ID = "#qgetLCEID.ID#">
            <cfreturn LCE_ID>
        </cfif>

    </cffunction>
     <!--- Insert CBC form  (Blood Values) --->
     <cffunction name="CBCInserta" returntype="any" output="false" access="public" >
        <!--- <cfdump var="#form#" abort="true"> --->
        <cftry>
        <cfquery name="qCBCInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_CBC
            (         
            LCE_ID
            ,BV_ID           
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>          
            )
        </cfquery>

        <cfquery name="qCBCInserta" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_Chemistry
            (         
            LCE_ID
            ,BV_ID           
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>          
            )
        </cfquery>

        <cfquery name="qCBCInsertb" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_Capillary
            (         
            LCE_ID
            ,BV_ID           
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>          
            )
        </cfquery>

        <cfquery name="qCBCInsertb" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_Dolphin
            (         
            LCE_ID
            ,BV_ID           
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>          
            )
        </cfquery>

        <cfquery name="qCBCInsertb" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_iSTAT_Chem
            (         
            LCE_ID
            ,BV_ID           
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>          
            )
        </cfquery>
        <cfquery name="qCBCInsertb" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_iSTAT_CG4
            (         
            LCE_ID
            ,BV_ID           
            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
            ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>          
            )
        </cfquery>

        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset CBC_ID = "#return_data.generatedkey#">
        <cfreturn CBC_ID>
    </cffunction>
        <!--- Fibrinogen Insert  --->
        <cffunction name="Fibrinogeninserta" returntype="any" output="false" access="public">
            <cftry>
                <cfquery name="qFibInsert" datasource="#Application.dsn#"  result="return_data" >
                INSERT INTO ST_Fibrinogen
                (
                    LCE_ID
                    ,BV_ID
                )
                VALUES
                (   
                    <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.LCE_ID#'>
                    ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.BV_ID#'>
                )   
            </cfquery>
            <cfcatch type="any">
                <cfdump  var="#cfcatch#"><cfabort>
            </cfcatch>
            </cftry>
            <cfset Fib_ID = "#return_data.generatedkey#">
            <cfreturn Fib_ID>
        </cffunction>

    <cffunction name="AjaxbloodValueUpdate" returntype="any" output="false" access="remote" returnformat="plain">
            
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_Blood_Values SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#bloodValues_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <!--- <cfset UpdateLevelA_HI(argumentCollection="#Form#")> --->
        <cfreturn bloodValues_ID>
    </cffunction>


    <cffunction name="AjaxToxicologyInsert" returntype="any" output="false" access="remote" returnformat="plain">
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_Toxicology where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_Toxicology 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,BodyOfWater
            ,species
            ,StTpye
            ,NOAAStock
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code  
            ,affiliatedID
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,county
            ,InitialCondition
            ,FinalCondition          
            ,lat
            ,lon
            ,actualClass
            ,BriefHistory
            ,CompletedBy       

            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
       
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
    <cfelse>
        <cfset ID = #qgetLCEID.ID#>
        <cfset LCE_ID = "#qgetLCEID.ID#">
        <cfreturn LCE_ID>
</cfif>
    </cffunction>

    <cffunction name="AjaxToxicologyUpdate" returntype="any" output="false" access="remote" returnformat="plain">
            
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_Toxicology SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#TX_IDValue#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>

        <cfreturn TX_IDValue>
    </cffunction>



    <cffunction name="AjaxAncillaryInsert" returntype="any" output="false" access="remote" returnformat="plain">
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_Ancillary_Diagnostics where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>

        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_Ancillary_Diagnostics 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,BodyOfWater
            ,species
            ,StTpye
            ,NOAAStock
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code  
            ,affiliatedID
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,county
            ,InitialCondition
            ,FinalCondition          
            ,lat
            ,lon
            ,actualClass
            ,BriefHistory
            ,CompletedBy       

            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
       
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
    <cfelse>
        <cfset ID = #qgetLCEID.ID#>
        <cfset LCE_ID = "#qgetLCEID.ID#">
        <cfreturn LCE_ID>
</cfif>
    </cffunction>

    <cffunction name="AjaxAncillaryUpdate" returntype="any" output="false" access="remote" returnformat="plain">
            
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_Ancillary_Diagnostics SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#ADID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>

        <cfreturn ADID>
    </cffunction>



    <cffunction name="AjaxSampleArchiveInsert" returntype="any" output="false" access="remote" returnformat="plain">
  
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_SampleArchive where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>

        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_SampleArchive 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,BodyOfWater
            ,species
            ,StTpye
            ,NOAAStock
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code  
            ,affiliatedID
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,county
            ,InitialCondition
            ,FinalCondition          
            ,lat
            ,lon
            ,actualClass
            ,BriefHistory
            ,CompletedBy       

            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
       
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
    <cfelse>
        <cfset ID = #qgetLCEID.ID#>
        <cfset LCE_ID = "#qgetLCEID.ID#">
        <cfreturn LCE_ID>
</cfif>
    </cffunction>

    <cffunction name="AjaxSampleArchiveUpdate" returntype="any" output="false" access="remote" returnformat="plain">
            
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_SampleArchive SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,CompletedBy = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#SampleArchiveSEID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>

        <cfreturn SampleArchiveSEID>
    </cffunction>


    <cffunction name="AjaxNecropsyReportInsert" returntype="any" output="false" access="remote" returnformat="plain">
  
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_CetaceanNecropsyReport where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>

        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_CetaceanNecropsyReport 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,BodyOfWater
            ,species
            ,StTpye
            ,NOAAStock
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code  
            ,affiliatedID
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,county
            ,InitialCondition
            ,FinalCondition          
            ,lat
            ,lon
            ,actualClass
            ,BriefHistory       

            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
       
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
    <cfelse>
        <cfset ID = #qgetLCEID.ID#>
        <cfset LCE_ID = "#qgetLCEID.ID#">
        <cfreturn LCE_ID>
</cfif>
    </cffunction>

    <cffunction name="AjaxNecropsyReportUpdate" returntype="any" output="false" access="remote" returnformat="plain">
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_CetaceanNecropsyReport where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>

        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_CetaceanNecropsyReport SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#repotrt_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>

        <cfreturn repotrt_ID>
    <cfelse>
        <cfset ID = #qgetLCEID.ID#>
        <cfset LCE_ID = "#qgetLCEID.ID#">
        <cfreturn LCE_ID>
    </cfif>
    </cffunction>



    <cffunction name="AjaxMorphometricsInsert" returntype="any" output="false" access="remote" returnformat="plain">
        <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
            SELECT ID from ST_Morphometrics where deleted != '1' and Fnumber = '#Fnumber#' 
        </cfquery>
        <cfif isDefined('qgetLCEID.ID') and #qgetLCEID.ID# eq ''>

        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
            <cfquery name="qLocationInsert" datasource="#Application.dsn#"  result="return_data" >
            INSERT INTO ST_Morphometrics 
            (
            date
            ,ResearchTeam
            ,Veterinarian
            ,BodyOfWater
            ,species
            ,StTpye
            ,NOAAStock
            ,Fnumber
            ,NMFS
            ,NDB
            ,NAA
            ,code  
            ,affiliatedID
            ,hera
            ,sex
            ,ageClass
            ,Location
            ,county
            ,InitialCondition
            ,FinalCondition          
            ,lat
            ,lon
            ,actualClass
            ,BriefHistory
            ,CompletedBy       

            ) 
            VALUES
            (
            <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>           
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>     
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>    
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#CompletedBy#'>
       
            )
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
        <cfset LCE_ID = "#return_data.generatedkey#">
        <cfreturn LCE_ID>
    <cfelse>
        <cfset ID = #qgetLCEID.ID#>
        <cfset LCE_ID = "#qgetLCEID.ID#">
        <cfreturn LCE_ID>
</cfif>

    </cffunction>

    <cffunction name="AjaxMorphometricsUpdate" returntype="any" output="false" access="remote" returnformat="plain">
            
        
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset CompletedBy = "#fname# #lname#">
        <cftry>
        <cfquery name="qCetaceanExamUpdate" datasource="#Application.dsn#"  result="return_data" >
            UPDATE  ST_Morphometrics SET

           date = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#date#'>          
           ,ResearchTeam = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ResearchTeam#'>          
           ,Veterinarian = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Veterinarian#'>          
           ,BodyOfWater = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BodyOfWater#'>          
           ,species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#species#'>          
           ,StTpye = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StTpye#'>          
           ,NOAAStock = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NOAAStock#'>          
           ,Fnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Fnumber#'>
           ,NMFS = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NMFS#'>
           ,NDB = <cfqueryparam cfsqltype="cf_sql_varchar" value='#NDB#'>
           ,NAA = <cfqueryparam cfsqltype="cf_sql_varchar" value='#StandingAgreementAuthority#'>
           ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
           ,hera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#hera#'>
           ,sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#sex#'>
           ,ageClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#ageClass#'>
           ,Location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Location#'>
           ,lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lat#'>
           ,lon = <cfqueryparam cfsqltype="cf_sql_varchar" value='#lon#'>          
           ,county = <cfqueryparam cfsqltype="cf_sql_varchar" value='#county#'>
           ,InitialCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#InitialCondition#'>
           ,FinalCondition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FinalCondition#'>
           ,BriefHistory = <cfqueryparam cfsqltype="cf_sql_varchar" value='#BriefHistory#'>
           ,affiliatedID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#affiliatedID#'>
           ,actualClass = <cfqueryparam cfsqltype="cf_sql_varchar" value='#actualClass#'>

           WHERE
           ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#Morphometricss_ID#'>
        </cfquery>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>

        <cfreturn Morphometricss_ID>
    </cffunction>


    <cffunction name="updateSampleReportRecord"  returntype="any" output="false" access="remote" >
       
        <!--- <cfdump var="test"><cfabort> --->

        <cfquery name="qupdateSampleData" datasource="#Application.dsn#" >
            update ST_SampleType set
             SampleID=<cfqueryparam cfsqltype="cf_sql_varchar" value='#SamplereportID#' >
            ,BinNumber=<cfqueryparam cfsqltype="cf_sql_varchar" value='#reportBinNumber#'>
            ,SampleType=<cfqueryparam cfsqltype="cf_sql_varchar" value='#reportSampleType#'>
            ,PreservationMethod=<cfqueryparam cfsqltype="cf_sql_varchar" value='#reportPreservationMethod#'>
            ,AmountofSample=<cfqueryparam cfsqltype="cf_sql_varchar" value='#reportAmountofSample#'>
            ,UnitofSample=<cfqueryparam cfsqltype="cf_sql_varchar" value='#reportUnitofSample#'>
            ,StorageType=<cfqueryparam cfsqltype="cf_sql_varchar" value='#reportStorageType#'>
            ,SampleComments=<cfqueryparam cfsqltype="cf_sql_varchar" value='#reportSampleComments#'>
            ,Sample_Date=<cfqueryparam cfsqltype="cf_sql_varchar" value='#reportSample_Date#'>
            ,Sample_Location=<cfqueryparam cfsqltype="cf_sql_varchar" value='#reportSample_Location#'>
            
            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
            
        </cfquery>
        <!--- <cfdump var="#qupdateSampleData#"> --->
		<cfreturn True>
	</cffunction>

    <cffunction name="deleteSampleReportRecord"  returntype="any" output="false" access="remote" returnformat="json">        
        <cfquery name="qdeleteSamplerecord" datasource="#Application.dsn#">
            delete from ST_SampleType
            where ID = '#ID#'
        </cfquery>
        <!--- <cfdump var="#qdeleteSamplerecord#"> --->
		<cfreturn True>
    </cffunction>

    <cffunction name="deleteDrugsAdministeredRecord"  returntype="any" output="false" access="remote" returnformat="json">        
        <cfquery name="qdeleteSamplerecord" datasource="#Application.dsn#">
            delete from ST_DrugsAdministered
            where ID = '#ID#'
        </cfquery>        
        <cfreturn True>       
    </cffunction>

    <cffunction name="updatedrugAdmin" access="remote" >
        <!--- <cfdump var="#ID#" abort="true"> --->
        <!--- <cfargument name="samplDate" type="any" required="yes"> --->
        <!--- <cfdump var="#form.LesionPresent#">
        <cfdump var="#form.LesionType#">
        <cfdump var="#form.Region#">
        <cfdump var="#form.Side#">
        <cfdump var="#form.ID#">
        <cfabort> --->
        <!--- <cfexit> --->
        <cfquery name="qupdateLesions" datasource="#Application.dsn#" >
            update ST_DrugsAdministered set
            Drugtype=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Drugtype#' >
            ,DrugMethod=<cfqueryparam cfsqltype="cf_sql_varchar" value='#DrugMethod#'>
            ,DrugTime=<cfqueryparam cfsqltype="cf_sql_varchar" value='#DrugTime#'>
            ,DrugDosage=<cfqueryparam cfsqltype="cf_sql_varchar" value='#DrugDosage#'>
            ,DrugVolume=<cfqueryparam cfsqltype="cf_sql_varchar" value='#DrugVolume#'>          
            
            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
            
        </cfquery>
        <!--- <cfdump var="#qupdateLesions#"> --->
		<cfreturn True>
	</cffunction>

</cfcomponent>    
