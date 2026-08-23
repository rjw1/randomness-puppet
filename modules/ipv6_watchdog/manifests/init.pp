# Restart systemd-networkd when IPv6 connectivity drops.
#
# Works around a recurring issue (seen on web-03) where IPv6 stops routing
# until systemd-networkd is bounced. Ships a oneshot systemd service, driven
# by a systemd timer, that pings out over IPv6 and restarts the network
# manager on failure.
class ipv6_watchdog (
  String $interval = '5min',
) {
  file { '/usr/local/sbin/check-ipv6.sh':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/ipv6_watchdog/check-ipv6.sh',
  }

  file { '/etc/systemd/system/ipv6-watchdog.service':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/ipv6_watchdog/ipv6-watchdog.service',
    notify => Exec['ipv6_watchdog-systemctl-daemon-reload'],
  }

  file { '/etc/systemd/system/ipv6-watchdog.timer':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('ipv6_watchdog/ipv6-watchdog.timer.epp', { 'interval' => $interval }),
    notify  => Exec['ipv6_watchdog-systemctl-daemon-reload'],
  }

  exec { 'ipv6_watchdog-systemctl-daemon-reload':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  }

  service { 'ipv6-watchdog.timer':
    ensure    => running,
    enable    => true,
    require   => [
      File['/usr/local/sbin/check-ipv6.sh'],
      File['/etc/systemd/system/ipv6-watchdog.service'],
      File['/etc/systemd/system/ipv6-watchdog.timer'],
    ],
    subscribe => Exec['ipv6_watchdog-systemctl-daemon-reload'],
  }
}
