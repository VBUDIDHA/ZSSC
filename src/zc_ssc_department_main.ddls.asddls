@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_SSC_DEPARTMENT_MAIN'
@ObjectModel.semanticKey: [ 'ZzEmpID', 'ZzDeptID' ]
define root view entity ZC_SSC_DEPARTMENT_MAIN
  provider contract transactional_query
  as projection on ZR_SSC_DEPARTMENT_MAIN

  association [0..*] to z_i_ssc_employee_vh   as _EmployeeVH on $projection.ZzEmpID = _EmployeeVH.EmployeeID
  association [0..*] to z_i_ssc_department_VH as _DeptVH     on $projection.ZzEmpID = _DeptVH.EmployeeID
{
      @Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_employee_vh', element: 'EmployeeID' } }]
  key ZzEmpID,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_department_VH', element: 'DepartmentID' } }]
  key ZzDeptID,
      ZzDeptName,
      ZzWbs,
      ZzBuilding,
      LocalLastChangedAt

}
