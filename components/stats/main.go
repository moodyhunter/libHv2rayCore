// Credit goes to https://github.com/Qv2ray/QvRPCBridge
// by Qv2ray Team (DuckSoft et al.) and contributors

package main

//go:generate protoc --go_out=./command --go_opt=paths=source_relative stats.proto
//go:generate protoc --go-grpc_out=./command --go-grpc_opt=paths=source_relative stats.proto

import (
	"context"
	"fmt"
	"os"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"hv2ray.core.stats/command"
)

const TIMEOUT_VALUE = time.Duration(5000) * time.Millisecond

type StatsInstance struct {
	grpcClient command.StatsServiceClient
	directTag  string
	proxyTag   string
}

var GLOBAL_CLIENT *StatsInstance = nil

type HvStatsResult struct {
	directUpload   uint64
	directDownload uint64
	proxyUpload    uint64
	proxyDownload  uint64
}

// required
func main() {
	// get arg1 from command line, and print it to log
	if len(os.Args) <= 1 {
		WriteLog("V2Ray stats component requires an argument")
		return
	}
	arg1 := os.Args[1]
	WriteLog("V2Ray stats component loaded, arg1: " + arg1)
}

func DoDial(port int, directTag string, proxyTag string) (errMsg string) {
	WriteLog("dialing statistics server")
	DoClose()

	ctx, cancelFunc := context.WithTimeout(context.Background(), TIMEOUT_VALUE)
	defer cancelFunc()

	addrString := fmt.Sprintf("127.0.0.1:%d", port)
	clientConn, err := grpc.NewClient(addrString, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		if ctx.Err() == context.DeadlineExceeded {
			errMsg := fmt.Sprintf("dial timed out at addr `%s`", addrString)
			WriteLog(errMsg)
			return errMsg
		}
		errMsg := fmt.Sprintf("dial failed: %s", err.Error())
		WriteLog(errMsg)
		return errMsg
	}

	GLOBAL_CLIENT = &StatsInstance{
		grpcClient: command.NewStatsServiceClient(clientConn),
		directTag:  directTag,
		proxyTag:   proxyTag,
	}
	WriteLog("DoDial done")
	return ""
}

func DoClose() {
	if GLOBAL_CLIENT != nil {
		WriteLog("stats client connection closed")
		GLOBAL_CLIENT = nil
	}
}

func (s *StatsInstance) GetStats() (statsResult HvStatsResult) {
	defaultResult := HvStatsResult{
		directUpload:   0,
		directDownload: 0,
		proxyUpload:    0,
		proxyDownload:  0,
	}

	if s.grpcClient == nil {
		errMsg := "get stats failed: not connected to V2Ray instance"
		WriteLog(errMsg)
		return defaultResult
	}

	ctx, cancelFunc := context.WithTimeout(context.Background(), TIMEOUT_VALUE)
	defer cancelFunc()

	directUp, directDown := s.getSingleStat(ctx, s.directTag)
	proxyUp, proxyDown := s.getSingleStat(ctx, s.proxyTag)

	return HvStatsResult{
		directUpload:   directUp,
		directDownload: directDown,
		proxyUpload:    proxyUp,
		proxyDownload:  proxyDown,
	}
}

func (s *StatsInstance) getSingleStat(ctx context.Context, name string) (uint64, uint64) {
	defaultResult := uint64(0)

	uploadReqTag := "outbound>>>" + name + ">>>traffic>>>uplink"
	downloadReqTag := "outbound>>>" + name + ">>>traffic>>>downlink"

	uploadReq := &command.GetStatsRequest{Name: uploadReqTag, Reset_: true}
	downloadReq := &command.GetStatsRequest{Name: downloadReqTag, Reset_: true}

	uploadResp, err := s.grpcClient.GetStats(ctx, uploadReq)
	if err != nil {
		errMsg := fmt.Sprintf("get stat `%s` failed: %s", uploadReqTag, err.Error())
		WriteLog(errMsg)
		return defaultResult, defaultResult
	}

	downloadResp, err := s.grpcClient.GetStats(ctx, downloadReq)
	if err != nil {
		errMsg := fmt.Sprintf("get stat `%s` failed: %s", downloadReqTag, err.Error())
		WriteLog(errMsg)
		return defaultResult, defaultResult
	}

	return uint64(uploadResp.Stat.Value), uint64(downloadResp.Stat.Value)
}

func DoGetStats() HvStatsResult {
	if GLOBAL_CLIENT == nil {
		WriteLog("get stats failed: not connected to V2Ray instance")
		return HvStatsResult{
			directUpload:   0,
			directDownload: 0,
			proxyUpload:    0,
			proxyDownload:  0,
		}
	}

	value := GLOBAL_CLIENT.GetStats()
	return value
}
