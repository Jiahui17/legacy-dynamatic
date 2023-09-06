#include "HlsLogging.h"

void log_inf(string tag, string msg) {
    cout << "[INFO  " << tag << "] "  << msg << endl;
}

void log_err(string tag, string msg) {
    cerr << "[ERROR " << tag << "] "  << msg << endl;
    abort();
}

void log_wrn(string tag, string msg) {
    cout << "[WARN  " << tag << "] "  << msg << endl;
}
