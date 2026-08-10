.class Landroidx/camera/video/Recorder$SetupVideoTask$1;
.super Ljava/lang/Object;
.source "Recorder.java"

# interfaces
.implements Landroidx/camera/core/impl/utils/futures/FutureCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/camera/video/Recorder$SetupVideoTask;->setupVideo(Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroidx/camera/core/impl/utils/futures/FutureCallback<",
        "Landroidx/camera/video/internal/encoder/Encoder;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

.field final synthetic val$videoEncoderSession:Landroidx/camera/video/VideoEncoderSession;


# direct methods
.method constructor <init>(Landroidx/camera/video/Recorder$SetupVideoTask;Landroidx/camera/video/VideoEncoderSession;)V
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

    iput-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    iput-object p2, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->val$videoEncoderSession:Landroidx/camera/video/VideoEncoderSession;

    .line 1258
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method synthetic lambda$onFailure$0$androidx-camera-video-Recorder$SetupVideoTask$1()V
    .locals 3

    .line 0
    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1277
    invoke-static {v0}, Landroidx/camera/video/Recorder$SetupVideoTask;->access$800(Landroidx/camera/video/Recorder$SetupVideoTask;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1278
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Retry setupVideo #"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    invoke-static {v1}, Landroidx/camera/video/Recorder$SetupVideoTask;->access$400(Landroidx/camera/video/Recorder$SetupVideoTask;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Recorder"

    invoke-static {v1, v0}, Landroidx/camera/core/Logger;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1279
    invoke-static {v0}, Landroidx/camera/video/Recorder$SetupVideoTask;->access$900(Landroidx/camera/video/Recorder$SetupVideoTask;)Landroidx/camera/core/SurfaceRequest;

    move-result-object v1

    iget-object v2, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    invoke-static {v2}, Landroidx/camera/video/Recorder$SetupVideoTask;->access$1000(Landroidx/camera/video/Recorder$SetupVideoTask;)Landroidx/camera/core/impl/Timebase;

    move-result-object v2

    invoke-static {v0, v1, v2}, Landroidx/camera/video/Recorder$SetupVideoTask;->access$1100(Landroidx/camera/video/Recorder$SetupVideoTask;Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;)V

    :cond_0
    return-void
.end method

.method public onFailure(Ljava/lang/Throwable;)V
    .locals 5

    .line 1273
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "VideoEncoder Setup error: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Recorder"

    invoke-static {v1, v0, p1}, Landroidx/camera/core/Logger;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1274
    invoke-static {v0}, Landroidx/camera/video/Recorder$SetupVideoTask;->access$400(Landroidx/camera/video/Recorder$SetupVideoTask;)I

    move-result v0

    iget-object v1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    invoke-static {v1}, Landroidx/camera/video/Recorder$SetupVideoTask;->access$500(Landroidx/camera/video/Recorder$SetupVideoTask;)I

    move-result v1

    if-ge v0, v1, :cond_0

    iget-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1275
    invoke-static {p1}, Landroidx/camera/video/Recorder$SetupVideoTask;->access$408(Landroidx/camera/video/Recorder$SetupVideoTask;)I

    iget-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1276
    new-instance v0, Landroidx/camera/video/Recorder$SetupVideoTask$1$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Landroidx/camera/video/Recorder$SetupVideoTask$1$$ExternalSyntheticLambda0;-><init>(Landroidx/camera/video/Recorder$SetupVideoTask$1;)V

    iget-object v1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    iget-object v1, v1, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    iget-object v1, v1, Landroidx/camera/video/Recorder;->mSequentialExecutor:Ljava/util/concurrent/Executor;

    sget-wide v2, Landroidx/camera/video/Recorder;->sRetrySetupVideoDelayMs:J

    sget-object v4, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {v0, v1, v2, v3, v4}, Landroidx/camera/video/Recorder;->access$700(Ljava/lang/Runnable;Ljava/util/concurrent/Executor;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    invoke-static {p1, v0}, Landroidx/camera/video/Recorder$SetupVideoTask;->access$602(Landroidx/camera/video/Recorder$SetupVideoTask;Ljava/util/concurrent/ScheduledFuture;)Ljava/util/concurrent/ScheduledFuture;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1283
    iget-object v0, v0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    invoke-virtual {v0, p1}, Landroidx/camera/video/Recorder;->onEncoderSetupError(Ljava/lang/Throwable;)V

    :goto_0
    return-void
.end method

.method public onSuccess(Landroidx/camera/video/internal/encoder/Encoder;)V
    .locals 3

    .line 1261
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "VideoEncoder is created. "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Recorder"

    invoke-static {v1, v0}, Landroidx/camera/core/Logger;->d(Ljava/lang/String;Ljava/lang/String;)V

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1265
    iget-object p1, p1, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    iget-object p1, p1, Landroidx/camera/video/Recorder;->mVideoEncoderSession:Landroidx/camera/video/VideoEncoderSession;

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->val$videoEncoderSession:Landroidx/camera/video/VideoEncoderSession;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-ne p1, v0, :cond_1

    move p1, v1

    goto :goto_0

    :cond_1
    move p1, v2

    :goto_0
    invoke-static {p1}, Landroidx/core/util/Preconditions;->checkState(Z)V

    iget-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1266
    iget-object p1, p1, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    iget-object p1, p1, Landroidx/camera/video/Recorder;->mVideoEncoder:Landroidx/camera/video/internal/encoder/Encoder;

    if-nez p1, :cond_2

    goto :goto_1

    :cond_2
    move v1, v2

    :goto_1
    invoke-static {v1}, Landroidx/core/util/Preconditions;->checkState(Z)V

    iget-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1267
    iget-object p1, p1, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->val$videoEncoderSession:Landroidx/camera/video/VideoEncoderSession;

    invoke-virtual {p1, v0}, Landroidx/camera/video/Recorder;->onVideoEncoderReady(Landroidx/camera/video/VideoEncoderSession;)V

    iget-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask$1;->this$1:Landroidx/camera/video/Recorder$SetupVideoTask;

    .line 1268
    iget-object p1, p1, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    invoke-virtual {p1}, Landroidx/camera/video/Recorder;->onConfigured()V

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

    .line 1258
    check-cast p1, Landroidx/camera/video/internal/encoder/Encoder;

    invoke-virtual {p0, p1}, Landroidx/camera/video/Recorder$SetupVideoTask$1;->onSuccess(Landroidx/camera/video/internal/encoder/Encoder;)V

    return-void
.end method
