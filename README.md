# dotfiles
My workstation dotfiles. 

Btw, I included the NixOS config too, but the individual configurations will work on other repos.

**Note**: If the icons don't show correctly in waybar try `fc-cache -r`

![Workstation demo](demo.png)

## Additional content

### Set **nnn** default program 

Simply run the `xdg-mime` commnad. For example:

```
xdg-mime default mpv.desktop video/mp4
```

## Laptop

In case of using this nix config on a laptop, tlp(for battery management) can be easily added:

``` nix
# For laptop, battery life improvement
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
  };
```
