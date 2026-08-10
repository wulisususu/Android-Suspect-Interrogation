.class Lcom/taobao/monitor/impl/data/n/a$a$a;
.super Ljava/lang/Object;
.source "FragmentDataCollector.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/data/n/a$a;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/data/n/a$a;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/n/a$a;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/n/a$a$a;->a:Lcom/taobao/monitor/impl/data/n/a$a;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$a$a;->a:Lcom/taobao/monitor/impl/data/n/a$a;

    .line 1
    iget-object v0, v0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$a$a;->a:Lcom/taobao/monitor/impl/data/n/a$a;

    .line 3
    iget-object v0, v0, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;)Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 9
    :cond_0
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v1, p0, Lcom/taobao/monitor/impl/data/n/a$a$a;->a:Lcom/taobao/monitor/impl/data/n/a$a;

    .line 14
    iget-object v1, v1, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v1}, Lcom/taobao/monitor/impl/data/n/a;->b(Lcom/taobao/monitor/impl/data/n/a;)J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-nez v1, :cond_2

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    iget-object v3, p0, Lcom/taobao/monitor/impl/data/n/a$a$a;->a:Lcom/taobao/monitor/impl/data/n/a$a;

    iget-object v3, v3, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v3}, Lcom/taobao/monitor/impl/data/n/a;->b(Lcom/taobao/monitor/impl/data/n/a;)J

    move-result-wide v3

    sub-long v3, v1, v3

    :goto_0
    iget-object v1, p0, Lcom/taobao/monitor/impl/data/n/a$a$a;->a:Lcom/taobao/monitor/impl/data/n/a$a;

    .line 15
    iget-object v1, v1, Lcom/taobao/monitor/impl/data/n/a$a;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v1}, Lcom/taobao/monitor/impl/data/n/a;->c(Lcom/taobao/monitor/impl/data/n/a;)J

    move-result-wide v5

    add-long/2addr v3, v5

    invoke-static {v1, v0, v3, v4}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;Landroid/view/View;J)V

    return-void
.end method
