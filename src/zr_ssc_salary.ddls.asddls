@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Salary Child CDS VIew'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zr_ssc_salary
  as select from zssc_salary

  association to parent ZR_SSC_EMPLOYEE as _Employee on $projection.EmployeeID = _Employee.EmployeeID

{
  key zz_emp_id          as EmployeeID,
  key zz_po_no           as PONumber,
      @Semantics.amount.currencyCode: 'Currency'
      zz_income          as Income,
      zz_currency        as Currency,
      zz_leaves_taken    as LeavesTaken,
      zz_leave_available as LeavesAvailable,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,

      //Associations
      _Employee
}
