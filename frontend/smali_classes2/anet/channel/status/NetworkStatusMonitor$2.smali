.class final Lanet/channel/status/NetworkStatusMonitor$2;
.super Landroid/content/BroadcastReceiver;
.source "Taobao"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 116
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    const/4 p1, 0x1

    .line 119
    invoke-static {p1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 120
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "receiver:"

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string v0, "awcn.NetworkStatusMonitor"

    const/4 v1, 0x0

    invoke-static {v0, p1, v1, p2}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 122
    :cond_0
    new-instance p1, Lanet/channel/status/d;

    invoke-direct {p1, p0}, Lanet/channel/status/d;-><init>(Lanet/channel/status/NetworkStatusMonitor$2;)V

    invoke-static {p1}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method
