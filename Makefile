app-start: install-dependencies
	quasar dev -p 8080 -H '0.0.0.0' -m spa

install-dependencies:
	npm install
