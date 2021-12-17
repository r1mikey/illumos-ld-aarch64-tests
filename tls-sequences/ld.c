#if 1
static __thread int x;
static __thread int y;
int sum() {
  return x + y;
}
#else
static __thread int x;
int sum() {
  return x;
}
#endif
