{
  enable = true;
  userName = "Caleb";
  userEmail = "choover11@gmail.com";

  ignores = [
    ".direnv/"
    ".vscode/"
    ".envrc"
    "result"
    "result-doc"
  ];

  extraConfig = {
    init = {
      defaultBranch = "main";
    };
    core = {
      editor = "vim";
    };
  };
}
