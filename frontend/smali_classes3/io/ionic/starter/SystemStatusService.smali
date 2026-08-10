.class public Lio/ionic/starter/SystemStatusService;
.super Landroid/app/Service;
.source "SystemStatusService.java"


# instance fields
.field private batteryReceiver:Landroid/content/BroadcastReceiver;

.field private bluetoothReceiver:Landroid/content/BroadcastReceiver;

.field private signalStrengthValue:I

.field private volumeReceiver:Landroid/content/BroadcastReceiver;

.field private wifiReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method static bridge synthetic -$$Nest$fgetsignalStrengthValue(Lio/ionic/starter/SystemStatusService;)I
    .locals 0

    iget p0, p0, Lio/ionic/starter/SystemStatusService;->signalStrengthValue:I

    return p0
.end method

.method static bridge synthetic -$$Nest$fputsignalStrengthValue(Lio/ionic/starter/SystemStatusService;I)V
    .locals 0

    iput p1, p0, Lio/ionic/starter/SystemStatusService;->signalStrengthValue:I

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 27
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lio/ionic/starter/SystemStatusService;->signalStrengthValue:I

    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 3

    .line 38
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 41
    new-instance v0, Lio/ionic/starter/SystemStatusService$1;

    invoke-direct {v0, p0}, Lio/ionic/starter/SystemStatusService$1;-><init>(Lio/ionic/starter/SystemStatusService;)V

    iput-object v0, p0, Lio/ionic/starter/SystemStatusService;->batteryReceiver:Landroid/content/BroadcastReceiver;

    .line 48
    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.intent.action.BATTERY_CHANGED"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v1}, Lio/ionic/starter/SystemStatusService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 51
    new-instance v0, Lio/ionic/starter/SystemStatusService$2;

    invoke-direct {v0, p0}, Lio/ionic/starter/SystemStatusService$2;-><init>(Lio/ionic/starter/SystemStatusService;)V

    iput-object v0, p0, Lio/ionic/starter/SystemStatusService;->wifiReceiver:Landroid/content/BroadcastReceiver;

    .line 63
    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v1}, Lio/ionic/starter/SystemStatusService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 66
    new-instance v0, Lio/ionic/starter/SystemStatusService$3;

    invoke-direct {v0, p0}, Lio/ionic/starter/SystemStatusService$3;-><init>(Lio/ionic/starter/SystemStatusService;)V

    iput-object v0, p0, Lio/ionic/starter/SystemStatusService;->bluetoothReceiver:Landroid/content/BroadcastReceiver;

    .line 74
    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.bluetooth.adapter.action.STATE_CHANGED"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v1}, Lio/ionic/starter/SystemStatusService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 77
    new-instance v0, Lio/ionic/starter/SystemStatusService$4;

    invoke-direct {v0, p0}, Lio/ionic/starter/SystemStatusService$4;-><init>(Lio/ionic/starter/SystemStatusService;)V

    iput-object v0, p0, Lio/ionic/starter/SystemStatusService;->volumeReceiver:Landroid/content/BroadcastReceiver;

    .line 85
    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.media.VOLUME_CHANGED_ACTION"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v1}, Lio/ionic/starter/SystemStatusService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    const-string v0, "phone"

    .line 88
    invoke-virtual {p0, v0}, Lio/ionic/starter/SystemStatusService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    if-eqz v0, :cond_0

    .line 90
    new-instance v1, Lio/ionic/starter/SystemStatusService$5;

    invoke-direct {v1, p0}, Lio/ionic/starter/SystemStatusService$5;-><init>(Lio/ionic/starter/SystemStatusService;)V

    const/16 v2, 0x100

    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    :cond_0
    return-void
.end method

.method public onDestroy()V
    .locals 1

    .line 102
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    iget-object v0, p0, Lio/ionic/starter/SystemStatusService;->batteryReceiver:Landroid/content/BroadcastReceiver;

    .line 103
    invoke-virtual {p0, v0}, Lio/ionic/starter/SystemStatusService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    iget-object v0, p0, Lio/ionic/starter/SystemStatusService;->wifiReceiver:Landroid/content/BroadcastReceiver;

    .line 104
    invoke-virtual {p0, v0}, Lio/ionic/starter/SystemStatusService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    iget-object v0, p0, Lio/ionic/starter/SystemStatusService;->bluetoothReceiver:Landroid/content/BroadcastReceiver;

    .line 105
    invoke-virtual {p0, v0}, Lio/ionic/starter/SystemStatusService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    iget-object v0, p0, Lio/ionic/starter/SystemStatusService;->volumeReceiver:Landroid/content/BroadcastReceiver;

    .line 106
    invoke-virtual {p0, v0}, Lio/ionic/starter/SystemStatusService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    return-void
.end method
