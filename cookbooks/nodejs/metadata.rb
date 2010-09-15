maintainer        "Gareth Marshall"
maintainer_email  "garethm@acm.org"
license           "Various"
description       "Installs node.js from source"
version           "0.8.0"

recipe "nodejs", "Installs node.js from source"

%w{ centos redhat fedora ubuntu debian arch}.each do |os|
  supports os
end
