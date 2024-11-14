pipeline {
    agent any
    
     environment {
        GITHUB_REPO = 'https://github.com/An-Isa93/PIA_LMP.git' // Reemplaza con tu URL de GitHub
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_COMPOSE_DIR = 'PIA_LMP'  // Directorio donde está el archivo docker-compose.yml
    }
    
    stages {
        
        stage('Clone GitHub Repository') {
            steps {
                script {
                    // Clonar el repositorio de GitHub
                    git branch: 'master', url: "${GITHUB_REPO}"
                }
            }
        }
        stage('Stop and Remove Old Containers') {
            steps {
                script {
                    // Detener y eliminar los contenedores antiguos antes de crear los nuevos
                    sh 'docker compose -f ${DOCKER_COMPOSE_FILE} down --volumes --remove-orphans'
                }
            }
        }

        stage('Build and Run Docker Containers') {
            steps {
                script {
                    // Construir y ejecutar los contenedores usando docker-compose
                    sh 'docker compose -f ${DOCKER_COMPOSE_FILE} up --build -d'
                }
            }
        }
        stage('Wait for MySQL to be Ready') {
            steps {
                script {
                    // Esperar a que MySQL esté listo para aceptar conexiones
                    echo "Waiting for MySQL to be ready..."
                    sleep(time: 40, unit: 'SECONDS')  // Esperar 20 segundos (ajustar según lo necesario)
                }
            }
        }
        stage('Restart Container') {
            steps {
                script {
                    // Reiniciar el contenedor por nombre
                    sh 'docker restart djangoLibrary'
                    echo "Waiting for restart..."
                    sleep(time: 10, unit: 'SECONDS')  // Esperar 20 segundos (ajustar según lo necesario)
                    dir("${DOCKER_COMPOSE_DIR}") {
                        sh 'docker-compose exec -T django python manage.py makemigrations'
                    }
                    dir("${DOCKER_COMPOSE_DIR}") {
                        sh 'docker-compose exec -T django python manage.py migrate'
                    }
                }
            }
        }
        stage('Restart Container Final') {
            steps {
                script {
                    // Reiniciar el contenedor por nombre
                    sh 'docker restart django-container'
                }
            }
        }
        /*stage('Make Migrations') {
            steps {
                script {
                    // Cambiar al directorio correcto y ejecutar las migraciones de Django
                    dir("${DOCKER_COMPOSE_DIR}") {
                        sh 'docker-compose exec -T django python manage.py makemigrations'
                    }
                }
            }
        }

        stage('Migrate') {
            steps {
                script {
                    // Cambiar al directorio correcto y ejecutar las migraciones de Django
                    dir("${DOCKER_COMPOSE_DIR}") {
                        sh 'docker-compose exec -T django python manage.py migrate'
                    }
                }
            }
        }*/
    }
}