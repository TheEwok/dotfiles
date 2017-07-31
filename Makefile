DOTFILE_SRC_DIR = $(CURDIR)/dotfiles
DOTFILES_SRC = $(notdir $(wildcard dotfiles/*))
LINK_TARGET ?= $(HOME)

link: $(foreach f, $(DOTFILES_SRC), link-dot-file-$(f))

link-dot-file-%: $(DOTFILE_SRC_DIR)/%
	@echo "Create Symlink for $(notdir $<)"
	@ln -s $(DOTFILE_SRC_DIR)/$(notdir $<) $(LINK_TARGET)/.$(notdir $<)

clean:
	rm -rf $(HOME)/.bashrc
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.tmux.conf
	rm -rf $(HOME)/.vimrc
	rm -rf $(HOME)/.vmailrc

brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

movein: link

movein_osx: link brew

.phony: clean brew movein movein_osx
