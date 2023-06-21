# RAIS: Baixar e importar microdados no R

# Original fonte: http://cemin.wikidot.com/raisrm
# Author; Guilherme Cemin
# Alterado/adaptado por: João Pedro Albino
# Data: 2023-06-20

if (!('data.table') %in% installed.packages()) install.packages('data.table')
library(data.table)
# Indique a pasta onde os arquivos serão baixados
#
#setwd('C:\\Users...')
diretorio <- "./dados/"
# Como os arquivos da RAIS estão compactados no formato .7z, é necessário ter o executável 7z.exe na pasta de trabalho.
# Não é necessário editar
download.file('http://cemin.wikidot.com/local--files/raisrm/7z.exe', destfile='./dados/7z.exe', mode='wb')

# Selecionar as variáveis desejadas
# As variáveis disponíveis são:
#'Bairros SP','Bairros Fortaleza','Bairros RJ','Causa Afastamento 1','Causa Afastamento 2',
#'Causa Afastamento 3','Motivo Desligamento','CBO Ocupação 2002','CNAE 2.0','Classe CNAE 95',
#'Classe Distritos SP','Vínculo Ativo 31/12','Faixa Etária','Faixa Hora Contrat','Faixa Remun Dezem (SM)', 
#'Faixa Remun Média (SM)','Faixa Tempo Emprego','Escolaridade após 2005','Qtd Hora Contr',
#'Idade','Ind CEI Vinculado','Ind Simples','Mês Admissão','Mês Desligamento','Mun Trab',
#'Município','Nacionalidade','Natureza Jurídica','Ind Portador Defic','Qtd Dias Afastamento',
#'Raça Cor','Regiões Adm DF','Vl Remun Dezembro Nom','Vl Remun Dezembro (SM)','Vl Remun Média Nom',
#'Vl Remun Média (SM)','CNAE 2.0 Subclasse','Sexo Trabalhador','Tamanho Estabelecimento',
#'Tempo Emprego','Tipo Admissão','Tipo Estab','Tipo Estab','Tipo Defic','Tipo Vínculo'
# Exemplo
# selvar <- c('CBO Ocupação 2002','Vínculo Ativo 31/12','Vl Remun Média Nom','Sexo Trabalhador')
selvar <- c()
# Selecione os anos (no exemplo, serão baixados os arquivos de 2013 e 2014)
for(i in c(2013:2014)){
  # Selecionar estados (no exemplo, serão baixados os arquivos para os estados do Sul para 2013 e 2014)
  for(j in c('PR','SC','RS')){
    # Daqui em diante não editar
    year <- as.character(i)
    uf <- as.character(j)
    files <- paste0(uf,year,'.7z')
    files.txt <- paste0(uf,year,'.txt')
    # Gerar url do arquivo
    ftp.path <- paste0('ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/',year,'/',files)
    # Tentar baixar cada arquivo 7z e extrair txt
    counter <- 0
    while(counter<10){
      counter <- sum(counter, 1)
      try1 <- try(download.file(ftp.path, destfile=paste0(diretorio,files), mode='wb', method='libcurl'), silent=F)
      if(class(try1)=='try-error'){Sys.sleep(60)}
      else{break}
    }
    system(paste0('7z e ',files,' -y',sep=''))
    path.file <- paste0(diretorio,files.txt)
    # Ler e salvar em Rda
    x <- suppressWarnings(fread(path.file, sep = ';', select=selvar, header = TRUE, encoding = 'Latin-1'))
    save(x, file=paste0(diretorio,uf,year,'.Rda'))
    # Remover arquivos que não serão mais utilizados:
    file.remove(paste0(diretorio,files),paste0(diretorio,files.txt))
    # Liberar ram a cada loop
    gc()
  }}

#file.remove(paste0(getwd(),'/','7z.exe'))

rm(list = ls())
gc()
