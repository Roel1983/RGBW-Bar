git_revision_nr         :=$(shell git rev-parse --short HEAD)
git_uncommitted_changes :=$(if $(shell git status --untracked-files=no --porcelain),+,)
git_revision            :=$(git_revision_nr)$(git_uncommitted_changes)

stl_folder              :=./stl/$(git_revision)

parts                    = case-bottom.stl case-top.stl profile-drill-guide.stl profile_support_mid.stl profile_support_end_straight.stl profile_support_end_bend.stl

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

define make-part-target
.PHONY: $1
$1: $(stl_folder)/$1

$(stl_folder)/$1: Enclosure.scad warn_committed_changes
	mkdir -p $(stl_folder)
	openscad -D "part=\"$1\"" -D "revision=\"$(git_revision)\"" -o $(stl_folder)/$1 Enclosure.scad
endef

$(foreach part,$(parts),$(eval $(call make-part-target,$(part))))

