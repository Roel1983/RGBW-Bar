git_revision_nr         :=$(shell git rev-parse --short HEAD)
git_uncommitted_changes :=$(if $(shell git status --untracked-files=no --porcelain),+,)
git_revision            :=$(git_revision_nr)$(git_uncommitted_changes)

stl_folder              :=./stl
stl_folder_rev          :=$(stl_folder)/$(git_revision)

parts                    = case-bottom.stl
parts                   += case-top.stl
parts                   += profile_support_mid.stl
parts                   += profile_support_end_straight.stl
parts                   += profile_support_end_bend.stl
parts                   += profile-drill-guide-center.stl
parts                   += profile-drill-guide-side.stl

.PHONY: all
all: $(parts)

.PHONY: warn_committed_changes
ifeq ($(git_uncommitted_changes),)
warn_committed_changes:
	@echo "All changes are committed."
else
warn_committed_changes:
	@echo -n "There are uncommitted changes. Continue? [y/N] " && read ans && [ $${ans:-N} = y ]
endif

define make-part-target
.PHONY: $1
$1: $(stl_folder)/$1

$(stl_folder)/$1: $(stl_folder_rev)/$1
	cp $(stl_folder_rev)/$1 $(stl_folder)/$1

$(stl_folder_rev)/$1: Enclosure.scad warn_committed_changes
	mkdir -p $(stl_folder_rev)
	openscad -D "part=\"$1\"" -D "revision=\"$(git_revision)\"" -o $(stl_folder_rev)/$1 Enclosure.scad
endef

$(foreach part,$(parts),$(eval $(call make-part-target,$(part))))

