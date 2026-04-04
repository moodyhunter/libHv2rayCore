module hv2ray.core.stats

go 1.26.1

require (
	google.golang.org/grpc v1.80.0
	hv2ray.core.common v0.0.0-00010101000000-000000000000
)

replace hv2ray.core.common => ../common

require (
	golang.org/x/net v0.49.0 // indirect
	golang.org/x/sys v0.40.0 // indirect
	golang.org/x/text v0.33.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260120221211-b8f7ae30c516 // indirect
	google.golang.org/protobuf v1.36.11 // indirect
)
