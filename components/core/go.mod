module hv2ray.core

go 1.26.0

require (
	github.com/v2fly/v2ray-core/v5 v5.48.0
	hv2ray.core.common v0.0.0-00010101000000-000000000000
)

replace (
	github.com/v2fly/v2ray-core/v5 => ../../deps/v2ray-core
	gvisor.dev/gvisor => ../../deps/gvisor
	hv2ray.core.common => ../common
)

require (
	github.com/adrg/xdg v0.5.3 // indirect
	github.com/aead/cmac v0.0.0-20160719120800-7af84192f0b1 // indirect
	github.com/andybalholm/brotli v1.1.1 // indirect
	github.com/apernet/quic-go v0.59.1-0.20260217092621-db4786c77a22 // indirect
	github.com/boljen/go-bitmap v0.0.0-20151001105940-23cd2fb0ce7d // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/dgryski/go-metro v0.0.0-20211217172704-adc40b04c140 // indirect
	github.com/golang-collections/go-datastructures v0.0.0-20150211160725-59788d5eb259 // indirect
	github.com/golang/protobuf v1.5.4 // indirect
	github.com/google/btree v1.1.2 // indirect
	github.com/google/gopacket v1.1.19 // indirect
	github.com/gorilla/websocket v1.5.3 // indirect
	github.com/klauspost/compress v1.17.11 // indirect
	github.com/klauspost/cpuid/v2 v2.2.9 // indirect
	github.com/klauspost/reedsolomon v1.12.4 // indirect
	github.com/kr/text v0.2.0 // indirect
	github.com/lunixbochs/struc v0.0.0-20241101090106-8d528fa2c543 // indirect
	github.com/miekg/dns v1.1.72 // indirect
	github.com/mustafaturan/bus v1.0.2 // indirect
	github.com/mustafaturan/monoton v1.0.0 // indirect
	github.com/patrickmn/go-cache v2.1.0+incompatible // indirect
	github.com/pelletier/go-toml v1.9.5 // indirect
	github.com/pion/dtls/v2 v2.2.12 // indirect
	github.com/pion/dtls/v3 v3.1.2 // indirect
	github.com/pion/logging v0.2.4 // indirect
	github.com/pion/randutil v0.1.0 // indirect
	github.com/pion/sctp v1.9.4 // indirect
	github.com/pion/transport/v2 v2.2.10 // indirect
	github.com/pion/transport/v3 v3.0.7 // indirect
	github.com/pion/transport/v4 v4.0.1 // indirect
	github.com/pires/go-proxyproto v0.11.0 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/quic-go/qpack v0.6.0 // indirect
	github.com/quic-go/quic-go v0.59.0 // indirect
	github.com/refraction-networking/utls v1.8.2 // indirect
	github.com/riobard/go-bloom v0.0.0-20200614022211-cdc8013cb5b3 // indirect
	github.com/secure-io/siv-go v0.0.0-20180922214919-5ff40651e2c4 // indirect
	github.com/seiflotfy/cuckoofilter v0.0.0-20240715131351-a2f2c23f1771 // indirect
	github.com/stretchr/objx v0.5.2 // indirect
	github.com/stretchr/testify v1.11.1 // indirect
	github.com/v2fly/hysteria/core/v2 v2.0.0-20260220231229-39018a43855e // indirect
	github.com/v2fly/ss-bloomring v0.0.0-20210312155135-28617310f63e // indirect
	github.com/v2fly/struc v0.0.0-20241227015403-8e8fa1badfd6 // indirect
	github.com/xiaokangwang/VLite v0.0.0-20231225174116-75fa4b06e9f2 // indirect
	github.com/xtaci/smux v1.5.33 // indirect
	go.starlark.net v0.0.0-20241226192728-8dfa5b98479f // indirect
	go4.org/netipx v0.0.0-20231129151722-fdeea329fbba // indirect
	golang.org/x/crypto v0.50.0 // indirect
	golang.org/x/exp v0.0.0-20250103183323-7d7fa50e5329 // indirect
	golang.org/x/mod v0.34.0 // indirect
	golang.org/x/net v0.53.0 // indirect
	golang.org/x/sync v0.20.0 // indirect
	golang.org/x/sys v0.43.0 // indirect
	golang.org/x/text v0.36.0 // indirect
	golang.org/x/time v0.12.0 // indirect
	golang.org/x/tools v0.43.0 // indirect
	golang.zx2c4.com/wintun v0.0.0-20230126152724-0fa3db229ce2 // indirect
	golang.zx2c4.com/wireguard v0.0.0-20250521234502-f333402bd9cb // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260120221211-b8f7ae30c516 // indirect
	google.golang.org/grpc v1.80.0 // indirect
	google.golang.org/protobuf v1.36.11 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	gvisor.dev/gvisor v0.0.0-20260218152508-eed1cebf761e // indirect
	lukechampine.com/blake3 v1.4.1 // indirect
)
