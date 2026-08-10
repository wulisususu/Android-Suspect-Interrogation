.class public Lanetwork/channel/unified/b;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanetwork/channel/unified/IUnifiedTask;


# instance fields
.field volatile a:Lanet/channel/request/Cancelable;

.field private volatile b:Z

.field private c:Lanetwork/channel/unified/j;

.field private d:I

.field private e:I

.field private f:Lanet/channel/request/Request;


# direct methods
.method public constructor <init>(Lanetwork/channel/unified/j;)V
    .locals 2

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanetwork/channel/unified/b;->b:Z

    const/4 v1, 0x0

    iput-object v1, p0, Lanetwork/channel/unified/b;->a:Lanet/channel/request/Cancelable;

    iput v0, p0, Lanetwork/channel/unified/b;->d:I

    iput v0, p0, Lanetwork/channel/unified/b;->e:I

    iput-object p1, p0, Lanetwork/channel/unified/b;->c:Lanetwork/channel/unified/j;

    .line 37
    iget-object p1, p1, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {p1}, Lanetwork/channel/entity/g;->a()Lanet/channel/request/Request;

    move-result-object p1

    iput-object p1, p0, Lanetwork/channel/unified/b;->f:Lanet/channel/request/Request;

    return-void
.end method

.method static synthetic a(Lanetwork/channel/unified/b;I)I
    .locals 0

    .line 26
    iput p1, p0, Lanetwork/channel/unified/b;->d:I

    return p1
.end method

.method static synthetic a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;
    .locals 0

    .line 26
    iget-object p0, p0, Lanetwork/channel/unified/b;->c:Lanetwork/channel/unified/j;

    return-object p0
.end method

.method static synthetic b(Lanetwork/channel/unified/b;)I
    .locals 2

    .line 26
    iget v0, p0, Lanetwork/channel/unified/b;->e:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lanetwork/channel/unified/b;->e:I

    return v0
.end method

.method static synthetic c(Lanetwork/channel/unified/b;)I
    .locals 0

    .line 26
    iget p0, p0, Lanetwork/channel/unified/b;->e:I

    return p0
.end method

.method static synthetic d(Lanetwork/channel/unified/b;)I
    .locals 0

    .line 26
    iget p0, p0, Lanetwork/channel/unified/b;->d:I

    return p0
.end method

.method static synthetic e(Lanetwork/channel/unified/b;)Lanet/channel/request/Request;
    .locals 0

    .line 26
    iget-object p0, p0, Lanetwork/channel/unified/b;->f:Lanet/channel/request/Request;

    return-object p0
.end method


# virtual methods
.method public cancel()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanetwork/channel/unified/b;->b:Z

    iget-object v0, p0, Lanetwork/channel/unified/b;->a:Lanet/channel/request/Cancelable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lanetwork/channel/unified/b;->a:Lanet/channel/request/Cancelable;

    .line 44
    invoke-interface {v0}, Lanet/channel/request/Cancelable;->cancel()V

    :cond_0
    return-void
.end method

.method public run()V
    .locals 5

    iget-boolean v0, p0, Lanetwork/channel/unified/b;->b:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanetwork/channel/unified/b;->c:Lanetwork/channel/unified/j;

    .line 53
    iget-object v0, v0, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v0}, Lanetwork/channel/entity/g;->i()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lanetwork/channel/unified/b;->c:Lanetwork/channel/unified/j;

    .line 54
    iget-object v0, v0, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v0}, Lanetwork/channel/entity/g;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lanetwork/channel/cookie/CookieManager;->getCookie(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 55
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lanetwork/channel/unified/b;->f:Lanet/channel/request/Request;

    .line 56
    invoke-virtual {v1}, Lanet/channel/request/Request;->newBuilder()Lanet/channel/request/Request$Builder;

    move-result-object v1

    iget-object v2, p0, Lanetwork/channel/unified/b;->f:Lanet/channel/request/Request;

    .line 57
    invoke-virtual {v2}, Lanet/channel/request/Request;->getHeaders()Ljava/util/Map;

    move-result-object v2

    const-string v3, "Cookie"

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 58
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    const-string v4, "; "

    .line 59
    invoke-static {v2, v4, v0}, Lanet/channel/util/StringUtils;->concatString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 61
    :cond_1
    invoke-virtual {v1, v3, v0}, Lanet/channel/request/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lanet/channel/request/Request$Builder;

    .line 62
    invoke-virtual {v1}, Lanet/channel/request/Request$Builder;->build()Lanet/channel/request/Request;

    move-result-object v0

    iput-object v0, p0, Lanetwork/channel/unified/b;->f:Lanet/channel/request/Request;

    :cond_2
    iget-object v0, p0, Lanetwork/channel/unified/b;->f:Lanet/channel/request/Request;

    .line 67
    iget-object v0, v0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    const/4 v1, 0x2

    iput v1, v0, Lanet/channel/statist/RequestStatistic;->degraded:I

    iget-object v0, p0, Lanetwork/channel/unified/b;->f:Lanet/channel/request/Request;

    .line 69
    iget-object v0, v0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-object v3, p0, Lanetwork/channel/unified/b;->f:Lanet/channel/request/Request;

    iget-object v3, v3, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v3, v3, Lanet/channel/statist/RequestStatistic;->reqStart:J

    sub-long/2addr v1, v3

    iput-wide v1, v0, Lanet/channel/statist/RequestStatistic;->sendBeforeTime:J

    iget-object v0, p0, Lanetwork/channel/unified/b;->f:Lanet/channel/request/Request;

    .line 70
    new-instance v1, Lanetwork/channel/unified/c;

    invoke-direct {v1, p0}, Lanetwork/channel/unified/c;-><init>(Lanetwork/channel/unified/b;)V

    .line 1073
    invoke-static {v0, v1}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/RequestCb;)Lanet/channel/session/b$a;

    return-void
.end method
