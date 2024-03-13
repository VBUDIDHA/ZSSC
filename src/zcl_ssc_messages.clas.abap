CLASS zcl_ssc_messages DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .
    INTERFACES if_abap_behv_message .

    CONSTANTS:
      zgc_msgid TYPE symsgid VALUE 'ZSSC_MESSAGES',

      BEGIN OF validate_leaves,
        msgid TYPE symsgid VALUE 'ZSSC_MESSAGES',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'zlv_avail_leaves',
        attr2 TYPE scx_attrname VALUE 'zlv_no_leaves',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF validate_leaves.

    METHODS constructor
      IMPORTING
        textid         LIKE if_t100_message=>t100key OPTIONAL
        attr1          TYPE string OPTIONAL
        attr2          TYPE string OPTIONAL
        attr3          TYPE string OPTIONAL
        attr4          TYPE string OPTIONAL
        previous       LIKE previous OPTIONAL
        EmployeeId     TYPE zv_ssc_emp_id OPTIONAL
        AvilableLeaves TYPE zv_ssc_leaves_avialable OPTIONAL
        NoLeaves       TYPE zv_ssc_leave_days OPTIONAL
        severity       TYPE if_abap_behv_message=>t_severity OPTIONAL.

    DATA:
      zlv_attr1        TYPE string,
      zlv_attr2        TYPE string,
      zlv_attr3        TYPE string,
      zlv_attr4        TYPE string,
      zlv_empid        TYPE zv_ssc_emp_id,
      zlv_avail_leaves TYPE zv_ssc_leaves_avialable,
      zlv_no_leaves    TYPE zv_ssc_leave_days.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ssc_messages IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(  previous = previous ) .

    me->zlv_attr1                 = attr1.
    me->zlv_attr2                 = attr2.
    me->zlv_attr3                 = attr3.
    me->zlv_attr4                 = attr4.
    me->zlv_empid = employeeid.
    me->zlv_avail_leaves           = avilableleaves.
    me->zlv_no_leaves = noleaves.

    if_abap_behv_message~m_severity = severity.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
