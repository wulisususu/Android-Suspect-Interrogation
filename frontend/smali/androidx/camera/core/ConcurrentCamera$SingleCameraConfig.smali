.class public final Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;
.super Ljava/lang/Object;
.source "ConcurrentCamera.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/core/ConcurrentCamera;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "SingleCameraConfig"
.end annotation


# instance fields
.field private mCameraSelector:Landroidx/camera/core/CameraSelector;

.field private mLayoutSettings:Landroidx/camera/core/LayoutSettings;

.field private mLifecycleOwner:Landroidx/lifecycle/LifecycleOwner;

.field private mUseCaseGroup:Landroidx/camera/core/UseCaseGroup;


# direct methods
.method public constructor <init>(Landroidx/camera/core/CameraSelector;Landroidx/camera/core/UseCaseGroup;Landroidx/camera/core/LayoutSettings;Landroidx/lifecycle/LifecycleOwner;)V
    .locals 0

    .line 111
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;->mCameraSelector:Landroidx/camera/core/CameraSelector;

    iput-object p2, p0, Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;->mUseCaseGroup:Landroidx/camera/core/UseCaseGroup;

    iput-object p3, p0, Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;->mLayoutSettings:Landroidx/camera/core/LayoutSettings;

    iput-object p4, p0, Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;->mLifecycleOwner:Landroidx/lifecycle/LifecycleOwner;

    return-void
.end method

.method public constructor <init>(Landroidx/camera/core/CameraSelector;Landroidx/camera/core/UseCaseGroup;Landroidx/lifecycle/LifecycleOwner;)V
    .locals 1

    .line 95
    sget-object v0, Landroidx/camera/core/LayoutSettings;->DEFAULT:Landroidx/camera/core/LayoutSettings;

    invoke-direct {p0, p1, p2, v0, p3}, Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;-><init>(Landroidx/camera/core/CameraSelector;Landroidx/camera/core/UseCaseGroup;Landroidx/camera/core/LayoutSettings;Landroidx/lifecycle/LifecycleOwner;)V

    return-void
.end method


# virtual methods
.method public getCameraSelector()Landroidx/camera/core/CameraSelector;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;->mCameraSelector:Landroidx/camera/core/CameraSelector;

    return-object v0
.end method

.method public getLayoutSettings()Landroidx/camera/core/LayoutSettings;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;->mLayoutSettings:Landroidx/camera/core/LayoutSettings;

    return-object v0
.end method

.method public getLifecycleOwner()Landroidx/lifecycle/LifecycleOwner;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;->mLifecycleOwner:Landroidx/lifecycle/LifecycleOwner;

    return-object v0
.end method

.method public getUseCaseGroup()Landroidx/camera/core/UseCaseGroup;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/ConcurrentCamera$SingleCameraConfig;->mUseCaseGroup:Landroidx/camera/core/UseCaseGroup;

    return-object v0
.end method
