{ lib, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      Vundle-vim
      nerdtree
      vim-surround
      ctrlp-vim
      ultisnips
      tcomment_vim
      vim-airline
      vim-airline-themes
      vim-gitgutter
      YouCompleteMe
      jedi-vim
      typescript-vim
      vim-jsx-typescript
      vim-colorschemes
    ];
    extraConfig = lib.readFile ./vimrc;
  };
}
