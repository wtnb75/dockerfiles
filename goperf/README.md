# Usage

- docker run -d --name goperf -p 8080:8080 -p 8081:8081 goperf
- open http://$(docker-machine ip):8081 (data saver)
- open http://$(docker-machine ip):8080 (analyzer)

## Upload

- single result
   - curl -X POST -F "file=@result.txt" http://$(docker-machine ip):8081/upload
- old/new result
   - curl -i -X POST --form "file=@oldfile.txt" --form "file=@newfile.txt" http://$(docker-machine ip):8081/upload

## Save data to local dir

- docker run -d -v $PWD:/data --name goperf -p 8080:8080 -p 8081:8081 goperf
