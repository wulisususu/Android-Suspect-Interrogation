.class public abstract Lcom/taobao/monitor/impl/data/AbsWebView;
.super Ljava/lang/Object;
.source "AbsWebView.java"

# interfaces
.implements Lcom/taobao/monitor/impl/data/IWebView;


# instance fields
.field private hashCode:I

.field private progress:I

.field private progressEndTime:J

.field private startTime:J


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->progress:I

    iput v0, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->hashCode:I

    return-void
.end method

.method static synthetic access$000(Lcom/taobao/monitor/impl/data/AbsWebView;)I
    .locals 0

    .line 1
    iget p0, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->progress:I

    return p0
.end method

.method static synthetic access$002(Lcom/taobao/monitor/impl/data/AbsWebView;I)I
    .locals 0

    .line 1
    iput p1, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->progress:I

    return p1
.end method

.method static synthetic access$102(Lcom/taobao/monitor/impl/data/AbsWebView;J)J
    .locals 0

    .line 1
    iput-wide p1, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->progressEndTime:J

    return-wide p1
.end method


# virtual methods
.method public abstract getProgress(Landroid/view/View;)I
.end method

.method public abstract isWebView(Landroid/view/View;)Z
.end method

.method public isWebViewLoadFinished(Landroid/view/View;)Z
    .locals 9

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result v0

    iget v1, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->hashCode:I

    const-wide/16 v2, 0x0

    const/4 v4, 0x0

    if-eq v0, v1, :cond_0

    .line 2
    invoke-virtual {p1}, Ljava/lang/Object;->hashCode()I

    move-result p1

    iput p1, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->hashCode:I

    iput v4, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->progress:I

    .line 4
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->startTime:J

    iput-wide v2, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->progressEndTime:J

    return v4

    :cond_0
    iget v0, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->progress:I

    const/16 v1, 0x64

    if-eq v0, v1, :cond_1

    .line 10
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v5

    invoke-direct {v0, v5}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 11
    new-instance v5, Lcom/taobao/monitor/impl/data/AbsWebView$a;

    invoke-direct {v5, p0, p1}, Lcom/taobao/monitor/impl/data/AbsWebView$a;-><init>(Lcom/taobao/monitor/impl/data/AbsWebView;Landroid/view/View;)V

    invoke-virtual {v0, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 26
    :cond_1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v5

    iget-wide v7, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->progressEndTime:J

    cmp-long p1, v7, v2

    if-eqz p1, :cond_2

    sub-long/2addr v5, v7

    long-to-double v2, v5

    iget-wide v5, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->startTime:J

    sub-long/2addr v7, v5

    long-to-double v5, v7

    const-wide/high16 v7, 0x3ff8000000000000L    # 1.5

    mul-double/2addr v5, v7

    cmpl-double p1, v2, v5

    if-lez p1, :cond_2

    iget p1, p0, Lcom/taobao/monitor/impl/data/AbsWebView;->progress:I

    if-ne p1, v1, :cond_2

    const/4 v4, 0x1

    :cond_2
    return v4
.end method
