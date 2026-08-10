.class Lanetwork/channel/unified/g;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanet/channel/SessionCenter;

.field final synthetic b:Lanet/channel/util/HttpUrl;

.field final synthetic c:Lanet/channel/statist/RequestStatistic;

.field final synthetic d:Lanet/channel/util/HttpUrl;

.field final synthetic e:Z

.field final synthetic f:Lanetwork/channel/unified/e;


# direct methods
.method constructor <init>(Lanetwork/channel/unified/e;Lanet/channel/SessionCenter;Lanet/channel/util/HttpUrl;Lanet/channel/statist/RequestStatistic;Lanet/channel/util/HttpUrl;Z)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/unified/g;->f:Lanetwork/channel/unified/e;

    iput-object p2, p0, Lanetwork/channel/unified/g;->a:Lanet/channel/SessionCenter;

    iput-object p3, p0, Lanetwork/channel/unified/g;->b:Lanet/channel/util/HttpUrl;

    iput-object p4, p0, Lanetwork/channel/unified/g;->c:Lanet/channel/statist/RequestStatistic;

    iput-object p5, p0, Lanetwork/channel/unified/g;->d:Lanet/channel/util/HttpUrl;

    iput-boolean p6, p0, Lanetwork/channel/unified/g;->e:Z

    .line 242
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .line 245
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lanetwork/channel/unified/g;->a:Lanet/channel/SessionCenter;

    iget-object v3, p0, Lanetwork/channel/unified/g;->b:Lanet/channel/util/HttpUrl;

    .line 247
    sget v4, Lanet/channel/entity/c;->a:I

    const-wide/16 v5, 0xbb8

    invoke-virtual {v2, v3, v4, v5, v6}, Lanet/channel/SessionCenter;->get(Lanet/channel/util/HttpUrl;IJ)Lanet/channel/Session;

    move-result-object v2

    iget-object v3, p0, Lanetwork/channel/unified/g;->c:Lanet/channel/statist/RequestStatistic;

    .line 248
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    sub-long/2addr v4, v0

    iput-wide v4, v3, Lanet/channel/statist/RequestStatistic;->connWaitTime:J

    iget-object v0, p0, Lanetwork/channel/unified/g;->c:Lanet/channel/statist/RequestStatistic;

    if-eqz v2, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 249
    :goto_0
    iput-boolean v1, v0, Lanet/channel/statist/RequestStatistic;->spdyRequestSend:Z

    iget-object v0, p0, Lanetwork/channel/unified/g;->f:Lanetwork/channel/unified/e;

    iget-object v1, p0, Lanetwork/channel/unified/g;->a:Lanet/channel/SessionCenter;

    iget-object v3, p0, Lanetwork/channel/unified/g;->d:Lanet/channel/util/HttpUrl;

    iget-boolean v4, p0, Lanetwork/channel/unified/g;->e:Z

    .line 250
    invoke-static {v0, v2, v1, v3, v4}, Lanetwork/channel/unified/e;->a(Lanetwork/channel/unified/e;Lanet/channel/Session;Lanet/channel/SessionCenter;Lanet/channel/util/HttpUrl;Z)Lanet/channel/Session;

    move-result-object v0

    iget-object v1, p0, Lanetwork/channel/unified/g;->f:Lanetwork/channel/unified/e;

    .line 251
    iget-object v2, v1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v2, v2, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v2}, Lanetwork/channel/entity/g;->a()Lanet/channel/request/Request;

    move-result-object v2

    invoke-static {v1, v0, v2}, Lanetwork/channel/unified/e;->a(Lanetwork/channel/unified/e;Lanet/channel/Session;Lanet/channel/request/Request;)V

    return-void
.end method
