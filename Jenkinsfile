pipeline {
    agent any

    stages {
        stage('Install Homebrew') {
            steps {
                script {
                    // Instalar o Homebrew (se não estiver instalado)
                    sh '''
                        if ! which brew > /dev/null; then
                            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                        fi
                    '''
                }
            }
        }

        stage('Install rbenv') {
            steps {
                script {
                    // Instalar o rbenv
                    sh 'brew install rbenv'
                }
            }
        }

        stage('Install Ruby') {
            steps {
                script {
                    // Instalar Ruby
                    sh '''
                        rbenv install 3.1.0
                        rbenv global 3.1.0
                    '''
                }
            }
        }

        stage('Install Cocoapods') {
            steps {
                script {
                    // Instalar Cocoapods
                    sh 'gem install cocoapods --user-install'
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