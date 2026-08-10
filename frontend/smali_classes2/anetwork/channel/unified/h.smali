.class Lanetwork/channel/unified/h;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/SessionGetCallback;


# instance fields
.field final synthetic a:Lanet/channel/statist/RequestStatistic;

.field final synthetic b:J

.field final synthetic c:Lanet/channel/request/Request;

.field final synthetic d:Lanet/channel/SessionCenter;

.field final synthetic e:Lanet/channel/util/HttpUrl;

.field final synthetic f:Z

.field final synthetic g:Lanetwork/channel/unified/e;


# direct methods
.method constructor <init>(Lanetwork/channel/unified/e;Lanet/channel/statist/RequestStatistic;JLanet/channel/request/Request;Lanet/channel/SessionCenter;Lanet/channel/util/HttpUrl;Z)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/unified/h;->g:Lanetwork/channel/unified/e;

    iput-object p2, p0, Lanetwork/channel/unified/h;->a:Lanet/channel/statist/RequestStatistic;

    iput-wide p3, p0, Lanetwork/channel/unified/h;->b:J

    iput-object p5, p0, Lanetwork/channel/unified/h;->c:Lanet/channel/request/Request;

    iput-object p6, p0, Lanetwork/channel/unified/h;->d:Lanet/channel/SessionCenter;

    iput-object p7, p0, Lanetwork/channel/unified/h;->e:Lanet/channel/util/HttpUrl;

    iput-boolean p8, p0, Lanetwork/channel/unified/h;->f:Z

    .line 279
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSessionGetFail()V
    .locals 5

    iget-object v0, p0, Lanetwork/channel/unified/h;->g:Lanetwork/channel/unified/e;

    .line 290
    iget-object v0, v0, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    iget-object v1, p0, Lanetwork/channel/unified/h;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v1, v1, Lanet/channel/statist/RequestStatistic;->url:Ljava/lang/String;

    const-string v2, "url"

    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "anet.NetworkTask"

    const-string v3, "onSessionGetFail"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanetwork/channel/unified/h;->a:Lanet/channel/statist/RequestStatistic;

    .line 291
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-wide v3, p0, Lanetwork/channel/unified/h;->b:J

    sub-long/2addr v1, v3

    iput-wide v1, v0, Lanet/channel/statist/RequestStatistic;->connWaitTime:J

    iget-object v0, p0, Lanetwork/channel/unified/h;->g:Lanetwork/channel/unified/e;

    iget-object v1, p0, Lanetwork/channel/unified/h;->d:Lanet/channel/SessionCenter;

    iget-object v2, p0, Lanetwork/channel/unified/h;->e:Lanet/channel/util/HttpUrl;

    iget-boolean v3, p0, Lanetwork/channel/unified/h;->f:Z

    const/4 v4, 0x0

    .line 292
    invoke-static {v0, v4, v1, v2, v3}, Lanetwork/channel/unified/e;->a(Lanetwork/channel/unified/e;Lanet/channel/Session;Lanet/channel/SessionCenter;Lanet/channel/util/HttpUrl;Z)Lanet/channel/Session;

    move-result-object v1

    iget-object v2, p0, Lanetwork/channel/unified/h;->c:Lanet/channel/request/Request;

    invoke-static {v0, v1, v2}, Lanetwork/channel/unified/e;->a(Lanetwork/channel/unified/e;Lanet/channel/Session;Lanet/channel/request/Request;)V

    return-void
.end method

.method public onSessionGetSuccess(Lanet/channel/Session;)V
    .locals 5

    iget-object v0, p0, Lanetwork/channel/unified/h;->g:Lanetwork/channel/unified/e;

    .line 282
    iget-object v0, v0, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    const-string v1, "Session"

    filled-new-array {v1, p1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "anet.NetworkTask"

    const-string v3, "onSessionGetSuccess"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanetwork/channel/unified/h;->a:Lanet/channel/statist/RequestStatistic;

    .line 283
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-wide v3, p0, Lanetwork/channel/unified/h;->b:J

    sub-long/2addr v1, v3

    iput-wide v1, v0, Lanet/channel/statist/RequestStatistic;->connWaitTime:J

    iget-object v0, p0, Lanetwork/channel/unified/h;->a:Lanet/channel/statist/RequestStatistic;

    const/4 v1, 0x1

    .line 284
    iput-boolean v1, v0, Lanet/channel/statist/RequestStatistic;->spdyRequestSend:Z

    iget-object v0, p0, Lanetwork/channel/unified/h;->g:Lanetwork/channel/unified/e;

    iget-object v1, p0, Lanetwork/channel/unified/h;->c:Lanet/channel/request/Request;

    .line 285
    invoke-static {v0, p1, v1}, Lanetwork/channel/unified/e;->a(Lanetwork/channel/unified/e;Lanet/channel/Session;Lanet/channel/request/Request;)V

    return-void
.end method
