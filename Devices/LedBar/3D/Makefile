git_revision_nr         :=$(shell git rev-parse --short HEAD)
git_uncommitted_changes :=$(if $(shell git status --untracked-files=no --porcelain),+,)
git_revision            :=$(git_revision_nr)$(git_uncommitted_changes)

stl_folder              :=./stl/$(git_revision)

parts                   := case-bottom.stl case-top.stl

.PHONY: warn_committed_changes
ifeq ($(git_uncommitted_changes),)
warn_committed_changes:
	@echo "All changes are committed."
else
warn_committed_changes:
	@echo -n "There are uncommitted changes. Continue? [y/N] " && read ans && [ $${ans:-N} = y ]
endif

.PHONY: all
all: $(parts)

.PHONY: case-bottom.stl
case-bottom.stl: $(stl_folder)/case-bottom.stl

#$(stl_folder)/case-bottom.stl: Enclosure.scad warn_committed_changes
#	mkdir -p $(stl_folder)
#	openscad -D "part=\"case-bottom.stl\"" -D "revision=\"$(git_revision)\"" -o $(stl_folder)/case-bottom.stl Enclosure.scad

define make-part-target
$1: Enclosure.scad warn_committed_changes
	mkdir -p $(stl_folder)
	openscad -D "part=\"$1\"" -D "revision=\"$(git_revision)\"" -o $(stl_folder)/$1 Enclosure.scad
endef

$(foreach part,$(parts),$(eval $(call make-part-target,$(part))))

