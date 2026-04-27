#!/bin/bash

echo "🧹 Borrando el despliegue de la tienda de vinilos..."
kubectl delete namespace vinyl-app --ignore-not-found=true

echo "🐙 Borrando la aplicación de Argo CD (si existe)..."
kubectl delete application vinyl -n argocd --ignore-not-found=true

echo "✨ Todo limpio. Listo para un nuevo despliegue."