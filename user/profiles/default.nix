{
  # xdg = {
  #   enable = true;
  #   mime = {
  #     enable = true;
  #     defaultApplications = {
  #       "application/pdf" = "google-chrome-beta.desktop";
  #       "image/png" = "feh.desktop";
  #     };
  #   };
  # };

  imports = [
    ./themes
    ./desktop-environment
    ./graphical
    ./terminal
  ];
}