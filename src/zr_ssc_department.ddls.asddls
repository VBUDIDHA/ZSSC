@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Department Child CDS VIew'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zr_ssc_department
  as select from zssc_department

  association to parent ZR_SSC_EMPLOYEE as _Employee on $projection.EmployeeID = _Employee.EmployeeID

{
  key zz_emp_id       as EmployeeID,
  key zz_dept_id      as DepartmentID,
      zz_dept_name    as DepartmentName,
      zz_wbs          as Wbs,
      zz_building     as Building,
      last_changed_at as LastChangedAt,

      //Associations
      _Employee
}
