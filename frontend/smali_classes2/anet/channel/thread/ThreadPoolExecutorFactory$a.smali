.class Lanet/channel/thread/ThreadPoolExecutorFactory$a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Comparable;
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/thread/ThreadPoolExecutorFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Comparable<",
        "Lanet/channel/thread/ThreadPoolExecutorFactory$a;",
        ">;",
        "Ljava/lang/Runnable;"
    }
.end annotation


# instance fields
.field a:Ljava/lang/Runnable;

.field b:I

.field c:J


# direct methods
.method public constructor <init>(Ljava/lang/Runnable;I)V
    .locals 2

    .line 107
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->a:Ljava/lang/Runnable;

    const/4 v0, 0x0

    iput v0, p0, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->b:I

    .line 105
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->c:J

    iput-object p1, p0, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->a:Ljava/lang/Runnable;

    iput p2, p0, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->b:I

    .line 110
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iput-wide p1, p0, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->c:J

    return-void
.end method


# virtual methods
.method public a(Lanet/channel/thread/ThreadPoolExecutorFactory$a;)I
    .locals 4

    iget v0, p0, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->b:I

    .line 115
    iget v1, p1, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->b:I

    if-eq v0, v1, :cond_0

    sub-int/2addr v0, v1

    return v0

    .line 118
    :cond_0
    iget-wide v0, p1, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->c:J

    iget-wide v2, p0, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->c:J

    sub-long/2addr v0, v2

    long-to-int p1, v0

    return p1
.end method

.method public synthetic compareTo(Ljava/lang/Object;)I
    .locals 0

    .line 102
    check-cast p1, Lanet/channel/thread/ThreadPoolExecutorFactory$a;

    invoke-virtual {p0, p1}, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->a(Lanet/channel/thread/ThreadPoolExecutorFactory$a;)I

    move-result p1

    return p1
.end method

.method public run()V
    .locals 1

    iget-object v0, p0, Lanet/channel/thread/ThreadPoolExecutorFactory$a;->a:Ljava/lang/Runnable;

    .line 124
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    return-void
.end method
