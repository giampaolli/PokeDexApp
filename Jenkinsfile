pipeline {
    agent any

    stages {
        stage('Install Dependencies') {
            steps {
                // Rodar pod install
                sh 'pod install'
            }
        }

        stage('Build') {
            steps {
                sh 'xcodebuild -workspace PokeDexAp.xcworkspace -scheme PokeDexAp clean build'
            }
        }

        stage('Test') {
            steps {
                sh 'xcodebuild test -workspace PokeDexAp.xcworkspace -scheme PokeDexAp'
            }
        }
    }
}