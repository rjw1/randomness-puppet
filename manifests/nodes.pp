# Use hiera as a lightweight ENC.
node default {
  lookup('classes', Array[String], 'unique').include
  $base_packages = lookup( { 'name' => 'base_packages',
          'merge' => {
            'strategy'        => 'deep',
          },
})
  stdlib::ensure_packages($base_packages)
  include accounts
}
