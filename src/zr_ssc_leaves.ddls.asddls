@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Leaves Child CDS VIew'

define view entity zr_ssc_leaves
  as select from zssc_leaves

  association to parent ZR_SSC_EMPLOYEE as _Employee on $projection.EmployeeID = _Employee.EmployeeID

{
@Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_employee_vh', element: 'EmployeeID' } }]
  key zz_emp_id       as EmployeeID,
  key zz_leave_req    as LeaveRequest,
      zz_leave_type   as LeaveRequestType,
      zz_no_days      as NoDays,
      zz_from_date    as FromDate,
      zz_to_date      as ToDate,
      zz_reason       as Reason,
      last_changed_at as LastChangedAt,

      //Associations
      _Employee
}
