SELECT MCARD.*, ATENDIME.*, PACIENTE.*, ITPRE_MED.CD_TIP_PRESC,
DS_TIP_PRESC,
ITPRE_MED.DS_ITPRE_MED,
ITPRE_MED.CD_TIP_ESQ,
PRE_MED.DT_VALIDADE PRE_MED_DT_VALIDADE,
TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS') AS DT_VALIDADE_BASE

FROM TB_MOV_CARDAPIO MCARD
LEFT OUTER JOIN ATENDIME ON ATENDIME.CD_ATENDIMENTO = MCARD.CD_ATENDIMENTO
LEFT OUTER JOIN PACIENTE ON PACIENTE.CD_PACIENTE = ATENDIME.CD_PACIENTE  
LEFT OUTER JOIN ITPRE_MED ON ITPRE_MED.CD_ITPRE_MED = MCARD.CD_ITPRE_MED
LEFT OUTER JOIN TIP_PRESC ON ITPRE_MED.CD_TIP_PRESC = TIP_PRESC.CD_TIP_PRESC
LEFT OUTER JOIN PRE_MED ON ITPRE_MED.CD_PRE_MED = PRE_MED.CD_PRE_MED
WHERE 
PRE_MED.DT_VALIDADE >=  TO_DATE( TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY HH24:MI:SS')
 AND MCARD.CD_ATENDIMENTO = :atendimento 
 ORDER BY PRE_MED.CD_SETOR,PRE_MED.CD_PRE_MED, PRE_MED.DT_VALIDADE DESC

-- 4751012 
-- 4779726
