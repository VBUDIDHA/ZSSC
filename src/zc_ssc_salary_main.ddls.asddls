@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_SSC_SALARY_MAIN'
@ObjectModel.semanticKey: [ 'ZzEmpID', 'ZzPoNo' ]
define root view entity ZC_SSC_SALARY_MAIN
  provider contract transactional_query
  as projection on ZR_SSC_SALARY_MAIN

  association [0..*] to z_i_ssc_employee_vh as _EmployeeVH on $projection.ZzEmpID = _EmployeeVH.EmployeeID
  association [0..*] to z_i_ssc_porder_vh   as _POrderVH   on $projection.ZzEmpID = _POrderVH.EmployeeID

{
      @Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_employee_vh', element: 'EmployeeID' } }]
  key ZzEmpID,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_porder_vh', element: 'PurchaseOrder' } }]
  key ZzPoNo,
      ZzIncome,
      ZzCurrency,
      ZzLeavesTaken,
      ZzLeaveAvailable,
      LocalLastChangedAt

}
