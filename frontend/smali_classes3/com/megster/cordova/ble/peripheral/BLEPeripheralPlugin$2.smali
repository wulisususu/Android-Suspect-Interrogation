.class Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$2;
.super Landroid/content/BroadcastReceiver;
.source "BLEPeripheralPlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->addStateListener()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;


# direct methods
.method constructor <init>(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V
    .locals 0

    iput-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$2;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 597
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$2;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 600
    invoke-static {p1, p2}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$monBluetoothStateChange(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;Landroid/content/Intent;)V

    return-void
.end method
