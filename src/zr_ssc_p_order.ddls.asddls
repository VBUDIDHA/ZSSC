@AbapCatalog.viewEnhancementCategory: [#NONE]
@EndUserText.label: 'Employee Purchase Order Child CDS VIew'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zr_ssc_p_order
  as select from zssc_p_order

  association to parent ZR_SSC_EMPLOYEE as _Employee on $projection.EmployeeID = _Employee.EmployeeID

{
  key zz_emp_id       as EmployeeID,
  key zz_po_no        as PONumber,
      zz_exp_date     as ExpiryDate,
      zz_valid_hrs    as ValidHours,
      @Semantics.amount.currencyCode: 'Currency'
      zz_billrate     as Billrate,
      zz_currency     as Currency,
      zz_po_owner     as PoOwner,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      
      //Associations
      _Employee      
}
