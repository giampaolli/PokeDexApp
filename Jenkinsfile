pipeline {
    agent any

    stages {
        stage('Install System Dependencies') {
            steps {
                script {
                    // Instalar o Cocoapods sem sudo (caso não esteja instalado)
                    sh 'gem install cocoapods --user-install'

                    // Garantir que o cocoapods seja executado a partir do diretório correto
                    sh 'export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH" && pod install'
                }
            }
        }
        stage('Checkout') {
            steps {
                git 'https://github.com/giampaolli/PokeDexApp.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pod install'
            }
        }

        stage('Build') {
            steps {
                sh 'xcodebuild -workspace YourWorkspace.xcworkspace -scheme YourScheme clean build'
            }
        }

        stage('Test') {
            steps {
                sh 'xcodebuild test -workspace YourWorkspace.xcworkspace -scheme YourScheme'
            }
        }

        stage('Deploy') {
            steps {
                sh 'fastlane ios beta'
            }
        }
    }
}