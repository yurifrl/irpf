FROM openjdk:9

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev && \
    rm -rf /var/lib/apt/lists/*

ARG YEAR=2019
ARG VERSION=1.5

RUN wget "http://downloadirpf.receita.fazenda.gov.br/irpf/$YEAR/irpf/arquivos/IRPF$YEAR-$VERSION.zip $FILE" -O irpf.zip && \
    unzip irpf.zip -d /opt/ && \
    mv /opt/IRPF*/ /opt/irpf

RUN groupadd --gid 1000 irpf && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash irpf

USER irpf

CMD ["java", "-Xms128M", "-Xmx512M", "-jar", "/opt/irpf/irpf.jar"]
