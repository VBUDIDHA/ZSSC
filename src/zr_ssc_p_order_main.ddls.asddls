@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED Individual ZSSC_P_ORDER'
define root view entity ZR_SSC_P_ORDER_MAIN
  as select from zssc_p_order as POrderMain
  association [0..*] to z_i_ssc_employee_vh as _EmployeeVH on $projection.ZzEmpID = _EmployeeVH.EmployeeID
{
      @Consumption.valueHelpDefinition: [{ entity: { name: 'z_i_ssc_employee_vh', element: 'EmployeeID' } }]
  key zz_emp_id             as ZzEmpID,
  key zz_po_no              as ZzPoNo,
      zz_exp_date           as ZzExpDate,
      zz_valid_hrs          as ZzValidHrs,
      @Semantics.amount.currencyCode: 'ZzCurrency'
      zz_billrate           as ZzBillrate,
      zz_currency           as ZzCurrency,
      zz_po_owner           as ZzPoOwner,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      
      //Association
      _EmployeeVH

}
