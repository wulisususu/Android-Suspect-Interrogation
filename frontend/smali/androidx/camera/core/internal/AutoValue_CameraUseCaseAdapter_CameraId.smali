.class final Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;
.super Landroidx/camera/core/internal/CameraUseCaseAdapter$CameraId;
.source "AutoValue_CameraUseCaseAdapter_CameraId.java"


# instance fields
.field private final cameraConfigId:Landroidx/camera/core/impl/Identifier;

.field private final cameraIdString:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Landroidx/camera/core/impl/Identifier;)V
    .locals 0

    .line 17
    invoke-direct {p0}, Landroidx/camera/core/internal/CameraUseCaseAdapter$CameraId;-><init>()V

    if-eqz p1, :cond_1

    iput-object p1, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraIdString:Ljava/lang/String;

    if-eqz p2, :cond_0

    iput-object p2, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraConfigId:Landroidx/camera/core/impl/Identifier;

    return-void

    .line 23
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "Null cameraConfigId"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 19
    :cond_1
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "Null cameraIdString"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 53
    :cond_0
    instance-of v1, p1, Landroidx/camera/core/internal/CameraUseCaseAdapter$CameraId;

    const/4 v2, 0x0

    if-eqz v1, :cond_2

    .line 54
    check-cast p1, Landroidx/camera/core/internal/CameraUseCaseAdapter$CameraId;

    iget-object v1, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraIdString:Ljava/lang/String;

    .line 55
    invoke-virtual {p1}, Landroidx/camera/core/internal/CameraUseCaseAdapter$CameraId;->getCameraIdString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraConfigId:Landroidx/camera/core/impl/Identifier;

    .line 56
    invoke-virtual {p1}, Landroidx/camera/core/internal/CameraUseCaseAdapter$CameraId;->getCameraConfigId()Landroidx/camera/core/impl/Identifier;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    goto :goto_0

    :cond_1
    move v0, v2

    :goto_0
    return v0

    :cond_2
    return v2
.end method

.method public getCameraConfigId()Landroidx/camera/core/impl/Identifier;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraConfigId:Landroidx/camera/core/impl/Identifier;

    return-object v0
.end method

.method public getCameraIdString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraIdString:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    iget-object v0, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraIdString:Ljava/lang/String;

    .line 65
    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-object v1, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraConfigId:Landroidx/camera/core/impl/Identifier;

    .line 67
    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 42
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "CameraId{cameraIdString="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraIdString:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", cameraConfigId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;->cameraConfigId:Landroidx/camera/core/impl/Identifier;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
