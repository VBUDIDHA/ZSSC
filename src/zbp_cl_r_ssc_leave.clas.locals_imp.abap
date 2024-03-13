CLASS lhc_Leave DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateleavecount FOR VALIDATE ON SAVE
      IMPORTING keys FOR Leave~validateleavecount.

ENDCLASS.

CLASS lhc_Leave IMPLEMENTATION.

  METHOD validateleavecount.

    READ ENTITIES OF zr_ssc_employee IN LOCAL MODE
    ENTITY Leave
    FIELDS ( NoDays )
    WITH CORRESPONDING #( keys )
    RESULT DATA(zlt_leaves).

    DATA(zlv_emp_id) = VALUE #( zlt_leaves[ 1 ]-EmployeeID OPTIONAL ).

    IF zlv_emp_id IS INITIAL.
      RETURN.
    ENDIF.

    SELECT SINGLE LeavesAvailable
    FROM zr_ssc_salary
    WHERE EmployeeID EQ @zlv_emp_id
    INTO @DATA(zlv_leaves_available).

    LOOP AT zlt_leaves INTO DATA(zls_leave).
      IF zls_leave-NoDays GT zlv_leaves_available.

        APPEND VALUE #( %tky = zls_leave-%tky ) TO failed-leave.

        APPEND VALUE #( %tky = zls_leave-%tky
                        %msg = NEW zcl_ssc_messages(
                                     avilableleaves = zlv_leaves_available
                                     noleaves = zls_leave-NoDays
                                     textid    = zcl_ssc_messages=>validate_leaves
                                     severity  = if_abap_behv_message=>severity-error )
                         %element-NoDays  = if_abap_behv=>mk-on
                      ) TO reported-leave.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
