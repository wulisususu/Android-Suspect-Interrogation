.class public Landroidx/camera/core/impl/RestrictedCameraInfo;
.super Landroidx/camera/core/impl/ForwardingCameraInfo;
.source "RestrictedCameraInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/core/impl/RestrictedCameraInfo$CameraOperation;
    }
.end annotation


# static fields
.field public static final CAMERA_OPERATION_AE_REGION:I = 0x3

.field public static final CAMERA_OPERATION_AF_REGION:I = 0x2

.field public static final CAMERA_OPERATION_AUTO_FOCUS:I = 0x1

.field public static final CAMERA_OPERATION_AWB_REGION:I = 0x4

.field public static final CAMERA_OPERATION_EXPOSURE_COMPENSATION:I = 0x7

.field public static final CAMERA_OPERATION_EXTENSION_STRENGTH:I = 0x8

.field public static final CAMERA_OPERATION_FLASH:I = 0x5

.field public static final CAMERA_OPERATION_TORCH:I = 0x6

.field public static final CAMERA_OPERATION_ZOOM:I


# instance fields
.field private final mCameraConfig:Landroidx/camera/core/impl/CameraConfig;

.field private final mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

.field private mIsCaptureProcessProgressSupported:Z

.field private mIsPostviewSupported:Z

.field private final mSessionProcessor:Landroidx/camera/core/impl/SessionProcessor;


# direct methods
.method public constructor <init>(Landroidx/camera/core/impl/CameraInfoInternal;Landroidx/camera/core/impl/CameraConfig;)V
    .locals 1

    .line 73
    invoke-direct {p0, p1}, Landroidx/camera/core/impl/ForwardingCameraInfo;-><init>(Landroidx/camera/core/impl/CameraInfoInternal;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mIsPostviewSupported:Z

    iput-boolean v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mIsCaptureProcessProgressSupported:Z

    iput-object p1, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    iput-object p2, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mCameraConfig:Landroidx/camera/core/impl/CameraConfig;

    const/4 p1, 0x0

    .line 76
    invoke-interface {p2, p1}, Landroidx/camera/core/impl/CameraConfig;->getSessionProcessor(Landroidx/camera/core/impl/SessionProcessor;)Landroidx/camera/core/impl/SessionProcessor;

    move-result-object p1

    iput-object p1, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mSessionProcessor:Landroidx/camera/core/impl/SessionProcessor;

    .line 78
    invoke-interface {p2}, Landroidx/camera/core/impl/CameraConfig;->isPostviewSupported()Z

    move-result p1

    invoke-virtual {p0, p1}, Landroidx/camera/core/impl/RestrictedCameraInfo;->setPostviewSupported(Z)V

    .line 79
    invoke-interface {p2}, Landroidx/camera/core/impl/CameraConfig;->isCaptureProcessProgressSupported()Z

    move-result p1

    invoke-virtual {p0, p1}, Landroidx/camera/core/impl/RestrictedCameraInfo;->setCaptureProcessProgressSupported(Z)V

    return-void
.end method


# virtual methods
.method public getCameraConfig()Landroidx/camera/core/impl/CameraConfig;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mCameraConfig:Landroidx/camera/core/impl/CameraConfig;

    return-object v0
.end method

.method public getExposureState()Landroidx/camera/core/ExposureState;
    .locals 2

    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mSessionProcessor:Landroidx/camera/core/impl/SessionProcessor;

    const/4 v1, 0x7

    filled-new-array {v1}, [I

    move-result-object v1

    .line 134
    invoke-static {v0, v1}, Landroidx/camera/core/impl/utils/SessionProcessorUtil;->isOperationSupported(Landroidx/camera/core/impl/SessionProcessor;[I)Z

    move-result v0

    if-nez v0, :cond_0

    .line 136
    new-instance v0, Landroidx/camera/core/impl/RestrictedCameraInfo$1;

    invoke-direct {v0, p0}, Landroidx/camera/core/impl/RestrictedCameraInfo$1;-><init>(Landroidx/camera/core/impl/RestrictedCameraInfo;)V

    return-object v0

    :cond_0
    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    .line 160
    invoke-interface {v0}, Landroidx/camera/core/impl/CameraInfoInternal;->getExposureState()Landroidx/camera/core/ExposureState;

    move-result-object v0

    return-object v0
.end method

.method public getImplementation()Landroidx/camera/core/impl/CameraInfoInternal;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    return-object v0
.end method

.method public getSessionProcessor()Landroidx/camera/core/impl/SessionProcessor;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mSessionProcessor:Landroidx/camera/core/impl/SessionProcessor;

    return-object v0
.end method

.method public getTorchState()Landroidx/lifecycle/LiveData;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Landroidx/lifecycle/LiveData<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mSessionProcessor:Landroidx/camera/core/impl/SessionProcessor;

    const/4 v1, 0x6

    filled-new-array {v1}, [I

    move-result-object v1

    .line 113
    invoke-static {v0, v1}, Landroidx/camera/core/impl/utils/SessionProcessorUtil;->isOperationSupported(Landroidx/camera/core/impl/SessionProcessor;[I)Z

    move-result v0

    if-nez v0, :cond_0

    .line 114
    new-instance v0, Landroidx/lifecycle/MutableLiveData;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/lifecycle/MutableLiveData;-><init>(Ljava/lang/Object;)V

    return-object v0

    :cond_0
    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    .line 117
    invoke-interface {v0}, Landroidx/camera/core/impl/CameraInfoInternal;->getTorchState()Landroidx/lifecycle/LiveData;

    move-result-object v0

    return-object v0
.end method

.method public getZoomState()Landroidx/lifecycle/LiveData;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Landroidx/lifecycle/LiveData<",
            "Landroidx/camera/core/ZoomState;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mSessionProcessor:Landroidx/camera/core/impl/SessionProcessor;

    const/4 v1, 0x0

    filled-new-array {v1}, [I

    move-result-object v1

    .line 123
    invoke-static {v0, v1}, Landroidx/camera/core/impl/utils/SessionProcessorUtil;->isOperationSupported(Landroidx/camera/core/impl/SessionProcessor;[I)Z

    move-result v0

    if-nez v0, :cond_0

    .line 124
    new-instance v0, Landroidx/lifecycle/MutableLiveData;

    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v2, v2, v2, v1}, Landroidx/camera/core/internal/ImmutableZoomState;->create(FFFF)Landroidx/camera/core/ZoomState;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/lifecycle/MutableLiveData;-><init>(Ljava/lang/Object;)V

    return-object v0

    :cond_0
    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    .line 128
    invoke-interface {v0}, Landroidx/camera/core/impl/CameraInfoInternal;->getZoomState()Landroidx/lifecycle/LiveData;

    move-result-object v0

    return-object v0
.end method

.method public hasFlashUnit()Z
    .locals 2

    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mSessionProcessor:Landroidx/camera/core/impl/SessionProcessor;

    const/4 v1, 0x5

    filled-new-array {v1}, [I

    move-result-object v1

    .line 103
    invoke-static {v0, v1}, Landroidx/camera/core/impl/utils/SessionProcessorUtil;->isOperationSupported(Landroidx/camera/core/impl/SessionProcessor;[I)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    .line 107
    invoke-interface {v0}, Landroidx/camera/core/impl/CameraInfoInternal;->hasFlashUnit()Z

    move-result v0

    return v0
.end method

.method public isCaptureProcessProgressSupported()Z
    .locals 1

    iget-boolean v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mIsCaptureProcessProgressSupported:Z

    return v0
.end method

.method public isFocusMeteringSupported(Landroidx/camera/core/FocusMeteringAction;)Z
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mSessionProcessor:Landroidx/camera/core/impl/SessionProcessor;

    .line 166
    invoke-static {v0, p1}, Landroidx/camera/core/impl/utils/SessionProcessorUtil;->getModifiedFocusMeteringAction(Landroidx/camera/core/impl/SessionProcessor;Landroidx/camera/core/FocusMeteringAction;)Landroidx/camera/core/FocusMeteringAction;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    iget-object v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mCameraInfo:Landroidx/camera/core/impl/CameraInfoInternal;

    .line 170
    invoke-interface {v0, p1}, Landroidx/camera/core/impl/CameraInfoInternal;->isFocusMeteringSupported(Landroidx/camera/core/FocusMeteringAction;)Z

    move-result p1

    return p1
.end method

.method public isPostviewSupported()Z
    .locals 1

    iget-boolean v0, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mIsPostviewSupported:Z

    return v0
.end method

.method public setCaptureProcessProgressSupported(Z)V
    .locals 0

    iput-boolean p1, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mIsCaptureProcessProgressSupported:Z

    return-void
.end method

.method public setPostviewSupported(Z)V
    .locals 0

    iput-boolean p1, p0, Landroidx/camera/core/impl/RestrictedCameraInfo;->mIsPostviewSupported:Z

    return-void
.end method
