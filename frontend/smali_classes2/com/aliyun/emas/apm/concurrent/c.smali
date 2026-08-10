.class Lcom/aliyun/emas/apm/concurrent/c;
.super Landroidx/concurrent/futures/AbstractResolvableFuture;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/ScheduledFuture;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/concurrent/c$c;,
        Lcom/aliyun/emas/apm/concurrent/c$b;
    }
.end annotation


# instance fields
.field private final a:Ljava/util/concurrent/ScheduledFuture;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/concurrent/c$c;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Landroidx/concurrent/futures/AbstractResolvableFuture;-><init>()V

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/c$a;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/concurrent/c$a;-><init>(Lcom/aliyun/emas/apm/concurrent/c;)V

    .line 3
    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/concurrent/c$c;->a(Lcom/aliyun/emas/apm/concurrent/c$b;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/c;->a:Ljava/util/concurrent/ScheduledFuture;

    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/concurrent/c;Ljava/lang/Object;)Z
    .locals 0

    .line 1
    invoke-virtual {p0, p1}, Landroidx/concurrent/futures/AbstractResolvableFuture;->set(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/concurrent/c;Ljava/lang/Throwable;)Z
    .locals 0

    .line 2
    invoke-virtual {p0, p1}, Landroidx/concurrent/futures/AbstractResolvableFuture;->setException(Ljava/lang/Throwable;)Z

    move-result p0

    return p0
.end method


# virtual methods
.method public a(Ljava/util/concurrent/Delayed;)I
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/c;->a:Ljava/util/concurrent/ScheduledFuture;

    .line 3
    invoke-interface {v0, p1}, Ljava/lang/Comparable;->compareTo(Ljava/lang/Object;)I

    move-result p1

    return p1
.end method

.method protected afterDone()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/c;->a:Ljava/util/concurrent/ScheduledFuture;

    .line 1
    invoke-virtual {p0}, Landroidx/concurrent/futures/AbstractResolvableFuture;->wasInterrupted()Z

    move-result v1

    invoke-interface {v0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    return-void
.end method

.method public bridge synthetic compareTo(Ljava/lang/Object;)I
    .locals 0

    .line 1
    check-cast p1, Ljava/util/concurrent/Delayed;

    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/concurrent/c;->a(Ljava/util/concurrent/Delayed;)I

    move-result p1

    return p1
.end method

.method public getDelay(Ljava/util/concurrent/TimeUnit;)J
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/c;->a:Ljava/util/concurrent/ScheduledFuture;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/concurrent/Delayed;->getDelay(Ljava/util/concurrent/TimeUnit;)J

    move-result-wide v0

    return-wide v0
.end method
