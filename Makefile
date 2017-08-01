DOTFILE_SRC_DIR = $(CURDIR)/dotfiles
DOTFILES_SRC = $(notdir $(wildcard dotfiles/*))
LINK_TARGET ?= $(HOME)
RM_DOTFILES = .bashrc .gitconfig .tmux.conf .vimrc .vmailrc

link: $(foreach f, $(DOTFILES_SRC), link-dot-file-$(f))

link-dot-file-%: $(DOTFILE_SRC_DIR)/%
	@echo "Create Symlink for $(notdir $<)"
	@ln -s $(DOTFILE_SRC_DIR)/$(notdir $<) $(LINK_TARGET)/.$(notdir $<)

vimdirs:
	@echo "Adding empty Vim dirs"
	@mkdir $(LINK_TARGET)/.vim/backupdir
	@mkdir $(LINK_TARGET)/.vim/undodir
	
clean: 
	rm -rf $(LINK_TARGET)/.bashrc
	rm -rf $(LINK_TARGET)/.gitconfig
	rm -rf $(LINK_TARGET)/.tmux.conf
	rm -rf $(LINK_TARGET)/.vimrc
	rm -rf $(LINK_TARGET)/.vmailrc

update:
	git pull origin master

brew:
	brew install bash bash-completion tmux cask 
	brew tap caskroom/fonts
	brew cask install font-source-code-pro

tpm:
	mkdir -p $(LINK_TARGET)/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm.git $(LINK_TARGET)/.tmux/plugins/tpm

movein: link tpm

movein_osx: brew movein

.phony: clean brew movein movein_osx update
