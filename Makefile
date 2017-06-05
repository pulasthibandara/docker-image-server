
REPO=pulasthibandara/image_server

.PHONY: build release test git_push

build:
	docker build -t ${REPO}:latest .

release: build bump_version
	$(eval VERSION=$(shell cat ./VERSION))
	docker tag ${REPO}:latest ${REPO}:${VERSION}
	docker push ${REPO}:latest
	docker push ${REPO}:${VERSION}

git_push:
	$(eval VERSION=$(shell cat ./VERSION))
	git tag -a "${VERSION}" -m "version ${VERSION}"
	git push
	git push --tags

test:
	-docker-compose -f ./test/docker-compose.yml up --build -d image_server
	-docker-compose -f ./test/docker-compose.yml up --build test_runner 
	docker-compose -f ./test/docker-compose.yml down

bump_version:
	./bump-version.sh