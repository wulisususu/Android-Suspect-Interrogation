.class Lanetwork/channel/unified/c;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/RequestCb;


# instance fields
.field final synthetic a:Lanetwork/channel/unified/b;


# direct methods
.method constructor <init>(Lanetwork/channel/unified/b;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDataReceive(Lanet/channel/bytes/ByteArray;Z)V
    .locals 2

    iget-object p2, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 86
    invoke-static {p2}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object p2

    iget-object p2, p2, Lanetwork/channel/unified/j;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {p2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result p2

    if-eqz p2, :cond_0

    return-void

    :cond_0
    iget-object p2, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 89
    invoke-static {p2}, Lanetwork/channel/unified/b;->b(Lanetwork/channel/unified/b;)I

    iget-object p2, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 90
    invoke-static {p2}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object p2

    iget-object p2, p2, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    if-eqz p2, :cond_1

    iget-object p2, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 91
    invoke-static {p2}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object p2

    iget-object p2, p2, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    invoke-static {v0}, Lanetwork/channel/unified/b;->c(Lanetwork/channel/unified/b;)I

    move-result v0

    iget-object v1, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    invoke-static {v1}, Lanetwork/channel/unified/b;->d(Lanetwork/channel/unified/b;)I

    move-result v1

    invoke-interface {p2, v0, v1, p1}, Lanetwork/channel/interceptor/Callback;->onDataReceiveSize(IILanet/channel/bytes/ByteArray;)V

    :cond_1
    return-void
.end method

.method public onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    .locals 5

    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 97
    invoke-static {v0}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object v0

    iget-object v0, v0, Lanetwork/channel/unified/j;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->getAndSet(Z)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x2

    .line 100
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 101
    invoke-static {v0}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object v0

    iget-object v0, v0, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "msg"

    const-string v4, "code"

    filled-new-array {v4, v2, v3, p2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "anet.DegradeTask"

    const-string v4, "[onFinish]"

    invoke-static {v3, v4, v0, v2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 103
    invoke-static {v0}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object v0

    invoke-virtual {v0}, Lanetwork/channel/unified/j;->a()V

    .line 104
    iget-object p3, p3, Lanet/channel/statist/RequestStatistic;->isDone:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {p3, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    iget-object p3, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 105
    invoke-static {p3}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object p3

    iget-object p3, p3, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    if-eqz p3, :cond_2

    iget-object p3, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 106
    invoke-static {p3}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object p3

    iget-object p3, p3, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    new-instance v0, Lanetwork/channel/aidl/DefaultFinishEvent;

    iget-object v1, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    invoke-static {v1}, Lanetwork/channel/unified/b;->e(Lanetwork/channel/unified/b;)Lanet/channel/request/Request;

    move-result-object v1

    invoke-direct {v0, p1, p2, v1}, Lanetwork/channel/aidl/DefaultFinishEvent;-><init>(ILjava/lang/String;Lanet/channel/request/Request;)V

    invoke-interface {p3, v0}, Lanetwork/channel/interceptor/Callback;->onFinish(Lanetwork/channel/aidl/DefaultFinishEvent;)V

    :cond_2
    return-void
.end method

.method public onResponseCode(ILjava/util/Map;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 73
    invoke-static {v0}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object v0

    iget-object v0, v0, Lanetwork/channel/unified/j;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 76
    invoke-static {v0}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object v0

    invoke-virtual {v0}, Lanetwork/channel/unified/j;->a()V

    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 77
    invoke-static {v0}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object v0

    iget-object v0, v0, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v0}, Lanetwork/channel/entity/g;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p2}, Lanetwork/channel/cookie/CookieManager;->setCookie(Ljava/lang/String;Ljava/util/Map;)V

    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 78
    invoke-static {p2}, Lanet/channel/util/HttpHelper;->parseContentLength(Ljava/util/Map;)I

    move-result v1

    invoke-static {v0, v1}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;I)I

    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 79
    invoke-static {v0}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object v0

    iget-object v0, v0, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lanetwork/channel/unified/c;->a:Lanetwork/channel/unified/b;

    .line 80
    invoke-static {v0}, Lanetwork/channel/unified/b;->a(Lanetwork/channel/unified/b;)Lanetwork/channel/unified/j;

    move-result-object v0

    iget-object v0, v0, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    invoke-interface {v0, p1, p2}, Lanetwork/channel/interceptor/Callback;->onResponseCode(ILjava/util/Map;)V

    :cond_1
    return-void
.end method
