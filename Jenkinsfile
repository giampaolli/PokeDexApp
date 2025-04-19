import groovy.json.JsonSlurper

pipeline {
    agent any

    environment {
        SONARQUBE_SCANNER_HOME = '/opt/sonar-scanner'  // Caminho onde o SonarQube Scanner está instalado
    }

    stages {

        // Stage para fazer checkout do código do repositório
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // Stage para realizar a análise do SonarQube
        stage('SonarQube Analysis') {
            steps {
                script {
                    // Executa a análise SonarQube
                    sh '''
                        sonar-scanner \
                            -Dsonar.projectKey=PokeDexApp \
                            -Dsonar.projectName=PokeDexApp \
                            -Dsonar.projectVersion=1.0 \
                            -Dsonar.sources=./PokeDexApp \
                            -Dsonar.host.url=http://localhost:9000  // URL do seu servidor SonarQube
                            -Dsonar.login=your_token_here  // Token de autenticação para o SonarQube
                    '''
                }
            }
        }

        // Stage para instalar as dependências com CocoaPods
        stage('Install Dependencies') {
            steps {
                sh 'pod install'
            }
        }

        // Stage para rodar o SwiftLint e garantir que o código siga os padrões
        stage('Run SwiftLint') {
            steps {
                script {
                    def swiftLintResult = sh(script: 'swiftlint', returnStatus: true)

                    if (swiftLintResult != 0) {
                        error "SwiftLint check failed. Please fix linting issues."
                    }
                }
            }
        }

        // Stage para rodar o build do projeto
        stage('Build') {
            steps {
                sh 'xcodebuild -workspace PokeDexApp.xcworkspace -scheme PokeDexApp clean build'
            }
        }

        // Stage para rodar os testes com cobertura
        stage('Run Tests with Coverage') {
            steps {
                script {
                    // Rodar os testes e gerar a cobertura de código
                    sh "xcodebuild test -workspace PokeDexApp.xcworkspace -scheme PokeDexAppTests -destination 'platform=iOS Simulator,name=iPhone 12,OS=14.4' -enableCodeCoverage YES -resultBundlePath ./build/yourbuild.xcresult"

                    // Usar o "xcresulttool" para extrair a cobertura de código
                    def coverageReport = sh(script: 'xcresulttool dump --format json --path ./build/yourbuild.xcresult | jq .tests[].coverage', returnStdout: true).trim()

                    // Definir um mínimo de cobertura de testes que o pipeline deve ter (por exemplo, 80%)
                    def minCoverage = 80
                    def currentCoverage = calculateCoverage(coverageReport)

                    // Se a cobertura for inferior a 80%, falhe o pipeline
                    if (currentCoverage < minCoverage) {
                        error "Test coverage is below ${minCoverage}%. Current coverage is ${currentCoverage}%."
                    }
                }
            }
        }
    }
}

// Função para calcular a cobertura de testes
def calculateCoverage(coverageReport) {
    // Exemplo: Parse e cálculo da cobertura a partir do report JSON
    def coverageData = new JsonSlurper().parseText(coverageReport)
    def totalTests = coverageData.size()
    def passedTests = coverageData.count { it.passed == true }
    return (passedTests / totalTests) * 100
}