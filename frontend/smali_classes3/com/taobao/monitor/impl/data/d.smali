.class public Lcom/taobao/monitor/impl/data/d;
.super Ljava/lang/Object;
.source "DrawTimeCollector.java"

# interfaces
.implements Landroid/view/ViewTreeObserver$OnDrawListener;


# instance fields
.field private a:I

.field private a:J

.field private a:Lcom/taobao/monitor/impl/trace/i;

.field private b:I

.field private b:J

.field private c:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/d;->a:J

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/d;->b:J

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/monitor/impl/data/d;->a:I

    iput v0, p0, Lcom/taobao/monitor/impl/data/d;->b:I

    const-string v0, "ACTIVITY_FPS_DISPATCHER"

    .line 12
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    .line 13
    instance-of v1, v0, Lcom/taobao/monitor/impl/trace/i;

    if-eqz v1, :cond_0

    .line 14
    check-cast v0, Lcom/taobao/monitor/impl/trace/i;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/d;->a:Lcom/taobao/monitor/impl/trace/i;

    :cond_0
    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/d;->c:J

    return-void
.end method

.method public onDraw()V
    .locals 9

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/taobao/monitor/impl/data/d;->c:J

    sub-long v2, v0, v2

    const-wide/16 v4, 0x7d0

    cmp-long v2, v2, v4

    if-lez v2, :cond_0

    return-void

    :cond_0
    iget-wide v2, p0, Lcom/taobao/monitor/impl/data/d;->a:J

    sub-long v2, v0, v2

    const-wide/16 v4, 0xc8

    cmp-long v4, v2, v4

    if-gez v4, :cond_4

    iget-wide v4, p0, Lcom/taobao/monitor/impl/data/d;->b:J

    add-long/2addr v4, v2

    iput-wide v4, p0, Lcom/taobao/monitor/impl/data/d;->b:J

    iget v6, p0, Lcom/taobao/monitor/impl/data/d;->b:I

    add-int/lit8 v6, v6, 0x1

    iput v6, p0, Lcom/taobao/monitor/impl/data/d;->b:I

    const-wide/16 v7, 0x20

    cmp-long v2, v2, v7

    if-lez v2, :cond_1

    iget v2, p0, Lcom/taobao/monitor/impl/data/d;->a:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/taobao/monitor/impl/data/d;->a:I

    :cond_1
    const-wide/16 v2, 0x3e8

    cmp-long v2, v4, v2

    if-lez v2, :cond_4

    const/16 v2, 0x3c

    if-le v6, v2, :cond_2

    iput v2, p0, Lcom/taobao/monitor/impl/data/d;->b:I

    :cond_2
    iget-object v2, p0, Lcom/taobao/monitor/impl/data/d;->a:Lcom/taobao/monitor/impl/trace/i;

    .line 17
    invoke-static {v2}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v2

    if-nez v2, :cond_3

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/d;->a:Lcom/taobao/monitor/impl/trace/i;

    iget v3, p0, Lcom/taobao/monitor/impl/data/d;->b:I

    .line 18
    invoke-virtual {v2, v3}, Lcom/taobao/monitor/impl/trace/i;->a(I)V

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/d;->a:Lcom/taobao/monitor/impl/trace/i;

    iget v3, p0, Lcom/taobao/monitor/impl/data/d;->a:I

    .line 19
    invoke-virtual {v2, v3}, Lcom/taobao/monitor/impl/trace/i;->b(I)V

    :cond_3
    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lcom/taobao/monitor/impl/data/d;->b:J

    const/4 v2, 0x0

    iput v2, p0, Lcom/taobao/monitor/impl/data/d;->b:I

    iput v2, p0, Lcom/taobao/monitor/impl/data/d;->a:I

    :cond_4
    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/d;->a:J

    return-void
.end method
