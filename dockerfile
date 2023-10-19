FROM fluent/fluentd:v1.16-debian-1
USER root
RUN ["mkdir", "-p", "/home/fluent/.local/share/gem/ruby/3.1.0/cache"]
RUN ["mkdir", "-p", "/var/data/google-fluentd"]
RUN chown -R fluent:fluent /var && chmod -R 775 /var
COPY ./gcp-access.json /var/data/google-fluentd/gcp-access.json
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "build-essential"]
RUN ["gem", "install", "fluent-plugin-google-cloud", "--no-document"]
# RUN ["gem", "install", "fluent-plugin-http", "--no-document"]
USER fluent
