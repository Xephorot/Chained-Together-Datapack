## ct:cluster/check_pull — Checks if elastic is active and applies pull_to_centroid.
## Executed AS the member that exceeds full_thresh.
## Normal function (not macro) to allow NBT compound in the if data check.

execute if data storage ct:main config{elastic:1b} run function ct:cluster/pull_to_centroid
