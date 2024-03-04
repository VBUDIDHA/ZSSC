@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Value help base CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z_i_ssc_employee_vh
  as select from zssc_employee
{
  key zz_emp_id as EmployeeID,
      zz_first_name as FirstName,
      zz_last_name as LastName
}
