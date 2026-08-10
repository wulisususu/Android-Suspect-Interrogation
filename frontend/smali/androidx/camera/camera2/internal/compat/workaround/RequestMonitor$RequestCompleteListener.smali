.class Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;
.super Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
.source "RequestMonitor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "RequestCompleteListener"
.end annotation


# instance fields
.field mStartRequestCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation
.end field

.field final mStartRequestFuture:Lcom/google/common/util/concurrent/ListenableFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/common/util/concurrent/ListenableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 1

    .line 157
    invoke-direct {p0}, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;-><init>()V

    .line 158
    new-instance v0, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener$$ExternalSyntheticLambda0;-><init>(Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;)V

    invoke-static {v0}, Landroidx/concurrent/futures/CallbackToFutureAdapter;->getFuture(Landroidx/concurrent/futures/CallbackToFutureAdapter$Resolver;)Lcom/google/common/util/concurrent/ListenableFuture;

    move-result-object v0

    iput-object v0, p0, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;->mStartRequestFuture:Lcom/google/common/util/concurrent/ListenableFuture;

    return-void
.end method

.method private completeFuture()V
    .locals 2

    iget-object v0, p0, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;->mStartRequestCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    .line 196
    invoke-virtual {v0, v1}, Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;->set(Ljava/lang/Object;)Z

    iput-object v1, p0, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;->mStartRequestCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    :cond_0
    return-void
.end method


# virtual methods
.method synthetic lambda$new$0$androidx-camera-camera2-internal-compat-workaround-RequestMonitor$RequestCompleteListener(Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 0
    iput-object p1, p0, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;->mStartRequestCompleter:Landroidx/concurrent/futures/CallbackToFutureAdapter$Completer;

    .line 160
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "RequestCompleteListener["

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "]"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public onCaptureCompleted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)V
    .locals 0

    .line 179
    invoke-direct {p0}, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;->completeFuture()V

    return-void
.end method

.method public onCaptureFailed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureFailure;)V
    .locals 0

    .line 185
    invoke-direct {p0}, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;->completeFuture()V

    return-void
.end method

.method public onCaptureSequenceAborted(Landroid/hardware/camera2/CameraCaptureSession;I)V
    .locals 0

    .line 173
    invoke-direct {p0}, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;->completeFuture()V

    return-void
.end method

.method public onCaptureSequenceCompleted(Landroid/hardware/camera2/CameraCaptureSession;IJ)V
    .locals 0

    .line 191
    invoke-direct {p0}, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;->completeFuture()V

    return-void
.end method

.method public onCaptureStarted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;JJ)V
    .locals 0

    .line 167
    invoke-direct {p0}, Landroidx/camera/camera2/internal/compat/workaround/RequestMonitor$RequestCompleteListener;->completeFuture()V

    return-void
.end method
