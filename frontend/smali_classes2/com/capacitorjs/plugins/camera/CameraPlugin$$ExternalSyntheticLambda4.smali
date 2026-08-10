.class public final synthetic Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnCanceledListener;


# instance fields
.field public final synthetic f$0:Lcom/getcapacitor/PluginCall;


# direct methods
.method public synthetic constructor <init>(Lcom/getcapacitor/PluginCall;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda4;->f$0:Lcom/getcapacitor/PluginCall;

    return-void
.end method


# virtual methods
.method public final onCanceled()V
    .locals 1

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraPlugin$$ExternalSyntheticLambda4;->f$0:Lcom/getcapacitor/PluginCall;

    invoke-static {v0}, Lcom/capacitorjs/plugins/camera/CameraPlugin;->lambda$showPrompt$1(Lcom/getcapacitor/PluginCall;)V

    return-void
.end method
