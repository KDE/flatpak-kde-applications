all: org.kde.kate.app org.kde.kalgebra.app org.kde.konversation.app # org.kde.gcompris.app org.kde.dolphin.app

%.app: %.json
	rm -rf app
	xdg-app-builder --ccache --require-changes --repo=repo --subject="Build of $<, `date`" ${EXPORT_ARGS-} app $<
