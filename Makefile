YEAR=2019
YEAR=1.5
IMAGE=yurifl/irpf

default:
	docker build -t ${IMAGE} --build-arg YEAR=${YEAR} --build-arg VERSION=${VERSION} .
	docker push ${IMAGE}
