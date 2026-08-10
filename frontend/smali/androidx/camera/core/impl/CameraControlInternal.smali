.class public interface abstract Landroidx/camera/core/impl/CameraControlInternal;
.super Ljava/lang/Object;
.source "CameraControlInternal.java"

# interfaces
.implements Landroidx/camera/core/CameraControl;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/core/impl/CameraControlInternal$CameraControlException;,
        Landroidx/camera/core/impl/CameraControlInternal$ControlUpdateCallback;
    }
.end annotation


# static fields
.field public static final DEFAULT_EMPTY_INSTANCE:Landroidx/camera/core/impl/CameraControlInternal;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 200
    new-instance v0, Landroidx/camera/core/impl/CameraControlInternal$2;

    invoke-direct {v0}, Landroidx/camera/core/impl/CameraControlInternal$2;-><init>()V

    sput-object v0, Landroidx/camera/core/impl/CameraControlInternal;->DEFAULT_EMPTY_INSTANCE:Landroidx/camera/core/impl/CameraControlInternal;

    return-void
.end method


# virtual methods
.method public abstract addInteropConfig(Landroidx/camera/core/impl/Config;)V
.end method

.method public abstract addZslConfig(Landroidx/camera/core/impl/SessionConfig$Builder;)V
.end method

.method public abstract clearInteropConfig()V
.end method

.method public decrementVideoUsage()V
    .locals 0

    return-void
.end method

.method public getCameraCapturePipelineAsync(II)Lcom/google/common/util/concurrent/ListenableFuture;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II)",
            "Lcom/google/common/util/concurrent/ListenableFuture<",
            "Landroidx/camera/core/imagecapture/CameraCapturePipeline;",
            ">;"
        }
    .end annotation

    .line 128
    new-instance p1, Landroidx/camera/core/impl/CameraControlInternal$1;

    invoke-direct {p1, p0}, Landroidx/camera/core/impl/CameraControlInternal$1;-><init>(Landroidx/camera/core/impl/CameraControlInternal;)V

    invoke-static {p1}, Landroidx/camera/core/impl/utils/futures/Futures;->immediateFuture(Ljava/lang/Object;)Lcom/google/common/util/concurrent/ListenableFuture;

    move-result-object p1

    return-object p1
.end method

.method public abstract getFlashMode()I
.end method

.method public getImplementation()Landroidx/camera/core/impl/CameraControlInternal;
    .locals 0

    return-object p0
.end method

.method public abstract getInteropConfig()Landroidx/camera/core/impl/Config;
.end method

.method public abstract getSensorRect()Landroid/graphics/Rect;
.end method

.method public abstract getSessionConfig()Landroidx/camera/core/impl/SessionConfig;
.end method

.method public incrementVideoUsage()V
    .locals 0

    return-void
.end method

.method public isInVideoUsage()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public abstract isZslDisabledByByUserCaseConfig()Z
.end method

.method public abstract setFlashMode(I)V
.end method

.method public setScreenFlash(Landroidx/camera/core/ImageCapture$ScreenFlash;)V
    .locals 0

    return-void
.end method

.method public abstract setZslDisabledByUserCaseConfig(Z)V
.end method

.method public abstract submitStillCaptureRequests(Ljava/util/List;II)Lcom/google/common/util/concurrent/ListenableFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroidx/camera/core/impl/CaptureConfig;",
            ">;II)",
            "Lcom/google/common/util/concurrent/ListenableFuture<",
            "Ljava/util/List<",
            "Ljava/lang/Void;",
            ">;>;"
        }
    .end annotation
.end method
