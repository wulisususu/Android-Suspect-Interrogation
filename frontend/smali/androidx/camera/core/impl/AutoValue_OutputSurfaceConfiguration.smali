.class final Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;
.super Landroidx/camera/core/impl/OutputSurfaceConfiguration;
.source "AutoValue_OutputSurfaceConfiguration.java"


# instance fields
.field private final imageAnalysisOutputSurface:Landroidx/camera/core/impl/OutputSurface;

.field private final imageCaptureOutputSurface:Landroidx/camera/core/impl/OutputSurface;

.field private final postviewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

.field private final previewOutputSurface:Landroidx/camera/core/impl/OutputSurface;


# direct methods
.method constructor <init>(Landroidx/camera/core/impl/OutputSurface;Landroidx/camera/core/impl/OutputSurface;Landroidx/camera/core/impl/OutputSurface;Landroidx/camera/core/impl/OutputSurface;)V
    .locals 0

    .line 23
    invoke-direct {p0}, Landroidx/camera/core/impl/OutputSurfaceConfiguration;-><init>()V

    if-eqz p1, :cond_1

    iput-object p1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->previewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    if-eqz p2, :cond_0

    iput-object p2, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageCaptureOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    iput-object p3, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageAnalysisOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    iput-object p4, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->postviewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    return-void

    .line 29
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "Null imageCaptureOutputSurface"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 25
    :cond_1
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "Null previewOutputSurface"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 75
    :cond_0
    instance-of v1, p1, Landroidx/camera/core/impl/OutputSurfaceConfiguration;

    const/4 v2, 0x0

    if-eqz v1, :cond_4

    .line 76
    check-cast p1, Landroidx/camera/core/impl/OutputSurfaceConfiguration;

    iget-object v1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->previewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    .line 77
    invoke-virtual {p1}, Landroidx/camera/core/impl/OutputSurfaceConfiguration;->getPreviewOutputSurface()Landroidx/camera/core/impl/OutputSurface;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageCaptureOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    .line 78
    invoke-virtual {p1}, Landroidx/camera/core/impl/OutputSurfaceConfiguration;->getImageCaptureOutputSurface()Landroidx/camera/core/impl/OutputSurface;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageAnalysisOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    if-nez v1, :cond_1

    .line 79
    invoke-virtual {p1}, Landroidx/camera/core/impl/OutputSurfaceConfiguration;->getImageAnalysisOutputSurface()Landroidx/camera/core/impl/OutputSurface;

    move-result-object v1

    if-nez v1, :cond_3

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Landroidx/camera/core/impl/OutputSurfaceConfiguration;->getImageAnalysisOutputSurface()Landroidx/camera/core/impl/OutputSurface;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    :goto_0
    iget-object v1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->postviewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    if-nez v1, :cond_2

    .line 80
    invoke-virtual {p1}, Landroidx/camera/core/impl/OutputSurfaceConfiguration;->getPostviewOutputSurface()Landroidx/camera/core/impl/OutputSurface;

    move-result-object p1

    if-nez p1, :cond_3

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Landroidx/camera/core/impl/OutputSurfaceConfiguration;->getPostviewOutputSurface()Landroidx/camera/core/impl/OutputSurface;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    goto :goto_1

    :cond_3
    move v0, v2

    :goto_1
    return v0

    :cond_4
    return v2
.end method

.method public getImageAnalysisOutputSurface()Landroidx/camera/core/impl/OutputSurface;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageAnalysisOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    return-object v0
.end method

.method public getImageCaptureOutputSurface()Landroidx/camera/core/impl/OutputSurface;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageCaptureOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    return-object v0
.end method

.method public getPostviewOutputSurface()Landroidx/camera/core/impl/OutputSurface;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->postviewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    return-object v0
.end method

.method public getPreviewOutputSurface()Landroidx/camera/core/impl/OutputSurface;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->previewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    iget-object v0, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->previewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    .line 89
    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-object v2, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageCaptureOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    .line 91
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageAnalysisOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    const/4 v3, 0x0

    if-nez v2, :cond_0

    move v2, v3

    goto :goto_0

    .line 93
    :cond_0
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_0
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->postviewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    if-nez v1, :cond_1

    goto :goto_1

    .line 95
    :cond_1
    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_1
    xor-int/2addr v0, v3

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 62
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "OutputSurfaceConfiguration{previewOutputSurface="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->previewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", imageCaptureOutputSurface="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageCaptureOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", imageAnalysisOutputSurface="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->imageAnalysisOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", postviewOutputSurface="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/camera/core/impl/AutoValue_OutputSurfaceConfiguration;->postviewOutputSurface:Landroidx/camera/core/impl/OutputSurface;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
