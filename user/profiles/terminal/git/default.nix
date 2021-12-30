{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Caleb";
    userEmail = "choover11@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "vim";
      };
    };
  };
}
