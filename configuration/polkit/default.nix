++
# Add polkit action
[ pkgs.writeTextFile {
      name = "zfs.txt";
      destination = "/share/polkit-1/actions/zfs-user-action.txt";
      text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD polkit Policy Configuration 1.0//EN"
      "http://www.freedesktop.org/software/polkit/policyconfig-1.dtd">
      <policyconfig>

        <vendor>John Ramsden</vendor>
        <vendor_url>https://ramsdenj.com/</vendor_url>

        <action id="org.john.zfs">
          <description>Run zfs list</description>
          <message>Authentication is required to run zfs list as (user=$(user), user.gecos=$(user.gecos), user.display=$(user.display)$
          <defaults>
            <allow_any>yes</allow_any>
            <allow_inactive>yes</allow_inactive>
            <allow_active>yes</allow_active>
          </defaults>
          <annotate key="org.freedesktop.policykit.exec.path">/usr/bin/zfs</annotate>
        </action>

        <action id="org.john.zpool">
          <description>Run zpool status</description>
          <message>Authentication is required to run zpool status as (user=$(user), user.gecos=$(user.gecos), user.display=$(user.disp$
          <defaults>
            <allow_any>yes</allow_any>
            <allow_inactive>yes</allow_inactive>
            <allow_active>yes</allow_active>
          </defaults>
          <annotate key="org.freedesktop.policykit.exec.path">/usr/bin/zpool</annotate>
        </action>

      </policyconfig>
      '';   }
];
