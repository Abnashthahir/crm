FROM frappe/bench:latest

WORKDIR /home/frappe

RUN bench init frappe-bench \
    --skip-assets \
    --skip-redis-config-generation \
    --python python3

WORKDIR /home/frappe/frappe-bench

RUN bench get-app crm https://github.com/frappe/crm.git

COPY --chown=frappe:frappe entrypoint.sh /home/frappe/entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["bash", "/home/frappe/entrypoint.sh"]
