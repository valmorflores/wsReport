SELECT MCARD.*, ATENDIME.*, PACIENTE.*, ITPRE_MED.CD_TIP_PRESC,
DS_TIP_PRESC,
ITPRE_MED.CD_TIP_ESQ,
PRE_MED.DT_VALIDADE PRE_MED_DT_VALIDADE  
FROM TB_MOV_CARDAPIO MCARD
LEFT OUTER JOIN ATENDIME ON ATENDIME.CD_ATENDIMENTO = MCARD.CD_ATENDIMENTO
LEFT OUTER JOIN PACIENTE ON PACIENTE.CD_PACIENTE = ATENDIME.CD_PACIENTE  
LEFT OUTER JOIN ITPRE_MED ON ITPRE_MED.CD_ITPRE_MED = MCARD.CD_ITPRE_MED
LEFT OUTER JOIN TIP_PRESC ON ITPRE_MED.CD_TIP_PRESC = TIP_PRESC.CD_TIP_PRESC
LEFT OUTER JOIN PRE_MED ON ITPRE_MED.CD_PRE_MED = PRE_MED.CD_PRE_MED
WHERE PRE_MED.DT_VALIDADE > TO_DATE('02/05/2022') AND MCARD.CD_ATENDIMENTO = 4751012
ORDER BY PRE_MED.DT_VALIDADE DESC

-- 4751012 
-- 4779726