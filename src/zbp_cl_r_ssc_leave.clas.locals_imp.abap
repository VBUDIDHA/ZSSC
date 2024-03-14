CLASS lhc_Leave DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateleavecount FOR VALIDATE ON SAVE
      IMPORTING keys FOR Leave~validateleavecount.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Leave RESULT result.

    METHODS acceptleave FOR MODIFY
      IMPORTING keys FOR ACTION Leave~acceptleave RESULT result.

    METHODS rejectleave FOR MODIFY
      IMPORTING keys FOR ACTION Leave~rejectleave RESULT result.

    METHODS SetOpenStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR Leave~SetOpenStatus.

    CONSTANTS:
      BEGIN OF zgc_leave_status,
        open     TYPE zv_ssc_leave_staus VALUE 'Open',
        accepted TYPE zv_ssc_leave_staus VALUE 'Accepted',
        rejected TYPE zv_ssc_leave_staus VALUE 'Rejected',
      END OF zgc_leave_status.

*    METHODS validatedates FOR VALIDATE ON SAVE
*      IMPORTING keys FOR Leave~validatedates.
*    METHODS get_days_diff
*      RETURNING
*        value(zrv_days_diff) TYPE zv_ssc_leave_days.

ENDCLASS.

CLASS lhc_Leave IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

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

*  "Validation on dates - If number of days is more/less on selected dates(From-To), error message
*  METHOD validatedates.
*
*    READ ENTITIES OF zr_ssc_employee IN LOCAL MODE
*      ENTITY Leave
*      FIELDS ( NoDays FromDate ToDate )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(zlt_leaves).
*
*    DATA(zlv_emp_id) = VALUE #( zlt_leaves[ 1 ]-EmployeeID OPTIONAL ).
*
*    IF zlv_emp_id IS INITIAL.
*      RETURN.
*    ENDIF.
*
*    LOOP AT zlt_leaves INTO DATA(zls_leave).
*
*        DATA(zlv_days_diff) = get_days_diff( ).
*
*      IF zls_leave-NoDays GT zlv_days_diff
*      OR zls_leave-NoDays LT zlv_days_diff.
*
*        APPEND VALUE #( %tky = zls_leave-%tky ) TO failed-leave.
*
*        APPEND VALUE #( %tky = zls_leave-%tky
*                        %msg = NEW zcl_ssc_messages(
*                                     avilableleaves = zls_leave-
*                                     noleaves = zls_leave-NoDays
*                                     textid    = zcl_ssc_messages=>validate_leaves
*                                     severity  = if_abap_behv_message=>severity-error )
*                         %element-NoDays  = if_abap_behv=>mk-on
*                      ) TO reported-leave.
*
*      ENDIF.
*    ENDLOOP.
*  ENDMETHOD.
*
*
*  METHOD get_days_diff.
*
*    call function 'DAYS_BETWEEN_TWO_DATES'
*
*
*
*
*
*
*  ENDMETHOD.

  METHOD acceptleave.

    "Modify Leave instance with status - accepted
    MODIFY ENTITIES OF zr_ssc_employee IN LOCAL MODE
      ENTITY Leave
        UPDATE FIELDS (  OverallStatus )
        WITH VALUE #( FOR key IN keys ( %tky          = key-%tky
                                        OverallStatus = zgc_leave_status-accepted ) ).

    "Read changed data for action result
    READ ENTITIES OF zr_ssc_employee IN LOCAL MODE
      ENTITY Leave
        ALL FIELDS WITH
        CORRESPONDING #( keys )
      RESULT DATA(zlt_leaves).

    result = VALUE #( FOR zls_leave IN zlt_leaves ( %tky   = zls_leave-%tky
                                                    %param = zls_leave ) ).

  ENDMETHOD.

  METHOD rejectleave.

    "Modify Leave instance with status - accepted
    MODIFY ENTITIES OF zr_ssc_employee IN LOCAL MODE
      ENTITY Leave
        UPDATE FIELDS (  OverallStatus )
        WITH VALUE #( FOR key IN keys ( %tky          = key-%tky
                                        OverallStatus = zgc_leave_status-rejected ) ).

    "Read changed data for action result
    READ ENTITIES OF zr_ssc_employee IN LOCAL MODE
      ENTITY Leave
        ALL FIELDS WITH
        CORRESPONDING #( keys )
      RESULT DATA(zlt_leaves).

    result = VALUE #( FOR zls_leave IN zlt_leaves ( %tky   = zls_leave-%tky
                                                    %param = zls_leave ) ).

  ENDMETHOD.

  METHOD SetOpenStatus.

    "First read Leave entered UI data
    READ ENTITIES OF zr_ssc_employee IN LOCAL MODE
    ENTITY Leave
    FIELDS ( OverallStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(zlt_leaves).

    "No need to update for existing records
    DELETE zlt_leaves WHERE  OverallStatus IS NOT INITIAL.
    IF zlt_leaves IS INITIAL.
      RETURN.
    ENDIF.

    "Update WeekNumber for new entry
    LOOP AT zlt_leaves ASSIGNING FIELD-SYMBOL(<zls_leave>).
      <zls_leave>-OverallStatus = zgc_leave_status-open.
    ENDLOOP.

    "Modify the Key Deliverables Entity to save into DB table
    MODIFY ENTITIES OF zr_ssc_employee IN LOCAL MODE
    ENTITY Leave
    UPDATE FIELDS ( OverallStatus )
    WITH CORRESPONDING #( zlt_leaves ).

  ENDMETHOD.

ENDCLASS.
