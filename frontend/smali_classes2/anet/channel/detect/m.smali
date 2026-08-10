.class Lanet/channel/detect/m;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

.field final synthetic b:Lanet/channel/detect/l;


# direct methods
.method constructor <init>(Lanet/channel/detect/l;Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/detect/m;->b:Lanet/channel/detect/l;

    iput-object p2, p0, Lanet/channel/detect/m;->a:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lanet/channel/detect/m;->a:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    .line 53
    sget-object v1, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->NO:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lanet/channel/detect/m;->a:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    sget-object v1, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->NONE:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lanet/channel/detect/m;->b:Lanet/channel/detect/l;

    .line 56
    iget-object v0, v0, Lanet/channel/detect/l;->a:Lanet/channel/detect/k;

    iget-object v1, p0, Lanet/channel/detect/m;->a:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    invoke-static {v1}, Lanet/channel/status/NetworkStatusHelper;->getUniqueId(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lanet/channel/detect/k;->a(Lanet/channel/detect/k;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :cond_1
    :goto_0
    return-void

    :catchall_0
    move-exception v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "anet.MTUDetector"

    const-string v3, "MTU detecet fail."

    const/4 v4, 0x0

    .line 58
    invoke-static {v2, v3, v4, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_1
    return-void
.end method
