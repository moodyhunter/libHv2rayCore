package common

/*
#ifdef __cplusplus
#define CGO_EXPORT extern "C"
#else
#define CGO_EXPORT
#endif

CGO_EXPORT void cgo_log(const char *component, const char* msg);
*/
import "C"

func CGoLog(component string, msg string) {
	C.cgo_log(C.CString(component), C.CString(msg))
}
