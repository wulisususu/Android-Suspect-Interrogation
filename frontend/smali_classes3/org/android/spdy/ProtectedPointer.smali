.class Lorg/android/spdy/ProtectedPointer;
.super Ljava/lang/Object;
.source "ProtectedPointer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/android/spdy/ProtectedPointer$ProtectedPointerOnClose;
    }
.end annotation


# static fields
.field private static final CLOSED:J = 0x3L

.field private static final INIT:J = 0x1L

.field private static final WAIT_CLOSE:J = 0x2L


# instance fields
.field private data2protected:Ljava/lang/Object;

.field protected how2close:Lorg/android/spdy/ProtectedPointer$ProtectedPointerOnClose;

.field private referAndstatus:Ljava/util/concurrent/atomic/AtomicLong;


# direct methods
.method constructor <init>(Ljava/lang/Object;)V
    .locals 3

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x1

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iput-object v0, p0, Lorg/android/spdy/ProtectedPointer;->referAndstatus:Ljava/util/concurrent/atomic/AtomicLong;

    iput-object p1, p0, Lorg/android/spdy/ProtectedPointer;->data2protected:Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method enter()Z
    .locals 5

    :cond_0
    iget-object v0, p0, Lorg/android/spdy/ProtectedPointer;->referAndstatus:Ljava/util/concurrent/atomic/AtomicLong;

    .line 49
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    const-wide/16 v2, 0x3

    cmp-long v2, v0, v2

    if-nez v2, :cond_1

    const/4 v0, 0x0

    return v0

    :cond_1
    const-wide/16 v2, 0x10

    add-long/2addr v2, v0

    iget-object v4, p0, Lorg/android/spdy/ProtectedPointer;->referAndstatus:Ljava/util/concurrent/atomic/AtomicLong;

    .line 54
    invoke-virtual {v4, v0, v1, v2, v3}, Ljava/util/concurrent/atomic/AtomicLong;->compareAndSet(JJ)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0
.end method

.method exit()V
    .locals 5

    iget-object v0, p0, Lorg/android/spdy/ProtectedPointer;->referAndstatus:Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, -0x10

    .line 63
    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;->addAndGet(J)J

    iget-object v0, p0, Lorg/android/spdy/ProtectedPointer;->referAndstatus:Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x2

    const-wide/16 v3, 0x3

    .line 64
    invoke-virtual {v0, v1, v2, v3, v4}, Ljava/util/concurrent/atomic/AtomicLong;->compareAndSet(JJ)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lorg/android/spdy/ProtectedPointer;->how2close:Lorg/android/spdy/ProtectedPointer$ProtectedPointerOnClose;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lorg/android/spdy/ProtectedPointer;->data2protected:Ljava/lang/Object;

    .line 66
    invoke-interface {v0, v1}, Lorg/android/spdy/ProtectedPointer$ProtectedPointerOnClose;->close(Ljava/lang/Object;)V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/android/spdy/ProtectedPointer;->data2protected:Ljava/lang/Object;

    :cond_1
    return-void
.end method

.method getData()Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lorg/android/spdy/ProtectedPointer;->data2protected:Ljava/lang/Object;

    return-object v0
.end method

.method release()V
    .locals 5

    iget-object v0, p0, Lorg/android/spdy/ProtectedPointer;->referAndstatus:Ljava/util/concurrent/atomic/AtomicLong;

    .line 77
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    iget-object v0, p0, Lorg/android/spdy/ProtectedPointer;->referAndstatus:Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x2

    const-wide/16 v3, 0x3

    .line 78
    invoke-virtual {v0, v1, v2, v3, v4}, Ljava/util/concurrent/atomic/AtomicLong;->compareAndSet(JJ)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lorg/android/spdy/ProtectedPointer;->how2close:Lorg/android/spdy/ProtectedPointer$ProtectedPointerOnClose;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lorg/android/spdy/ProtectedPointer;->data2protected:Ljava/lang/Object;

    .line 80
    invoke-interface {v0, v1}, Lorg/android/spdy/ProtectedPointer$ProtectedPointerOnClose;->close(Ljava/lang/Object;)V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/android/spdy/ProtectedPointer;->data2protected:Ljava/lang/Object;

    :cond_1
    return-void
.end method

.method setHow2close(Lorg/android/spdy/ProtectedPointer$ProtectedPointerOnClose;)V
    .locals 0

    iput-object p1, p0, Lorg/android/spdy/ProtectedPointer;->how2close:Lorg/android/spdy/ProtectedPointer$ProtectedPointerOnClose;

    return-void
.end method
