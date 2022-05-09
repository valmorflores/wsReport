

Gerador de Relatorio
---------------------

Modulo de execução de multiplas formas:

1) Por prompt:
wsreport.exe -r reports\rel_mapa_dieta_por_atendimento_validade c:\temp\relatorio123.pdf atendimento=4779726

2) Via browser diretamente com parametro
http://srvm24:88/?r=rel_mapa_dieta_por_atendimento_validade/atendimento=4779726

3) Via sistema de relatorio no browser (uRep)
http://srvm24:89/app/reports/urep/public/login
Relatorio: http://srvm24:89/app/reports/urep/public/report/r/rel_mapa_dieta_por_atendimento_validade

4) Exemplos diversos / links:
srvm24:89/app/reports/urep/public/report/rviewatend/rel_atendimento_iniciado_hoje/0


Como instalar o servidor?

Você tem três microserviços para o funcionamento da ferramenta:
1) webserver: wsreportserver
Fica escutando na porta indicada em config.ini e executa conforme demanda e responde com endereço do relatorio

2) executor de relatorio: wsreport
Conecta na base de dados, executa a consulta e roda o relatorio salvando em pdf em local indicado

3) reportdesigner
Permite a edição de relatorio em tela, configuração do SQL correspondente e salvamento do .lrf


