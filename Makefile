REPO=repo
ARCH?=$(shell flatpak --default-arch)
INSTALL_SOURCE?=--install-deps-from=flathub

all: $(REPO)/config $(foreach file, $(wildcard org.*.*.json), $(subst .json,.app,$(file))) $(foreach file, $(wildcard org.*.*.remoteapp), $(subst .remoteapp,.app,$(file)))

%.app: %.json
	flatpak-builder $(INSTALL_SOURCE) --force-clean --arch=$(ARCH) --ccache --repo=$(REPO) --subject="Build of $<, `date`" ${EXPORT_ARGS} app $<

%.app: %.remoteapp
	./build.sh $<

%.flatpak: %.app
	flatpak build-bundle ${REPO} $@ $*

export:
	flatpak build-update-repo --prune --prune-depth=20 --generate-static-deltas $(REPO) ${EXPORT_ARGS}

$(REPO)/config:
	ostree init --mode=archive-z2 --repo=$(REPO)

remotes:
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo $(EXPORT_ARGS)

check: $(REPO)/config $(foreach file, $(wildcard org.*.*.json), $(subst .json,.clean,$(file)))

%.clean: %.json
	json-glib-validate $<
	flatpak-builder --force-clean --arch=$(ARCH) --download-only ${EXPORT_ARGS} app $<

clean:
	rm -rf $(TMP) .flatpak-builder
