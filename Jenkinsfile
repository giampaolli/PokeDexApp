import groovy.json.JsonSlurper

pipeline {
    agent any

    stages {

        // 1. Checkout do código
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // 2. Análise do SonarQube
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
                            -Dsonar.host.url=http://localhost:9000 \
                            -Dsonar.login=your_token_here
                    '''
                }
            }
        }

        // 3. Instalar Dependências
        stage('Install Dependencies') {
            steps {
                sh 'pod install'
            }
        }

        // 4. Rodar o SwiftLint (Verificação de estilo)
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

        // 5. Build do Projeto
        stage('Build') {
            steps {
                sh 'xcodebuild -workspace PokeDexApp.xcworkspace -scheme PokeDexApp clean build'
            }
        }

        // 6. Rodar os Testes com Cobertura
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