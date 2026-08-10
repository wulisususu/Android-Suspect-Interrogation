.class public Lcom/taobao/monitor/impl/data/p/a;
.super Ljava/lang/Object;
.source "PhenixLifeCycleImpl.java"

# interfaces
.implements Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;


# instance fields
.field private a:Lcom/taobao/monitor/impl/trace/m;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    .line 5
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/p/a;->a()V

    return-void
.end method

.method private a()V
    .locals 2

    const-string v0, "IMAGE_STAGE_DISPATCHER"

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    .line 2
    instance-of v1, v0, Lcom/taobao/monitor/impl/trace/m;

    if-eqz v1, :cond_0

    .line 3
    check-cast v0, Lcom/taobao/monitor/impl/trace/m;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    :cond_0
    return-void
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
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

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    const/4 v1, 0x3

    .line 2
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/trace/m;->a(I)V

    .line 4
    :cond_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0, p3}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    const-string p3, "procedureName"

    const-string v1, "ImageLib"

    .line 5
    invoke-virtual {v0, p3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "stage"

    const-string v1, "onCancel"

    .line 6
    invoke-virtual {v0, p3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "requestId"

    .line 7
    invoke-virtual {v0, p3, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "requestUrl"

    .line 8
    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 9
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "image"

    invoke-static {p2, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public onError(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
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

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    const/4 v1, 0x2

    .line 2
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/trace/m;->a(I)V

    .line 5
    :cond_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0, p3}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    const-string p3, "procedureName"

    const-string v1, "ImageLib"

    .line 6
    invoke-virtual {v0, p3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "stage"

    const-string v1, "onError"

    .line 7
    invoke-virtual {v0, p3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "requestId"

    .line 8
    invoke-virtual {v0, p3, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "requestUrl"

    .line 9
    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 10
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "image"

    invoke-static {p2, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public onEvent(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 4
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

    const-string v0, "requestUrl"

    if-eqz p3, :cond_0

    .line 1
    invoke-interface {p3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    const-string v2, ""

    invoke-static {v1, v2}, Lcom/taobao/monitor/impl/util/e;->a(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 4
    :goto_0
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2, p3}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    const-string p3, "procedureName"

    const-string v3, "ImageLib"

    .line 5
    invoke-virtual {v2, p3, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "stage"

    .line 6
    invoke-virtual {v2, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p2, "requestId"

    .line 7
    invoke-virtual {v2, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 8
    invoke-virtual {v2, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 9
    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "image"

    invoke-static {p2, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public onFinished(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
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

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    const/4 v1, 0x1

    .line 2
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/trace/m;->a(I)V

    .line 4
    :cond_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0, p3}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    const-string p3, "procedureName"

    const-string v1, "ImageLib"

    .line 5
    invoke-virtual {v0, p3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "stage"

    const-string v1, "onFinished"

    .line 6
    invoke-virtual {v0, p3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "requestId"

    .line 7
    invoke-virtual {v0, p3, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "requestUrl"

    .line 8
    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 9
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "image"

    invoke-static {p2, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public onRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
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

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/p/a;->a:Lcom/taobao/monitor/impl/trace/m;

    const/4 v1, 0x0

    .line 2
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/trace/m;->a(I)V

    .line 6
    :cond_0
    :try_start_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0, p3}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    const-string p3, "procedureName"

    const-string v1, "ImageLib"

    .line 7
    invoke-virtual {v0, p3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "stage"

    const-string v1, "onRequest"

    .line 8
    invoke-virtual {v0, p3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "requestId"

    .line 9
    invoke-virtual {v0, p3, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "requestUrl"

    .line 10
    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string p1, "image"

    .line 11
    :try_start_1
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {p1, p2}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 13
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method
