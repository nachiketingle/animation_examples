pipeline {
    agent { docker { image 'openpriv/flutter-desktop:linux-dev' } }
    stages {
        stage('build') {
            steps {
                sh 'flutter doctor'
            }
        }
    }
}