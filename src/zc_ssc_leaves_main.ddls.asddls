@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_SSC_LEAVES_MAIN'
@ObjectModel.semanticKey: [ 'ZzEmpID', 'ZzLeaveReq' ]
define root view entity ZC_SSC_LEAVES_MAIN
  provider contract transactional_query
  as projection on ZR_SSC_LEAVES_MAIN
  association [0..*] to z_i_ssc_employee_vh as _EmployeeVH on $projection.ZzEmpID = _EmployeeVH.EmployeeID

{
      @Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_employee_vh', element: 'EmployeeID' } }]
  key ZzEmpID,
  key ZzLeaveReq,
      ZzLeaveType,
      ZzNoDays,
      ZzFromDate,
      ZzToDate,
      ZzReason,
      LocalLastChangedAt

}
