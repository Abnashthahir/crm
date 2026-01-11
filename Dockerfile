FROM frappe/bench:latest

WORKDIR /home/frappe/frappe-bench

RUN bench get-app crm https://github.com/frappe/crm.git

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]