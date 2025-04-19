pipeline {
    agent any

    stages {
        stage('Install Dependencies') {
            steps {
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
                sh "xcodebuild test -workspace PokeDexApp.xcworkspace -scheme PokeDexAppTests -destination 'platform=iOS Simulator,name=iPhone 16'"
            }
        }
    }
}