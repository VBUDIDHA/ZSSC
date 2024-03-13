CLASS lhc_KeyDeliver DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS SetWeekNumber FOR DETERMINE ON SAVE
      IMPORTING keys FOR KeyDeliver~SetWeekNumber. "Determination

    METHODS get_week
      RETURNING
        VALUE(zrv_week) TYPE zv_ssc_week_no. "local method

ENDCLASS.

CLASS lhc_KeyDeliver IMPLEMENTATION.

  METHOD get_week.

    TRY.
        "Fetch Week number
        NEW cl_scal_utils(  )->date_get_week( EXPORTING iv_date = sy-datum
                                              IMPORTING ev_year = DATA(zlv_year)
                                                        ev_week = DATA(zlv_week) ) .

        zrv_week = |{ text-001 }{ zlv_year+2(2) }{ zlv_week }|.

      CATCH cx_scal INTO DATA(zls_scal).
    ENDTRY.

  ENDMETHOD.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Determiniation to get Week Number automatically
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  METHOD SetWeekNumber.

    "First read Key Deliveries entered UI data
    READ ENTITIES OF zr_ssc_employee IN LOCAL MODE
    ENTITY KeyDeliver
    FIELDS ( WeekNumber )
    WITH CORRESPONDING #( keys )
    RESULT DATA(zlt_keydelivers).

    "No need to update for exisiting records
    DELETE zlt_keydelivers WHERE WeekNumber IS NOT INITIAL.
    IF zlt_keydelivers IS INITIAL.
      RETURN.
    ENDIF.

    "Fetch Week number
    DATA(zlv_week) = get_week( ).

    "Update WeekNumber for new entry
    LOOP AT zlt_keydelivers ASSIGNING FIELD-SYMBOL(<zls_keydeliver>).
      <zls_keydeliver>-WeekNumber = zlv_week.
    ENDLOOP.

    "Modify the Key Deliverables Entity to save into DB table
    MODIFY ENTITIES OF zr_ssc_employee IN LOCAL MODE
    ENTITY KeyDeliver
    UPDATE FIELDS ( WeekNumber )
    WITH CORRESPONDING #( zlt_keydelivers ).

  ENDMETHOD.

ENDCLASS.
