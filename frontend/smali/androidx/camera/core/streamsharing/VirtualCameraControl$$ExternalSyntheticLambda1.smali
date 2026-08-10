.class public final synthetic Landroidx/camera/core/streamsharing/VirtualCameraControl$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroidx/camera/core/impl/utils/futures/AsyncFunction;


# instance fields
.field public final synthetic f$0:Landroidx/camera/core/streamsharing/VirtualCameraControl;

.field public final synthetic f$1:Ljava/util/List;


# direct methods
.method public synthetic constructor <init>(Landroidx/camera/core/streamsharing/VirtualCameraControl;Ljava/util/List;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/camera/core/streamsharing/VirtualCameraControl$$ExternalSyntheticLambda1;->f$0:Landroidx/camera/core/streamsharing/VirtualCameraControl;

    iput-object p2, p0, Landroidx/camera/core/streamsharing/VirtualCameraControl$$ExternalSyntheticLambda1;->f$1:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Lcom/google/common/util/concurrent/ListenableFuture;
    .locals 2

    iget-object v0, p0, Landroidx/camera/core/streamsharing/VirtualCameraControl$$ExternalSyntheticLambda1;->f$0:Landroidx/camera/core/streamsharing/VirtualCameraControl;

    iget-object v1, p0, Landroidx/camera/core/streamsharing/VirtualCameraControl$$ExternalSyntheticLambda1;->f$1:Ljava/util/List;

    check-cast p1, Ljava/lang/Void;

    invoke-virtual {v0, v1, p1}, Landroidx/camera/core/streamsharing/VirtualCameraControl;->lambda$submitStillCaptureRequests$1$androidx-camera-core-streamsharing-VirtualCameraControl(Ljava/util/List;Ljava/lang/Void;)Lcom/google/common/util/concurrent/ListenableFuture;

    move-result-object p1

    return-object p1
.end method
