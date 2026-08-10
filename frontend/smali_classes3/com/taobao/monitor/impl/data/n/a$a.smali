.class Lcom/taobao/monitor/impl/data/n/a$a;
.super Ljava/lang/Object;
.source "FragmentDataCollector.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/data/n/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/data/n/a;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/n/a;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Landroidx/fragment/app/Fragment;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->b(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/fragment/app/Fragment;

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->getUserVisibleHint()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 4
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/impl/data/n/a$a$a;

    invoke-direct {v1, p0}, Lcom/taobao/monitor/impl/data/n/a$a$a;-><init>(Lcom/taobao/monitor/impl/data/n/a$a;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 25
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->b(Lcom/taobao/monitor/impl/data/n/a;)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 26
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v0, v1, v2}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;J)J

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 29
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Runnable;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 30
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v1}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 31
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v1}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Runnable;

    move-result-object v1

    const-wide/16 v2, 0x4b

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_2
    :goto_0
    return-void
.end method
