kubectl apply \
-f namespace.yaml \
-f sa.yaml \
-f sa_token_secrets.yaml \
-f roles.yaml \
-f cluster_roles.yaml \
-f role_bindings.yaml \
-f cluster_role_bindings.yaml \
-f storage_class.yaml \
-f pv.yaml \
-f pvc.yaml \
-f cm.yaml \
-f deployment.yaml \
-f service.yaml \
-f ingress.yaml \