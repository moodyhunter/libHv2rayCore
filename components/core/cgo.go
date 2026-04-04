package main

/*
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum HvLogSeverity {
	Severity_Unknown = 0,
	Severity_Error = 1,
	Severity_Warning = 2,
	Severity_Info = 3,
	Severity_Debug = 4,
} HvLogSeverity;

void DoWriteAccessLog(const char* from, const char* to, const char* outbound, bool accepted);
void DoWriteGeneralLog(HvLogSeverity severity, const char* content);

#ifdef __cplusplus
}
#endif
*/
import "C"
import (
	"github.com/v2fly/v2ray-core/v5/common/log"
	common "hv2ray.core.common"
)

func WriteLog(msg string) {
	common.CGoLog("core", msg)
}

func WriteAccessLog(from string, to string, outbound string, accepted bool) {
	C.DoWriteAccessLog(C.CString(from), C.CString(to), C.CString(outbound), C.bool(accepted))
}

func WriteGeneralLog(severity log.Severity, content string) {
	C.DoWriteGeneralLog(C.HvLogSeverity(severity), C.CString(content))
}

//export StartV2RayKernel
func StartV2RayKernel(configBytes *C.char) *C.char {
	config := C.GoString(configBytes)
	err := DoStart(config)
	if err != nil {
		WriteLog(err.Error())
		return C.CString(err.Error())
	}

	if GLOBAL_INSTANCE == nil {
		DoClose()
		return C.CString("Global instance is nil after a successful start.")
	}

	return nil
}

//export CloseV2RayKernel
func CloseV2RayKernel() {
	DoClose()
}
