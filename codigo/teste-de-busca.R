 library(curl)
 url = "ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/11/PXD000299/"
 h = new_handle(dirlistonly=TRUE)
 con = curl(url, "r", h)
 tbl = read.table(con, stringsAsFactors=TRUE, fill=TRUE)
 close(con)
 head(tbl)
 

 # Teste 1 
 url = "ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/1990/"
 
 # Teste 2
 url = "ftp://ftp.mtps.gov.br/pdet/microdados/"
 
 # Teste 3
 url = "ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/Layouts/v%EDnculos/"
 
 # Teste de download para Estado de SP
 
 uf = "SP"
 year = 2017
 files <- paste0(uf,year,'.7z')
 ftp.path <- paste0('ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/',year,'/',files)
 diretorio <- "./dados/"
 download.file(ftp.path, destfile=paste0(diretorio,files), mode='wb', method='libcurl') 
 
# zipF<-file.choose() # permite escolher um arquivo e salvar seu caminho de arquivo em R (pelo menos para Windows)
# outDir<-"D:\\GitHub\\rais-microdados\\dados" # Define a pasta onde o arquivo zip deve ser descompactado.
# unzip(zipF,exdir=outDir) # descompactar o arquivo
 
system('7z e -o ./dados/ SP2017.7z')

files.txt <- paste0(uf,year,'.txt')
system(paste0('7z e ',files,' -y',sep=''))
path.file <- paste0(diretorio,files.txt)
