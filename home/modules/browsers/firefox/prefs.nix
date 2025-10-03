let
  prefsJS = builtins.readFile ./prefs.js;
  lines = (builtins.filter (line: line != "") (builtins.split "\n" prefsJS));
  lines' = builtins.filter (x: builtins.typeOf x == "string") lines;

  parser = line:
    let
      
      match = builtins.match ''user_pref\("([^"]+)",[[:space:]]*([^)]+)\);'' line;
      key = if match != null then builtins.elemAt match 0 else null;
      rawVal = if match != null then builtins.elemAt match 1 else null;

      valueProcessor =
        if rawVal == null then null
        else if rawVal == "true" then true
        else if rawVal == "false" then false
        else if rawVal == "null" then null
          else if builtins.match ''-?[0-9]+'' rawVal != null then builtins.fromJSON rawVal
        else if builtins.match ''"(.*)"'' rawVal != null then
          let
            str = builtins.head (builtins.match ''"(.*)"'' rawVal);
            unescaped = builtins.replaceStrings [ "\\\"" "\\\\" "\\n" "\\t" ] [ "\"" "\\" "\n" "\t" ] str;
          in
          unescaped
        else rawVal;
    in
      if key == null || valueProcessor == null then null
      else { name = key; value = valueProcessor; };
  parsedLines = builtins.map parser lines';
  keyValuePairs = builtins.filter (x: x != null) parsedLines;
  attrs = builtins.listToAttrs keyValuePairs;
in {
  programs.firefox.profiles.day2day.settings = attrs;
}
