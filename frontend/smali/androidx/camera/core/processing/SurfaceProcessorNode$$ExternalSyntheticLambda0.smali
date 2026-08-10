.class public final synthetic Landroidx/camera/core/processing/SurfaceProcessorNode$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroidx/core/util/Consumer;


# instance fields
.field public final synthetic f$0:Ljava/util/Map;


# direct methods
.method public synthetic constructor <init>(Ljava/util/Map;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/camera/core/processing/SurfaceProcessorNode$$ExternalSyntheticLambda0;->f$0:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    iget-object v0, p0, Landroidx/camera/core/processing/SurfaceProcessorNode$$ExternalSyntheticLambda0;->f$0:Ljava/util/Map;

    check-cast p1, Landroidx/camera/core/SurfaceRequest$TransformationInfo;

    invoke-static {v0, p1}, Landroidx/camera/core/processing/SurfaceProcessorNode;->lambda$setUpRotationUpdates$1(Ljava/util/Map;Landroidx/camera/core/SurfaceRequest$TransformationInfo;)V

    return-void
.end method
