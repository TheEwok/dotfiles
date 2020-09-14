.DEFAULT_GOAL := movein
DOTFILE_SRC_DIR = $(CURDIR)/dotfiles
DOTFILES_SRC = $(notdir $(wildcard dotfiles/*))
LINK_TARGET ?= $(HOME)
RM_DOTFILES = .bashrc .gitconfig .tmux.conf .vimrc .vmailrc
BREW_PACKAGES = bash bash-completion tmux cask 
TPM_PLUGINS_DIR = .tmux/plugins/tpm

link: $(foreach f, $(DOTFILES_SRC), link-dot-file-$(f))

link-dot-file-%: $(DOTFILE_SRC_DIR)/%
	@echo "Create Symlink for $(notdir $<)"
	@ln -s $(DOTFILE_SRC_DIR)/$(notdir $<) $(LINK_TARGET)/.$(notdir $<)

clean: $(foreach f, $(RM_DOTFILES), rm-dot-file-$(f))

rm-dot-file-%: $(foreach f, $(RM_DOTFILES), rm-dot-file-$(f))
	rm -rf $(LINK_TARGET)/$($<)

vimdirs:
	@echo "Adding empty Vim dirs"
	@mkdir $(LINK_TARGET)/.vim/backupdir
	@mkdir $(LINK_TARGET)/.vim/undodir
	
update:
	git pull origin master
	git submodule update --init --recursive

brew:
	brew install $(BREW_PACKAGES)
	brew tap caskroom/fonts
	brew cask install font-source-code-pro

no_desktop:
	@echo "Hiding desktop items"
	defaults write com.apple.finder CreateDesktop false
	killall Finder

tpm:
	mkdir -p $(LINK_TARGET)/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm.git $(LINK_TARGET)/.tmux/plugins/tpm

movein: link update tpm vimdirs

movein_osx: brew no_desktop movein

.phony: clean brew movein movein_osx update vimdirs no_desktop
