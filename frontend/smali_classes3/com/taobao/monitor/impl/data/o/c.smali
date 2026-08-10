.class Lcom/taobao/monitor/impl/data/o/c;
.super Ljava/lang/Object;
.source "GCSignalSender.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/data/o/c$b;
    }
.end annotation


# static fields
.field private static a:Lcom/taobao/monitor/impl/data/o/c$b;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/data/o/c$b;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/monitor/impl/data/o/c$b;-><init>(Lcom/taobao/monitor/impl/data/o/c$a;)V

    sput-object v0, Lcom/taobao/monitor/impl/data/o/c;->a:Lcom/taobao/monitor/impl/data/o/c$b;

    return-void
.end method

.method static synthetic a()Lcom/taobao/monitor/impl/data/o/c$b;
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/data/o/c;->a:Lcom/taobao/monitor/impl/data/o/c$b;

    return-object v0
.end method

.method static a()V
    .locals 2

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    sget-object v1, Lcom/taobao/monitor/impl/data/o/c;->a:Lcom/taobao/monitor/impl/data/o/c$b;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
