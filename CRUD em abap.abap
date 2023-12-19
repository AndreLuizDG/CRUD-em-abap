REPORT z_algj_39.

*--------------------------------------------------------------------*
* Declarações
*--------------------------------------------------------------------*

TABLES:
  ztb_crud_algj.

TYPES:
  BEGIN OF type_alv,
    func_cod         TYPE ztb_crud_algj-func_cod,
    func_nome        TYPE ztb_crud_algj-func_nome,
    func_dt_nasc     TYPE ztb_crud_algj-func_dt_nasc,
    func_salario     TYPE ztb_crud_algj-func_salario,
    func_dt_contr    TYPE ztb_crud_algj-func_dt_contr,
    func_dt_demis    TYPE ztb_crud_algj-func_dt_demis,
    func_desc_funcao TYPE ztb_crud_algj-func_desc_funcao,
  END OF type_alv.


DATA:
  ti_funcionarios TYPE TABLE OF ztb_crud_algj,
  ti_fieldcat     TYPE TABLE OF slis_fieldcat_alv,
  ti_alv          TYPE TABLE OF type_alv.

DATA:
  wa_funcionarios TYPE ztb_crud_algj,
  wa_fieldcat     TYPE slis_fieldcat_alv,
  wa_alv          TYPE type_alv.

CONSTANTS:
  c_e TYPE char1 VALUE 'E',
  c_s TYPE char1 VALUE 'S'.

*--------------------------------------------------------------------*
* Tela de seleção
*--------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-e01.

PARAMETERS: so1 TYPE ztb_crud_algj-func_cod,
            so2 TYPE ztb_crud_algj-func_nome,
            so3 TYPE ztb_crud_algj-func_dt_nasc,
            so4 TYPE ztb_crud_algj-func_salario,
            so5 TYPE ztb_crud_algj-func_dt_contr,
            so6 TYPE ztb_crud_algj-func_dt_demis,
            so7 TYPE ztb_crud_algj-func_desc_funcao.

SELECTION-SCREEN END OF BLOCK b1.


SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-e02.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: b1 RADIOBUTTON GROUP g1.
SELECTION-SCREEN COMMENT 20(15) text-001 FOR FIELD b1. "Criar
SELECTION-SCREEN POSITION 40.
PARAMETERS: b2 RADIOBUTTON GROUP g1.
SELECTION-SCREEN COMMENT 60(15) text-002 FOR FIELD b2. "Listar
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: b3 RADIOBUTTON GROUP g1.
SELECTION-SCREEN COMMENT 20(15) text-003 FOR FIELD b3. "Atualizar
SELECTION-SCREEN POSITION 40.
PARAMETERS: b4 RADIOBUTTON GROUP g1.
SELECTION-SCREEN COMMENT 60(15) text-004 FOR FIELD b4. "Deletar
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b2.


*--------------------------------------------------------------------*
* Eventos
*--------------------------------------------------------------------*

*--------------------------------------------------------------------*
* Forms
*--------------------------------------------------------------------*

*$*$ -------------------------------------------------------------- *$*$
*$*$                                CRIAR                           *$*$
*$*$ -------------------------------------------------------------- *$*$
"
IF b1 IS NOT INITIAL.

  wa_funcionarios-func_cod         = so1.
  wa_funcionarios-func_nome        = so2.
  wa_funcionarios-func_dt_nasc     = so3.
  wa_funcionarios-func_salario     = so4.
  wa_funcionarios-func_dt_contr    = so5.
  wa_funcionarios-func_dt_demis    = so6.
  wa_funcionarios-func_desc_funcao = so7.

  INSERT ztb_crud_algj FROM wa_funcionarios.

  IF sy-subrc = 0.
    MESSAGE s208(00) WITH text-006 DISPLAY LIKE c_s. "Funcionario registrado!
  ELSE.
    MESSAGE s208(00) WITH text-008 DISPLAY LIKE c_e. "Erro ao registrar funcionario!
  ENDIF.

ENDIF.


*$*$ -------------------------------------------------------------- *$*$
*$*$                                LISTAR                          *$*$
*$*$ -------------------------------------------------------------- *$*$


IF b2 IS NOT INITIAL.

  FREE ti_funcionarios.
  SELECT *
    FROM ztb_crud_algj
    INTO TABLE ti_funcionarios.

  IF sy-subrc <> 0.
    FREE ti_funcionarios.
    MESSAGE s208(00) WITH text-005 DISPLAY LIKE c_e. "Funcionario não encontrado!
    LEAVE LIST-PROCESSING.
  ENDIF.

  LOOP AT ti_funcionarios INTO wa_funcionarios.

    wa_alv-func_cod          =  wa_funcionarios-func_cod        .
    wa_alv-func_nome         =  wa_funcionarios-func_nome       .
    wa_alv-func_dt_nasc      =  wa_funcionarios-func_dt_nasc    .
    wa_alv-func_salario      =  wa_funcionarios-func_salario    .
    wa_alv-func_dt_contr     =  wa_funcionarios-func_dt_contr   .
    wa_alv-func_dt_demis     =  wa_funcionarios-func_dt_demis   .
    wa_alv-func_desc_funcao  =  wa_funcionarios-func_desc_funcao.

    APPEND wa_alv TO ti_alv.
    CLEAR wa_alv.

  ENDLOOP.

  PERFORM zf_monata_tabela_fieldcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = ti_fieldcat
    TABLES
      t_outtab           = ti_alv
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    MESSAGE s208(00) WITH text-004 DISPLAY LIKE c_e. "Erro ao exibir o relat#rio!
  ENDIF.

ENDIF.

*$*$ -------------------------------------------------------------- *$*$
*$*$                                EDITAR                          *$*$
*$*$ -------------------------------------------------------------- *$*$

IF b3 IS NOT INITIAL.

  FREE ti_funcionarios.
  SELECT *
    FROM ztb_crud_algj
    INTO TABLE ti_funcionarios
   WHERE func_cod = so1.

  IF sy-subrc <> 0.
    FREE ti_funcionarios.
    MESSAGE s208(00) WITH text-005 DISPLAY LIKE c_e. "Funcionario não encontrado!
    LEAVE LIST-PROCESSING.
  ENDIF.

  READ TABLE ti_funcionarios INTO wa_funcionarios INDEX 1.

  IF sy-subrc = 0.

    IF so2 IS NOT INITIAL.
      wa_funcionarios-func_nome        = so2.
    ENDIF.

    IF so3 IS NOT INITIAL.
      wa_funcionarios-func_dt_nasc     = so3.
    ENDIF.

    IF so4 IS NOT INITIAL.
      wa_funcionarios-func_salario     = so4.
    ENDIF.

    IF so5 IS NOT INITIAL.
      wa_funcionarios-func_dt_contr    = so5.
    ENDIF.

    IF so6 IS NOT INITIAL.
      wa_funcionarios-func_dt_demis    = so6.
    ENDIF.

    IF so7 IS NOT INITIAL.
      wa_funcionarios-func_desc_funcao = so7.
    ENDIF.


    MODIFY ztb_crud_algj FROM wa_funcionarios.
    CLEAR wa_alv.

    IF sy-subrc = 0.
      MESSAGE s208(00) WITH text-007 DISPLAY LIKE c_s. "Dados editados com sucesso!
    ELSE.
      MESSAGE s208(00) WITH text-011 DISPLAY LIKE c_s. "Erro ao editados dados!
    ENDIF.

  ENDIF.

ENDIF.


*$*$ -------------------------------------------------------------- *$*$
*$*$                               DELETAR                          *$*$
*$*$ -------------------------------------------------------------- *$*$


IF b4 IS NOT INITIAL.
  DELETE FROM ztb_crud_algj WHERE func_cod = so1.

  IF sy-subrc = 0.
    MESSAGE s208(00) WITH text-009 DISPLAY LIKE c_s. "Funcionário excluido com sucesso!
  ELSE.
    MESSAGE s208(00) WITH text-010 DISPLAY LIKE c_s. "Erro ao excluir funcionário!
  ENDIF.

ENDIF.

FORM zf_monata_tabela_fieldcat.

  PERFORM zf_monta_fieldcat USING:

  'FUNC_COD'           'TI_ALV'   'FUNC_COD'           'ZTB_CRUD_ALGJ' ''                    '10',
  'FUNC_NOME'          'TI_ALV'   'FUNC_NOME'          'ZTB_CRUD_ALGJ' ''                    '30',
  'FUNC_DT_NASC'       'TI_ALV'   'FUNC_DT_NASC'       'ZTB_CRUD_ALGJ' ''                    '15',
  'FUNC_SALARIO'       'TI_ALV'   'FUNC_SALARIO'       'ZTB_CRUD_ALGJ' 'Salário'             '15',
  'FUNC_DT_CONTR'      'TI_ALV'   'FUNC_DT_CONTR'      'ZTB_CRUD_ALGJ' ''                    '15',
  'FUNC_DT_DEMIS'      'TI_ALV'   'FUNC_DT_DEMIS'      'ZTB_CRUD_ALGJ' 'Data de demissão'    '15',
  'FUNC_DESC_FUNCAO'   'TI_ALV'   'FUNC_DESC_FUNCAO'   'ZTB_CRUD_ALGJ' ''                    '20'.
ENDFORM.

FORM zf_monta_fieldcat USING l_fieldname     TYPE any
                             l_tabname       TYPE any
                             l_ref_fieldname TYPE any
                             l_ref_tabname   TYPE any
                             l_seltext_m     TYPE any
                             l_outputlen     TYPE any.

  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname        = l_fieldname.
  wa_fieldcat-tabname          = l_tabname.
  wa_fieldcat-ref_fieldname    = l_ref_fieldname.
  wa_fieldcat-ref_tabname      = l_ref_tabname.
  wa_fieldcat-seltext_m        = l_seltext_m.
  wa_fieldcat-outputlen        = l_outputlen.
  APPEND wa_fieldcat TO ti_fieldcat.

ENDFORM.
