@EndUserText.label: 'Projection View for Department CDS'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity ZC_SSC_DEPARTMENT
  as projection on zr_ssc_department
{
  key EmployeeID,
  key DepartmentID,
      DepartmentName,
      Wbs,
      Building,
      LastChangedAt,
      
      /* Associations */
      _Employee : redirected to parent ZC_SSC_EMPLOYEE
}
