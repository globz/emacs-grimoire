#include <stdio.h>
#include <linux/landlock.h>
#include <sys/syscall.h>
#include <unistd.h>

int main() {
    int abi = syscall(SYS_landlock_create_ruleset, NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
    if (abi < 0) {
        printf("0\n");
    } else {
        printf("%d\n", abi);
    }
    return 0;
}
