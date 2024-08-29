PROJECT ?= zfs

.PHONY: all
all: build

#
# Test
#
.PHONY: test
test:

#
# Build
#
.PHONY: build
build: build-doc 

SRC-DOC		:=	.
DOCS		:=	$(SRC-DOC)/SOURCE
.PHONY: build-doc
build-doc: $(DOCS)

$(SRC-DOC):
	mkdir -p $(SRC-DOC)

.PHONY: $(SRC-DOC)/SOURCE
$(SRC-DOC)/SOURCE: $(SRC-DOC)
	echo -e "git clone $(shell git remote get-url origin)\ngit checkout $(shell git rev-parse HEAD)" > "$@"

#
# Clean
#
.PHONY: distclean
distclean: clean

.PHONY: clean
clean: clean-doc clean-deb

.PHONY: clean-doc
clean-doc:
	rm -rf $(DOCS)

.PHONY: clean-deb
clean-deb:
	# The packaging of the zfs team is not standard. There will be many *.install files generated during packaging, which need to be cleaned using GIT.
	git clean -fx debian/*.install
	dh_auto_clean
	rm -rf debian/.debhelper debian/lib*/ debian/*pyzfs*/ debian/*zfs*/ debian/tmp/ debian/debhelper-build-stamp debian/files debian/*.debhelper.log debian/*.*.debhelper debian/*.substvars

#
# Release
#
.PHONY: dch
dch: debian/changelog
	EDITOR=true gbp dch --debian-branch=main --multimaint-merge --commit --release --dch-opt=--upstream

.PHONY: deb
deb: debian
	debuild --no-lintian --no-sign -b -aarm64 -Pcross

.PHONY: release
release:
	gh workflow run .github/workflows/new_version.yml
