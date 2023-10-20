### configuracao gcp

- criar role com permisoes logging.logEntries.[create, route], logging.buckets.write
- criar conta de servico com o role
- criar sink com bucket de logs e configurar filtro com base nos campos adicionados no fluent
- passar para o fluent o arquivo de autenticacao da conta de servico (no dockerfile)

  ### pelo gcloud
  ```bash
  // create role
  gcloud iam roles create customLogRole --project=my-project-id \
--title="Custom Log Role" \
--description="Role with permissions to create and route log entries, and write to buckets" \
--stage=GA \
--permissions=logging.logEntries.create,logging.logEntries.route,logging.buckets.write

// create service-account
gcloud iam service-accounts create my-service-account --display-name="My Service Account" --project=my-project-id
```

// associeate role to account
gcloud projects add-iam-policy-binding my-project-id \
--member=serviceAccount:my-service-account@my-project-id.iam.gserviceaccount.com \
--role=projects/my-project-id/roles/customLogRole

// create sink
gcloud logging sinks create my-sink storage.googleapis.com/my-log-bucket \
--log-filter='metadata.userLabels.origin="appLog"' --project=my-project-id

// get account auth-key file
gcloud iam service-accounts keys create key.json \
--iam-account=my-service-account@my-project-id.iam.gserviceaccount.com --project=my-project-id
