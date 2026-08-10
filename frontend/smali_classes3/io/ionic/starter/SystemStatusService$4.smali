.class Lio/ionic/starter/SystemStatusService$4;
.super Landroid/content/BroadcastReceiver;
.source "SystemStatusService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/ionic/starter/SystemStatusService;->onCreate()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/ionic/starter/SystemStatusService;


# direct methods
.method constructor <init>(Lio/ionic/starter/SystemStatusService;)V
    .locals 0

    iput-object p1, p0, Lio/ionic/starter/SystemStatusService$4;->this$0:Lio/ionic/starter/SystemStatusService;

    .line 77
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    iget-object p1, p0, Lio/ionic/starter/SystemStatusService$4;->this$0:Lio/ionic/starter/SystemStatusService;

    const-string p2, "audio"

    .line 80
    invoke-virtual {p1, p2}, Lio/ionic/starter/SystemStatusService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/media/AudioManager;

    const/4 p2, 0x3

    .line 81
    invoke-virtual {p1, p2}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result p1

    const-string p2, "volume"

    .line 82
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v0, "volumeChange"

    invoke-static {v0, p2, p1}, Lplugins/Immersive/ImmersivePlugin;->sendEvent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
