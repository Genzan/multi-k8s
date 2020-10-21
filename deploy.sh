docker build -t genzan/multi-client:latest -t genzan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t genzan/multi-server:latest -t genzan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t genzan/multi-worker:latest -t genzan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push genzan/multi-client:latest
docker push genzan/multi-server:latest
docker push genzan/multi-worker:latest
docker push genzan/multi-client:$SHA
docker push genzan/multi-server:$SHA
docker push genzan/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=genzan/multi-server:$SHA
kubectl set image deployments/client-deployment client=genzan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=genzan/multi-worker:$SHA