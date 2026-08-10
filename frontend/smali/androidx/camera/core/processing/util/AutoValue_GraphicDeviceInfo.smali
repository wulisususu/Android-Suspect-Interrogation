.class final Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;
.super Landroidx/camera/core/processing/util/GraphicDeviceInfo;
.source "AutoValue_GraphicDeviceInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo$Builder;
    }
.end annotation


# instance fields
.field private final eglExtensions:Ljava/lang/String;

.field private final eglVersion:Ljava/lang/String;

.field private final glExtensions:Ljava/lang/String;

.field private final glVersion:Ljava/lang/String;


# direct methods
.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 22
    invoke-direct {p0}, Landroidx/camera/core/processing/util/GraphicDeviceInfo;-><init>()V

    iput-object p1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glVersion:Ljava/lang/String;

    iput-object p2, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglVersion:Ljava/lang/String;

    iput-object p3, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glExtensions:Ljava/lang/String;

    iput-object p4, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglExtensions:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo$1;)V
    .locals 0

    .line 8
    invoke-direct {p0, p1, p2, p3, p4}, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 68
    :cond_0
    instance-of v1, p1, Landroidx/camera/core/processing/util/GraphicDeviceInfo;

    const/4 v2, 0x0

    if-eqz v1, :cond_2

    .line 69
    check-cast p1, Landroidx/camera/core/processing/util/GraphicDeviceInfo;

    iget-object v1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glVersion:Ljava/lang/String;

    .line 70
    invoke-virtual {p1}, Landroidx/camera/core/processing/util/GraphicDeviceInfo;->getGlVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglVersion:Ljava/lang/String;

    .line 71
    invoke-virtual {p1}, Landroidx/camera/core/processing/util/GraphicDeviceInfo;->getEglVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glExtensions:Ljava/lang/String;

    .line 72
    invoke-virtual {p1}, Landroidx/camera/core/processing/util/GraphicDeviceInfo;->getGlExtensions()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglExtensions:Ljava/lang/String;

    .line 73
    invoke-virtual {p1}, Landroidx/camera/core/processing/util/GraphicDeviceInfo;->getEglExtensions()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

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

.method public getEglExtensions()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglExtensions:Ljava/lang/String;

    return-object v0
.end method

.method public getEglVersion()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglVersion:Ljava/lang/String;

    return-object v0
.end method

.method public getGlExtensions()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glExtensions:Ljava/lang/String;

    return-object v0
.end method

.method public getGlVersion()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glVersion:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glVersion:Ljava/lang/String;

    .line 82
    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-object v2, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglVersion:Ljava/lang/String;

    .line 84
    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glExtensions:Ljava/lang/String;

    .line 86
    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglExtensions:Ljava/lang/String;

    .line 88
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 55
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "GraphicDeviceInfo{glVersion="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glVersion:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", eglVersion="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglVersion:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", glExtensions="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->glExtensions:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", eglExtensions="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo;->eglExtensions:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
