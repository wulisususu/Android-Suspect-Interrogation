.class public Lcom/taobao/monitor/impl/common/Global;
.super Ljava/lang/Object;
.source "Global.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/common/Global$b;
    }
.end annotation


# instance fields
.field private context:Landroid/content/Context;

.field private handler:Landroid/os/Handler;

.field private namespace:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/impl/common/Global$a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/common/Global;-><init>()V

    return-void
.end method

.method private declared-synchronized initNamespace()V
    .locals 3

    const-string v0, "ALI_APM/"

    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/impl/common/Global;->context:Landroid/content/Context;

    .line 1
    invoke-static {v1}, Lcom/ut/device/UTDevice;->getUtdid(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    const-string v2, "UTF-8"

    .line 4
    invoke-static {v1, v2}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    :try_start_2
    const-string v2, "ALI_APM/device-id/monitor/procedure"

    iput-object v2, p0, Lcom/taobao/monitor/impl/common/Global;->namespace:Ljava/lang/String;

    .line 8
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/monitor/procedure"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/common/Global;->namespace:Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public static instance()Lcom/taobao/monitor/impl/common/Global;
    .locals 1

    .line 1
    sget-object v0, Lcom/taobao/monitor/impl/common/Global$b;->a:Lcom/taobao/monitor/impl/common/Global;

    return-object v0
.end method


# virtual methods
.method public context()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/common/Global;->context:Landroid/content/Context;

    return-object v0
.end method

.method public getAsyncUiHandler()Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/common/Global;->handler:Landroid/os/Handler;

    return-object v0
.end method

.method public getNamespace()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/common/Global;->namespace:Ljava/lang/String;

    .line 1
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2
    invoke-direct {p0}, Lcom/taobao/monitor/impl/common/Global;->initNamespace()V

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/common/Global;->namespace:Ljava/lang/String;

    return-object v0
.end method

.method public handler()Landroid/os/Handler;
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/common/Global;->handler:Landroid/os/Handler;

    if-nez v0, :cond_0

    .line 2
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "APM-Monitor-Biz"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    .line 3
    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 4
    new-instance v1, Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {v1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Lcom/taobao/monitor/impl/common/Global;->handler:Landroid/os/Handler;

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/common/Global;->handler:Landroid/os/Handler;

    return-object v0
.end method

.method public setContext(Landroid/content/Context;)Lcom/taobao/monitor/impl/common/Global;
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/common/Global;->context:Landroid/content/Context;

    return-object p0
.end method

.method public setHandler(Landroid/os/Handler;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/common/Global;->handler:Landroid/os/Handler;

    return-void
.end method

.method public setNamespace(Ljava/lang/String;)Lcom/taobao/monitor/impl/common/Global;
    .locals 0

    return-object p0
.end method
