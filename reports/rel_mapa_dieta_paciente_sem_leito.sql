SELECT ATENDIME.*, ITPRE_MED.*, PRE_MED.*,
ITPRE_MED.cd_tip_presc,ITPRE_MED.CD_TIP_ESQ
          ,  ds_tip_presc   || ' ; ' ||  Decode ( TIP_PRESC.qt_infusao , NULL , QT_ITPRE_MED || ' '  ||UNI_PRESC.CD_UNIDADE , TIP_PRESC.qt_infusao || Decode ( itpre_med.tp_tempo , 'H' , '/ HR' , 'M' , '/ MIN' , NULL ) )   PROD_GRAMA_P_LITRO

FROM ATENDIME
LEFT OUTER JOIN PRE_MED ON PRE_MED.cd_atendimento = ATENDIME.cd_atendimento
LEFT OUTER JOIN ITPRE_MED ON ITPRE_MED.cd_pre_med  = PRE_MED.cd_pre_med
LEFT OUTER JOIN TIP_PRESC ON ITPRE_MED.cd_tip_presc  =  TIP_PRESC.cd_tip_presc
LEFT OUTER JOIN UNI_PRESC ON ITPRE_MED.cd_uni_presc   =  UNI_PRESC.cd_uni_presc
WHERE
  ITPRE_MED.cd_tip_esq IN ('DIT', 'DEL', 'DIE')
  AND  Trunc ( (  SYSDATE -  dt_atendimento )  * 24  , 2) BETWEEN 0 AND 48
                                                                         

