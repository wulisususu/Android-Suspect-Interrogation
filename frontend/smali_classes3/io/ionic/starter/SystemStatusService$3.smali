.class Lio/ionic/starter/SystemStatusService$3;
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

    iput-object p1, p0, Lio/ionic/starter/SystemStatusService$3;->this$0:Lio/ionic/starter/SystemStatusService;

    .line 66
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    .line 69
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 70
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    const-string p2, "bluetoothEnabled"

    .line 71
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    const-string v0, "bluetoothChange"

    invoke-static {v0, p2, p1}, Lplugins/Immersive/ImmersivePlugin;->sendEvent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
