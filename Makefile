REPO=repo
ARCH?=$(shell flatpak --default-arch)

all: $(REPO)/config $(foreach file, $(wildcard org.kde.*.json), $(subst .json,.app,$(file)))

%.app: %.json
	flatpak-builder --force-clean --arch=$(ARCH) --ccache --repo=$(REPO) --subject="Build of $<, `date`" ${EXPORT_ARGS} app $<

%.flatpak: %.app
	flatpak build-bundle ${REPO} $@ $*

export:
	flatpak build-update-repo --prune --prune-depth=20 $(REPO) ${EXPORT_ARGS}

$(REPO)/config:
	ostree init --mode=archive-z2 --repo=$(REPO)

remotes:
	flatpak remote-add kde --from https://distribute.kde.org/kderuntime.flatpakrepo --if-not-exists

deps:
	flatpak install $(ARGS) kde org.kde.Platform
	flatpak install $(ARGS) kde org.kde.Sdk

check: $(REPO)/config $(foreach file, $(wildcard org.kde.*.json), $(subst .json,.clean,$(file)))

%.clean: %.json
	json-glib-validate $<
	flatpak-builder --force-clean --arch=$(ARCH) --download-only ${EXPORT_ARGS} app $<

clean:
	rm -rf $(TMP) .flatpak-builder
