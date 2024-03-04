@EndUserText.label: 'Projection View for Purchase Order CDS'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity ZC_SSC_P_ORDER
  as projection on zr_ssc_p_order
{
  key EmployeeID,
  key PONumber,
      ExpiryDate,
      ValidHours,
      Billrate,
      Currency,
      PoOwner,
      LastChangedAt,
      
      /* Associations */
      _Employee : redirected to parent ZC_SSC_EMPLOYEE
}
