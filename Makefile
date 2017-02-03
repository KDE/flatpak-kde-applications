REPO=repo



all: $(REPO)/config $(foreach file, $(wildcard *.json), $(subst .json,.app,$(file)))

%.app: %.json
	rm -rf app
	flatpak-builder --ccache --repo=$(REPO) --subject="Build of $<, `date`" ${EXPORT_ARGS} app $<

export:
	flatpak build-update-repo $(REPO) ${EXPORT_ARGS}

$(REPO)/config:
	ostree init --mode=archive-z2 --repo=$(REPO)

remotes:
	wget http://distribute.kde.org/kdeflatpak.asc
	flatpak remote-add kde http://distribute.kde.org/flatpak-testing/ --gpg-import=kdeflatpak.asc --if-not-exists
	rm kdeflatpak.asc*

deps:
	flatpak install $(ARGS) kde org.kde.Platform
	flatpak install $(ARGS) kde org.kde.Sdk

check:
	json-glib-validate *.json

clean:
	rm -rf $(TMP) .flatpak-builder
