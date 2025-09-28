
<cfparam name="form.PenaltyId" default="">
<cfparam name="form.PenaltyGoalId" default="">
<cfparam name="form.form.PenaltyStart" default="">
<cfparam name="form.PenaltyUnitList" default="">
<cfparam name="form.PenaltyUnitTypeId" default="">
<cfparam name="form.PenaltyLength" default="1.0">
<cfparam name="form.Period" default="">
<cfparam name="form.PenaltyStart" default="">
<cfparam name="form.PenaltyTimeTypeId" default="">
<cfparam name="form.STARTPOINT" default="">
<cfparam name="form.EndPOINT" default="">
	
	
<cfquery name="qInsertUpdatePenalty"  DATASOURCE="#Application.DataSource#" debug="Yes">
    exec  stpInsertUpdatePenalty 
	 @PenaltyId=<cfqueryparam value="#form.PenaltyId#" cfsqltype="cf_sql_varchar" null="#form.PenaltyId is ''#">
	 ,@PenalizedPlayerId=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.PlayerId#" null="#form.PlayerId is ''#" >	
	 ,@GameId=<cfqueryparam CFSQLTYPE="cf_sql_integer" VALUE="#form.gameid#" null="#form.GameId is ''#">
     ,@PenaltyGoalId=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.PenaltyGoalId#" null="#form.PenaltyGoalId is ''#">	
	 ,@PenaltyUnitTypeId=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.PenaltyUnitTypeId#" null="#form.PenaltyUnitTypeId is ''#">	
	 ,@PenaltyLength=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.PenaltyLength#" null="#form.PenaltyLength is ''#">
	 ,@PenaltyPeriod=<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#form.Period#" null="#form.Period is ''#">	
	 ,@PenaltyStart=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.PenaltyStart#" null="#form.PenaltyStart is ''#">
	 ,@PenaltyTimeTypeId=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.PenaltyTimeTypeId#" null="#form.PenaltyTimeTypeId is ''#">		
	 ,@PenaltyStartPoint=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.STARTPOINT#" null="#form.STARTPOINT is ''#">
	 ,@PenaltyStopPoint=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.EndPOINT#" null="#form.EndPOINT is ''#">		 
     , @PenaltyUnitList=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.PenaltyUnitList#" null="#form.PenaltyUnitList is ''#">		
</cfquery>
	
		 <cfset url.Step=13>
			 
	<cf_GoalWizard PenaltyId="#qInsertUpdatePenalty.PenaltyId#" step="13">






  


