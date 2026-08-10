.class Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;
.super Landroid/bluetooth/le/AdvertiseCallback;
.source "BLEPeripheralPlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;
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

    iput-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 817
    invoke-direct {p0}, Landroid/bluetooth/le/AdvertiseCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onStartFailure(I)V
    .locals 3

    .line 833
    invoke-super {p0, p1}, Landroid/bluetooth/le/AdvertiseCallback;->onStartFailure(I)V

    iget-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 834
    invoke-static {v0, p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$mgetAdvertiseErrorString(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;I)Ljava/lang/String;

    move-result-object v0

    .line 835
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "BLE Advertising failed: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " (Error code: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, ")"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v1, "BLEPeripheral"

    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 837
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetadvertisingStartedCallback(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Lorg/apache/cordova/CallbackContext;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 838
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetadvertisingStartedCallback(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Lorg/apache/cordova/CallbackContext;

    move-result-object p1

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Advertising failed: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    :cond_0
    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 842
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$msendServiceStateChange(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V

    return-void
.end method

.method public onStartSuccess(Landroid/bluetooth/le/AdvertiseSettings;)V
    .locals 1

    .line 820
    invoke-super {p0, p1}, Landroid/bluetooth/le/AdvertiseCallback;->onStartSuccess(Landroid/bluetooth/le/AdvertiseSettings;)V

    const-string p1, "BLEPeripheral"

    const-string v0, "BLE advertising started successfully"

    .line 821
    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 823
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetadvertisingStartedCallback(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Lorg/apache/cordova/CallbackContext;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 824
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetadvertisingStartedCallback(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Lorg/apache/cordova/CallbackContext;

    move-result-object p1

    invoke-virtual {p1}, Lorg/apache/cordova/CallbackContext;->success()V

    :cond_0
    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 828
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$msendServiceStateChange(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V

    return-void
.end method
