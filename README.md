# Docker IMAGE_SERVER

## Usage
An nginx based image server provided as a docker container.
- Supports CROP, RESIZE and STATIC fucntions
- Has a caching layer for serving previously requested processed images

```bash
# run docker image
# for cache presistance and image input two volumes should be mapped
# -v ./images:/images -v ./image_cache:/image_cache
# -p 8080:80 maps host port 8080 to container port 80 running nginx
# --rm automatically remove the container when it exits
docker run --rm -v ./images:/images -v ./image_cache:/image_cache -p 8000:80  pula/image_server:latest
```

example request
```
# crop
http://docker_service/process_crop_100x100/path-to-image.jpg

# resize
http://docker_service/process_resize_100x100/path-to-image.jpg

# static
http://docker_service/static/path-to-image.jpg
```

## Development
- Use the test.sh file to add unit tests to any new features or bugs
- The provided Makefile gives an easy interface for builds and releases

```bash
# using the make file
# build: builds the image
make build

# release: buld, tag and push the images to docker hub 
# a prompt will ask for the release version and update the VERSION file
make release

# test: run unit tests
make test

# git_push: taggs and push commited chages remote
make git_push
```

- Running make on windows: 

  To run make on windows, install the make executable. 
  I used `chocolatey` package manager for windows `choco install make`

## Author
Paul Bandara