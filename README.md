1.Descripción del proyecto
Mi proyecto se basa en una tienda de vinilos ( solo 6 vinilos) que han sido hechos por un frontend hecho solo por html. 

2.Estructura de las carpetas dentro del repositorio

Argocd
Primero vemos una carpeta llamada argocd , que es el que contiene app.yaml, manifiesto necesario para registrar el repositorio en ArgoCD y desplegarlo en Git. 
El manifiesto contiene estos siguientes elementos:
 - crea la aplicación vinyl-app
 - apunta al repositorio de github
 - indica que los manifiestos están en la carpeta vinyl-app/k8s
 - despliega en el cluster interno de kubernetes
 - activa sincronización automática

Vinyl-app
Dentro de la carpeta vinyl-app, encontramos la carpeta front y k8s.
 - FRONT
Dentro de la carpeta front, encontramos el index.html y el style.css y una carpeta llamada img para las imagenes dentro de la página.
También encontramos el Dockerfile que contiene la configuración para construir la imagen de la aplicación.

 - K8S
Dentro de la carpeta k8s, encontramos el deployment.yaml que contiene la configuración para desplegar la página y asegura que esté disponible
Y el service.yaml que es la que expone la aplicación tanto internamente como externamente, que en este caso usamos un tipo NodePOrt para permitir acceso externo

Scripts
Dentro de la carpeta scripts, encontramos el build-vinyl.sh que es el script que se encarga de construir la imagen de la aplicación.
Y un cleanup.sh que resetea el estado de la aplicación sin desintalar los elementos de k8s y argocd
También se encuentran otros 4 scripts usados dentro de las sesiones del taller para descargar los elementos de kubernetes, verificarlos y desinstalarlos. 



3. Recursos de Kubernetes usados
Como ya se ha mencionado antes, tenemos dentro de la carpeta vinyl-app/k8s, el deployment.yaml y el service.yaml 
 y la carpeta argocd/app.yaml que son los elementos fundamentales. 

4. Como se contruyen las imagenes y como se versionan
Se construye utilizando el script build-vinyl.sh. Este script se conecta con el Dockerfile 
La imagen se llama vinyl-front:1.0.0, indicando que es la primera versión de la imagen

5. Ejecución 
   En la carpeta docs/ se podrán observar en las capturas como seguimos este proceso 
 5.1. Preparación
   minikube start --driver=docker
 5.2. Construir aplicación
   ./scripts/build-vinyl.sh
 este script tiene todo lo necesario para hacer la imagen 
 5.3 ArgoCD
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
  Deja pasar un minuto
kubectl apply -f argocd/app.yaml

Para ver en terminal como está el cluster
kubectl get application -n argocd
kubectl get pods -n vinyl-app 

Para meterse en Argo CD
1. Saca la contraseña
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
2. Abre túnel
   kubectl port-forward svc/argocd-server -n argocd 8080:443

5.4. Página funcionando
   minikube service front -n vinyl-app

6. Posibles mejoras
Se podría implementar un sistema de autenticación en la página y una base de datos, y ahí 
7. podríamos usar el recurso de kubernetes llamado secret para los datos sensibles.