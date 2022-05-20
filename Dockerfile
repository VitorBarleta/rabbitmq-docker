FROM rabbitmq:3-management-alpine

ENV RABBITMQ_USER user
ENV RABBITMQ_PASSWORD password

ADD startup.sh /startup.sh
RUN chmod +x startup.sh
EXPOSE 15672

ADD rabbitmq.conf /etc/rabbitmq/
ADD definitions.json /etc/rabbitmq/

CMD ["/startup.sh"]