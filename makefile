.PHONY: setup install_rbenv install_ruby install_bundler bundle pod fastlane

RUBY_VERSION=2.7.6

setup: install_rbenv install_ruby install_bundler bundle

install_rbenv:
	@echo "🔧 Instalando rbenv via Homebrew (se necessário)..."
	brew list rbenv || brew install rbenv
	brew list ruby-build || brew install ruby-build
	@echo "✅ rbenv instalado."

install_ruby:
	@echo "💎 Instalando Ruby $(RUBY_VERSION) com rbenv (se necessário)..."
	rbenv install -s $(RUBY_VERSION)
	rbenv local $(RUBY_VERSION)
	@echo "2.7.6" > .ruby-version
	@echo "✅ Ruby $(RUBY_VERSION) ativo localmente."

install_bundler:
	@echo "📦 Instalando Bundler..."
	gem install bundler
	@echo "✅ Bundler instalado."

bundle:
	@echo "📚 Instalando gems com Bundler..."
	bundle install
	@echo "✅ Gems instaladas."

pod:
	@echo "📦 Instalando dependências do CocoaPods..."
	bundle exec pod install
	@echo "✅ Pods instalados."

fastlane:
	@echo "🚀 Rodando Fastlane (lane padrão)..."
	bundle exec fastlane