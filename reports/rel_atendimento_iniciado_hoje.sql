SELECT
  TB_ATENDIME.*,
  TB_ATENDIME.CD_ATENDIMENTO,
  TB_ATENDIME.HR_ATENDIMENTO,
  TB_ATENDIME.CD_CONVENIO,
  CONVENIO.NM_CONVENIO,
  TB_ATENDIME.CD_PRESTADOR,
  PRESTADOR.NM_PRESTADOR,
  TB_ATENDIME.CD_PACIENTE,
  PACIENTE.NM_PACIENTE,
  TB_ATENDIME.CD_SERVICO,
  TB_ATENDIME.CD_LOC_PROCED,
  LOC_PROCED.DS_LOC_PROCED

FROM TB_ATENDIME
LEFT OUTER JOIN PACIENTE ON TB_ATENDIME.CD_PACIENTE = PACIENTE.CD_PACIENTE
LEFT OUTER JOIN PRESTADOR ON TB_ATENDIME.CD_PRESTADOR = PRESTADOR.CD_PRESTADOR
LEFT OUTER JOIN CONVENIO ON TB_ATENDIME.CD_CONVENIO = CONVENIO.CD_CONVENIO
LEFT OUTER JOIN servico ON TB_ATENDIME.CD_SERVICO = SERVICO.CD_SERVICO
LEFT OUTER JOIN LOC_PROCED ON TB_ATENDIME.CD_LOC_PROCED = LOC_PROCED.CD_LOC_PROCED
WHERE  Trunc ( (  SYSDATE -  dt_atendimento )  * 24  , 2) BETWEEN 0 AND 24
    ;