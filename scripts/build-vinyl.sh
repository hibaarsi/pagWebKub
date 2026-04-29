#!/bin/bash

echo "🔌 Conectando con el demonio de Docker de Minikube..."

# shellcheck disable=SC2046
eval $(minikube docker-env)

echo "🏗️ Construyendo imagen: vinyl-front:1.0.0..."
docker build -t vinyl-front:1.0.0 ./vinyl-app/front

echo "✅ ¡Imagen lista en el inventario de Minikube!"