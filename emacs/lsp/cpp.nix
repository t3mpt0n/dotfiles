 {
   config,
   lib,
   pkgs,
   ...
 }: {
   environment.systemPackages = with pkgs; [
     ccls
     libcs50
     gdb
   ];
 }
