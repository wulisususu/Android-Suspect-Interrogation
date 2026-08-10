.class public final synthetic Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroidx/activity/result/ActivityResultCallback;


# instance fields
.field public final synthetic f$0:Lcom/capacitorjs/plugins/camera/CameraPlugin;

.field public final synthetic f$1:Lcom/getcapacitor/PluginCall;


# direct methods
.method public synthetic constructor <init>(Lcom/capacitorjs/plugins/camera/CameraPlugin;Lcom/getcapacitor/PluginCall;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda1;->f$0:Lcom/capacitorjs/plugins/camera/CameraPlugin;

    iput-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda1;->f$1:Lcom/getcapacitor/PluginCall;

    return-void
.end method


# virtual methods
.method public final onActivityResult(Ljava/lang/Object;)V
    .locals 2

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda1;->f$0:Lcom/capacitorjs/plugins/camera/CameraPlugin;

    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda1;->f$1:Lcom/getcapacitor/PluginCall;

    check-cast p1, Ljava/util/List;

    invoke-static {v0, v1, p1}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->$r8$lambda$fTjbhwXpo9A6PA35qcfl__8nKdQ(Lcom/capacitorjs/plugins/camera/CameraPlugin;Lcom/getcapacitor/PluginCall;Ljava/util/List;)V

    return-void
.end method
