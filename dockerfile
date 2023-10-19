FROM fluent/fluentd:v1.16-debian-1
USER root
RUN ["mkdir", "-p", "/home/fluent/.local/share/gem/ruby/3.1.0/cache"]
RUN ["mkdir", "-p", "/var/data"]
RUN chown -R fluent:fluent /var/data && chmod -R 775 /var/data
COPY ./gcp-access.json /var/data/gcp-access.json
RUN ["gem", "install", "fluent-plugin-google-cloud", "--no-document"]
RUN ["gem", "install", "fluent-plugin-http", "--no-document"]
USER fluent
