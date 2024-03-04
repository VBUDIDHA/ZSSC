@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED Individual ZSSC_LEAVES'
define root view entity ZR_SSC_LEAVES_MAIN
  as select from zssc_leaves as LeavesMain
{
  key zz_emp_id as ZzEmpID,
  key zz_leave_req as ZzLeaveReq,
  zz_leave_type as ZzLeaveType,
  zz_no_days as ZzNoDays,
  zz_from_date as ZzFromDate,
  zz_to_date as ZzToDate,
  zz_reason as ZzReason,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
  
}
