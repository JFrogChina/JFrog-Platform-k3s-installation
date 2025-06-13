

kubectl get svc -n jp

# e.g.
# NAME                               TYPE           CLUSTER-IP        EXTERNAL-IP     PORT(S)                                 AGE
# jfrog-platform-artifactory         ClusterIP      x.x.x.x           <none>          8082/TCP,8081/TCP                       18h
# jfrog-platform-artifactory-nginx   LoadBalancer   x.x.x.x           x.x.x.x         8080:31969/TCP,8443:30929/TCP           18h
# jfrog-platform-postgresql          ClusterIP      x.x.x.x           <none>          5432/TCP                                18h
# jfrog-platform-postgresql-hl       ClusterIP      None              <none>          5432/TCP                                18h
# jfrog-platform-rabbitmq            ClusterIP      x.x.x.x           <none>          5672/TCP,4369/TCP,25672/TCP,15672/TCP   18h
# jfrog-platform-rabbitmq-headless   ClusterIP      None              <none>          4369/TCP,5672/TCP,25672/TCP,15672/TCP   18h
# jfrog-platform-xray                ClusterIP      x.x.x.x           <none>          80/TCP,8082/TCP                         18h

