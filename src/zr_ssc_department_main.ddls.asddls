@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED Individual ZSSC_DEPARTMENT'
define root view entity ZR_SSC_DEPARTMENT_MAIN
  as select from zssc_department as DepartmentMain
{
  key zz_emp_id as ZzEmpID,
  key zz_dept_id as ZzDeptID,
  zz_dept_name as ZzDeptName,
  zz_wbs as ZzWbs,
  zz_building as ZzBuilding,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
  
}
