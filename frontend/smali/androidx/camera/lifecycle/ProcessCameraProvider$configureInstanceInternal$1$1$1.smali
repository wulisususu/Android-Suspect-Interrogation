.class final Landroidx/camera/lifecycle/ProcessCameraProvider$configureInstanceInternal$1$1$1;
.super Ljava/lang/Object;
.source "ProcessCameraProvider.kt"

# interfaces
.implements Landroidx/camera/core/CameraXConfig$Provider;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/camera/lifecycle/ProcessCameraProvider;->configureInstanceInternal(Landroidx/camera/core/CameraXConfig;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0008\n\u0000\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u0001H\n\u00a2\u0006\u0002\u0008\u0002"
    }
    d2 = {
        "<anonymous>",
        "Landroidx/camera/core/CameraXConfig;",
        "getCameraXConfig"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $cameraXConfig:Landroidx/camera/core/CameraXConfig;


# direct methods
.method constructor <init>(Landroidx/camera/core/CameraXConfig;)V
    .locals 0

    iput-object p1, p0, Landroidx/camera/lifecycle/ProcessCameraProvider$configureInstanceInternal$1$1$1;->$cameraXConfig:Landroidx/camera/core/CameraXConfig;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getCameraXConfig()Landroidx/camera/core/CameraXConfig;
    .locals 1

    iget-object v0, p0, Landroidx/camera/lifecycle/ProcessCameraProvider$configureInstanceInternal$1$1$1;->$cameraXConfig:Landroidx/camera/core/CameraXConfig;

    return-object v0
.end method
