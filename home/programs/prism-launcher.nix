{ pkgs, ... } :

{
  home.packages = [
  
  (pkgs.prismlauncher.override {
    jdks = [
      pkgs.temurin-bin-25
    ];
  })
];
}
