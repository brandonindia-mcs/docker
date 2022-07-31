My development containers.
They exist under some hierarchies that I'll document here
I'll add more as I secure the public versions

1) ubuntu:20.04 > seed > gituser
2) mcr.microsoft.com/azure-cli:latest > azcli

From shell build with the command:
$ . ./build-docker.sh

To run a new image:
$ docker run --rm -it user/seed

