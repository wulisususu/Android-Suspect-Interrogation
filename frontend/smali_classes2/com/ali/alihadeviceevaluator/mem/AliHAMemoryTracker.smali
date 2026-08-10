.class public Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;
.super Ljava/lang/Object;
.source "AliHAMemoryTracker.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private getMemInfo()[J
    .locals 12

    const/4 v0, 0x4

    new-array v1, v0, [J

    :try_start_0
    const-string v2, "android.os.Process"

    .line 49
    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "readProcLines"

    const/4 v4, 0x3

    new-array v5, v4, [Ljava/lang/Class;

    const-class v6, Ljava/lang/String;

    const/4 v7, 0x0

    aput-object v6, v5, v7

    const-class v6, [Ljava/lang/String;

    const/4 v8, 0x1

    aput-object v6, v5, v8

    const-class v6, [J

    const/4 v9, 0x2

    aput-object v6, v5, v9

    invoke-virtual {v2, v3, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v3, v4, [Ljava/lang/Object;

    new-array v5, v0, [Ljava/lang/String;

    const-string v6, "MemTotal:"

    aput-object v6, v5, v7

    const-string v6, "MemFree:"

    aput-object v6, v5, v8

    const-string v6, "Buffers:"

    aput-object v6, v5, v9

    const-string v6, "Cached:"

    aput-object v6, v5, v4

    new-array v4, v0, [J

    const-wide/16 v10, 0x1e

    aput-wide v10, v4, v7

    const-wide/16 v10, -0x1e

    aput-wide v10, v4, v8

    const-string v6, "/proc/meminfo"

    aput-object v6, v3, v7

    aput-object v5, v3, v8

    aput-object v4, v3, v9

    if-eqz v2, :cond_0

    const/4 v5, 0x0

    .line 59
    invoke-virtual {v2, v5, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    if-ge v7, v0, :cond_0

    .line 61
    aget-wide v2, v4, v7

    aput-wide v2, v1, v7
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    :cond_0
    return-object v1

    :catch_0
    move-exception v0

    .line 65
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    return-object v1
.end method


# virtual methods
.method public getDeviceMem()[J
    .locals 10

    .line 39
    invoke-direct {p0}, Lcom/ali/alihadeviceevaluator/mem/AliHAMemoryTracker;->getMemInfo()[J

    move-result-object v0

    const/4 v1, 0x2

    new-array v2, v1, [J

    const/4 v3, 0x0

    .line 41
    aget-wide v4, v0, v3

    aput-wide v4, v2, v3

    .line 42
    aget-wide v3, v0, v3

    const/4 v5, 0x1

    aget-wide v6, v0, v5

    aget-wide v8, v0, v1

    add-long/2addr v6, v8

    const/4 v1, 0x3

    aget-wide v8, v0, v1

    add-long/2addr v6, v8

    sub-long/2addr v3, v6

    aput-wide v3, v2, v5

    return-object v2
.end method

.method public getHeapJVM()[J
    .locals 6

    const/4 v0, 0x2

    new-array v0, v0, [J

    .line 18
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Runtime;->maxMemory()J

    move-result-wide v1

    const/16 v3, 0xa

    shr-long/2addr v1, v3

    const/4 v4, 0x0

    aput-wide v1, v0, v4

    .line 19
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Runtime;->totalMemory()J

    move-result-wide v1

    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Runtime;->freeMemory()J

    move-result-wide v4

    sub-long/2addr v1, v4

    shr-long/2addr v1, v3

    const/4 v3, 0x1

    aput-wide v1, v0, v3

    return-object v0
.end method

.method public getHeapNative()[J
    .locals 6

    const/4 v0, 0x2

    new-array v0, v0, [J

    .line 29
    invoke-static {}, Landroid/os/Debug;->getNativeHeapSize()J

    move-result-wide v1

    const/16 v3, 0xa

    shr-long/2addr v1, v3

    const/4 v4, 0x0

    aput-wide v1, v0, v4

    .line 30
    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v1

    invoke-static {}, Landroid/os/Debug;->getNativeHeapFreeSize()J

    move-result-wide v4

    sub-long/2addr v1, v4

    shr-long/2addr v1, v3

    const/4 v3, 0x1

    aput-wide v1, v0, v3

    return-object v0
.end method

.method public getPSS(Landroid/content/Context;I)[J
    .locals 6
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "context",
            "pid"
        }
    .end annotation

    const/4 v0, 0x3

    new-array v0, v0, [J

    const/4 v1, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ltz p2, :cond_0

    :try_start_0
    filled-new-array {p2}, [I

    move-result-object p2

    const-string v4, "activity"

    .line 101
    invoke-virtual {p1, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/ActivityManager;

    .line 102
    invoke-virtual {p1, p2}, Landroid/app/ActivityManager;->getProcessMemoryInfo([I)[Landroid/os/Debug$MemoryInfo;

    move-result-object p1

    .line 103
    aget-object p1, p1, v3

    .line 105
    iget p2, p1, Landroid/os/Debug$MemoryInfo;->dalvikPss:I

    int-to-long v4, p2

    aput-wide v4, v0, v3

    .line 106
    iget p2, p1, Landroid/os/Debug$MemoryInfo;->nativePss:I

    int-to-long v3, p2

    aput-wide v3, v0, v2

    .line 107
    invoke-virtual {p1}, Landroid/os/Debug$MemoryInfo;->getTotalPss()I

    move-result p1

    int-to-long p1, p1

    aput-wide p1, v0, v1

    goto :goto_0

    :cond_0
    const-wide/16 p1, 0x0

    aput-wide p1, v0, v3

    aput-wide p1, v0, v2

    aput-wide p1, v0, v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 114
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    return-object v0
.end method

.method public getPrivateDirty(Landroid/content/Context;I)[J
    .locals 3
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "context",
            "pid"
        }
    .end annotation

    const-string v0, "activity"

    .line 79
    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/ActivityManager;

    filled-new-array {p2}, [I

    move-result-object p2

    .line 82
    invoke-virtual {p1, p2}, Landroid/app/ActivityManager;->getProcessMemoryInfo([I)[Landroid/os/Debug$MemoryInfo;

    move-result-object p1

    const/4 p2, 0x0

    .line 83
    aget-object p1, p1, p2

    const/4 v0, 0x3

    new-array v0, v0, [J

    .line 85
    iget v1, p1, Landroid/os/Debug$MemoryInfo;->dalvikPrivateDirty:I

    int-to-long v1, v1

    aput-wide v1, v0, p2

    .line 86
    iget p2, p1, Landroid/os/Debug$MemoryInfo;->nativePrivateDirty:I

    int-to-long v1, p2

    const/4 p2, 0x1

    aput-wide v1, v0, p2

    .line 87
    invoke-virtual {p1}, Landroid/os/Debug$MemoryInfo;->getTotalPrivateDirty()I

    move-result p1

    int-to-long p1, p1

    const/4 v1, 0x2

    aput-wide p1, v0, v1

    return-object v0
.end method
