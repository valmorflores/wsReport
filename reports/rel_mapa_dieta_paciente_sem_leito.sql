SELECT ATENDIME.*, ITPRE_MED.*, PRE_MED.*,
ITPRE_MED.cd_tip_presc,ITPRE_MED.CD_TIP_ESQ
          ,  ds_tip_presc   || ' ; ' ||  Decode ( TIP_PRESC.qt_infusao , NULL , QT_ITPRE_MED || ' '  ||UNI_PRESC.CD_UNIDADE , TIP_PRESC.qt_infusao || Decode ( itpre_med.tp_tempo , 'H' , '/ HR' , 'M' , '/ MIN' , NULL ) )   PROD_GRAMA_P_LITRO
          , MOV_CARDAPIO.obs_nutricao
          , PACIENTE.NM_PACIENTE
          , MOV_CARDAPIO.cd_tipo_refeicao
          , MOV_CARDAPIO.sn_prescricao_suspensa
          , tipo_refeicao.tipo_refeicao
          , PRE_MED.DT_VALIDADE PRE_MED_DT_VALIDADE
          , ds_tip_presc 
          , TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS') AS DT_VALIDADE_BASE
          , PACIENTE.dt_nascimento

FROM ATENDIME
LEFT OUTER JOIN PRE_MED ON PRE_MED.cd_atendimento = ATENDIME.cd_atendimento
LEFT OUTER JOIN ITPRE_MED ON ITPRE_MED.cd_pre_med  = PRE_MED.cd_pre_med
LEFT OUTER JOIN TIP_PRESC ON ITPRE_MED.cd_tip_presc  =  TIP_PRESC.cd_tip_presc
LEFT OUTER JOIN UNI_PRESC ON ITPRE_MED.cd_uni_presc   =  UNI_PRESC.cd_uni_presc
LEFT OUTER JOIN MOV_CARDAPIO ON PRE_MED.cd_atendimento = MOV_CARDAPIO.cd_atendimento AND  mov_cardapio.tp_cardapio = 'P'
LEFT OUTER JOIN PACIENTE ON ATENDIME.CD_PACIENTE = PACIENTE.CD_PACIENTE
LEFT OUTER JOIN tipo_refeicao ON tipo_refeicao.cd_tipo_refeicao = MOV_CARDAPIO.cd_tipo_refeicao 
     
WHERE
  ITPRE_MED.cd_tip_esq IN ('DIT', 'DEL', 'DIE')
  AND  Trunc ( (  SYSDATE -  dt_atendimento )  * 24  , 2) BETWEEN 0 AND 48

ORDER BY PRE_MED.CD_SETOR, ATENDIME.CD_PACIENTE, PRE_MED.CD_PRE_MED

/*
SELECT DISTINCT mov_cardapio.obs_nutricao obs_almoco
           FROM dbamv.mov_cardapio mov_cardapio, dbamv.tipo_dieta tipo_dieta
          WHERE mov_cardapio.cd_tipo_dieta = tipo_dieta.cd_tipo_dieta(+)
            AND mov_cardapio.cd_atendimento = :b1
            AND mov_cardapio.tp_cardapio = 'P'
            AND mov_cardapio.cd_mov_cardapio =
                   (SELECT MAX (cd_mov_cardapio)
                      FROM dbamv.mov_cardapio, dbamv.tipo_refeicao
                     WHERE mov_cardapio.cd_atendimento = :b1
                       AND mov_cardapio.tp_cardapio = 'P'
                       AND mov_cardapio.cd_tipo_refeicao =
                                                tipo_refeicao.cd_tipo_refeicao
                       AND tipo_refeicao.tipo_refeicao = 'A'
                       AND mov_cardapio.obs_nutricao IS NOT NULL
                       AND TRUNC (dt_mov_cardapio) <= TRUNC (:b3))
*/