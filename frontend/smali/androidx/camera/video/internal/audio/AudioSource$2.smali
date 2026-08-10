.class Landroidx/camera/video/internal/audio/AudioSource$2;
.super Ljava/lang/Object;
.source "AudioSource.java"

# interfaces
.implements Landroidx/camera/core/impl/utils/futures/FutureCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/camera/video/internal/audio/AudioSource;->resetBufferProvider(Landroidx/camera/video/internal/BufferProvider;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroidx/camera/core/impl/utils/futures/FutureCallback<",
        "Landroidx/camera/video/internal/encoder/InputBuffer;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/camera/video/internal/audio/AudioSource;

.field final synthetic val$bufferProvider:Landroidx/camera/video/internal/BufferProvider;


# direct methods
.method constructor <init>(Landroidx/camera/video/internal/audio/AudioSource;Landroidx/camera/video/internal/BufferProvider;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010
        }
        names = {
            null,
            null
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    iput-object p2, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->val$bufferProvider:Landroidx/camera/video/internal/BufferProvider;

    .line 439
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/Throwable;)V
    .locals 2

    iget-object v0, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 482
    iget-object v0, v0, Landroidx/camera/video/internal/audio/AudioSource;->mBufferProvider:Landroidx/camera/video/internal/BufferProvider;

    iget-object v1, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->val$bufferProvider:Landroidx/camera/video/internal/BufferProvider;

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    const-string v0, "AudioSource"

    const-string v1, "Unable to get input buffer, the BufferProvider could be transitioning to INACTIVE state."

    .line 485
    invoke-static {v0, v1}, Landroidx/camera/core/Logger;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 490
    instance-of v0, p1, Ljava/lang/IllegalStateException;

    if-nez v0, :cond_1

    iget-object v0, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 491
    invoke-virtual {v0, p1}, Landroidx/camera/video/internal/audio/AudioSource;->notifyError(Ljava/lang/Throwable;)V

    :cond_1
    return-void
.end method

.method public onSuccess(Landroidx/camera/video/internal/encoder/InputBuffer;)V
    .locals 6

    iget-object v0, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 443
    iget-boolean v0, v0, Landroidx/camera/video/internal/audio/AudioSource;->mIsSendingAudio:Z

    if-eqz v0, :cond_5

    iget-object v0, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    iget-object v0, v0, Landroidx/camera/video/internal/audio/AudioSource;->mBufferProvider:Landroidx/camera/video/internal/BufferProvider;

    iget-object v1, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->val$bufferProvider:Landroidx/camera/video/internal/BufferProvider;

    if-eq v0, v1, :cond_0

    goto/16 :goto_1

    :cond_0
    iget-object v0, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 447
    iget-boolean v0, v0, Landroidx/camera/video/internal/audio/AudioSource;->mInSilentStartState:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    invoke-virtual {v0}, Landroidx/camera/video/internal/audio/AudioSource;->isStartRetryIntervalReached()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 448
    invoke-virtual {v0}, Landroidx/camera/video/internal/audio/AudioSource;->retryStartAudioStream()V

    :cond_1
    iget-object v0, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 454
    invoke-virtual {v0}, Landroidx/camera/video/internal/audio/AudioSource;->getCurrentAudioStream()Landroidx/camera/video/internal/audio/AudioStream;

    move-result-object v0

    .line 455
    invoke-interface {p1}, Landroidx/camera/video/internal/encoder/InputBuffer;->getByteBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 456
    invoke-interface {v0, v1}, Landroidx/camera/video/internal/audio/AudioStream;->read(Ljava/nio/ByteBuffer;)Landroidx/camera/video/internal/audio/AudioStream$PacketInfo;

    move-result-object v0

    .line 457
    invoke-virtual {v0}, Landroidx/camera/video/internal/audio/AudioStream$PacketInfo;->getSizeInBytes()I

    move-result v2

    if-lez v2, :cond_4

    iget-object v2, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 458
    iget-boolean v2, v2, Landroidx/camera/video/internal/audio/AudioSource;->mMuted:Z

    if-eqz v2, :cond_2

    iget-object v2, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 459
    invoke-virtual {v0}, Landroidx/camera/video/internal/audio/AudioStream$PacketInfo;->getSizeInBytes()I

    move-result v3

    invoke-virtual {v2, v1, v3}, Landroidx/camera/video/internal/audio/AudioSource;->overrideBySilence(Ljava/nio/ByteBuffer;I)V

    :cond_2
    iget-object v2, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 463
    iget-object v2, v2, Landroidx/camera/video/internal/audio/AudioSource;->mCallbackExecutor:Ljava/util/concurrent/Executor;

    if-eqz v2, :cond_3

    .line 464
    invoke-virtual {v0}, Landroidx/camera/video/internal/audio/AudioStream$PacketInfo;->getTimestampNs()J

    move-result-wide v2

    iget-object v4, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    iget-wide v4, v4, Landroidx/camera/video/internal/audio/AudioSource;->mAmplitudeTimestamp:J

    sub-long/2addr v2, v4

    const-wide/16 v4, 0xc8

    cmp-long v2, v2, v4

    if-ltz v2, :cond_3

    iget-object v2, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 465
    invoke-virtual {v0}, Landroidx/camera/video/internal/audio/AudioStream$PacketInfo;->getTimestampNs()J

    move-result-wide v3

    iput-wide v3, v2, Landroidx/camera/video/internal/audio/AudioSource;->mAmplitudeTimestamp:J

    iget-object v2, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 466
    invoke-virtual {v2, v1}, Landroidx/camera/video/internal/audio/AudioSource;->postMaxAmplitude(Ljava/nio/ByteBuffer;)V

    .line 468
    :cond_3
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->position()I

    move-result v2

    invoke-virtual {v0}, Landroidx/camera/video/internal/audio/AudioStream$PacketInfo;->getSizeInBytes()I

    move-result v3

    add-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    .line 469
    sget-object v1, Ljava/util/concurrent/TimeUnit;->NANOSECONDS:Ljava/util/concurrent/TimeUnit;

    .line 470
    invoke-virtual {v0}, Landroidx/camera/video/internal/audio/AudioStream$PacketInfo;->getTimestampNs()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/util/concurrent/TimeUnit;->toMicros(J)J

    move-result-wide v0

    .line 469
    invoke-interface {p1, v0, v1}, Landroidx/camera/video/internal/encoder/InputBuffer;->setPresentationTimeUs(J)V

    .line 471
    invoke-interface {p1}, Landroidx/camera/video/internal/encoder/InputBuffer;->submit()Z

    goto :goto_0

    :cond_4
    const-string v0, "AudioSource"

    const-string v1, "Unable to read data from AudioStream."

    .line 473
    invoke-static {v0, v1}, Landroidx/camera/core/Logger;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 474
    invoke-interface {p1}, Landroidx/camera/video/internal/encoder/InputBuffer;->cancel()Z

    :goto_0
    iget-object p1, p0, Landroidx/camera/video/internal/audio/AudioSource$2;->this$0:Landroidx/camera/video/internal/audio/AudioSource;

    .line 476
    invoke-virtual {p1}, Landroidx/camera/video/internal/audio/AudioSource;->sendNextAudio()V

    return-void

    .line 444
    :cond_5
    :goto_1
    invoke-interface {p1}, Landroidx/camera/video/internal/encoder/InputBuffer;->cancel()Z

    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000
        }
        names = {
            null
        }
    .end annotation

    .line 439
    check-cast p1, Landroidx/camera/video/internal/encoder/InputBuffer;

    invoke-virtual {p0, p1}, Landroidx/camera/video/internal/audio/AudioSource$2;->onSuccess(Landroidx/camera/video/internal/encoder/InputBuffer;)V

    return-void
.end method
