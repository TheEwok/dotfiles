DOTFILE_SRC_DIR = $(CURDIR)/dotfiles
DOTFILES_SRC = $(notdir $(wildcard dotfiles/*))
LINK_TARGET ?= home_dir

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

