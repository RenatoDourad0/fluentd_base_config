### configuracao gcp

- criar role com permisoes logging.logEntries.[create, route], logging.buckets.write
- criar conta de servico com o role
- criar sink com bucket de logs e configurar filtro com base nos campos adicionados no fluent
- passar para o fluent o arquivo de autenticacao da conta de servico (no dockerfile)