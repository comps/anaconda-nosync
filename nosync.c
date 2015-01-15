void sync(void) { return; }
void syncfs(int fd) { (void)fd; return; }
int fsync(int fd) { (void)fd; return 0; }
int fdatasync(int fd) { (void)fd; return 0; }
