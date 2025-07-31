{
# DNS over HTTP (DoH), aka. Trusted Recursive Resolver (TRR)
# (https://wiki.mozilla.org/Trusted_Recursive_Resolver), uses a server run by
# Cloudflare to resolve hostnames, even when the system uses another (normal) DNS
# server. This setting disables it and sets the mode to explicit opt-out (5).
  "network.trr.mode" = 5;
}
