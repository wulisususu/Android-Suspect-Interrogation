.class public Lcom/taobao/monitor/impl/data/j;
.super Ljava/lang/Object;
.source "SimplePageLoadCalculate.java"

# interfaces
.implements Lcom/taobao/monitor/impl/data/f;
.implements Landroid/view/ViewTreeObserver$OnDrawListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/data/j$e;
    }
.end annotation


# instance fields
.field private a:I

.field private a:J

.field private final a:Landroid/os/Handler;

.field private final a:Landroid/view/View;

.field private final a:Lcom/taobao/monitor/impl/data/j$e;

.field private final a:Ljava/lang/Runnable;

.field private volatile a:Z

.field private b:J

.field private final b:Ljava/lang/Runnable;

.field private volatile b:Z


# direct methods
.method public constructor <init>(Landroid/view/View;Lcom/taobao/monitor/impl/data/j$e;)V
    .locals 3

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/j;->a:Z

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/j;->b:Z

    .line 6
    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Lcom/taobao/monitor/impl/data/j;->a:Landroid/os/Handler;

    .line 8
    new-instance v1, Lcom/taobao/monitor/impl/data/j$a;

    invoke-direct {v1, p0}, Lcom/taobao/monitor/impl/data/j$a;-><init>(Lcom/taobao/monitor/impl/data/j;)V

    iput-object v1, p0, Lcom/taobao/monitor/impl/data/j;->a:Ljava/lang/Runnable;

    iput v0, p0, Lcom/taobao/monitor/impl/data/j;->a:I

    .line 22
    new-instance v0, Lcom/taobao/monitor/impl/data/j$b;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/impl/data/j$b;-><init>(Lcom/taobao/monitor/impl/data/j;)V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/j;->b:Ljava/lang/Runnable;

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/j;->a:Landroid/view/View;

    iput-object p2, p0, Lcom/taobao/monitor/impl/data/j;->a:Lcom/taobao/monitor/impl/data/j$e;

    return-void

    .line 42
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/j;)I
    .locals 0

    .line 5
    iget p0, p0, Lcom/taobao/monitor/impl/data/j;->a:I

    return p0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/j;)J
    .locals 2

    .line 2
    iget-wide v0, p0, Lcom/taobao/monitor/impl/data/j;->a:J

    return-wide v0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/j;J)J
    .locals 0

    .line 4
    iput-wide p1, p0, Lcom/taobao/monitor/impl/data/j;->b:J

    return-wide p1
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/j;)Landroid/os/Handler;
    .locals 0

    .line 6
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/j;->a:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/j;)Landroid/view/View;
    .locals 0

    .line 7
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/j;->a:Landroid/view/View;

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/j;)Lcom/taobao/monitor/impl/data/j$e;
    .locals 0

    .line 3
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/j;->a:Lcom/taobao/monitor/impl/data/j$e;

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/j;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/j;->d()V

    return-void
.end method

.method static synthetic b(Lcom/taobao/monitor/impl/data/j;)I
    .locals 2

    .line 2
    iget v0, p0, Lcom/taobao/monitor/impl/data/j;->a:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/taobao/monitor/impl/data/j;->a:I

    return v0
.end method

.method static synthetic b(Lcom/taobao/monitor/impl/data/j;)J
    .locals 2

    .line 1
    iget-wide v0, p0, Lcom/taobao/monitor/impl/data/j;->b:J

    return-wide v0
.end method

.method private d()V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/j;->b:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/j;->b:Z

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j;->a:Landroid/os/Handler;

    .line 3
    new-instance v1, Lcom/taobao/monitor/impl/data/j$d;

    invoke-direct {v1, p0}, Lcom/taobao/monitor/impl/data/j$d;-><init>(Lcom/taobao/monitor/impl/data/j;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 12
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j;->a:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/j;->a:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/j;->a:Z

    .line 10
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/j;->d()V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j;->a:Landroid/os/Handler;

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j;->b:Ljava/lang/Runnable;

    .line 11
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j;->a:Landroid/os/Handler;

    .line 3
    new-instance v1, Lcom/taobao/monitor/impl/data/j$c;

    invoke-direct {v1, p0}, Lcom/taobao/monitor/impl/data/j$c;-><init>(Lcom/taobao/monitor/impl/data/j;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 12
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j;->a:Ljava/lang/Runnable;

    const-wide/16 v2, 0xbb8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public c()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j;->a:Lcom/taobao/monitor/impl/data/j$e;

    iget-wide v1, p0, Lcom/taobao/monitor/impl/data/j;->a:J

    .line 1
    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/impl/data/j$e;->a(J)V

    iget-wide v0, p0, Lcom/taobao/monitor/impl/data/j;->b:J

    iget-wide v2, p0, Lcom/taobao/monitor/impl/data/j;->a:J

    cmp-long v2, v0, v2

    if-lez v2, :cond_0

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/j;->a:Lcom/taobao/monitor/impl/data/j$e;

    const/4 v3, 0x4

    .line 3
    invoke-interface {v2, v3, v0, v1}, Lcom/taobao/monitor/impl/data/j$e;->a(IJ)V

    .line 4
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/j;->a()V

    :cond_0
    return-void
.end method

.method public onDraw()V
    .locals 4

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/j;->a:J

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/monitor/impl/data/j;->a:I

    .line 4
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j;->a:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 5
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j;->a:Ljava/lang/Runnable;

    const-wide/16 v2, 0xbb8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j;->a:Landroid/os/Handler;

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j;->b:Ljava/lang/Runnable;

    .line 6
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j;->a:Landroid/os/Handler;

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j;->b:Ljava/lang/Runnable;

    const-wide/16 v2, 0x10

    .line 7
    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
