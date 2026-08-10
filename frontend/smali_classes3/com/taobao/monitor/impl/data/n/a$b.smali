.class Lcom/taobao/monitor/impl/data/n/a$b;
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

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->c(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Landroidx/fragment/app/Fragment;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->d(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/fragment/app/Fragment;

    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->isResumed()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 4
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/impl/data/n/a$b$a;

    invoke-direct {v1, p0}, Lcom/taobao/monitor/impl/data/n/a$b$a;-><init>(Lcom/taobao/monitor/impl/data/n/a$b;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    .line 16
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->b(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Runnable;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 17
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v1}, Lcom/taobao/monitor/impl/data/n/a;->b(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 18
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v1}, Lcom/taobao/monitor/impl/data/n/a;->b(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Runnable;

    move-result-object v1

    const-wide/16 v2, 0x4b

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_1
    :goto_0
    return-void
.end method
