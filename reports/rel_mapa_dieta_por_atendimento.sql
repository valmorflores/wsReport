SELECT ATENDIME.*, ITPRE_MED.*, PRE_MED.*,
ITPRE_MED.cd_tip_presc,ITPRE_MED.CD_TIP_ESQ
          ,  ds_tip_presc   || ' ; ' ||  Decode ( TIP_PRESC.qt_infusao , NULL , QT_ITPRE_MED || ' '  ||UNI_PRESC.CD_UNIDADE , TIP_PRESC.qt_infusao || Decode ( itpre_med.tp_tempo , 'H' , '/ HR' , 'M' , '/ MIN' , NULL ) )   PROD_GRAMA_P_LITRO
          , MOV_CARDAPIO.obs_nutricao obs_almoco
          , PACIENTE.NM_PACIENTE
          , MOV_CARDAPIO.cd_tipo_refeicao
          , MOV_CARDAPIO.sn_prescricao_suspensa
          , PRE_MED.cd_pre_med
          , PRE_MED.DH_CRIACAO
          

FROM ATENDIME
LEFT OUTER JOIN PRE_MED ON PRE_MED.cd_atendimento = ATENDIME.cd_atendimento
LEFT OUTER JOIN ITPRE_MED ON ITPRE_MED.cd_pre_med  = PRE_MED.cd_pre_med
LEFT OUTER JOIN TIP_PRESC ON ITPRE_MED.cd_tip_presc  =  TIP_PRESC.cd_tip_presc
LEFT OUTER JOIN UNI_PRESC ON ITPRE_MED.cd_uni_presc   =  UNI_PRESC.cd_uni_presc
LEFT OUTER JOIN MOV_CARDAPIO ON ITPRE_MED.cd_itpre_med = MOV_CARDAPIO.cd_itpre_med 
LEFT OUTER JOIN PACIENTE ON ATENDIME.CD_PACIENTE = PACIENTE.CD_PACIENTE
     
WHERE
  ITPRE_MED.cd_tip_esq IN ('DIT', 'DEL', 'DIE')
  AND PRE_MED.cd_atendimento = 4751012


ORDER BY

  PRE_MED.DH_CRIACAO


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