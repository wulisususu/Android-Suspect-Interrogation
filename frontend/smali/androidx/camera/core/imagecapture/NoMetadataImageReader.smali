.class public Landroidx/camera/core/imagecapture/NoMetadataImageReader;
.super Ljava/lang/Object;
.source "NoMetadataImageReader.java"

# interfaces
.implements Landroidx/camera/core/impl/ImageReaderProxy;


# instance fields
.field private mPendingRequest:Landroidx/camera/core/imagecapture/ProcessingRequest;

.field private final mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;


# direct methods
.method constructor <init>(Landroidx/camera/core/impl/ImageReaderProxy;)V
    .locals 0

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    return-void
.end method

.method private createImageProxyWithEmptyMetadata(Landroidx/camera/core/ImageProxy;)Landroidx/camera/core/ImageProxy;
    .locals 7

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    iget-object v1, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mPendingRequest:Landroidx/camera/core/imagecapture/ProcessingRequest;

    if-nez v1, :cond_1

    .line 135
    invoke-static {}, Landroidx/camera/core/impl/TagBundle;->emptyBundle()Landroidx/camera/core/impl/TagBundle;

    move-result-object v1

    goto :goto_0

    .line 136
    :cond_1
    new-instance v1, Landroid/util/Pair;

    iget-object v2, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mPendingRequest:Landroidx/camera/core/imagecapture/ProcessingRequest;

    invoke-virtual {v2}, Landroidx/camera/core/imagecapture/ProcessingRequest;->getTagBundleKey()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mPendingRequest:Landroidx/camera/core/imagecapture/ProcessingRequest;

    .line 137
    invoke-virtual {v3}, Landroidx/camera/core/imagecapture/ProcessingRequest;->getStageIds()Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 136
    invoke-static {v1}, Landroidx/camera/core/impl/TagBundle;->create(Landroid/util/Pair;)Landroidx/camera/core/impl/TagBundle;

    move-result-object v1

    :goto_0
    iput-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mPendingRequest:Landroidx/camera/core/imagecapture/ProcessingRequest;

    .line 139
    new-instance v0, Landroidx/camera/core/SettableImageProxy;

    new-instance v2, Landroid/util/Size;

    .line 140
    invoke-interface {p1}, Landroidx/camera/core/ImageProxy;->getWidth()I

    move-result v3

    invoke-interface {p1}, Landroidx/camera/core/ImageProxy;->getHeight()I

    move-result v4

    invoke-direct {v2, v3, v4}, Landroid/util/Size;-><init>(II)V

    new-instance v3, Landroidx/camera/core/internal/CameraCaptureResultImageInfo;

    new-instance v4, Landroidx/camera/core/streamsharing/VirtualCameraCaptureResult;

    .line 142
    invoke-interface {p1}, Landroidx/camera/core/ImageProxy;->getImageInfo()Landroidx/camera/core/ImageInfo;

    move-result-object v5

    invoke-interface {v5}, Landroidx/camera/core/ImageInfo;->getTimestamp()J

    move-result-wide v5

    invoke-direct {v4, v1, v5, v6}, Landroidx/camera/core/streamsharing/VirtualCameraCaptureResult;-><init>(Landroidx/camera/core/impl/TagBundle;J)V

    invoke-direct {v3, v4}, Landroidx/camera/core/internal/CameraCaptureResultImageInfo;-><init>(Landroidx/camera/core/impl/CameraCaptureResult;)V

    invoke-direct {v0, p1, v2, v3}, Landroidx/camera/core/SettableImageProxy;-><init>(Landroidx/camera/core/ImageProxy;Landroid/util/Size;Landroidx/camera/core/ImageInfo;)V

    return-object v0
.end method


# virtual methods
.method acceptProcessingRequest(Landroidx/camera/core/imagecapture/ProcessingRequest;)V
    .locals 2

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mPendingRequest:Landroidx/camera/core/imagecapture/ProcessingRequest;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const-string v1, "Pending request should be null"

    .line 66
    invoke-static {v0, v1}, Landroidx/core/util/Preconditions;->checkState(ZLjava/lang/String;)V

    iput-object p1, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mPendingRequest:Landroidx/camera/core/imagecapture/ProcessingRequest;

    return-void
.end method

.method public acquireLatestImage()Landroidx/camera/core/ImageProxy;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 77
    invoke-interface {v0}, Landroidx/camera/core/impl/ImageReaderProxy;->acquireLatestImage()Landroidx/camera/core/ImageProxy;

    move-result-object v0

    invoke-direct {p0, v0}, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->createImageProxyWithEmptyMetadata(Landroidx/camera/core/ImageProxy;)Landroidx/camera/core/ImageProxy;

    move-result-object v0

    return-object v0
.end method

.method public acquireNextImage()Landroidx/camera/core/ImageProxy;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 83
    invoke-interface {v0}, Landroidx/camera/core/impl/ImageReaderProxy;->acquireNextImage()Landroidx/camera/core/ImageProxy;

    move-result-object v0

    invoke-direct {p0, v0}, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->createImageProxyWithEmptyMetadata(Landroidx/camera/core/ImageProxy;)Landroidx/camera/core/ImageProxy;

    move-result-object v0

    return-object v0
.end method

.method public clearOnImageAvailableListener()V
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 126
    invoke-interface {v0}, Landroidx/camera/core/impl/ImageReaderProxy;->clearOnImageAvailableListener()V

    return-void
.end method

.method clearProcessingRequest()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mPendingRequest:Landroidx/camera/core/imagecapture/ProcessingRequest;

    return-void
.end method

.method public close()V
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 88
    invoke-interface {v0}, Landroidx/camera/core/impl/ImageReaderProxy;->close()V

    return-void
.end method

.method public getHeight()I
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 93
    invoke-interface {v0}, Landroidx/camera/core/impl/ImageReaderProxy;->getHeight()I

    move-result v0

    return v0
.end method

.method public getImageFormat()I
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 103
    invoke-interface {v0}, Landroidx/camera/core/impl/ImageReaderProxy;->getImageFormat()I

    move-result v0

    return v0
.end method

.method public getMaxImages()I
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 108
    invoke-interface {v0}, Landroidx/camera/core/impl/ImageReaderProxy;->getMaxImages()I

    move-result v0

    return v0
.end method

.method public getSurface()Landroid/view/Surface;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 114
    invoke-interface {v0}, Landroidx/camera/core/impl/ImageReaderProxy;->getSurface()Landroid/view/Surface;

    move-result-object v0

    return-object v0
.end method

.method public getWidth()I
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 98
    invoke-interface {v0}, Landroidx/camera/core/impl/ImageReaderProxy;->getWidth()I

    move-result v0

    return v0
.end method

.method synthetic lambda$setOnImageAvailableListener$0$androidx-camera-core-imagecapture-NoMetadataImageReader(Landroidx/camera/core/impl/ImageReaderProxy$OnImageAvailableListener;Landroidx/camera/core/impl/ImageReaderProxy;)V
    .locals 0

    .line 121
    invoke-interface {p1, p0}, Landroidx/camera/core/impl/ImageReaderProxy$OnImageAvailableListener;->onImageAvailable(Landroidx/camera/core/impl/ImageReaderProxy;)V

    return-void
.end method

.method public setOnImageAvailableListener(Landroidx/camera/core/impl/ImageReaderProxy$OnImageAvailableListener;Ljava/util/concurrent/Executor;)V
    .locals 2

    iget-object v0, p0, Landroidx/camera/core/imagecapture/NoMetadataImageReader;->mWrappedImageReader:Landroidx/camera/core/impl/ImageReaderProxy;

    .line 120
    new-instance v1, Landroidx/camera/core/imagecapture/NoMetadataImageReader$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Landroidx/camera/core/imagecapture/NoMetadataImageReader$$ExternalSyntheticLambda0;-><init>(Landroidx/camera/core/imagecapture/NoMetadataImageReader;Landroidx/camera/core/impl/ImageReaderProxy$OnImageAvailableListener;)V

    invoke-interface {v0, v1, p2}, Landroidx/camera/core/impl/ImageReaderProxy;->setOnImageAvailableListener(Landroidx/camera/core/impl/ImageReaderProxy$OnImageAvailableListener;Ljava/util/concurrent/Executor;)V

    return-void
.end method
