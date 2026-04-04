package main

/*
typedef struct HvStatsConfig {
    const int statsPort;
	const char *directTag;
	const char *proxyTag;
} HvStatsConfig;

typedef struct HvStats {
	unsigned long directUpload;
	unsigned long directDownload;
	unsigned long proxyUpload;
	unsigned long proxyDownload;
} HvStats;
*/
import "C" //required
import common "hv2ray.core.common"

func WriteLog(msg string) {
	common.CGoLog("stats", msg)
}

//export InitStats
func InitStats(config *C.HvStatsConfig) (errMsg *C.char) {
	resultStr := DoDial(int(config.statsPort), C.GoString(config.directTag), C.GoString(config.proxyTag))
	return C.CString(resultStr)
}

//export GetStats
func GetStats() (value C.HvStats) {
	stats := DoGetStats()
	return C.HvStats{
		directUpload:   C.ulong(stats.directUpload),
		directDownload: C.ulong(stats.directDownload),
		proxyUpload:    C.ulong(stats.proxyUpload),
		proxyDownload:  C.ulong(stats.proxyDownload),
	}
}

//export CloseStats
func CloseStats() {
	DoClose()
}
