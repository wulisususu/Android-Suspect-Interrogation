.class public abstract Landroidx/camera/core/internal/CameraUseCaseAdapter$CameraId;
.super Ljava/lang/Object;
.source "CameraUseCaseAdapter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/core/internal/CameraUseCaseAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "CameraId"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1093
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static create(Ljava/lang/String;Landroidx/camera/core/impl/Identifier;)Landroidx/camera/core/internal/CameraUseCaseAdapter$CameraId;
    .locals 1

    .line 1098
    new-instance v0, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;

    invoke-direct {v0, p0, p1}, Landroidx/camera/core/internal/AutoValue_CameraUseCaseAdapter_CameraId;-><init>(Ljava/lang/String;Landroidx/camera/core/impl/Identifier;)V

    return-object v0
.end method


# virtual methods
.method public abstract getCameraConfigId()Landroidx/camera/core/impl/Identifier;
.end method

.method public abstract getCameraIdString()Ljava/lang/String;
.end method
