.class abstract Landroidx/camera/core/imagecapture/TakePictureManager$CaptureError;
.super Ljava/lang/Object;
.source "TakePictureManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/core/imagecapture/TakePictureManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x408
    name = "CaptureError"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 309
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static of(ILandroidx/camera/core/ImageCaptureException;)Landroidx/camera/core/imagecapture/TakePictureManager$CaptureError;
    .locals 1

    .line 317
    new-instance v0, Landroidx/camera/core/imagecapture/AutoValue_TakePictureManager_CaptureError;

    invoke-direct {v0, p0, p1}, Landroidx/camera/core/imagecapture/AutoValue_TakePictureManager_CaptureError;-><init>(ILandroidx/camera/core/ImageCaptureException;)V

    return-object v0
.end method


# virtual methods
.method abstract getImageCaptureException()Landroidx/camera/core/ImageCaptureException;
.end method

.method abstract getRequestId()I
.end method
