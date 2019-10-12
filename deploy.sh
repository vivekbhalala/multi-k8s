docker build -t vivekbhalala/multi-client:latest -t vivekbhalala/multi-client:$SHA ./client/Dockerfile ./client
docker build -t vivekbhalala/multi-server:latest -t vivekbhalala/multi-server:$SHA ./server/Dockerfile ./server
docker build -t vivekbhalala/multi-worker:latest -t vivekbhalala/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push vivekbhalala/multi-client:latest
docker push vivekbhalala/multi-server:latest
docker push vivekbhalala/multi-worker:latest

docker push vivekbhalala/multi-client:$SHA
docker push vivekbhalala/multi-server:$SHA
docker push vivekbhalala/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vivekbhalala/multi-server:$SHA
kubectl set image deployments/client-deployment client=vivekbhalala/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vivekbhalala/multi-worker:$SHA