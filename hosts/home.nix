{ config, lib, ... }:

with builtins;
with lib;
let blocklist = fetchurl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn/hosts;
 # blocklist2 = fetchurl https://raw.githubusercontent.com/LukeSmithxyz/etc/master/ips;
 in
 {
  networking.extraHosts = ''
    192.168.1.1   router.home
    127.0.0.1 nixos
    ${readFile blocklist}
     #  0.0.0.0 youtube.com
     #  0.0.0.0 twitter.com
     #  0.0.0.0 x.com
     #  0.0.0.0 youchu.be
     # 0.0.0.0 reddit.com
     # 0.0.0.0 www.reddit.com
     # 0.0.0.0 iv.ggtyler.dev
     # 0.0.0.0 www.youtube.com
     # 0.0.0.0 yewtu.be
     # 0.0.0.0 invidious.drgns.space
     # 0.0.0.0 gab.com
     # 0.0.0.0 nitter.net
     # 0.0.0.0 invidious.slipfox.xyz
     # 0.0.0.0 www.yewtu.be
     # 0.0.0.0 vid.puffyan.us
     # 0.0.0.0 invidious.io
     # 0.0.0.0 invidious.io
     # 0.0.0.0 inv.tux.pizza
     # 0.0.0.0 invidious.projectsegfau.lt
     # 0.0.0.0 inv.us.projectsegfau.lt
     # 0.0.0.0 docs.invidious.io
     # 0.0.0.0 rumble.com
     # 0.0.0.0 api.invidious.io
     # 0.0.0.0 invidious.nerdvpn.de
     # 0.0.0.0 invidious.fdn.fr
     # 0.0.0.0 y.com.sb
     # 0.0.0.0 cozy.tv
     # 0.0.0.0 invidious.perennialte.ch
     # 0.0.0.0 nitter.poast.org
     # 0.0.0.0 invidious.poast.org
     # 0.0.0.0 argentbeacon.com
     # 0.0.0.0 news.ycombinator.com
    '';
  ## Location config -- since Toronto is my 127.0.0.1
  time.timeZone = mkDefault "Europe/London";  #  "America/Los_Angeles";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";
  # For redshift, mainly
  location = (if config.time.timeZone == "Europe/London" then {
    latitude = 43.70011;
    longitude = -79.4163;
  } else if config.time.timeZone == "Europe/Copenhagen" then {
    latitude = 55.88;
    longitude = 12.5;
  } else if config.time.timeZone == "America/Los_Angeles" then {
    latitude = 55.88;
    longitude = 12.5;
  }
    else {});

  # So the vaultwarden CLI knows where to find my server.
  # modules.shell.vaultwarden.config.server = "vault.lissner.net";
}
