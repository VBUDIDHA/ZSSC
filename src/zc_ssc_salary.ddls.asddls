@EndUserText.label: 'Projection View for Salary CDS'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity ZC_SSC_SALARY
  as projection on zr_ssc_salary
{
  key EmployeeID,
  key PONumber,
      Income,
      Currency,
      LeavesTaken,
      LeavesAvailable,
      LastChangedAt,

      /* Associations */
      _Employee : redirected to parent ZC_SSC_EMPLOYEE
}
