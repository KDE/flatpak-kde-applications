REPO=repo

all: $(foreach file, $(wildcard *.json), $(subst .json,.app,$(file)))

%.app: %.json
	rm -rf app
	flatpak-builder --ccache --require-changes --repo=$(REPO) --subject="Build of $<, `date`" ${EXPORT_ARGS} app $<

