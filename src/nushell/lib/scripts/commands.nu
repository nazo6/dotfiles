def ip-info [] {
  http get https://am.i.mullvad.net/json | table --expand
}
