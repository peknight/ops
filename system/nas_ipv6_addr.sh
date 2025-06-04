#!/bin/bash
ssh -p 31011 admin@pub.peknight.com ifconfig | sed -rn 's!^\s*inet6\s*addr:\s*([:0-9a-zA-Z]*).*global$!\1!ip'
# curl ifconfig.me
