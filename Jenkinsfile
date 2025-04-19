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
                sh 'xcodebuild -workspace PokeDexApp.xcworkspace -scheme PokeDexApp clean build'
            }
        }

        stage('Test') {
            steps {
                // Corrigir a sintaxe usando aspas duplas para envolver o comando
                sh "xcodebuild test -workspace PokeDexApp.xcworkspace -scheme PokeDexApp -destination 'platform=iOS Simulator,name=iPhone 16'"
            }
        }
    }
}