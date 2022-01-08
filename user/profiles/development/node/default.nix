{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs
    nodePackages.nodemon
    nodePackages.http-server
    nodePackages.eslint
  ];
}
