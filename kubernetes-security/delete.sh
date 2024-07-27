kubectl delete \
-f ingress.yaml \
-f service.yaml \
-f deployment.yaml \
-f cm.yaml \
-f pvc.yaml \
-f pv.yaml \
-f storage_class.yaml \
-f cluster_role_bindings.yaml \
-f role_bindings.yaml \
-f cluster_roles.yaml \
-f roles.yaml \
-f sa_token_secrets.yaml \
-f sa.yaml \
-f namespace.yaml

