unit usql_editor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

implementation

{

SQL

/* Formatted on 2022/04/28 13:34 (Formatter Plus v4.8.8) */
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



---
/* Formatted on 2022/04/28 13:42 (Formatter Plus v4.8.8) */
SELECT hospital.ds_rodape_reports
  FROM dbamv.hospital hospital
 WHERE hospital.cd_multi_empresa = NVL (1, 1)


---
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
}

end.

