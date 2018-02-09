// ExternalObjectInstanceCounter.h
#ifndef EXTERNALOBJECTINSTANCECOUNTER
#define EXTERNALOBJECTINSTANCECOUNTER

#pragma once

#ifdef __cplusplus

namespace ExternalObjectInstanceCounter {

	class Counter
	{
	private:
		static Counter* root; // root of all counters
		int counter;   // Current counter value
		int id;        // Dymola id, for search by id
		Counter * next; // pointer to next counter
	public:
		Counter(int givenId=0) {
			counter = 0;
			// if passed 0 or default value, auto allocate id.
			if(givenId == 0) {
				id = 1;
				for (Counter * c = root; c != 0; c=c->next) {
					if (c->id >= id) id = c->id + 1; // new instance id is larger than all known ids.
				}
			} else id = givenId;
			// check that id isn't already used. Normally cannot happen since the C interface
			// performs a findById if ids are used.
			for (Counter * c = root; c != 0; c=c->next) {
				if (c->id == givenId) c->id = -2; // reset conflicting ids.
			}
			// insert at head of list.
			next = root;
			root = this;
		}
		/* Destructor: set counter at -1 and remove from list */
		~Counter(void) {
			counter = -1;
			// Remove from list, using sequential search from root.
			// Most efficient when counters are destroyed in reverse creation order.
			for (Counter ** p = &root; *p != 0; p=&((*p)->next)) {
				if (*p == this) {
					*p = next;
					next = static_cast<Counter*>(0);
					break;
				}
			}
		}
		/* Method count. Ensure a valid "this" is used when calling this method. */
		int count(void){
			counter++;
			return counter;
		}
		/* Overload operator == for <list> operations. */
		bool operator == (const Counter& other) {
			return id == other.id;
		}
		/* Class function checks whether pointer to counter is valid */
		static bool isValid(Counter* p) {
			for (Counter * c = root; c != 0; c=c->next) {
				if (p == c) {
					return true; // Found in list, therefore valid.
				}
			}
			return false; // Not found, therefore invalid. Do not cast!
		}
		/* Class function searches for a counter by id */
		static Counter * findById(int id) {
			for (Counter * c = root; c != 0; c=c->next) {
				if (c->id == id) {
					return c; // Found in list.
				}
			}
			return 0; // Not found. Unknown id!
		}
		/* Class function creates a counter and returns id */
		static int nextCounterId(void) {
			Counter& c=*new Counter();
			return c.id;
		}
	};
}
// Out of all namespaces
#endif // __cplusplus

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
// Export rule
#ifdef _WINDOWS
#ifndef EXPORT
#define EXPORT __declspec(dllimport) __cdecl
#endif
#else
#define EXPORT
#endif

// Function prototypes 
	EXPORT void* ExternalObjectInstanceCounter_ctor(void);
	EXPORT void ExternalObjectInstanceCoutner_dtor(void* data);
	EXPORT int ExternalObjectInstanceCounter_count(void* data);
	EXPORT int ExternalObjectInstanceCounter_next(int x);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif // EXTERNALOBJECTINSTANCECOUNTER
