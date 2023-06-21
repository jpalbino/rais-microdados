# RAIS: Baixar e importar microdados no R
# Para uma visão detalhada das variáveis e códigos baixe os Layouts: ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/Layouts/v%EDnculos/

if (!('curl') %in% installed.packages()) install.packages('curl')
library(curl)
url = "ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/Layouts/v%EDnculos/"
h = new_handle(dirlistonly=TRUE)
con = curl(url, "r", h)
tbl = read.table(con, stringsAsFactors=TRUE, col.names = "arquivo", fill=TRUE)
close(con)
# Lista de arquivos de layout da RAIS
str(tbl)
# 'data.frame':	7 obs. of  1 variable:
#  $ V1: Factor w/ 7 levels "RAIS_vinculos_layout.xls",..: 1 2 3 4 5 6 7
tbl
#                                  V1
# 1          RAIS_vinculos_layout.xls
# 2 RAIS_vinculos_layout1985a1993.xls
# 3      RAIS_vinculos_layout2015.xls
# 4      RAIS_vinculos_layout2016.xls
# 5      RAIS_vinculos_layout2017.xls
# 6 RAIS_vinculos_layout2018e2019.xls
# 7      RAIS_vinculos_layout2020.xls

# "Baixando" os arquivos de layout dos microdados
diretorio <- "./documentos/" # diretório destino dos arquivos
for (v in 1:nrow(tbl)) {
  download.file(paste0(url,tbl$arquivo[v]), destfile=paste0(diretorio, tbl$arquivo[v]), mode='wb', method='libcurl')
}

