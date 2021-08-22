pipeline {
    agent { docker { image 'openpriv/flutter-desktop:windows-sdk30-fdev2.5rc' } }
    stages {
        stage('build') {
            steps {
                sh 'flutter doctor'
            }
        }
    }
}