.class Lanet/channel/session/h;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanet/channel/session/TnetSpdySession;


# direct methods
.method constructor <init>(Lanet/channel/session/TnetSpdySession;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    .line 380
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    .line 383
    iget-boolean v0, v0, Lanet/channel/session/TnetSpdySession;->y:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    .line 384
    iget-object v0, v0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    iget-object v1, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    iget-boolean v1, v1, Lanet/channel/session/TnetSpdySession;->y:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "pingUnRcv:"

    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "awcn.TnetSpdySession"

    const-string v3, "send msg time out!"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :try_start_0
    iget-object v0, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    const/16 v1, 0x800

    const/4 v2, 0x0

    .line 386
    invoke-static {v0, v1, v2}, Lanet/channel/session/TnetSpdySession;->a(Lanet/channel/session/TnetSpdySession;ILanet/channel/entity/b;)V

    iget-object v0, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    .line 387
    iget-object v0, v0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    .line 388
    iget-object v0, v0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    const-string v1, "ping time out"

    iput-object v1, v0, Lanet/channel/statist/SessionStatistic;->closeReason:Ljava/lang/String;

    .line 391
    :cond_0
    new-instance v0, Lanet/channel/strategy/ConnEvent;

    invoke-direct {v0}, Lanet/channel/strategy/ConnEvent;-><init>()V

    const/4 v1, 0x0

    .line 392
    iput-boolean v1, v0, Lanet/channel/strategy/ConnEvent;->isSuccess:Z

    iget-object v1, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    .line 393
    invoke-static {v1}, Lanet/channel/session/TnetSpdySession;->a(Lanet/channel/session/TnetSpdySession;)Z

    move-result v1

    iput-boolean v1, v0, Lanet/channel/strategy/ConnEvent;->isAccs:Z

    .line 394
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object v1

    iget-object v2, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    invoke-static {v2}, Lanet/channel/session/TnetSpdySession;->b(Lanet/channel/session/TnetSpdySession;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    invoke-static {v3}, Lanet/channel/session/TnetSpdySession;->c(Lanet/channel/session/TnetSpdySession;)Lanet/channel/strategy/IConnStrategy;

    move-result-object v3

    invoke-interface {v1, v2, v3, v0}, Lanet/channel/strategy/IStrategyInstance;->notifyConnEvent(Ljava/lang/String;Lanet/channel/strategy/IConnStrategy;Lanet/channel/strategy/ConnEvent;)V

    iget-object v0, p0, Lanet/channel/session/h;->a:Lanet/channel/session/TnetSpdySession;

    const/4 v1, 0x1

    .line 395
    invoke-virtual {v0, v1}, Lanet/channel/session/TnetSpdySession;->close(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
