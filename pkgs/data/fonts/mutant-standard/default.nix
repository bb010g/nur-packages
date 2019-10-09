{ lib, fetchzip }:

let
  pname = "mutant-standard";
  version = "0.4.0";

  fcConf = "mutant-standard-emoji.conf";
  fontconf-45 = builtins.toFile "45-${fcConf}" /*xml*/''
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias binding="same">
    <family>Mutant Standard emoji</family>
    <default><family>emoji</family></default>
  </alias>
</fontconfig>
'';

  fontconf-60 = builtins.toFile "60-${fcConf}" /*xml*/''
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias binding="same">
    <family>emoji</family>
    <prefer>
      <family>Mutant Standard emoji</family>
    </prefer>
  </alias>
</fontconfig>
'';

  fontconf-80 = builtins.toFile "80-${fcConf}" /*xml*/''
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match target="scan">
    <test name="family">
      <string>Mutant Standard emoji (SVGinOT)</string>
    </test>
    <edit name="family" binding="same">
      <string>Mutant Standard emoji</string>
    </edit>
  </match>
  <match target="scan">
    <test name="family">
      <string>Mutant Standard emoji (sbixOT)</string>
    </test>
    <edit name="family" binding="same">
      <string>Mutant Standard emoji</string>
    </edit>
  </match>

  <match target="scan">
    <test name="family">
      <string>Mutant Standard emoji</string>
    </test>
    <edit name="lang" binding="strong">
      <string>und-zsye</string>
    </edit>
    <edit name="color" binding="strong">
      <bool>true</bool>
    </edit>
  </match>
</fontconfig>
'';

in
fetchzip {
  name = "${pname}-${version}";
  passthru.pname = pname;
  passthru.version = version;

  url = "https://mutant.tech/dl/0.4.0/mtnt_0.4.0_font_svginot.zip";
  sha256 = "040qczzpmc7lwwi63wldz6ixaf5ghk8ppd2xjaczhcjrppb0975v";

  extraPostFetch = /*sh*/''
    mv -fT "$out" "$unpackDir"

    mkdir -p "$out"/share/fonts/opentype
    mv "$unpackDir"/font/mtnt_${version}_SVGinOT.otf \
      "$out"/share/fonts/opentype/MutantStandardEmoji.otf

    mkdir -p "$out"/etc/fonts/conf.d
    cp ${lib.escapeShellArg fontconf-45} "$out"/etc/fonts/conf.d/45-${fcConf}
    cp ${lib.escapeShellArg fontconf-60} "$out"/etc/fonts/conf.d/60-${fcConf}
    cp ${lib.escapeShellArg fontconf-80} "$out"/etc/fonts/conf.d/80-${fcConf}
  '';

  meta = {
    description = "Mutant Standard alternative emoji set";
    longDescription = ''
      Mutant Standard is an alternative emoji set. It rejects the status quo
      while maintaining many old favourites. It is pushing for a more diverse
      emoji future.
      
      Unlike other emoji sets, this is truly gender-neutral and inclusive to
      people of all kinds of orientations and genders.

      There are all-new ways to express yourself, including new emoji and
      modifiers for furries and roleplayers.

      Inspired by older emoji and emoticons, it's bright, simple and readable
      in many environments. Even on dark backgrounds!

      Mutant Standard is independent and free - it's supported by people like you.

      No marketing, no brands, no spying.
    '';
    homepage = https://mutant.tech/;
    license = lib.licenses.cc-by-nc-sa-40;
    maintainers = let m = lib.maintainers; in [ m.bb010g ];
  };
}
