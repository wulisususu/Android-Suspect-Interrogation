.class Landroidx/camera/video/Recorder$SetupVideoTask;
.super Ljava/lang/Object;
.source "Recorder.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/video/Recorder;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SetupVideoTask"
.end annotation


# instance fields
.field private mIsFailedRetryCanceled:Z

.field private final mMaxRetryCount:I

.field private mRetryCount:I

.field private mRetryFuture:Ljava/util/concurrent/ScheduledFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;"
        }
    .end annotation
.end field

.field private final mSurfaceRequest:Landroidx/camera/core/SurfaceRequest;

.field private final mTimebase:Landroidx/camera/core/impl/Timebase;

.field final synthetic this$0:Landroidx/camera/video/Recorder;


# direct methods
.method constructor <init>(Landroidx/camera/video/Recorder;Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;I)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1010,
            0x0,
            0x0,
            0x0
        }
        names = {
            null,
            null,
            null,
            null
        }
    .end annotation

    iput-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    .line 1212
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    iput-boolean p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mIsFailedRetryCanceled:Z

    iput p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mRetryCount:I

    const/4 p1, 0x0

    iput-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mRetryFuture:Ljava/util/concurrent/ScheduledFuture;

    iput-object p2, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mSurfaceRequest:Landroidx/camera/core/SurfaceRequest;

    iput-object p3, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mTimebase:Landroidx/camera/core/impl/Timebase;

    iput p4, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mMaxRetryCount:I

    return-void
.end method

.method static synthetic access$1000(Landroidx/camera/video/Recorder$SetupVideoTask;)Landroidx/camera/core/impl/Timebase;
    .locals 0

    .line 1201
    iget-object p0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mTimebase:Landroidx/camera/core/impl/Timebase;

    return-object p0
.end method

.method static synthetic access$1100(Landroidx/camera/video/Recorder$SetupVideoTask;Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;)V
    .locals 0

    .line 1201
    invoke-direct {p0, p1, p2}, Landroidx/camera/video/Recorder$SetupVideoTask;->setupVideo(Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;)V

    return-void
.end method

.method static synthetic access$400(Landroidx/camera/video/Recorder$SetupVideoTask;)I
    .locals 0

    .line 1201
    iget p0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mRetryCount:I

    return p0
.end method

.method static synthetic access$408(Landroidx/camera/video/Recorder$SetupVideoTask;)I
    .locals 2

    .line 1201
    iget v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mRetryCount:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mRetryCount:I

    return v0
.end method

.method static synthetic access$500(Landroidx/camera/video/Recorder$SetupVideoTask;)I
    .locals 0

    .line 1201
    iget p0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mMaxRetryCount:I

    return p0
.end method

.method static synthetic access$602(Landroidx/camera/video/Recorder$SetupVideoTask;Ljava/util/concurrent/ScheduledFuture;)Ljava/util/concurrent/ScheduledFuture;
    .locals 0

    .line 1201
    iput-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mRetryFuture:Ljava/util/concurrent/ScheduledFuture;

    return-object p1
.end method

.method static synthetic access$800(Landroidx/camera/video/Recorder$SetupVideoTask;)Z
    .locals 0

    .line 1201
    iget-boolean p0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mIsFailedRetryCanceled:Z

    return p0
.end method

.method static synthetic access$900(Landroidx/camera/video/Recorder$SetupVideoTask;)Landroidx/camera/core/SurfaceRequest;
    .locals 0

    .line 1201
    iget-object p0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mSurfaceRequest:Landroidx/camera/core/SurfaceRequest;

    return-object p0
.end method

.method private setupVideo(Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;)V
    .locals 2

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    .line 1238
    invoke-static {v0}, Landroidx/camera/video/Recorder;->access$000(Landroidx/camera/video/Recorder;)Lcom/google/common/util/concurrent/ListenableFuture;

    move-result-object v0

    new-instance v1, Landroidx/camera/video/Recorder$SetupVideoTask$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1, p2}, Landroidx/camera/video/Recorder$SetupVideoTask$$ExternalSyntheticLambda0;-><init>(Landroidx/camera/video/Recorder$SetupVideoTask;Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;)V

    iget-object p1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    iget-object p1, p1, Landroidx/camera/video/Recorder;->mSequentialExecutor:Ljava/util/concurrent/Executor;

    invoke-interface {v0, v1, p1}, Lcom/google/common/util/concurrent/ListenableFuture;->addListener(Ljava/lang/Runnable;Ljava/util/concurrent/Executor;)V

    return-void
.end method


# virtual methods
.method cancelFailedRetry()V
    .locals 2

    iget-boolean v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mIsFailedRetryCanceled:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mIsFailedRetryCanceled:Z

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mRetryFuture:Ljava/util/concurrent/ScheduledFuture;

    if-eqz v0, :cond_1

    const/4 v1, 0x0

    .line 1230
    invoke-interface {v0, v1}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z

    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mRetryFuture:Ljava/util/concurrent/ScheduledFuture;

    :cond_1
    return-void
.end method

.method synthetic lambda$setupVideo$0$androidx-camera-video-Recorder$SetupVideoTask(Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;)V
    .locals 4

    .line 1239
    invoke-virtual {p1}, Landroidx/camera/core/SurfaceRequest;->isServiced()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    iget-object v0, v0, Landroidx/camera/video/Recorder;->mVideoEncoderSession:Landroidx/camera/video/VideoEncoderSession;

    .line 1240
    invoke-virtual {v0, p1}, Landroidx/camera/video/VideoEncoderSession;->isConfiguredSurfaceRequest(Landroidx/camera/core/SurfaceRequest;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    .line 1241
    invoke-virtual {v0}, Landroidx/camera/video/Recorder;->isPersistentRecordingInProgress()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 1250
    :cond_0
    new-instance v0, Landroidx/camera/video/VideoEncoderSession;

    iget-object v1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    .line 1251
    invoke-static {v1}, Landroidx/camera/video/Recorder;->access$100(Landroidx/camera/video/Recorder;)Landroidx/camera/video/internal/encoder/EncoderFactory;

    move-result-object v1

    iget-object v2, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    iget-object v2, v2, Landroidx/camera/video/Recorder;->mSequentialExecutor:Ljava/util/concurrent/Executor;

    iget-object v3, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    .line 1252
    invoke-static {v3}, Landroidx/camera/video/Recorder;->access$200(Landroidx/camera/video/Recorder;)Ljava/util/concurrent/Executor;

    move-result-object v3

    invoke-direct {v0, v1, v2, v3}, Landroidx/camera/video/VideoEncoderSession;-><init>(Landroidx/camera/video/internal/encoder/EncoderFactory;Ljava/util/concurrent/Executor;Ljava/util/concurrent/Executor;)V

    iget-object v1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    .line 1253
    iget-object v2, v1, Landroidx/camera/video/Recorder;->mMediaSpec:Landroidx/camera/core/impl/MutableStateObservable;

    invoke-virtual {v1, v2}, Landroidx/camera/video/Recorder;->getObservableData(Landroidx/camera/core/impl/StateObservable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/camera/video/MediaSpec;

    iget-object v2, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    .line 1256
    invoke-static {v2}, Landroidx/camera/video/Recorder;->access$300(Landroidx/camera/video/Recorder;)Landroidx/camera/video/internal/VideoValidatedEncoderProfilesProxy;

    move-result-object v2

    .line 1255
    invoke-virtual {v0, p1, p2, v1, v2}, Landroidx/camera/video/VideoEncoderSession;->configure(Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;Landroidx/camera/video/MediaSpec;Landroidx/camera/video/internal/VideoValidatedEncoderProfilesProxy;)Lcom/google/common/util/concurrent/ListenableFuture;

    move-result-object p1

    iget-object p2, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    .line 1257
    iput-object v0, p2, Landroidx/camera/video/Recorder;->mVideoEncoderSession:Landroidx/camera/video/VideoEncoderSession;

    .line 1258
    new-instance p2, Landroidx/camera/video/Recorder$SetupVideoTask$1;

    invoke-direct {p2, p0, v0}, Landroidx/camera/video/Recorder$SetupVideoTask$1;-><init>(Landroidx/camera/video/Recorder$SetupVideoTask;Landroidx/camera/video/VideoEncoderSession;)V

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    iget-object v0, v0, Landroidx/camera/video/Recorder;->mSequentialExecutor:Ljava/util/concurrent/Executor;

    invoke-static {p1, p2, v0}, Landroidx/camera/core/impl/utils/futures/Futures;->addCallback(Lcom/google/common/util/concurrent/ListenableFuture;Landroidx/camera/core/impl/utils/futures/FutureCallback;Ljava/util/concurrent/Executor;)V

    return-void

    .line 1245
    :cond_1
    :goto_0
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "Ignore the SurfaceRequest "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, " isServiced: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    .line 1246
    invoke-virtual {p1}, Landroidx/camera/core/SurfaceRequest;->isServiced()Z

    move-result p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " VideoEncoderSession: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object p2, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->this$0:Landroidx/camera/video/Recorder;

    iget-object p2, p2, Landroidx/camera/video/Recorder;->mVideoEncoderSession:Landroidx/camera/video/VideoEncoderSession;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " has been configured with a persistent in-progress recording."

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "Recorder"

    .line 1245
    invoke-static {p2, p1}, Landroidx/camera/core/Logger;->w(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method start()V
    .locals 2

    iget-object v0, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mSurfaceRequest:Landroidx/camera/core/SurfaceRequest;

    iget-object v1, p0, Landroidx/camera/video/Recorder$SetupVideoTask;->mTimebase:Landroidx/camera/core/impl/Timebase;

    .line 1220
    invoke-direct {p0, v0, v1}, Landroidx/camera/video/Recorder$SetupVideoTask;->setupVideo(Landroidx/camera/core/SurfaceRequest;Landroidx/camera/core/impl/Timebase;)V

    return-void
.end method
