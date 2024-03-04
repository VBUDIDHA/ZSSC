@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SSC Department ID Value help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z_i_ssc_department_VH
  as select from zssc_department
{
  key zz_emp_id             as EmployeeID,
  key zz_dept_id            as DepartmentID,
      zz_dept_name          as DepartmentName
}
