.class public Lcom/taobao/monitor/impl/data/n/a;
.super Lcom/taobao/monitor/impl/data/a;
.source "FragmentDataCollector.java"

# interfaces
.implements Lcom/taobao/monitor/impl/data/n/b$a;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/taobao/monitor/impl/data/a<",
        "Landroidx/fragment/app/Fragment;",
        ">;",
        "Lcom/taobao/monitor/impl/data/n/b$a;"
    }
.end annotation


# instance fields
.field private a:J

.field private final a:Landroid/app/Activity;

.field private a:Lcom/taobao/monitor/impl/trace/l;

.field private b:J

.field private b:Ljava/lang/Runnable;

.field private c:J

.field private c:Ljava/lang/Runnable;

.field private f:Z


# direct methods
.method constructor <init>(Landroid/app/Activity;Landroidx/fragment/app/Fragment;)V
    .locals 2

    .line 1
    invoke-direct {p0, p2}, Lcom/taobao/monitor/impl/data/a;-><init>(Ljava/lang/Object;)V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:J

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->b:J

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->c:J

    const/4 p2, 0x1

    iput-boolean p2, p0, Lcom/taobao/monitor/impl/data/n/a;->f:Z

    .line 7
    new-instance p2, Lcom/taobao/monitor/impl/data/n/a$a;

    invoke-direct {p2, p0}, Lcom/taobao/monitor/impl/data/n/a$a;-><init>(Lcom/taobao/monitor/impl/data/n/a;)V

    iput-object p2, p0, Lcom/taobao/monitor/impl/data/n/a;->b:Ljava/lang/Runnable;

    .line 47
    new-instance p2, Lcom/taobao/monitor/impl/data/n/a$b;

    invoke-direct {p2, p0}, Lcom/taobao/monitor/impl/data/n/a$b;-><init>(Lcom/taobao/monitor/impl/data/n/a;)V

    iput-object p2, p0, Lcom/taobao/monitor/impl/data/n/a;->c:Ljava/lang/Runnable;

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Landroid/app/Activity;

    .line 77
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/n/a;->b()V

    return-void
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/n/a;)J
    .locals 2

    .line 2
    iget-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->b:J

    return-wide v0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/n/a;J)J
    .locals 0

    .line 6
    iput-wide p1, p0, Lcom/taobao/monitor/impl/data/n/a;->a:J

    return-wide p1
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/n/a;)Landroid/app/Activity;
    .locals 0

    .line 5
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Landroid/app/Activity;

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Object;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Runnable;
    .locals 0

    .line 3
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/n/a;->b:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/n/a;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    .line 4
    iput-object p1, p0, Lcom/taobao/monitor/impl/data/n/a;->b:Ljava/lang/Runnable;

    return-object p1
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/n/a;Landroid/view/View;J)V
    .locals 0

    .line 7
    invoke-virtual {p0, p1, p2, p3}, Lcom/taobao/monitor/impl/data/a;->a(Landroid/view/View;J)V

    return-void
.end method

.method static synthetic b(Lcom/taobao/monitor/impl/data/n/a;)J
    .locals 2

    .line 2
    iget-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:J

    return-wide v0
.end method

.method static synthetic b(Lcom/taobao/monitor/impl/data/n/a;J)J
    .locals 0

    .line 3
    iput-wide p1, p0, Lcom/taobao/monitor/impl/data/n/a;->c:J

    return-wide p1
.end method

.method static synthetic b(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Object;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic b(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Runnable;
    .locals 0

    .line 4
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/n/a;->c:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic b(Lcom/taobao/monitor/impl/data/n/a;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    .line 5
    iput-object p1, p0, Lcom/taobao/monitor/impl/data/n/a;->c:Ljava/lang/Runnable;

    return-object p1
.end method

.method static synthetic c(Lcom/taobao/monitor/impl/data/n/a;)J
    .locals 2

    .line 1
    iget-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->c:J

    return-wide v0
.end method

.method static synthetic c(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Object;
    .locals 0

    .line 2
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic d(Lcom/taobao/monitor/impl/data/n/a;)Ljava/lang/Object;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/a;->a:Ljava/lang/Object;

    return-object p0
.end method


# virtual methods
.method public a(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 8
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 9
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->l(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/a;->c:Ljava/lang/Runnable;

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    .line 13
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object p1

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/n/a;->c:Ljava/lang/Runnable;

    invoke-virtual {p1, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->c:Ljava/lang/Runnable;

    :cond_1
    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/a;->b:Ljava/lang/Runnable;

    if-eqz p1, :cond_2

    .line 18
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object p1

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/n/a;->b:Ljava/lang/Runnable;

    invoke-virtual {p1, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->b:Ljava/lang/Runnable;

    .line 21
    :cond_2
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/a;->e()V

    return-void
.end method

.method protected b()V
    .locals 2

    .line 6
    invoke-super {p0}, Lcom/taobao/monitor/impl/data/a;->b()V

    const-string v0, "FRAGMENT_LIFECYCLE_DISPATCHER"

    .line 7
    invoke-static {v0}, Lcom/taobao/monitor/impl/common/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    .line 8
    instance-of v1, v0, Lcom/taobao/monitor/impl/trace/l;

    if-eqz v1, :cond_0

    .line 9
    check-cast v0, Lcom/taobao/monitor/impl/trace/l;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    :cond_0
    return-void
.end method

.method public b(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 10
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 11
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->k(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/n/a;->f:Z

    if-eqz v0, :cond_3

    .line 17
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const/4 v1, 0x0

    :goto_0
    if-nez v1, :cond_1

    if-eqz v0, :cond_1

    .line 20
    const-class v2, Ljava/lang/Object;

    invoke-virtual {v0, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    :try_start_0
    const-string v2, "mMaxState"

    .line 22
    invoke-virtual {v0, v2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    .line 26
    :catch_0
    invoke-virtual {v0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_0

    :cond_1
    if-eqz v1, :cond_2

    const/4 v0, 0x1

    .line 31
    :try_start_1
    invoke-virtual {v1, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 32
    invoke-virtual {v1, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1
    :try_end_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_1

    if-eqz p1, :cond_2

    const-string v0, "STARTED"

    .line 34
    :try_start_2
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/a;->c:Ljava/lang/Runnable;

    if-eqz p1, :cond_2

    .line 35
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->b:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/a;->c:Ljava/lang/Runnable;

    .line 36
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_2
    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/data/n/a;->f:Z

    :cond_3
    return-void
.end method

.method public c(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 3
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 4
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->n(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public d(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->h(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public e(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->j(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public f(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->f(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public g(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->g(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public h(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->b(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public i(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->c(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public j(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->e(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public k(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->d(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public l(Landroidx/fragment/app/Fragment;)V
    .locals 4

    iget-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->b:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->c:J

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/taobao/monitor/impl/data/n/a;->b:J

    sub-long/2addr v0, v2

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/n/a;->c:J

    const-string v2, "stayStartedStateDuration"

    .line 3
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "onFragmentResumed"

    filled-new-array {v1, v2, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "FragmentDataCollector"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 6
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 7
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->i(Landroidx/fragment/app/Fragment;J)V

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Landroid/app/Activity;

    if-nez v0, :cond_2

    return-void

    :cond_2
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->b:Ljava/lang/Runnable;

    if-eqz v0, :cond_3

    if-eqz p1, :cond_3

    .line 12
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->inBlackList(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 13
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->b:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/a;->b:Ljava/lang/Runnable;

    .line 14
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    :cond_3
    return-void
.end method

.method public m(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->a(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public n(Landroidx/fragment/app/Fragment;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a;->a:Lcom/taobao/monitor/impl/trace/l;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/l;->m(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method
