.class public Lcom/taobao/monitor/impl/trace/f;
.super Lcom/taobao/monitor/impl/trace/a;
.source "ApplicationLowMemoryDispatcher.java"

# interfaces
.implements Landroid/content/ComponentCallbacks;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/trace/f$b;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/taobao/monitor/impl/trace/a<",
        "Lcom/taobao/monitor/impl/trace/f$b;",
        ">;",
        "Landroid/content/ComponentCallbacks;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/a;-><init>()V

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/content/Context;->registerComponentCallbacks(Landroid/content/ComponentCallbacks;)V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/f$a;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/impl/trace/f$a;-><init>(Lcom/taobao/monitor/impl/trace/f;)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    return-void
.end method

.method public onLowMemory()V
    .locals 2

    const-string v0, "onLowMemory"

    .line 1
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ApplicationLowMemory"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 2
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/trace/f;->a()V

    return-void
.end method
