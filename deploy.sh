docker build -t kuperlen/multi-client:latest -t kuperlen/multi-client:314b019710fb2f60e4924fdb3da805ee2545fa29 -f ./client/Dockerfile ./client
docker build -t kuperlen/multi-server:latest -t kuperlen/multi-server:314b019710fb2f60e4924fdb3da805ee2545fa29 -f ./server/Dockerfile ./server
docker build -t kuperlen/multi-worker:latest -t kuperlen/multi-worker:314b019710fb2f60e4924fdb3da805ee2545fa29 -f ./worker/Dockerfile ./worker

docker push kuperlen/multi-client:314b019710fb2f60e4924fdb3da805ee2545fa29
docker push kuperlen/multi-server:314b019710fb2f60e4924fdb3da805ee2545fa29
docker push kuperlen/multi-worker:314b019710fb2f60e4924fdb3da805ee2545fa29

docker push kuperlen/multi-client:latest
docker push kuperlen/multi-server:latest
docker push kuperlen/multi-worker:latest

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kuperlen/multi-server:314b019710fb2f60e4924fdb3da805ee2545fa29
kubectl set image deployments/client-deployment client=kuperlen/multi-server:314b019710fb2f60e4924fdb3da805ee2545fa29
kubectl set image deployments/worker-deployment worker=kuperlen/multi-server:314b019710fb2f60e4924fdb3da805ee2545fa29