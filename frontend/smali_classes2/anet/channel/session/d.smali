.class public Lanet/channel/session/d;
.super Lanet/channel/Session;
.source "Taobao"


# instance fields
.field private w:Ljavax/net/ssl/SSLSocketFactory;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lanet/channel/entity/a;)V
    .locals 0

    .line 38
    invoke-direct {p0, p1, p2}, Lanet/channel/Session;-><init>(Landroid/content/Context;Lanet/channel/entity/a;)V

    .line 39
    iget-object p1, p0, Lanet/channel/session/d;->k:Lanet/channel/strategy/IConnStrategy;

    if-nez p1, :cond_1

    .line 40
    iget-object p1, p0, Lanet/channel/session/d;->c:Ljava/lang/String;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lanet/channel/session/d;->c:Ljava/lang/String;

    const-string p2, "https"

    invoke-virtual {p1, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    sget-object p1, Lanet/channel/entity/ConnType;->HTTPS:Lanet/channel/entity/ConnType;

    goto :goto_0

    :cond_0
    sget-object p1, Lanet/channel/entity/ConnType;->HTTP:Lanet/channel/entity/ConnType;

    :goto_0
    iput-object p1, p0, Lanet/channel/session/d;->j:Lanet/channel/entity/ConnType;

    goto :goto_1

    .line 41
    :cond_1
    invoke-static {}, Lanet/channel/AwcnConfig;->isHttpsSniEnable()Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lanet/channel/session/d;->j:Lanet/channel/entity/ConnType;

    sget-object p2, Lanet/channel/entity/ConnType;->HTTPS:Lanet/channel/entity/ConnType;

    invoke-virtual {p1, p2}, Lanet/channel/entity/ConnType;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 42
    new-instance p1, Lanet/channel/util/j;

    iget-object p2, p0, Lanet/channel/session/d;->d:Ljava/lang/String;

    invoke-direct {p1, p2}, Lanet/channel/util/j;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lanet/channel/session/d;->w:Ljavax/net/ssl/SSLSocketFactory;

    :cond_2
    :goto_1
    return-void
.end method

.method static synthetic a(Lanet/channel/session/d;ILanet/channel/entity/b;)V
    .locals 0

    .line 33
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/d;->notifyStatus(ILanet/channel/entity/b;)V

    return-void
.end method

.method static synthetic a(Lanet/channel/session/d;Lanet/channel/request/Request;I)V
    .locals 0

    .line 33
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/d;->handleResponseCode(Lanet/channel/request/Request;I)V

    return-void
.end method

.method static synthetic a(Lanet/channel/session/d;Lanet/channel/request/Request;Ljava/util/Map;)V
    .locals 0

    .line 33
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/d;->handleResponseHeaders(Lanet/channel/request/Request;Ljava/util/Map;)V

    return-void
.end method

.method static synthetic b(Lanet/channel/session/d;ILanet/channel/entity/b;)V
    .locals 0

    .line 33
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/d;->handleCallbacks(ILanet/channel/entity/b;)V

    return-void
.end method

.method static synthetic c(Lanet/channel/session/d;ILanet/channel/entity/b;)V
    .locals 0

    .line 33
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/d;->handleCallbacks(ILanet/channel/entity/b;)V

    return-void
.end method


# virtual methods
.method public close()V
    .locals 2

    const/4 v0, 0x6

    const/4 v1, 0x0

    .line 103
    invoke-virtual {p0, v0, v1}, Lanet/channel/session/d;->notifyStatus(ILanet/channel/entity/b;)V

    return-void
.end method

.method public close(Z)V
    .locals 0

    const/4 p1, 0x0

    .line 108
    iput-boolean p1, p0, Lanet/channel/session/d;->t:Z

    .line 109
    invoke-virtual {p0}, Lanet/channel/session/d;->close()V

    return-void
.end method

.method public connect()V
    .locals 9

    const-string v0, "awcn.HttpSession"

    const/4 v1, 0x0

    const/4 v2, 0x0

    .line 55
    :try_start_0
    iget-object v3, p0, Lanet/channel/session/d;->k:Lanet/channel/strategy/IConnStrategy;

    const/4 v4, 0x4

    const/4 v5, 0x1

    if-eqz v3, :cond_0

    iget-object v3, p0, Lanet/channel/session/d;->k:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v3}, Lanet/channel/strategy/IConnStrategy;->getIpSource()I

    move-result v3

    if-ne v3, v5, :cond_0

    .line 56
    new-instance v3, Lanet/channel/entity/b;

    invoke-direct {v3, v5}, Lanet/channel/entity/b;-><init>(I)V

    invoke-virtual {p0, v4, v3}, Lanet/channel/session/d;->notifyStatus(ILanet/channel/entity/b;)V

    return-void

    .line 60
    :cond_0
    new-instance v3, Lanet/channel/request/Request$Builder;

    invoke-direct {v3}, Lanet/channel/request/Request$Builder;-><init>()V

    iget-object v6, p0, Lanet/channel/session/d;->c:Ljava/lang/String;

    .line 61
    invoke-virtual {v3, v6}, Lanet/channel/request/Request$Builder;->setUrl(Ljava/lang/String;)Lanet/channel/request/Request$Builder;

    move-result-object v3

    iget-object v6, p0, Lanet/channel/session/d;->p:Ljava/lang/String;

    .line 62
    invoke-virtual {v3, v6}, Lanet/channel/request/Request$Builder;->setSeq(Ljava/lang/String;)Lanet/channel/request/Request$Builder;

    move-result-object v3

    iget v6, p0, Lanet/channel/session/d;->r:I

    int-to-float v6, v6

    .line 63
    invoke-static {}, Lanet/channel/util/Utils;->getNetworkTimeFactor()F

    move-result v7

    mul-float/2addr v6, v7

    float-to-int v6, v6

    invoke-virtual {v3, v6}, Lanet/channel/request/Request$Builder;->setConnectTimeout(I)Lanet/channel/request/Request$Builder;

    move-result-object v3

    iget v6, p0, Lanet/channel/session/d;->s:I

    int-to-float v6, v6

    .line 64
    invoke-static {}, Lanet/channel/util/Utils;->getNetworkTimeFactor()F

    move-result v7

    mul-float/2addr v6, v7

    float-to-int v6, v6

    invoke-virtual {v3, v6}, Lanet/channel/request/Request$Builder;->setReadTimeout(I)Lanet/channel/request/Request$Builder;

    move-result-object v3

    .line 65
    invoke-virtual {v3, v2}, Lanet/channel/request/Request$Builder;->setRedirectEnable(Z)Lanet/channel/request/Request$Builder;

    move-result-object v3

    iget-object v6, p0, Lanet/channel/session/d;->w:Ljavax/net/ssl/SSLSocketFactory;

    if-eqz v6, :cond_1

    .line 67
    invoke-virtual {v3, v6}, Lanet/channel/request/Request$Builder;->setSslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)Lanet/channel/request/Request$Builder;

    .line 69
    :cond_1
    iget-boolean v6, p0, Lanet/channel/session/d;->m:Z

    if-eqz v6, :cond_2

    const-string v6, "Host"

    .line 70
    iget-object v7, p0, Lanet/channel/session/d;->e:Ljava/lang/String;

    invoke-virtual {v3, v6, v7}, Lanet/channel/request/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lanet/channel/request/Request$Builder;

    .line 74
    :cond_2
    invoke-static {}, Lanet/channel/util/c;->a()Z

    move-result v6

    if-eqz v6, :cond_3

    iget-object v6, p0, Lanet/channel/session/d;->e:Ljava/lang/String;

    invoke-static {v6}, Lanet/channel/strategy/utils/c;->a(Ljava/lang/String;)Z

    move-result v6
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v6, :cond_3

    .line 76
    :try_start_1
    iget-object v6, p0, Lanet/channel/session/d;->e:Ljava/lang/String;

    invoke-static {v6}, Lanet/channel/util/c;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, p0, Lanet/channel/session/d;->f:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :cond_3
    :try_start_2
    const-string v6, "HttpSession connect"

    const/4 v7, 0x6

    new-array v7, v7, [Ljava/lang/Object;

    const-string v8, "host"

    aput-object v8, v7, v2

    .line 81
    iget-object v8, p0, Lanet/channel/session/d;->c:Ljava/lang/String;

    aput-object v8, v7, v5

    const-string v5, "ip"

    const/4 v8, 0x2

    aput-object v5, v7, v8

    iget-object v5, p0, Lanet/channel/session/d;->f:Ljava/lang/String;

    const/4 v8, 0x3

    aput-object v5, v7, v8

    const-string v5, "port"

    aput-object v5, v7, v4

    iget v4, p0, Lanet/channel/session/d;->g:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/4 v5, 0x5

    aput-object v4, v7, v5

    invoke-static {v0, v6, v1, v7}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 82
    invoke-virtual {v3}, Lanet/channel/request/Request$Builder;->build()Lanet/channel/request/Request;

    move-result-object v3

    .line 83
    iget-object v4, p0, Lanet/channel/session/d;->f:Ljava/lang/String;

    iget v5, p0, Lanet/channel/session/d;->g:I

    invoke-virtual {v3, v4, v5}, Lanet/channel/request/Request;->setDnsOptimize(Ljava/lang/String;I)V

    .line 84
    new-instance v4, Lanet/channel/session/e;

    invoke-direct {v4, p0, v3}, Lanet/channel/session/e;-><init>(Lanet/channel/session/d;Lanet/channel/request/Request;)V

    sget v3, Lanet/channel/thread/ThreadPoolExecutorFactory$Priority;->LOW:I

    invoke-static {v4, v3}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitPriorityTask(Ljava/lang/Runnable;I)Ljava/util/concurrent/Future;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v3

    const-string v4, "HTTP connect fail."

    new-array v2, v2, [Ljava/lang/Object;

    .line 97
    invoke-static {v0, v4, v1, v3, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method

.method protected getRecvTimeOutRunnable()Ljava/lang/Runnable;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public isAvailable()Z
    .locals 2

    .line 48
    iget v0, p0, Lanet/channel/session/d;->n:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public request(Lanet/channel/request/Request;Lanet/channel/RequestCb;)Lanet/channel/request/Cancelable;
    .locals 7

    .line 119
    sget-object v0, Lanet/channel/request/b;->NULL:Lanet/channel/request/b;

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    .line 121
    iget-object v2, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    goto :goto_0

    :cond_0
    new-instance v2, Lanet/channel/statist/RequestStatistic;

    iget-object v3, p0, Lanet/channel/session/d;->d:Ljava/lang/String;

    invoke-direct {v2, v3, v1}, Lanet/channel/statist/RequestStatistic;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 122
    :goto_0
    iget-object v3, p0, Lanet/channel/session/d;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v2, v3}, Lanet/channel/statist/RequestStatistic;->setConnType(Lanet/channel/entity/ConnType;)V

    .line 123
    iget-wide v3, v2, Lanet/channel/statist/RequestStatistic;->start:J

    const-wide/16 v5, 0x0

    cmp-long v3, v3, v5

    if-nez v3, :cond_1

    .line 124
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iput-wide v3, v2, Lanet/channel/statist/RequestStatistic;->reqStart:J

    iput-wide v3, v2, Lanet/channel/statist/RequestStatistic;->start:J

    :cond_1
    if-eqz p1, :cond_a

    if-nez p2, :cond_2

    goto/16 :goto_3

    .line 135
    :cond_2
    :try_start_0
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v3

    if-nez v3, :cond_3

    iget-object v3, p0, Lanet/channel/session/d;->w:Ljavax/net/ssl/SSLSocketFactory;

    if-eqz v3, :cond_3

    .line 136
    invoke-virtual {p1}, Lanet/channel/request/Request;->newBuilder()Lanet/channel/request/Request$Builder;

    move-result-object v1

    iget-object v3, p0, Lanet/channel/session/d;->w:Ljavax/net/ssl/SSLSocketFactory;

    invoke-virtual {v1, v3}, Lanet/channel/request/Request$Builder;->setSslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)Lanet/channel/request/Request$Builder;

    move-result-object v1

    .line 138
    :cond_3
    iget-boolean v3, p0, Lanet/channel/session/d;->m:Z

    if-eqz v3, :cond_5

    if-nez v1, :cond_4

    .line 140
    invoke-virtual {p1}, Lanet/channel/request/Request;->newBuilder()Lanet/channel/request/Request$Builder;

    move-result-object v1

    :cond_4
    const-string v3, "Host"

    .line 142
    iget-object v4, p0, Lanet/channel/session/d;->e:Ljava/lang/String;

    invoke-virtual {v1, v3, v4}, Lanet/channel/request/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lanet/channel/request/Request$Builder;

    :cond_5
    if-eqz v1, :cond_6

    .line 144
    invoke-virtual {v1}, Lanet/channel/request/Request$Builder;->build()Lanet/channel/request/Request;

    move-result-object p1

    .line 146
    :cond_6
    iget-object v1, p0, Lanet/channel/session/d;->f:Ljava/lang/String;

    if-nez v1, :cond_7

    .line 147
    invoke-virtual {p1}, Lanet/channel/request/Request;->getHttpUrl()Lanet/channel/util/HttpUrl;

    move-result-object v1

    .line 148
    invoke-virtual {v1}, Lanet/channel/util/HttpUrl;->host()Ljava/lang/String;

    move-result-object v1

    .line 150
    invoke-static {}, Lanet/channel/util/c;->a()Z

    move-result v3

    if-eqz v3, :cond_7

    invoke-static {v1}, Lanet/channel/strategy/utils/c;->a(Ljava/lang/String;)Z

    move-result v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v3, :cond_7

    .line 152
    :try_start_1
    invoke-static {v1}, Lanet/channel/util/c;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lanet/channel/session/d;->f:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 157
    :catch_0
    :cond_7
    :try_start_2
    iget-object v1, p0, Lanet/channel/session/d;->f:Ljava/lang/String;

    iget v3, p0, Lanet/channel/session/d;->g:I

    invoke-virtual {p1, v1, v3}, Lanet/channel/request/Request;->setDnsOptimize(Ljava/lang/String;I)V

    .line 158
    iget-object v1, p0, Lanet/channel/session/d;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v1}, Lanet/channel/entity/ConnType;->isSSL()Z

    move-result v1

    invoke-virtual {p1, v1}, Lanet/channel/request/Request;->setUrlScheme(Z)V

    .line 159
    iget-object v1, p0, Lanet/channel/session/d;->k:Lanet/channel/strategy/IConnStrategy;

    if-eqz v1, :cond_8

    .line 160
    iget-object v1, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v3, p0, Lanet/channel/session/d;->k:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v3}, Lanet/channel/strategy/IConnStrategy;->getIpSource()I

    move-result v3

    iget-object v4, p0, Lanet/channel/session/d;->k:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v4}, Lanet/channel/strategy/IConnStrategy;->getIpType()I

    move-result v4

    invoke-virtual {v1, v3, v4}, Lanet/channel/statist/RequestStatistic;->setIpInfo(II)V

    goto :goto_1

    .line 162
    :cond_8
    iget-object v1, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    const/4 v3, 0x1

    invoke-virtual {v1, v3, v3}, Lanet/channel/statist/RequestStatistic;->setIpInfo(II)V

    .line 164
    :goto_1
    iget-object v1, p1, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v3, p0, Lanet/channel/session/d;->l:Ljava/lang/String;

    iput-object v3, v1, Lanet/channel/statist/RequestStatistic;->unit:Ljava/lang/String;

    .line 167
    new-instance v1, Lanet/channel/request/b;

    new-instance v3, Lanet/channel/session/f;

    invoke-direct {v3, p0, p1, p2, v2}, Lanet/channel/session/f;-><init>(Lanet/channel/session/d;Lanet/channel/request/Request;Lanet/channel/RequestCb;Lanet/channel/statist/RequestStatistic;)V

    .line 199
    invoke-static {p1}, Lanet/channel/util/h;->a(Lanet/channel/request/Request;)I

    move-result v4

    .line 167
    invoke-static {v3, v4}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitPriorityTask(Ljava/lang/Runnable;I)Ljava/util/concurrent/Future;

    move-result-object v3

    .line 199
    invoke-virtual {p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v1, v3, p1}, Lanet/channel/request/b;-><init>(Ljava/util/concurrent/Future;Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object v0, v1

    goto :goto_2

    :catchall_0
    move-exception p1

    if-eqz p2, :cond_9

    .line 202
    invoke-virtual {p1}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object p1

    const/16 v1, -0x65

    invoke-static {v1, p1}, Lanet/channel/util/ErrorConstant;->formatMsg(ILjava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, v1, p1, v2}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    :cond_9
    :goto_2
    return-object v0

    :cond_a
    :goto_3
    if-eqz p2, :cond_b

    const/16 p1, -0x66

    .line 129
    invoke-static {p1}, Lanet/channel/util/ErrorConstant;->getErrMsg(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {p2, p1, v1, v2}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    :cond_b
    return-object v0
.end method
