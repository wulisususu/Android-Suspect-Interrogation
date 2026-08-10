.class Lcom/taobao/monitor/impl/data/j$b;
.super Ljava/lang/Object;
.source "SimplePageLoadCalculate.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/data/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/data/j;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/j;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/j$b;->a:Lcom/taobao/monitor/impl/data/j;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$b;->a:Lcom/taobao/monitor/impl/data/j;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/j;->b(Lcom/taobao/monitor/impl/data/j;)I

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$b;->a:Lcom/taobao/monitor/impl/data/j;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;)I

    move-result v0

    const/4 v1, 0x2

    if-le v0, v1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$b;->a:Lcom/taobao/monitor/impl/data/j;

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v0, v1, v2}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;J)J

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$b;->a:Lcom/taobao/monitor/impl/data/j;

    .line 6
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;)Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$b;->a:Lcom/taobao/monitor/impl/data/j;

    .line 7
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v1, 0x10

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
