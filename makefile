.PHONY: setup install_rbenv install_ruby install_bundler bundle pod fastlane

RUBY_VERSION=3.4.3

setup: install_rbenv install_ruby install_bundler bundle

install_rbenv:
	@echo "🔧 Verificando instalação do rbenv..."
	@if ! command -v rbenv >/dev/null; then \
		echo "Instalando rbenv via Homebrew..."; \
		brew install rbenv; \
	fi
	@if ! brew list ruby-build >/dev/null 2>&1; then \
		echo "Instalando ruby-build..."; \
		brew install ruby-build; \
	fi
	@echo "✅ rbenv instalado."

install_ruby:
	@echo "💎 Instalando Ruby $(RUBY_VERSION) com rbenv (se necessário)..."
	@rbenv versions | grep -q $(RUBY_VERSION) || ( \
		echo "Tentando instalar Ruby $(RUBY_VERSION)..."; \
		if ! rbenv install -s $(RUBY_VERSION); then \
			echo "❌ Falha ao instalar Ruby $(RUBY_VERSION)."; \
			echo "🔁 Tente rodar: brew upgrade ruby-build"; \
			exit 1; \
		fi \
	)
	@rbenv local $(RUBY_VERSION)
	@echo "$(RUBY_VERSION)" > .ruby-version
	@echo "✅ Ruby $(RUBY_VERSION) configurado localmente."

install_bundler:
	@echo "📦 Instalando Bundler..."
	@gem install bundler || echo "⚠️ Bundler já instalado."
	@echo "✅ Bundler pronto."

bundle:
	@echo "📚 Instalando gems com Bundler..."
	@bundle install
	@echo "✅ Gems instaladas."

pod:
	@echo "📦 Instalando dependências do CocoaPods..."
	@bundle exec pod install
	@echo "✅ Pods instalados."

fastlane:
	@echo "🚀 Rodando Fastlane (lane padrão)..."
	@bundle exec fastlane