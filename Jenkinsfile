pipeline {
    agent any

    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    // Instala o Cocoapods
                    sh 'sudo gem install cocoapods'
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