.class public Lanetwork/channel/aidl/adapter/d;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field static volatile a:Lanetwork/channel/aidl/IRemoteNetworkGetter; = null

.field static volatile b:Z = false

.field static volatile c:Z = false

.field static volatile d:Ljava/util/concurrent/CountDownLatch;

.field static e:Landroid/os/Handler;

.field private static f:Landroid/content/ServiceConnection;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 27
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lanetwork/channel/aidl/adapter/d;->e:Landroid/os/Handler;

    .line 29
    new-instance v0, Lanetwork/channel/aidl/adapter/e;

    invoke-direct {v0}, Lanetwork/channel/aidl/adapter/e;-><init>()V

    sput-object v0, Lanetwork/channel/aidl/adapter/d;->f:Landroid/content/ServiceConnection;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()Lanetwork/channel/aidl/IRemoteNetworkGetter;
    .locals 1

    sget-object v0, Lanetwork/channel/aidl/adapter/d;->a:Lanetwork/channel/aidl/IRemoteNetworkGetter;

    return-object v0
.end method

.method private static a(Landroid/content/Context;)V
    .locals 6

    const/4 v0, 0x2

    .line 101
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    const/4 v1, 0x0

    const-string v2, "anet.RemoteGetter"

    const/4 v3, 0x0

    if-eqz v0, :cond_0

    .line 102
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v4, "[asyncBindService] mContext:"

    invoke-direct {v0, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " bBindFailed:"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-boolean v4, Lanetwork/channel/aidl/adapter/d;->b:Z

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " bBinding:"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-boolean v4, Lanetwork/channel/aidl/adapter/d;->c:Z

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v4, v3, [Ljava/lang/Object;

    invoke-static {v2, v0, v1, v4}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    if-nez p0, :cond_1

    return-void

    :cond_1
    sget-boolean v0, Lanetwork/channel/aidl/adapter/d;->b:Z

    if-eqz v0, :cond_2

    return-void

    :cond_2
    sget-boolean v0, Lanetwork/channel/aidl/adapter/d;->c:Z

    if-eqz v0, :cond_3

    return-void

    :cond_3
    const/4 v0, 0x1

    sput-boolean v0, Lanetwork/channel/aidl/adapter/d;->c:Z

    .line 121
    new-instance v4, Landroid/content/Intent;

    const-class v5, Lanetwork/channel/aidl/NetworkService;

    invoke-direct {v4, p0, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 122
    const-class v5, Lanetwork/channel/aidl/IRemoteNetworkGetter;

    invoke-virtual {v5}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "android.intent.category.DEFAULT"

    .line 123
    invoke-virtual {v4, v5}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    sget-object v5, Lanetwork/channel/aidl/adapter/d;->f:Landroid/content/ServiceConnection;

    .line 124
    invoke-virtual {p0, v4, v5, v0}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    move-result p0

    xor-int/2addr p0, v0

    sput-boolean p0, Lanetwork/channel/aidl/adapter/d;->b:Z

    sget-boolean p0, Lanetwork/channel/aidl/adapter/d;->b:Z

    if-eqz p0, :cond_4

    sput-boolean v3, Lanetwork/channel/aidl/adapter/d;->c:Z

    const-string p0, "[asyncBindService]ANet_Service start not success. ANet run with local mode!"

    new-array v0, v3, [Ljava/lang/Object;

    .line 128
    invoke-static {v2, p0, v1, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_4
    sget-object p0, Lanetwork/channel/aidl/adapter/d;->e:Landroid/os/Handler;

    .line 131
    new-instance v0, Lanetwork/channel/aidl/adapter/f;

    invoke-direct {v0}, Lanetwork/channel/aidl/adapter/f;-><init>()V

    const-wide/16 v1, 0x2710

    invoke-virtual {p0, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public static a(Landroid/content/Context;Z)V
    .locals 4

    sget-object v0, Lanetwork/channel/aidl/adapter/d;->a:Lanetwork/channel/aidl/IRemoteNetworkGetter;

    if-eqz v0, :cond_0

    return-void

    :cond_0
    sget-boolean v0, Lanetwork/channel/aidl/adapter/d;->b:Z

    if-nez v0, :cond_4

    .line 70
    invoke-static {p0}, Lanetwork/channel/aidl/adapter/d;->a(Landroid/content/Context;)V

    sget-boolean p0, Lanetwork/channel/aidl/adapter/d;->b:Z

    if-nez p0, :cond_4

    if-eqz p1, :cond_4

    const/4 p0, 0x0

    const/4 p1, 0x0

    :try_start_0
    const-class v0, Lanetwork/channel/aidl/adapter/d;

    .line 74
    monitor-enter v0
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    sget-object v1, Lanetwork/channel/aidl/adapter/d;->a:Lanetwork/channel/aidl/IRemoteNetworkGetter;

    if-eqz v1, :cond_1

    .line 76
    monitor-exit v0

    return-void

    :cond_1
    sget-object v1, Lanetwork/channel/aidl/adapter/d;->d:Ljava/util/concurrent/CountDownLatch;

    if-nez v1, :cond_2

    .line 79
    new-instance v1, Ljava/util/concurrent/CountDownLatch;

    const/4 v2, 0x1

    invoke-direct {v1, v2}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    sput-object v1, Lanetwork/channel/aidl/adapter/d;->d:Ljava/util/concurrent/CountDownLatch;

    .line 81
    :cond_2
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    const-string v0, "anet.RemoteGetter"

    const-string v1, "[initRemoteGetterAndWait]begin to wait"

    new-array v2, p0, [Ljava/lang/Object;

    .line 82
    invoke-static {v0, v1, p1, v2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    sget-object v0, Lanetwork/channel/aidl/adapter/d;->d:Ljava/util/concurrent/CountDownLatch;

    .line 83
    invoke-static {}, Lanetwork/channel/config/NetworkConfigCenter;->getServiceBindWaitTime()I

    move-result v1

    int-to-long v1, v1

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/concurrent/CountDownLatch;->await(JLjava/util/concurrent/TimeUnit;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "anet.RemoteGetter"

    const-string v1, "mServiceBindLock count down to 0"

    new-array v2, p0, [Ljava/lang/Object;

    .line 84
    invoke-static {v0, v1, p1, v2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_3
    const-string v0, "anet.RemoteGetter"

    const-string v1, "mServiceBindLock wait timeout"

    new-array v2, p0, [Ljava/lang/Object;

    .line 86
    invoke-static {v0, v1, p1, v2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    :catchall_0
    move-exception v1

    .line 81
    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v1
    :try_end_4
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    const-string v0, "anet.RemoteGetter"

    const-string v1, "mServiceBindLock wait interrupt"

    new-array p0, p0, [Ljava/lang/Object;

    .line 89
    invoke-static {v0, v1, p1, p0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_4
    :goto_0
    return-void
.end method
