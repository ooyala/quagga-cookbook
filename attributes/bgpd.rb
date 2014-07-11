include_attribute "quagga"

default[:quagga][:bgp][:local_asn] = ""
default[:quagga][:bgp][:networks] = []
default[:quagga][:bgp][:peers] = {}
