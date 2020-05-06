docker build -t shadgun20/multi-client:latest -t shadgun20/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shadgun20/multi-server:latest -t shadgun20/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shadgun20/multi-worker:latest -t shadgun20/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push shadgun20/multi-client:latest
docker push shadgun20/multi-server:latest
docker push shadgun20/multi-worker:latest
docker push shadgun20/multi-client:$SHA
docker push shadgun20/multi-server:$SHA
docker push shadgun20/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shadgun20/multi-server:$SHA
kubectl set image deployments/client-deployment client=shadgun20/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shadgun20/multi-worker:$SHA
