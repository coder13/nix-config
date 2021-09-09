{
  enable = true;
  script = "polybar top &";
  settings = {
    "bar/top" = {
      monitor = "DVI-D-0";
      width = "100%";
      height = "3%";
      modules-right = "date";
    };
    "module/date" = {
      type = "internal/date";
      date = "%Y-%m-%d%";
    };
  };
}