@EndUserText.label: 'Leaves Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity ZC_SSC_LEAVE
  as projection on zr_ssc_leaves
{
  key EmployeeID,
  key LeaveRequest,
      LeaveRequestType,
      NoDays,
      FromDate,
      ToDate,
      Reason,
      OverallStatus,
      LastChangedAt,
      
      /* Associations */
      _Employee : redirected to parent ZC_SSC_EMPLOYEE
}
