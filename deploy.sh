  
docker build -t kuperlen/multi-client:latest -t kuperlen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kuperlen/multi-server:latest -t kuperlen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kuperlen/multi-worker:latest -t kuperlen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kuperlen/multi-client:latest
docker push kuperlen/multi-server:latest
docker push kuperlen/multi-worker:latest

docker push kuperlen/multi-client:$SHA
docker push kuperlen/multi-server:$SHA
docker push kuperlen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kuperlen/multi-server:$SHA
kubectl set image deployments/client-deployment client=kuperlen/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kuperlen/multi-worker:$SHA