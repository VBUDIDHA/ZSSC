@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Key Deliverables Child CDS view'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zr_ssc_key_deliver
  as select from zssc_key_deliver

  association to parent ZR_SSC_EMPLOYEE as _Employee on $projection.EmployeeID = _Employee.EmployeeID

{
  key zz_emp_id       as EmployeeID,
  key zz_user_story   as UserStory,
      zz_wk_no        as WeekNumber,
      zz_desc         as Description,
      zz_status       as Status,
      zz_remarks      as Remarks,
      zz_risk         as Risk,
      zz_milestone    as Milestone,
      last_changed_at as LastChangedAt,

      //Associations
      _Employee
}
