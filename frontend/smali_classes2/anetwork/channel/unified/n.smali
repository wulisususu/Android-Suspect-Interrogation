.class Lanetwork/channel/unified/n;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanetwork/channel/unified/k;


# direct methods
.method constructor <init>(Lanetwork/channel/unified/k;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/unified/n;->a:Lanetwork/channel/unified/k;

    .line 152
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    iget-object v0, p0, Lanetwork/channel/unified/n;->a:Lanetwork/channel/unified/k;

    .line 155
    iget-object v0, v0, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lanetwork/channel/unified/n;->a:Lanetwork/channel/unified/k;

    .line 156
    iget-object v0, v0, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    iget-object v0, v0, Lanetwork/channel/entity/g;->b:Lanet/channel/statist/RequestStatistic;

    .line 157
    iget-object v3, v0, Lanet/channel/statist/RequestStatistic;->isDone:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v3, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v1

    const/4 v2, 0x0

    const/16 v3, -0xca

    if-eqz v1, :cond_0

    .line 158
    iput v3, v0, Lanet/channel/statist/RequestStatistic;->statusCode:I

    .line 159
    invoke-static {v3}, Lanet/channel/util/ErrorConstant;->getErrMsg(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lanet/channel/statist/RequestStatistic;->msg:Ljava/lang/String;

    .line 160
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, v0, Lanet/channel/statist/RequestStatistic;->rspEnd:J

    iget-object v1, p0, Lanetwork/channel/unified/n;->a:Lanetwork/channel/unified/k;

    .line 161
    iget-object v1, v1, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    iget-object v1, v1, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    const-string v4, "rs"

    filled-new-array {v4, v0}, [Ljava/lang/Object;

    move-result-object v4

    const-string v5, "anet.UnifiedRequestTask"

    const-string v6, "task time out"

    invoke-static {v5, v6, v1, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 162
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v1

    new-instance v4, Lanet/channel/statist/ExceptionStatistic;

    invoke-direct {v4, v3, v2, v0, v2}, Lanet/channel/statist/ExceptionStatistic;-><init>(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;Ljava/lang/Throwable;)V

    invoke-interface {v1, v4}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    :cond_0
    iget-object v0, p0, Lanetwork/channel/unified/n;->a:Lanetwork/channel/unified/k;

    .line 164
    iget-object v0, v0, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    invoke-virtual {v0}, Lanetwork/channel/unified/j;->b()V

    iget-object v0, p0, Lanetwork/channel/unified/n;->a:Lanetwork/channel/unified/k;

    .line 165
    iget-object v0, v0, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    new-instance v1, Lanetwork/channel/aidl/DefaultFinishEvent;

    iget-object v4, p0, Lanetwork/channel/unified/n;->a:Lanetwork/channel/unified/k;

    iget-object v4, v4, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    iget-object v4, v4, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v4}, Lanetwork/channel/entity/g;->a()Lanet/channel/request/Request;

    move-result-object v4

    invoke-direct {v1, v3, v2, v4}, Lanetwork/channel/aidl/DefaultFinishEvent;-><init>(ILjava/lang/String;Lanet/channel/request/Request;)V

    invoke-interface {v0, v1}, Lanetwork/channel/interceptor/Callback;->onFinish(Lanetwork/channel/aidl/DefaultFinishEvent;)V

    :cond_1
    return-void
.end method
