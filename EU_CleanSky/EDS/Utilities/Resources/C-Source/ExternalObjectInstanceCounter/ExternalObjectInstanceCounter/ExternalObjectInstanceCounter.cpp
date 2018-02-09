// This is the main DLL file.

//#include "stdafx.h"
// Export rule (affecte header file)
#ifdef WIN32
#define EXPORT __declspec(dllexport)
#endif
#include "ExternalObjectInstanceCounter.h"

ExternalObjectInstanceCounter::Counter* ExternalObjectInstanceCounter::Counter::root = 0; // root of all counters

#include <cstdio>

static bool logInitialised = false;
static void ExternalObjectInstanceCounter_print(const char * format, int n=0) {
	FILE * log;
	if(!logInitialised) {
		logInitialised = true;
		int error = fopen_s(&log,"C:\\Temp\\EOIC.log","w");
	} else {
		int error = fopen_s(&log,"C:\\Temp\\EOIC.log","a");
	}
	if(log != 0) {
 		fprintf(log,format,n);
		fprintf(log,"\n");
		fclose(log);
	}
}


extern "C" {

	// Some Modelica tools never call the declared ctor and dtor of ExternalObjects.
	// Dymola for instance represents external objects as:
	struct DymolaExternalObject {
		int  id;
	};

	void* ExternalObjectInstanceCounter_ctor(void) {
		ExternalObjectInstanceCounter::Counter * opaque = new ExternalObjectInstanceCounter::Counter;
		return static_cast<void*>(opaque);
	}

	void ExternalObjectInstanceCounter_dtor(void* data) {
		ExternalObjectInstanceCounter::Counter * opaque = 0;
		// Check if data is found in counters list.
		if( ExternalObjectInstanceCounter::Counter::isValid(static_cast<ExternalObjectInstanceCounter::Counter*>(data)) ) {
			// Modelica 3.3 compliant tool
			opaque = static_cast<ExternalObjectInstanceCounter::Counter*>(data);
		} else {
			int id = static_cast<DymolaExternalObject*>(data)->id;
			opaque = ExternalObjectInstanceCounter::Counter::findById(id);
			if(opaque == 0) {
				// Not found in list. Delete directly
				ExternalObjectInstanceCounter_print("ExternalObjectInstanceCounter destructor called with unknown counter id.");
				delete static_cast<ExternalObjectInstanceCounter::Counter*>(data);
			}
		}
	}

	int ExternalObjectInstanceCounter_count(void* data) {
		// Workaround Dymola implementation.
		// In Dymola, the ctor and dtor above are never called and memory for a structure containing a single int named "id" is statically allocated.
		// In the Dymola version of the Modelica Standard Library, the id is initialised by an equation in a "when initial()" section, and is therefore a 
		// variable (not suitable for parameter initialisation).
		ExternalObjectInstanceCounter::Counter * opaque = 0;
		// Detect bug:
		if( ExternalObjectInstanceCounter::Counter::isValid(static_cast<ExternalObjectInstanceCounter::Counter*>(data)) ) {
			// Modelica 3.3 compliant tool
			opaque = static_cast<ExternalObjectInstanceCounter::Counter*>(data);
		} else {
			// Dymola...
		    ExternalObjectInstanceCounter_print("ExternalObjectInstanceCounter Workaround for Dymola...");
			int id = static_cast<DymolaExternalObject*>(data)->id;
			// a null id means auto-allocate id
			if(id != 0) {
				ExternalObjectInstanceCounter_print("  ExternalObjectInstanceCounter_count searching counter list by id...");
				opaque = ExternalObjectInstanceCounter::Counter::findById(id);
			}
			// create counter
			if(opaque == 0) {
				ExternalObjectInstanceCounter_print("  ExternalObjectInstanceCounter_count did not find counter in list...");
				// Call constructor with given id.
				opaque = new ExternalObjectInstanceCounter::Counter(id);
			} else {
				ExternalObjectInstanceCounter_print("  ExternalObjectInstanceCounter_count found the counter by id...");
			}
		}
		int count = opaque->count();
		ExternalObjectInstanceCounter_print("  ExternalObjectInstanceCounter_count returned %d.",count);
		return count;
	}

	int ExternalObjectInstanceCounter_next(int x) {
		int id = ExternalObjectInstanceCounter::Counter::nextCounterId();
		ExternalObjectInstanceCounter_print("ExternalObjectInstanceCounter_next called... returned %d.", id);
		return id;
	}

} // extern "C"
