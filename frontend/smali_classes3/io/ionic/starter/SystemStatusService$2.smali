.class Lio/ionic/starter/SystemStatusService$2;
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

    iput-object p1, p0, Lio/ionic/starter/SystemStatusService$2;->this$0:Lio/ionic/starter/SystemStatusService;

    .line 51
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    const-string p2, "connectivity"

    .line 54
    invoke-virtual {p1, p2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/net/ConnectivityManager;

    const/4 p2, 0x0

    if-eqz p1, :cond_0

    .line 57
    invoke-virtual {p1}, Landroid/net/ConnectivityManager;->getActiveNetwork()Landroid/net/Network;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/net/ConnectivityManager;->getNetworkCapabilities(Landroid/net/Network;)Landroid/net/NetworkCapabilities;

    move-result-object p1

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    .line 58
    invoke-virtual {p1, v0}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result p1

    if-eqz p1, :cond_0

    move p2, v0

    :cond_0
    const-string p1, "wifiConnected"

    .line 60
    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    const-string v0, "wifiChange"

    invoke-static {v0, p1, p2}, Lplugins/Immersive/ImmersivePlugin;->sendEvent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
