NAME = ec2metadata

up: 
	docker run -e RACK_ENV=production -it --rm --name=$(NAME) -p 127.0.0.1:8009:4567 -v `ls -d ~/.aws`:/root/.aws farrellit/ec2metadata:latest

daemon: 
	docker run -e RACK_ENV=production --rm -d --name=$(NAME) -p 127.0.0.1:8009:4567 -v `ls -d ~/.aws`:/root/.aws farrellit/ec2metadata:latest


# obviously, this is only for farrellit
publish:
	docker login
	docker tag ec2metadata farrellit/ec2metadata:latest
	docker push farrellit/ec2metadata:latest

# for local testing
build:
	docker build -t ec2metadata .

develop:  build
	docker run -it --rm --name=$(NAME) -p 8009:4567 -v `pwd`:/code -v `ls -d ~/.aws`:/root/.aws ec2metadata

