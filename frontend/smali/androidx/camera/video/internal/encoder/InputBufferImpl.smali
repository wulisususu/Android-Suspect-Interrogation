.class Landroidx/camera/video/internal/encoder/InputBufferImpl;
.super Ljava/lang/Object;
.source "InputBufferImpl.java"

# interfaces
.implements Landroidx/camera/video/internal/encoder/InputBuffer;


# instance fields
.field private final mBufferIndex:I

.field private final mByteBuffer:Ljava/nio/ByteBuffer;

.field private mIsEndOfStream:Z

.field private final mMediaCodec:Landroid/media/MediaCodec;

.field private mPresentationTimeUs:J

.field private final mTerminated:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private final mTerminationCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation
.end field

.field private final mTerminationFuture:Lcom/google/common/util/concurrent/ListenableFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/common/util/concurrent/ListenableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Landroid/media/MediaCodec;I)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/media/MediaCodec$CodecException;
        }
    .end annotation

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminated:Ljava/util/concurrent/atomic/AtomicBoolean;

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mPresentationTimeUs:J

    iput-boolean v1, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mIsEndOfStream:Z

    .line 46
    invoke-static {p1}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/MediaCodec;

    iput-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mMediaCodec:Landroid/media/MediaCodec;

    .line 47
    invoke-static {p2}, Landroidx/core/util/Preconditions;->checkArgumentNonnegative(I)I

    move-result v0

    iput v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mBufferIndex:I

    .line 48
    invoke-virtual {p1, p2}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mByteBuffer:Ljava/nio/ByteBuffer;

    .line 49
    new-instance p1, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {p1}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    .line 50
    new-instance p2, Landroidx/camera/video/internal/encoder/InputBufferImpl$$ExternalSyntheticLambda0;

    invoke-direct {p2, p1}, Landroidx/camera/video/internal/encoder/InputBufferImpl$$ExternalSyntheticLambda0;-><init>(Ljava/util/concurrent/atomic/AtomicReference;)V

    invoke-static {p2}, Landroidx/concurrent/futures/CallbackToFutureAdapter;->getFuture(Landroidx/concurrent/futures/CallbackToFutureAdapter$Resolver;)Lcom/google/common/util/concurrent/ListenableFuture;

    move-result-object p2

    iput-object p2, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminationFuture:Lcom/google/common/util/concurrent/ListenableFuture;

    .line 55
    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    invoke-static {p1}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    iput-object p1, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminationCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    return-void
.end method

.method static synthetic lambda$new$0(Ljava/util/concurrent/atomic/AtomicReference;Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 52
    invoke-virtual {p0, p1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    const-string p0, "Terminate InputBuffer"

    return-object p0
.end method

.method private throwIfTerminated()V
    .locals 2

    iget-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminated:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 124
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 125
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "The buffer is submitted or canceled."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public cancel()Z
    .locals 9

    iget-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminated:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    .line 104
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->getAndSet(Z)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    :try_start_0
    iget-object v2, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mMediaCodec:Landroid/media/MediaCodec;

    iget v3, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mBufferIndex:I

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x0

    .line 108
    invoke-virtual/range {v2 .. v8}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    iget-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminationCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    const/4 v2, 0x0

    .line 109
    invoke-virtual {v0, v2}, Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;->set(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v2, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminationCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    .line 111
    invoke-virtual {v2, v0}, Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;->setException(Ljava/lang/Throwable;)Z

    :goto_0
    return v1
.end method

.method public getByteBuffer()Ljava/nio/ByteBuffer;
    .locals 1

    .line 62
    invoke-direct {p0}, Landroidx/camera/video/internal/encoder/InputBufferImpl;->throwIfTerminated()V

    iget-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mByteBuffer:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getTerminationFuture()Lcom/google/common/util/concurrent/ListenableFuture;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/util/concurrent/ListenableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminationFuture:Lcom/google/common/util/concurrent/ListenableFuture;

    .line 120
    invoke-static {v0}, Landroidx/camera/core/impl/utils/futures/Futures;->nonCancellationPropagating(Lcom/google/common/util/concurrent/ListenableFuture;)Lcom/google/common/util/concurrent/ListenableFuture;

    move-result-object v0

    return-object v0
.end method

.method public setEndOfStream(Z)V
    .locals 0

    .line 77
    invoke-direct {p0}, Landroidx/camera/video/internal/encoder/InputBufferImpl;->throwIfTerminated()V

    iput-boolean p1, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mIsEndOfStream:Z

    return-void
.end method

.method public setPresentationTimeUs(J)V
    .locals 2

    .line 69
    invoke-direct {p0}, Landroidx/camera/video/internal/encoder/InputBufferImpl;->throwIfTerminated()V

    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-ltz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 70
    :goto_0
    invoke-static {v0}, Landroidx/core/util/Preconditions;->checkArgument(Z)V

    iput-wide p1, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mPresentationTimeUs:J

    return-void
.end method

.method public submit()Z
    .locals 10

    iget-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminated:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    .line 84
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->getAndSet(Z)Z

    move-result v0

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    return v2

    :cond_0
    :try_start_0
    iget-object v3, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mMediaCodec:Landroid/media/MediaCodec;

    iget v4, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mBufferIndex:I

    iget-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mByteBuffer:Ljava/nio/ByteBuffer;

    .line 89
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v5

    iget-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mByteBuffer:Ljava/nio/ByteBuffer;

    .line 90
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->limit()I

    move-result v6

    iget-wide v7, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mPresentationTimeUs:J

    iget-boolean v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mIsEndOfStream:Z

    if-eqz v0, :cond_1

    const/4 v0, 0x4

    move v9, v0

    goto :goto_0

    :cond_1
    move v9, v2

    .line 88
    :goto_0
    invoke-virtual/range {v3 .. v9}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    iget-object v0, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminationCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    const/4 v3, 0x0

    .line 93
    invoke-virtual {v0, v3}, Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;->set(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    :catch_0
    move-exception v0

    iget-object v1, p0, Landroidx/camera/video/internal/encoder/InputBufferImpl;->mTerminationCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    .line 96
    invoke-virtual {v1, v0}, Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;->setException(Ljava/lang/Throwable;)Z

    return v2
.end method
