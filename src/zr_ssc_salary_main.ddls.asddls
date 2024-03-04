@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED Individual ZSSC_SALARY'
define root view entity ZR_SSC_SALARY_MAIN
  as select from zssc_salary as SalaryMain
{
  key zz_emp_id as ZzEmpID,
  key zz_po_no as ZzPoNo,
  @Semantics.amount.currencyCode: 'ZzCurrency'
  zz_income as ZzIncome,
  zz_currency as ZzCurrency,
  zz_leaves_taken as ZzLeavesTaken,
  zz_leave_available as ZzLeaveAvailable,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
  
}
