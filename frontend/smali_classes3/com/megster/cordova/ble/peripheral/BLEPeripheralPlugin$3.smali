.class Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;
.super Landroid/bluetooth/BluetoothGattServerCallback;
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

    iput-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 646
    invoke-direct {p0}, Landroid/bluetooth/BluetoothGattServerCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onCharacteristicReadRequest(Landroid/bluetooth/BluetoothDevice;IILandroid/bluetooth/BluetoothGattCharacteristic;)V
    .locals 7

    .line 671
    invoke-super {p0, p1, p2, p3, p4}, Landroid/bluetooth/BluetoothGattServerCallback;->onCharacteristicReadRequest(Landroid/bluetooth/BluetoothDevice;IILandroid/bluetooth/BluetoothGattCharacteristic;)V

    iget-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 673
    invoke-static {v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetgattServer(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v1

    const/4 v4, 0x0

    invoke-virtual {p4}, Landroid/bluetooth/BluetoothGattCharacteristic;->getValue()[B

    move-result-object v6

    move-object v2, p1

    move v3, p2

    move v5, p3

    invoke-virtual/range {v1 .. v6}, Landroid/bluetooth/BluetoothGattServer;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)Z

    return-void
.end method

.method public onCharacteristicWriteRequest(Landroid/bluetooth/BluetoothDevice;ILandroid/bluetooth/BluetoothGattCharacteristic;ZZI[B)V
    .locals 13

    move-object v1, p0

    move-object/from16 v2, p3

    move-object/from16 v7, p7

    const-string v0, "timestamp"

    const-string v3, "type"

    const-string v4, "UTF-8"

    const-string v5, "BLEPeripheral"

    const-string v6, "Sent heartbeat response to device: "

    const-string v8, "Received heartbeat from device: "

    .line 678
    invoke-super/range {p0 .. p7}, Landroid/bluetooth/BluetoothGattServerCallback;->onCharacteristicWriteRequest(Landroid/bluetooth/BluetoothDevice;ILandroid/bluetooth/BluetoothGattCharacteristic;ZZI[B)V

    .line 682
    :try_start_0
    new-instance v9, Ljava/lang/String;

    invoke-direct {v9, v7, v4}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    .line 683
    new-instance v10, Lorg/json/JSONObject;

    invoke-direct {v10, v9}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v9, "heartbeat"

    .line 686
    invoke-virtual {v10, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_0

    .line 687
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v5, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 690
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8}, Lorg/json/JSONObject;-><init>()V

    const-string v9, "heartbeat_response"

    .line 691
    invoke-virtual {v8, v3, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 692
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    invoke-virtual {v8, v0, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v3, "original_timestamp"

    const-wide/16 v11, 0x0

    .line 693
    invoke-virtual {v10, v0, v11, v12}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v9

    invoke-virtual {v8, v3, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 696
    invoke-virtual {v8}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    .line 697
    invoke-virtual {v0, v4}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/bluetooth/BluetoothGattCharacteristic;->setValue([B)Z

    iget-object v0, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 700
    invoke-static {v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetgattServer(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v3, 0x0

    move-object v4, p1

    :try_start_1
    invoke-virtual {v0, p1, v2, v3}, Landroid/bluetooth/BluetoothGattServer;->notifyCharacteristicChanged(Landroid/bluetooth/BluetoothDevice;Landroid/bluetooth/BluetoothGattCharacteristic;Z)Z

    .line 702
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v5, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    goto :goto_0

    :cond_0
    move-object v4, p1

    goto :goto_1

    :catch_1
    move-exception v0

    move-object v4, p1

    :goto_0
    const-string v3, "Failed to process potential heartbeat message"

    .line 705
    invoke-static {v5, v3, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_1
    iget-object v0, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 708
    invoke-static {v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetcharacteristicValueChangedCallback(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Lorg/apache/cordova/CallbackContext;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 710
    :try_start_2
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v3, "service"

    .line 711
    invoke-virtual/range {p3 .. p3}, Landroid/bluetooth/BluetoothGattCharacteristic;->getService()Landroid/bluetooth/BluetoothGattService;

    move-result-object v6

    invoke-virtual {v6}, Landroid/bluetooth/BluetoothGattService;->getUuid()Ljava/util/UUID;

    move-result-object v6

    invoke-virtual {v6}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v3, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v3, "characteristic"

    .line 712
    invoke-virtual/range {p3 .. p3}, Landroid/bluetooth/BluetoothGattCharacteristic;->getUuid()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v2, "value"

    iget-object v3, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 713
    invoke-static {v3, v7}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$mbyteArrayToJSON(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;[B)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 715
    new-instance v2, Lorg/apache/cordova/PluginResult;

    sget-object v3, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v2, v3, v0}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Lorg/json/JSONObject;)V

    const/4 v0, 0x1

    .line 716
    invoke-virtual {v2, v0}, Lorg/apache/cordova/PluginResult;->setKeepCallback(Z)V

    iget-object v0, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 717
    invoke-static {v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetcharacteristicValueChangedCallback(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Lorg/apache/cordova/CallbackContext;

    move-result-object v0

    invoke-virtual {v0, v2}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_2

    :catch_2
    move-exception v0

    const-string v2, "JSON encoding failed in onCharacteristicWriteRequest"

    .line 719
    invoke-static {v5, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    :goto_2
    if-eqz p5, :cond_2

    iget-object v0, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 724
    invoke-static {v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetgattServer(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v2

    const/4 v5, 0x0

    move-object v3, p1

    move v4, p2

    move/from16 v6, p6

    move-object/from16 v7, p7

    invoke-virtual/range {v2 .. v7}, Landroid/bluetooth/BluetoothGattServer;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)Z

    :cond_2
    return-void
.end method

.method public onConnectionStateChange(Landroid/bluetooth/BluetoothDevice;II)V
    .locals 0

    .line 649
    invoke-super {p0, p1, p2, p3}, Landroid/bluetooth/BluetoothGattServerCallback;->onConnectionStateChange(Landroid/bluetooth/BluetoothDevice;II)V

    if-nez p3, :cond_0

    iget-object p2, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 652
    invoke-static {p2}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetregisteredDevices(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Ljava/util/Set;

    move-result-object p2

    invoke-interface {p2, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    :cond_0
    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 658
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$msendServiceStateChange(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V

    return-void
.end method

.method public onDescriptorReadRequest(Landroid/bluetooth/BluetoothDevice;IILandroid/bluetooth/BluetoothGattDescriptor;)V
    .locals 6

    .line 770
    invoke-super {p0, p1, p2, p3, p4}, Landroid/bluetooth/BluetoothGattServerCallback;->onDescriptorReadRequest(Landroid/bluetooth/BluetoothDevice;IILandroid/bluetooth/BluetoothGattDescriptor;)V

    iget-object p3, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 772
    invoke-static {p3}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetgattServer(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v0

    const/4 v3, 0x0

    const/4 v4, 0x0

    .line 776
    invoke-virtual {p4}, Landroid/bluetooth/BluetoothGattDescriptor;->getValue()[B

    move-result-object v5

    move-object v1, p1

    move v2, p2

    .line 772
    invoke-virtual/range {v0 .. v5}, Landroid/bluetooth/BluetoothGattServer;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)Z

    return-void
.end method

.method public onDescriptorWriteRequest(Landroid/bluetooth/BluetoothDevice;ILandroid/bluetooth/BluetoothGattDescriptor;ZZI[B)V
    .locals 6

    .line 736
    invoke-super/range {p0 .. p7}, Landroid/bluetooth/BluetoothGattServerCallback;->onDescriptorWriteRequest(Landroid/bluetooth/BluetoothDevice;ILandroid/bluetooth/BluetoothGattDescriptor;ZZI[B)V

    .line 738
    invoke-static {}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$sfgetCLIENT_CHARACTERISTIC_CONFIGURATION_UUID()Ljava/util/UUID;

    move-result-object p4

    invoke-virtual {p3}, Landroid/bluetooth/BluetoothGattDescriptor;->getUuid()Ljava/util/UUID;

    move-result-object p3

    invoke-virtual {p4, p3}, Ljava/util/UUID;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_3

    .line 739
    sget-object p3, Landroid/bluetooth/BluetoothGattDescriptor;->ENABLE_NOTIFICATION_VALUE:[B

    invoke-static {p3, p7}, Ljava/util/Arrays;->equals([B[B)Z

    move-result p3

    if-eqz p3, :cond_0

    iget-object p3, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 740
    invoke-static {p3}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetregisteredDevices(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Ljava/util/Set;

    move-result-object p3

    invoke-interface {p3, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 741
    :cond_0
    sget-object p3, Landroid/bluetooth/BluetoothGattDescriptor;->DISABLE_NOTIFICATION_VALUE:[B

    invoke-static {p3, p7}, Ljava/util/Arrays;->equals([B[B)Z

    move-result p3

    if-eqz p3, :cond_1

    iget-object p3, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 742
    invoke-static {p3}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetregisteredDevices(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Ljava/util/Set;

    move-result-object p3

    invoke-interface {p3, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    :cond_1
    :goto_0
    if-eqz p5, :cond_2

    iget-object p3, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 746
    invoke-static {p3}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetgattServer(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, p1

    move v2, p2

    invoke-virtual/range {v0 .. v5}, Landroid/bluetooth/BluetoothGattServer;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)Z

    :cond_2
    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 753
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$msendServiceStateChange(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V

    goto :goto_1

    :cond_3
    const-string p3, "BLEPeripheral"

    const-string p4, "Unknown descriptor write request"

    .line 756
    invoke-static {p3, p4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p5, :cond_4

    iget-object p3, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 758
    invoke-static {p3}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$fgetgattServer(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v0

    const/16 v3, 0x101

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, p1

    move v2, p2

    invoke-virtual/range {v0 .. v5}, Landroid/bluetooth/BluetoothGattServer;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)Z

    :cond_4
    :goto_1
    return-void
.end method

.method public onExecuteWrite(Landroid/bluetooth/BluetoothDevice;IZ)V
    .locals 0

    .line 782
    invoke-super {p0, p1, p2, p3}, Landroid/bluetooth/BluetoothGattServerCallback;->onExecuteWrite(Landroid/bluetooth/BluetoothDevice;IZ)V

    return-void
.end method

.method public onNotificationSent(Landroid/bluetooth/BluetoothDevice;I)V
    .locals 0

    .line 731
    invoke-super {p0, p1, p2}, Landroid/bluetooth/BluetoothGattServerCallback;->onNotificationSent(Landroid/bluetooth/BluetoothDevice;I)V

    return-void
.end method

.method public onServiceAdded(ILandroid/bluetooth/BluetoothGattService;)V
    .locals 0

    .line 663
    invoke-super {p0, p1, p2}, Landroid/bluetooth/BluetoothGattServerCallback;->onServiceAdded(ILandroid/bluetooth/BluetoothGattService;)V

    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 666
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->-$$Nest$msendServiceStateChange(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V

    return-void
.end method
