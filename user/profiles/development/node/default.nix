{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodePackages.nodemon
    nodePackages.http-server
    nodePackages.eslint
  ];

}