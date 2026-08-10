.class Lio/ionic/starter/SystemStatusService$1;
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

    iput-object p1, p0, Lio/ionic/starter/SystemStatusService$1;->this$0:Lio/ionic/starter/SystemStatusService;

    .line 41
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    const-string p1, "level"

    const/4 v0, -0x1

    .line 44
    invoke-virtual {p2, p1, v0}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    const-string p2, "battery"

    .line 45
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v0, "batteryChange"

    invoke-static {v0, p2, p1}, Lplugins/Immersive/ImmersivePlugin;->sendEvent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
