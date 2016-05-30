REPO=repo

all: org.kde.kate.app org.kde.kalgebra.app org.kde.konversation.app org.kde.kturtle.app org.kde.kanagram.app org.kde.kompare.app org.kde.artikulate.app org.kde.okular.app

%.app: %.json
	rm -rf app
	flatpak-builder --ccache --require-changes --repo=$(REPO) --subject="Build of $<, `date`" ${EXPORT_ARGS} app $<

