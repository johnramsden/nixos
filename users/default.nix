{ config, pkgs, ... }:

{
  imports =
  [
    ./shells
    ./john
  ];

  users.extraUsers.root = {
    openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDENPIfXWxIHLso5sSUgHB8ezAukyc9V4bp5tTOKVDErEH8F0Pe3u5JMN4EsrP4YAT3LMIJJjBui7htRJkzV7npaA73Qr8DP4j9QbYWvdS4moUzRBPgo/qH//xoHqGw7iN65TrUSyndDRPIaDAKrVuzrDk4XB52CUiOlcLMYFzoucb1kCkmb/JcYnmWhbREl1iWTJzTUuZcsa6uv3c2lzT8XRMRPD6ij+1VewjKE0OB0R2//Sgmkd20YXsz15Ny/+v8nBL9yPRHgEQWHn9u8vAtd9NmAZzAh+5VquqwgPLtOhqFhXHCKjMKHuC552C4AegoJYEGgn2DuByx9IWq7PD/ root@lilan.ramsden.network"
    ];
  };

}
