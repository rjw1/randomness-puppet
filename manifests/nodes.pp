# Use hiera as a lightweight ENC.
node default {
  hiera_include('classes')
  $accounts = hiera('accounts')
  create_resources('account', $accounts)
}
