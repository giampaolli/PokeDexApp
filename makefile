.PHONY: full-setup install_rbenv install_ruby install_bundler bundle pod fastlane

RUBY_VERSION=3.4.3

full-setup:
	@echo "🧼 Atualizando Homebrew..."
	brew update

	@echo "🔧 Verificando rbenv..."
	@if ! command -v rbenv >/dev/null; then \
		echo "📦 Instalando rbenv..."; \
		brew install rbenv; \
	else \
		echo "✅ rbenv já instalado."; \
	fi

	@echo "🔁 Garantindo última versão do ruby-build..."
	brew uninstall --ignore-dependencies ruby-build || true
	brew install ruby-build

	@echo "📋 Verificando se Ruby $(RUBY_VERSION) está disponível..."
	@if ! rbenv install --list | grep -q "$(RUBY_VERSION)"; then \
		echo "⚠️ Versão $(RUBY_VERSION) não encontrada. Instalando ruby-build como plugin via GitHub..."; \
		git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build || true; \
	fi

	@echo "💎 Instalando Ruby $(RUBY_VERSION)..."
	rbenv install -s $(RUBY_VERSION)
	rbenv local $(RUBY_VERSION)
	echo "$(RUBY_VERSION)" > .ruby-version

	@echo "📦 Instalando Bundler..."
	gem install bundler || echo "⚠️ Bundler já instalado."

	@echo "📚 Instalando gems com Bundler..."
	bundle install

	@echo "📦 Instalando CocoaPods..."
	bundle exec pod install

	@echo ""
	@echo "✅ Ambiente configurado com sucesso!"
	@echo "Ruby: `ruby -v`"
	@echo "Bundler: `bundle -v`"

# Targets auxiliares caso queira rodar separado
install_rbenv:
	brew install rbenv
	brew install ruby-build

install_ruby:
	rbenv install -s $(RUBY_VERSION)
	rbenv local $(RUBY_VERSION)
	echo "$(RUBY_VERSION)" > .ruby-version

install_bundler:
	gem install bundler

bundle:
	bundle install

pod:
	bundle exec pod install

fastlane:
	bundle exec fastlane