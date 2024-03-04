@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '##GENERATED ZSSC_EMPLOYEE table'

define root view entity ZR_SSC_EMPLOYEE
  as select from zssc_employee as Employee

  composition [0..*] of zr_ssc_key_deliver  as _KeyDeliver
  composition [0..*] of zr_ssc_leaves       as _Leave
  composition [0..*] of zr_ssc_p_order      as _POrder
  composition [0..*] of zr_ssc_salary       as _Salary
  composition [0..*] of zr_ssc_department   as _Department

  association [0..*] to z_i_ssc_employee_vh as _EmployeeVH on $projection.EmployeeID = _EmployeeVH.EmployeeID

{
      @Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_employee_vh', element: 'EmployeeID' } }]
  key zz_emp_id             as EmployeeID,

      zz_dept_id            as DepartmentID,
      zz_first_name         as FirstName,
      zz_last_name          as LastName,
      zz_dob                as Dob,
      zz_location           as Location,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by       as LastChangedBy,

      //Association
      _KeyDeliver,
      _Leave,
      _POrder,
      _Salary,
      _Department,
      _EmployeeVH

}
