.class Lanet/channel/session/f;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanet/channel/request/Request;

.field final synthetic b:Lanet/channel/RequestCb;

.field final synthetic c:Lanet/channel/statist/RequestStatistic;

.field final synthetic d:Lanet/channel/session/d;


# direct methods
.method constructor <init>(Lanet/channel/session/d;Lanet/channel/request/Request;Lanet/channel/RequestCb;Lanet/channel/statist/RequestStatistic;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/session/f;->d:Lanet/channel/session/d;

    iput-object p2, p0, Lanet/channel/session/f;->a:Lanet/channel/request/Request;

    iput-object p3, p0, Lanet/channel/session/f;->b:Lanet/channel/RequestCb;

    iput-object p4, p0, Lanet/channel/session/f;->c:Lanet/channel/statist/RequestStatistic;

    .line 168
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lanet/channel/session/f;->a:Lanet/channel/request/Request;

    .line 171
    iget-object v0, v0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-object v3, p0, Lanet/channel/session/f;->a:Lanet/channel/request/Request;

    iget-object v3, v3, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v3, v3, Lanet/channel/statist/RequestStatistic;->reqStart:J

    sub-long/2addr v1, v3

    iput-wide v1, v0, Lanet/channel/statist/RequestStatistic;->sendBeforeTime:J

    iget-object v0, p0, Lanet/channel/session/f;->a:Lanet/channel/request/Request;

    .line 172
    new-instance v1, Lanet/channel/session/g;

    invoke-direct {v1, p0}, Lanet/channel/session/g;-><init>(Lanet/channel/session/f;)V

    .line 1073
    invoke-static {v0, v1}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/RequestCb;)Lanet/channel/session/b$a;

    return-void
.end method
