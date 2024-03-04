@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SSC Purchase Order value help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity z_i_ssc_porder_vh
  as select from zssc_p_order
{
  key zz_emp_id   as EmployeeID,
  key zz_po_no    as PurchaseOrder,
      zz_exp_date as ExpiryDate
}
