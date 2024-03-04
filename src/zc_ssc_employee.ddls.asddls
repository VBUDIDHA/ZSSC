@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_SSC_EMPLOYEE'
//@ObjectModel.semanticKey: [ 'EmployeeID' ]

define root view entity ZC_SSC_EMPLOYEE
  provider contract transactional_query
  as projection on ZR_SSC_EMPLOYEE

  association [0..*] to z_i_ssc_employee_vh   as _EmployeeVH on $projection.EmployeeID = _EmployeeVH.EmployeeID
  association [0..*] to z_i_ssc_department_VH as _DeptVH     on $projection.EmployeeID = _DeptVH.EmployeeID
{
      @Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_employee_vh', element: 'EmployeeID' } }]
  key EmployeeID,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_department_VH', element: 'DepartmentID' } }]
      DepartmentID,
      FirstName,
      LastName,
      Dob,
      Location,
      LocalLastChangedAt,

      //Association
      _KeyDeliver : redirected to composition child zc_ssc_key_deliver,
      _Leave      : redirected to composition child ZC_SSC_LEAVE,
      _POrder     : redirected to composition child ZC_SSC_P_ORDER,
      _Salary     : redirected to composition child ZC_SSC_SALARY,
      _Department : redirected to composition child ZC_SSC_DEPARTMENT,
      _EmployeeVH,
      _DeptVH
}
