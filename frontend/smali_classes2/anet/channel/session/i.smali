.class Lanet/channel/session/i;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/IAuth$AuthCallback;


# instance fields
.field final synthetic a:Lanet/channel/session/TnetSpdySession;


# direct methods
.method constructor <init>(Lanet/channel/session/TnetSpdySession;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 469
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAuthFail(ILjava/lang/String;)V
    .locals 2

    iget-object p2, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    const/4 v0, 0x5

    const/4 v1, 0x0

    .line 486
    invoke-static {p2, v0, v1}, Lanet/channel/session/TnetSpdySession;->c(Lanet/channel/session/TnetSpdySession;ILanet/channel/entity/b;)V

    iget-object p2, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 487
    iget-object p2, p2, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 488
    iget-object p2, p2, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Accs_Auth_Fail:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lanet/channel/statist/SessionStatistic;->closeReason:Ljava/lang/String;

    iget-object p2, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 489
    iget-object p2, p2, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    int-to-long v0, p1

    iput-wide v0, p2, Lanet/channel/statist/SessionStatistic;->errorCode:J

    :cond_0
    iget-object p1, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 491
    invoke-virtual {p1}, Lanet/channel/session/TnetSpdySession;->close()V

    return-void
.end method

.method public onAuthSuccess()V
    .locals 5

    iget-object v0, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    const/4 v1, 0x4

    const/4 v2, 0x0

    .line 472
    invoke-static {v0, v1, v2}, Lanet/channel/session/TnetSpdySession;->b(Lanet/channel/session/TnetSpdySession;ILanet/channel/entity/b;)V

    iget-object v0, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 473
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Lanet/channel/session/TnetSpdySession;->z:J

    iget-object v0, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 474
    iget-object v0, v0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 475
    iget-object v0, v0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    iget-object v1, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    invoke-interface {v0, v1}, Lanet/channel/heartbeat/IHeartbeat;->start(Lanet/channel/Session;)V

    :cond_0
    iget-object v0, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 477
    iget-object v0, v0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    const/4 v1, 0x1

    iput v1, v0, Lanet/channel/statist/SessionStatistic;->ret:I

    iget-object v0, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 478
    iget-object v0, v0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    iget-object v1, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    iget-object v1, v1, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide v1, v1, Lanet/channel/statist/SessionStatistic;->authTime:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "authTime"

    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "awcn.TnetSpdySession"

    const-string v3, "spdyOnStreamResponse"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 479
    iget-wide v0, v0, Lanet/channel/session/TnetSpdySession;->A:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_1

    iget-object v0, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    .line 480
    iget-object v0, v0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-object v3, p0, Lanet/channel/session/i;->a:Lanet/channel/session/TnetSpdySession;

    iget-wide v3, v3, Lanet/channel/session/TnetSpdySession;->A:J

    sub-long/2addr v1, v3

    iput-wide v1, v0, Lanet/channel/statist/SessionStatistic;->authTime:J

    :cond_1
    return-void
.end method
