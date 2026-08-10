.class public Lcom/taobao/monitor/impl/data/q/a;
.super Ljava/lang/Object;
.source "NetworkLifecycleImpl.java"

# interfaces
.implements Lcom/taobao/network/lifecycle/INetworkLifecycle;
.implements Lcom/taobao/network/lifecycle/IMtopLifecycle;


# instance fields
.field private a:Lcom/taobao/monitor/impl/trace/n;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    .line 5
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/q/a;->a()V

    return-void
.end method

.method private a()V
    .locals 2

    const-string v0, "NETWORK_STAGE_DISPATCHER"

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    .line 2
    instance-of v1, v0, Lcom/taobao/monitor/impl/trace/n;

    if-eqz v1, :cond_0

    .line 3
    check-cast v0, Lcom/taobao/monitor/impl/trace/n;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    :cond_0
    return-void
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    .line 1
    invoke-static {p1}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    const/4 p2, 0x3

    .line 2
    invoke-virtual {p1, p2}, Lcom/taobao/monitor/impl/trace/n;->a(I)V

    :cond_0
    return-void
.end method

.method public onError(Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    .line 1
    invoke-static {p1}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    const/4 p2, 0x2

    .line 2
    invoke-virtual {p1, p2}, Lcom/taobao/monitor/impl/trace/n;->a(I)V

    :cond_0
    return-void
.end method

.method public onEvent(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public onFinished(Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    .line 1
    invoke-static {p1}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    const/4 p2, 0x1

    .line 2
    invoke-virtual {p1, p2}, Lcom/taobao/monitor/impl/trace/n;->a(I)V

    :cond_0
    return-void
.end method

.method public onMtopCancel(Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public onMtopError(Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public onMtopEvent(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public onMtopFinished(Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public onMtopRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public onRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    .line 1
    invoke-static {p1}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/q/a;->a:Lcom/taobao/monitor/impl/trace/n;

    const/4 p2, 0x0

    .line 2
    invoke-virtual {p1, p2}, Lcom/taobao/monitor/impl/trace/n;->a(I)V

    :cond_0
    return-void
.end method

.method public onValidRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    return-void
.end method
