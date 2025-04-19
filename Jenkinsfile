pipeline {
    agent any

    stages {
        stage('Install Ruby') {
            steps {
                script {
                    // Instalar o rbenv
                    sh '''
                        # Instalar rbenv
                        brew install rbenv
                        rbenv init
                        echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
                        source ~/.bash_profile

                        # Instalar Ruby 3.1.0 (ou qualquer versão que você precise)
                        rbenv install 3.1.0
                        rbenv global 3.1.0
                    '''
                }
            }
        }

        stage('Install Cocoapods') {
            steps {
                script {
                    // Instalar o Cocoapods
                    sh '''
                        gem install cocoapods --user-install
                    '''
                }
            }
        }

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