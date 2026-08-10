.class Lcom/taobao/monitor/impl/data/o/c$b;
.super Ljava/lang/Object;
.source "GCSignalSender.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/data/o/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/impl/data/o/c$a;)V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/o/c$b;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    invoke-static {}, Lcom/taobao/monitor/impl/data/o/c;->a()Lcom/taobao/monitor/impl/data/o/c$b;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-string v0, "APPLICATION_GC_DISPATCHER"

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/common/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    .line 3
    instance-of v1, v0, Lcom/taobao/monitor/impl/trace/e;

    if-eqz v1, :cond_0

    .line 4
    check-cast v0, Lcom/taobao/monitor/impl/trace/e;

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/trace/e;->a()V

    :cond_0
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "gc"

    .line 6
    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
