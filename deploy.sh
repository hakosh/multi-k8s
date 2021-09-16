docker build -t hakosh/multi-client:latest -t hakosh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hakosh/multi-server:latest -t hakosh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hakosh/multi-worker:latest -t hakosh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hakosh/multi-client:latest
docker push hakosh/multi-client:$SHA
docker push hakosh/multi-server:latest
docker push hakosh/multi-server:$SHA
docker push hakosh/multi-worker:latest
docker push hakosh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=hakosh/multi-client:$SHA
kubectl set image deployments/server-deployment server=hakosh/multi-server:$SHA
kubectl set image deployments/worker-deployment server=hakosh/multi-worker:$SHA

