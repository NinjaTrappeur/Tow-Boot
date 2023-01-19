{ lib, ... }:

{
  device = {
    manufacturer = "Radxa";
    name = lib.mkDefault "ROCK Pi 4 model A/B";
    identifier = lib.mkDefault "radxa-RockPi4";
    productPageURL = "https://wiki.radxa.com/Rockpi4";
  };

  hardware = {
    soc = "rockchip-rk3399";
    SPISize = 4 * 1024 * 1024; # 4 MiB
  };

  Tow-Boot = {
    defconfig = lib.mkDefault "rock-pi-4-rk3399_defconfig";
    config = [
      (helpers: with helpers; {
        USE_PREBOOT = yes;
        PREBOOT = freeform ''"usb start"'';
        LOG = yes;
        LOG_MAX_LEVEL = freeform "9";
      })
    ];
    patches = [
      # Based on https://github.com/armbian/build/blob/master/patch/u-boot/u-boot-rockchip64/board-rock-pi-4-enable-spi-flash.patch
      ./0001-rockpi4-rk3399-add-spi-support.patch
      ./0001-Towboot-debug-heh-did-not-find-a-better-way-to-debug.patch
      # From https://github.com/armbian/build/blob/master/patch/u-boot/u-boot-rockchip64/general-add-xtx-spi-nor-chips.patch
      ./general-add-xtx-spi-nor-chips.patch
    ];
  };
}
