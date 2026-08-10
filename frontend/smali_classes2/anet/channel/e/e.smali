.class final Lanet/channel/e/e;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;


# direct methods
.method constructor <init>(Ljava/util/List;Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/e/e;->a:Ljava/util/List;

    iput-object p2, p0, Lanet/channel/e/e;->b:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    .line 160
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lanet/channel/e/e;->a:Ljava/util/List;

    const/4 v1, 0x0

    .line 163
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lanet/channel/strategy/IConnStrategy;

    .line 165
    new-instance v1, Lanet/channel/entity/a;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "https://"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lanet/channel/e/a;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Http3Detect"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lanet/channel/e/a;->e()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0}, Lanet/channel/e/a;->a(Lanet/channel/strategy/IConnStrategy;)Lanet/channel/strategy/IConnStrategy;

    move-result-object v4

    invoke-direct {v1, v2, v3, v4}, Lanet/channel/entity/a;-><init>(Ljava/lang/String;Ljava/lang/String;Lanet/channel/strategy/IConnStrategy;)V

    .line 166
    new-instance v2, Lanet/channel/session/TnetSpdySession;

    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3, v1}, Lanet/channel/session/TnetSpdySession;-><init>(Landroid/content/Context;Lanet/channel/entity/a;)V

    .line 167
    new-instance v1, Lanet/channel/e/f;

    invoke-direct {v1, p0, v0}, Lanet/channel/e/f;-><init>(Lanet/channel/e/e;Lanet/channel/strategy/IConnStrategy;)V

    const/16 v0, 0x101

    invoke-virtual {v2, v0, v1}, Lanet/channel/session/TnetSpdySession;->registerEventcb(ILanet/channel/entity/EventCb;)V

    .line 182
    iget-object v0, v2, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lanet/channel/statist/SessionStatistic;->isCommitted:Z

    .line 183
    invoke-virtual {v2}, Lanet/channel/session/TnetSpdySession;->connect()V

    return-void
.end method
