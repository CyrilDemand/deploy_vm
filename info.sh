if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <nomDuProjet> <nomDuScript>"
    exit 1
fi

projet="$1"

docker_name=$(docker ps --format "{{.Names}}" | grep "$projet" | awk -F '-' '{print $NF}')

# prend le dernier mot du nom du conteneur après le dernier _
env_value=$(echo "$docker_name" | awk -F '_' '{print $NF}')

if [ -n "$env_value" ]; then
    echo "le projet $projet est lancé sur l'environnement : $env_value"
else
    echo "Aucun conteneur contenant '$projet' n'est actuellement en cours d'exécution."
fi