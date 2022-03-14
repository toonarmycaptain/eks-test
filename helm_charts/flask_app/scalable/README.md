Deploy nfs_server.yaml, nfs_service.yaml, storage.yaml before deploying scalable_chart. 


# Scalable GCP deploy

####Create 100GB disk named gce-nfs-disk in Compute Engine - Disks


## Deploy workloads on cluster.
kubectl apply -f helm_charts/flask_app/scalable/nfs_server.yaml 
####Wait until nfs-server is running.

kubectl apply -f helm_charts/flask_app/scalable/nfs_service.yaml  
kubectl apply -f helm_charts/flask_app/scalable/storage.yaml  

helm install test-flask-app helm_charts/flask_app/scalable/scalable_chart/



###To delete
helm uninstall test-flask-app  
kubectl delete -f helm_charts/flask_app/scalable/storage.yaml  
kubectl delete -f helm_charts/flask_app/scalable/nfs_service.yaml  
kubectl delete -f helm_charts/flask_app/scalable/nfs_server.yaml 
