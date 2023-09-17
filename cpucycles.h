#ifndef cpucycles_h
#define cpucycles_h
#include <time.h>
static inline unsigned long long cpucycles(void) {
  struct timespec time;
  clock_gettime(CLOCK_REALTIME, &time);
  return (unsigned long long) time.tv_sec*1e9*time.tv_nsec;
}

#endif
