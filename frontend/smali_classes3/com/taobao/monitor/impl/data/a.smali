.class public Lcom/taobao/monitor/impl/data/a;
.super Ljava/lang/Object;
.source "AbstractDataCollector.java"

# interfaces
.implements Ljava/lang/Runnable;
.implements Lcom/taobao/monitor/impl/data/i$b;
.implements Lcom/taobao/monitor/impl/data/j$e;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Ljava/lang/Runnable;",
        "Lcom/taobao/monitor/impl/data/i$b;",
        "Lcom/taobao/monitor/impl/data/j$e;"
    }
.end annotation


# instance fields
.field private a:F

.field private a:I

.field private final a:Lcom/taobao/application/common/IPageListener;

.field private a:Lcom/taobao/monitor/impl/data/f;

.field private a:Lcom/taobao/monitor/impl/trace/o;

.field protected final a:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field

.field private final a:Ljava/lang/Runnable;

.field private final a:Ljava/lang/String;

.field private volatile a:Z

.field private b:Lcom/taobao/monitor/impl/data/f;

.field private b:Z

.field private c:Z

.field private d:Z

.field private final e:Z


# direct methods
.method protected constructor <init>(Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Z

    iput v0, p0, Lcom/taobao/monitor/impl/data/a;->a:I

    const/4 v1, 0x0

    iput v1, p0, Lcom/taobao/monitor/impl/data/a;->a:F

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->b:Z

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->c:Z

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->d:Z

    .line 23
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/IPageListener;

    move-result-object v1

    iput-object v1, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/application/common/IPageListener;

    .line 25
    new-instance v2, Lcom/taobao/monitor/impl/data/a$a;

    invoke-direct {v2, p0}, Lcom/taobao/monitor/impl/data/a$a;-><init>(Lcom/taobao/monitor/impl/data/a;)V

    iput-object v2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Runnable;

    .line 33
    instance-of v2, p1, Landroid/app/Activity;

    if-nez v2, :cond_1

    instance-of v3, p1, Landroidx/fragment/app/Fragment;

    if-eqz v3, :cond_0

    goto :goto_0

    .line 34
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1

    :cond_1
    :goto_0
    iput-object p1, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    iput-boolean v2, p0, Lcom/taobao/monitor/impl/data/a;->e:Z

    .line 38
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    .line 39
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v1, p1, v0, v2, v3}, Lcom/taobao/application/common/IPageListener;->onPageChanged(Ljava/lang/String;IJ)V

    const-string v0, "visibleStart"

    .line 40
    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "AbstractDataCollector"

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method private a()V
    .locals 5

    .line 38
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroidx/localbroadcastmanager/content/LocalBroadcastManager;

    move-result-object v0

    .line 39
    new-instance v1, Landroid/content/Intent;

    const-string v2, "ACTIVITY_FRAGMENT_VISIBLE_ACTION"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    const-string v3, "page_name"

    .line 40
    invoke-virtual {v1, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    .line 41
    instance-of v3, v2, Landroid/app/Activity;

    const-string v4, "type"

    if-eqz v3, :cond_0

    const-string v2, "activity"

    .line 42
    invoke-virtual {v1, v4, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0

    .line 43
    :cond_0
    instance-of v2, v2, Landroidx/fragment/app/Fragment;

    if-eqz v2, :cond_1

    const-string v2, "fragment"

    .line 44
    invoke-virtual {v1, v4, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0

    :cond_1
    const-string v2, "unknown"

    .line 46
    invoke-virtual {v1, v4, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :goto_0
    const-string v2, "status"

    const/4 v3, 0x1

    .line 48
    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 49
    invoke-virtual {v0, v1}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->sendBroadcastSync(Landroid/content/Intent;)V

    .line 50
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "doSendPageFinishedEvent:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AbstractDataCollector"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/a;->c()V

    return-void
.end method

.method private b(J)V
    .locals 4

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->c:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->d:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    .line 16
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    const/4 v1, 0x2

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    const-string v2, " visible"

    .line 17
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "AbstractDataCollector"

    invoke-static {v2, v0}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    .line 18
    invoke-virtual {v0, v2, v1, p1, p2}, Lcom/taobao/monitor/impl/trace/o;->a(Ljava/lang/Object;IJ)V

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/application/common/IPageListener;

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    .line 20
    invoke-interface {v0, v2, v1, p1, p2}, Lcom/taobao/application/common/IPageListener;->onPageChanged(Ljava/lang/String;IJ)V

    .line 21
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/a;->c()V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/data/a;->c:Z

    :cond_1
    return-void
.end method

.method private c()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/data/f;

    if-eqz v0, :cond_4

    .line 2
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/data/f;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->b:Lcom/taobao/monitor/impl/data/f;

    if-eqz v0, :cond_3

    .line 4
    :cond_0
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/data/f;

    if-eqz v0, :cond_1

    .line 6
    invoke-interface {v0}, Lcom/taobao/monitor/impl/data/f;->a()V

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->b:Lcom/taobao/monitor/impl/data/f;

    if-eqz v0, :cond_2

    .line 9
    invoke-interface {v0}, Lcom/taobao/monitor/impl/data/f;->a()V

    .line 12
    :cond_2
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/a;->a()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/data/f;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/a;->b:Lcom/taobao/monitor/impl/data/f;

    .line 16
    :cond_3
    monitor-exit p0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    :cond_4
    :goto_0
    return-void
.end method


# virtual methods
.method public a(F)V
    .locals 7

    .line 24
    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    const-string v2, "visiblePercent"

    filled-new-array {v2, v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AbstractDataCollector"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    iget v0, p0, Lcom/taobao/monitor/impl/data/a;->a:F

    sub-float v0, p1, v0

    .line 25
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const v3, 0x3d4ccccd    # 0.05f

    cmpl-float v0, v0, v3

    const v3, 0x3f4ccccd    # 0.8f

    if-gtz v0, :cond_0

    cmpl-float v0, p1, v3

    if-lez v0, :cond_3

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    .line 26
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    iget-object v4, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    .line 27
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v5

    invoke-virtual {v0, v4, p1, v5, v6}, Lcom/taobao/monitor/impl/trace/o;->a(Ljava/lang/Object;FJ)V

    .line 29
    :cond_1
    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    iget-object v4, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    filled-new-array {v2, v0, v4}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    cmpl-float v0, p1, v3

    if-lez v0, :cond_2

    .line 32
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    invoke-direct {p0, v0, v1}, Lcom/taobao/monitor/impl/data/a;->b(J)V

    .line 33
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/a;->run()V

    :cond_2
    iput p1, p0, Lcom/taobao/monitor/impl/data/a;->a:F

    :cond_3
    return-void
.end method

.method public a(IJ)V
    .locals 0

    .line 37
    invoke-virtual {p0, p1, p2, p3}, Lcom/taobao/monitor/impl/data/a;->b(IJ)V

    return-void
.end method

.method public a(J)V
    .locals 0

    .line 36
    invoke-direct {p0, p1, p2}, Lcom/taobao/monitor/impl/data/a;->b(J)V

    return-void
.end method

.method protected a(Landroid/view/View;J)V
    .locals 7

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->d:Z

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Z

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    .line 4
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    .line 5
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v3

    move-wide v5, p2

    invoke-virtual/range {v1 .. v6}, Lcom/taobao/monitor/impl/trace/o;->a(Ljava/lang/Object;JJ)V

    .line 7
    :cond_0
    new-instance p2, Lcom/taobao/monitor/impl/data/i;

    invoke-direct {p2, p1}, Lcom/taobao/monitor/impl/data/i;-><init>(Landroid/view/View;)V

    iput-object p2, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/data/f;

    .line 8
    move-object p3, p2

    check-cast p3, Lcom/taobao/monitor/impl/data/i;

    invoke-virtual {p2, p0}, Lcom/taobao/monitor/impl/data/i;->a(Lcom/taobao/monitor/impl/data/i$b;)Lcom/taobao/monitor/impl/data/i;

    move-result-object p2

    iget-object p3, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    .line 9
    invoke-virtual {p2, p3}, Lcom/taobao/monitor/impl/data/i;->a(Ljava/lang/Object;)Lcom/taobao/monitor/impl/data/i;

    move-result-object p2

    .line 10
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object p3

    invoke-virtual {p3}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/IPageLoadCalculateListener;

    move-result-object p3

    invoke-virtual {p2, p3}, Lcom/taobao/monitor/impl/data/i;->a(Lcom/taobao/application/common/IPageLoadCalculateListener;)Lcom/taobao/monitor/impl/data/i;

    move-result-object p2

    .line 11
    invoke-virtual {p2}, Lcom/taobao/monitor/impl/data/i;->b()V

    iget-object p2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    .line 14
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->inComplexPage(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_1

    .line 16
    new-instance p2, Lcom/taobao/monitor/impl/data/j;

    invoke-direct {p2, p1, p0}, Lcom/taobao/monitor/impl/data/j;-><init>(Landroid/view/View;Lcom/taobao/monitor/impl/data/j$e;)V

    iput-object p2, p0, Lcom/taobao/monitor/impl/data/a;->b:Lcom/taobao/monitor/impl/data/f;

    .line 17
    invoke-interface {p2}, Lcom/taobao/monitor/impl/data/f;->b()V

    .line 21
    :cond_1
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Runnable;

    const-wide/16 v0, 0x4e20

    invoke-virtual {p1, p2, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/application/common/IPageListener;

    iget-object p2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    .line 22
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    const/4 p3, 0x1

    invoke-interface {p1, p2, p3, v0, v1}, Lcom/taobao/application/common/IPageListener;->onPageChanged(Ljava/lang/String;IJ)V

    iput-boolean p3, p0, Lcom/taobao/monitor/impl/data/a;->a:Z

    :cond_2
    return-void
.end method

.method protected b()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    .line 1
    instance-of v0, v0, Landroid/app/Activity;

    if-eqz v0, :cond_0

    const-string v0, "ACTIVITY_USABLE_VISIBLE_DISPATCHER"

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/common/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    goto :goto_0

    :cond_0
    const-string v0, "FRAGMENT_USABLE_VISIBLE_DISPATCHER"

    .line 3
    invoke-static {v0}, Lcom/taobao/monitor/impl/common/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    .line 4
    :goto_0
    instance-of v1, v0, Lcom/taobao/monitor/impl/trace/o;

    if-eqz v1, :cond_1

    .line 5
    check-cast v0, Lcom/taobao/monitor/impl/trace/o;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    :cond_1
    return-void
.end method

.method protected b(IJ)V
    .locals 7

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->b:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->d:Z

    if-nez v0, :cond_1

    const-string v0, "usable"

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    .line 7
    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AbstractDataCollector"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    const-string v2, " usable"

    .line 8
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    filled-new-array {v0, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    .line 9
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/monitor/impl/trace/o;

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    const/4 v3, 0x2

    move v4, p1

    move-wide v5, p2

    .line 10
    invoke-virtual/range {v1 .. v6}, Lcom/taobao/monitor/impl/trace/o;->a(Ljava/lang/Object;IIJ)V

    .line 12
    :cond_0
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/a;->c()V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/a;->a:Lcom/taobao/application/common/IPageListener;

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/String;

    const/4 v1, 0x3

    .line 13
    invoke-interface {p1, v0, v1, p2, p3}, Lcom/taobao/application/common/IPageListener;->onPageChanged(Ljava/lang/String;IJ)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/data/a;->b:Z

    :cond_1
    return-void
.end method

.method protected d()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/a;->b:Lcom/taobao/monitor/impl/data/f;

    .line 1
    instance-of v1, v0, Lcom/taobao/monitor/impl/data/j;

    if-eqz v1, :cond_0

    .line 2
    check-cast v0, Lcom/taobao/monitor/impl/data/j;

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/data/j;->c()V

    :cond_0
    return-void
.end method

.method protected e()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/a;->c()V

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->e:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/a;->d:Z

    return-void
.end method

.method public run()V
    .locals 4

    iget v0, p0, Lcom/taobao/monitor/impl/data/a;->a:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/taobao/monitor/impl/data/a;->a:I

    const/4 v2, 0x2

    if-le v0, v2, :cond_0

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p0, v1, v2, v3}, Lcom/taobao/monitor/impl/data/a;->b(IJ)V

    return-void

    .line 7
    :cond_0
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 8
    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-wide/16 v1, 0x10

    .line 9
    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
