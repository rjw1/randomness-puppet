# Use hiera as a lightweight ENC.
node default {
  lookup('classes', Array[String], 'unique').include
  $accounts = lookup( { 'name'  => 'accounts',
          'merge' => {
            'strategy'        => 'deep',
          },
})
  create_resources('account', $accounts)
  $sudo_conf = lookup('sudo_conf')
  create_resources('sudo::conf', $sudo_conf)
  $ufw_allow = lookup( { 'name' => 'ufw_allow',
          'merge' => {
            'strategy'        => 'deep',
          },
})
  create_resources('ufw::allow', $ufw_allow)
  $base_packages = lookup( { 'name' => 'base_packages',
          'merge' => {
            'strategy'        => 'deep',
          },
})
  ensure_packages($base_packages)
}
