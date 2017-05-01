{ config, pkgs, ... }:

{

  users.extraUsers.john = {
        name = "john";
        group = "users";
        extraGroups = [ "wheel" "networkmanager" "audio" ];
        uid = 1000;
        home = "/home/john";
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkkpuwZ+Pf7tdF1I6HzEnb9QsrFMywmNnosw5dC0uJVAj7+yCWPWNc2xVc+1b4584yYU474VtE3ly6XGLuXLw4FckCR8VHvTIBseP6nK0l/S9M7AAwbTf92lX3aeCOZFIczzyKQDBmx/YUqSBeTZKoc6e7XBtgMbuioEfsIsEwkSgZBl35X7UYqpJYVJcdDBF/FhwJsYHAv6Nkerp9NDH8T0xCFnxgOXC9XcfowLHDmCoqE3EwdiFRvH13kIhfCfP76NWxrfXo+nI3nXMFOM9KcPuG2XmtNHDKWGsfb5K9rTyR8vyxy+g9q6LKcyZzSvrAdiQT6eu8oveIsbfKjtAV john@skel" "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeAoJGh3IoGZnZ4ZIXwll52bKt9SlsO/t4HwMWcp1zoLKY9VIKJorF3JKuNCjPQROdn9nOKHlsvfmAJwM/2+2ZMETcLnbdg8KFQnhKNZe5vMSuM5u8RkaqvH0UaTTPSC0DFC3DOFd/pCtPLjBOYgYvpn+m2+z3U6wz/5H7rWy9ikK4rwZqa4bhwY1yoGCfifW2pKIpFTnQJMtkNJ7yzgfpRg6mddVYDv8+PxVJrb3ALoTiADtUc8QzaNh4tvm4h2XfjN7qR+hD1ii7FG0oG9bBcSCV/9kHO8U21pETfGRh+VKktK09qxWMiM6pFG7aKHY7mIncvMzKJ/KvHNUgBo1L john@sloth" "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCw/E7zHW9O0o433VJXmHluDQsmscMcLXrIJYUm7Wqc2oU6jHGrrUFcQnlbjuZCtTokCDf9bwPHaYUq77dsWxd82j/wNEuQJKmiSInTMyAZmTG9zZM/sLofRUkQro0RCU+ZnqHDwT59Sq4kKVYUtpzOAY28SDnHXI+zw24RX/sclvV7+Io+TzHYie7mJmsjnEVub7PXhvleSJ81JNPfBphLcGQON+z0SCnbPCqRIl0XkaepKNj91XPH9zPbzTN0JYWrfSvqXwmXxYex2iGankFvYAlJb97mklkYGJ2ahVp3k7YDhH1UKdTzpPzFHBcv3hCV+aztpb86xrYvib7IJ+OF john@switchblade" ];
  };

  # Services Drectly Connected to john
  services = {
    gnome3.gnome-keyring.enable = true;
    syncthing = {
      useInotify = true;
      enable = true;
      group = "users";
      user = "john";
    };
  };
  
  # For syncthing inotify
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 204800;
  };

}
