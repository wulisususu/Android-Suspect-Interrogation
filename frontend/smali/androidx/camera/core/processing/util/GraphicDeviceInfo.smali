.class public abstract Landroidx/camera/core/processing/util/GraphicDeviceInfo;
.super Ljava/lang/Object;
.source "GraphicDeviceInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/core/processing/util/GraphicDeviceInfo$Builder;
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 85
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static builder()Landroidx/camera/core/processing/util/GraphicDeviceInfo$Builder;
    .locals 2

    .line 77
    new-instance v0, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo$Builder;

    invoke-direct {v0}, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo$Builder;-><init>()V

    const-string v1, "0.0"

    .line 78
    invoke-virtual {v0, v1}, Landroidx/camera/core/processing/util/AutoValue_GraphicDeviceInfo$Builder;->setGlVersion(Ljava/lang/String;)Landroidx/camera/core/processing/util/GraphicDeviceInfo$Builder;

    move-result-object v0

    .line 79
    invoke-virtual {v0, v1}, Landroidx/camera/core/processing/util/GraphicDeviceInfo$Builder;->setEglVersion(Ljava/lang/String;)Landroidx/camera/core/processing/util/GraphicDeviceInfo$Builder;

    move-result-object v0

    const-string v1, ""

    .line 80
    invoke-virtual {v0, v1}, Landroidx/camera/core/processing/util/GraphicDeviceInfo$Builder;->setGlExtensions(Ljava/lang/String;)Landroidx/camera/core/processing/util/GraphicDeviceInfo$Builder;

    move-result-object v0

    .line 81
    invoke-virtual {v0, v1}, Landroidx/camera/core/processing/util/GraphicDeviceInfo$Builder;->setEglExtensions(Ljava/lang/String;)Landroidx/camera/core/processing/util/GraphicDeviceInfo$Builder;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public abstract getEglExtensions()Ljava/lang/String;
.end method

.method public abstract getEglVersion()Ljava/lang/String;
.end method

.method public abstract getGlExtensions()Ljava/lang/String;
.end method

.method public abstract getGlVersion()Ljava/lang/String;
.end method
