#VERSION=latest
#SRCDIR=src/minibank

#bin/minibank: $(shell find $(SRCDIR) -name '*.go')
#		docker run -it -v `pwd`:/usr/app \
 #               -w /usr/app \
  #              -e GOPATH=/usr/app \
   #             -e CGO_ENABLED=0 \
    #            -e GOOS=linux \
     #           golang:1.9 sh -c 'go get minibank && go build -ldflags "-extldflags -static" -o $@ minibank'
#minibank: bin/minibank
#	docker build -t minibank:$(VERSION) -f Dockerfile bin
#mysql:
#	docker pull mariadb:latest

#run-images: minibank mysql
#	sh run

minibank:
	docker build -t minibank Minibank/

mysql:
	docker build -t mysql Mysql/

run-images: #$(shell find $(SRCDIR) -name '*.go')

	#cd something
	#docker build -t minibank 

	#docker rm -f $(docker ps -aq)
	# docker system prune -a -f
	#docker build -t mysql Mysql/
	#docker build -t minibank Minibank/
	docker network ls -f "driver=bridge" | grep ' minibanknet ' > /dev/null || docker network create minibanknet

	docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=HOBBES --network minibanknet mysql:latest
	sleep 10 
	docker run -d --name minibank -p 80:8080 --network minibanknet minibank:latest
