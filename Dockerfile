FROM alpine AS irpf
RUN apk add --no-cache wget
ENV YEAR 2020
ENV VERSION 1.4
ENV URL "http://downloadirpf.receita.fazenda.gov.br/irpf/${YEAR}/irpf/arquivos/IRPF${YEAR}-${VERSION}.zip"
RUN echo $URL
RUN wget -L $URL -O irpf.zip && \
    unzip irpf.zip -d / && \
    rm irpf.zip && \
    mv "IRPF${YEAR}" /opt/irpf

FROM openjdk:8-alpine
RUN apk add --no-cache ttf-dejavu
RUN adduser -D -u 1000 irpf
WORKDIR /home/irpf

COPY --from=irpf --chown=irpf:irpf /opt/irpf /opt/irpf

USER irpf
CMD ["java", "-jar", "/opt/irpf/irpf.jar"]