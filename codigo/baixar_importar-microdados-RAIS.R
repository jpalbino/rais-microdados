# RAIS: Baixar e importar microdados no R

# Original fonte: http://cemin.wikidot.com/raisrm
# Author; Guilherme Cemin
# Alterado/adaptado por: João Pedro Albino
# Data: 2023-06-20

if (!('data.table') %in% installed.packages()) install.packages('data.table')
library(data.table)
# Indicar a pasta onde os arquivos serão baixados
diretorio <- "./dados/"

# Teste de download para Estado de SP

uf = "PR" # Especificar a sigla do Estado 
year = 2013 # Especificar o ano. Na base atual vai até 2017, apenas!
files <- paste0(uf,year,'.7z') # Os dados estão em arquivos compactados .7z
ftp.path <- paste0('ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/',year,'/',files)
download.file(ftp.path, destfile=paste0(diretorio,files), mode='wb', method='libcurl')

# Para descompatar
if (!('archive') %in% installed.packages()) install.packages('archive')
library(archive)
tf <- tempfile()
td <- tempdir()
download.file(ftp.path, destfile=tf, mode='wb', method='libcurl')
files.data <- unzip( tf , exdir = td )
archive(tf)
archive_extract(
  tf,
  dir = diretorio,
  files = NULL,
  options = character(),
  strip_components = 0L
)

archive("./dados/SP2017.7z")

system('./dados/7z.exe e -o ./dados/ ./dados/SP2013.7z')

