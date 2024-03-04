@EndUserText.label: 'Projection View for Key Deliverables CDS'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity zc_ssc_key_deliver
  as projection on zr_ssc_key_deliver
{
  key  EmployeeID,
  key  UserStory,
       WeekNumber,
       Description,
       Status,
       Remarks,
       Risk,
       Milestone,
       LastChangedAt,

       /* Associations */
       _Employee : redirected to parent ZC_SSC_EMPLOYEE
}
