.class Lio/ionic/starter/SystemStatusService$5;
.super Landroid/telephony/PhoneStateListener;
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

    iput-object p1, p0, Lio/ionic/starter/SystemStatusService$5;->this$0:Lio/ionic/starter/SystemStatusService;

    .line 90
    invoke-direct {p0}, Landroid/telephony/PhoneStateListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onSignalStrengthsChanged(Landroid/telephony/SignalStrength;)V
    .locals 2

    iget-object v0, p0, Lio/ionic/starter/SystemStatusService$5;->this$0:Lio/ionic/starter/SystemStatusService;

    .line 93
    invoke-virtual {p1}, Landroid/telephony/SignalStrength;->getLevel()I

    move-result p1

    invoke-static {v0, p1}, Lio/ionic/starter/SystemStatusService;->-$$Nest$fputsignalStrengthValue(Lio/ionic/starter/SystemStatusService;I)V

    iget-object p1, p0, Lio/ionic/starter/SystemStatusService$5;->this$0:Lio/ionic/starter/SystemStatusService;

    .line 94
    invoke-static {p1}, Lio/ionic/starter/SystemStatusService;->-$$Nest$fgetsignalStrengthValue(Lio/ionic/starter/SystemStatusService;)I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v0, "signalChange"

    const-string v1, "signalStrength"

    invoke-static {v0, v1, p1}, Lplugins/Immersive/ImmersivePlugin;->sendEvent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
