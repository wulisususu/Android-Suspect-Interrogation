.class public Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;
.super Lorg/apache/cordova/CordovaPlugin;
.source "BLEPeripheralPlugin.java"


# static fields
.field private static final ADD_CHARACTERISTIC:Ljava/lang/String; = "addCharacteristic"

.field private static final CLIENT_CHARACTERISTIC_CONFIGURATION_UUID:Ljava/util/UUID;

.field private static final CREATE_SERVICE:Ljava/lang/String; = "createService"

.field private static final CREATE_SERVICE_FROM_JSON:Ljava/lang/String; = "createServiceFromJSON"

.field private static final ENABLE:Ljava/lang/String; = "enable"

.field private static final GET_SERVICE_STATE:Ljava/lang/String; = "getServiceState"

.field private static final MIN_ANDROID_VERSION:I = 0x15

.field private static final PUBLISH_SERVICE:Ljava/lang/String; = "publishService"

.field private static final REMOVE_SERVICE:Ljava/lang/String; = "removeService"

.field private static final REQUEST_ENABLE_BLUETOOTH:I = 0x11

.field private static final SETTINGS:Ljava/lang/String; = "showBluetoothSettings"

.field private static final SET_BLUETOOTH_STATE_CHANGED_LISTENER:Ljava/lang/String; = "setBluetoothStateChangedListener"

.field private static final SET_CHARACTERISTIC_VALUE:Ljava/lang/String; = "setCharacteristicValue"

.field private static final SET_CHARACTERISTIC_VALUE_CHANGED_LISTENER:Ljava/lang/String; = "setCharacteristicValueChangedListener"

.field private static final SET_SERVICE_STATE_CHANGED_LISTENER:Ljava/lang/String; = "setServiceStateChangedListener"

.field private static final START_ADVERTISING:Ljava/lang/String; = "startAdvertising"

.field private static final STOP_ADVERTISING:Ljava/lang/String; = "stopAdvertising"

.field private static final TAG:Ljava/lang/String; = "BLEPeripheral"


# instance fields
.field private advertiseCallback:Landroid/bluetooth/le/AdvertiseCallback;

.field private advertisingStartedCallback:Lorg/apache/cordova/CallbackContext;

.field private bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

.field private bluetoothStates:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private characteristicValueChangedCallback:Lorg/apache/cordova/CallbackContext;

.field private enableBluetoothCallback:Lorg/apache/cordova/CallbackContext;

.field private gattServer:Landroid/bluetooth/BluetoothGattServer;

.field private gattServerCallback:Landroid/bluetooth/BluetoothGattServerCallback;

.field private registeredDevices:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation
.end field

.field private serviceStateChangedCallback:Lorg/apache/cordova/CallbackContext;

.field private services:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/util/UUID;",
            "Landroid/bluetooth/BluetoothGattService;",
            ">;"
        }
    .end annotation
.end field

.field private stateCallback:Lorg/apache/cordova/CallbackContext;

.field private stateReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method static bridge synthetic -$$Nest$fgetadvertisingStartedCallback(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Lorg/apache/cordova/CallbackContext;
    .locals 0

    iget-object p0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->advertisingStartedCallback:Lorg/apache/cordova/CallbackContext;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetcharacteristicValueChangedCallback(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Lorg/apache/cordova/CallbackContext;
    .locals 0

    iget-object p0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->characteristicValueChangedCallback:Lorg/apache/cordova/CallbackContext;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetgattServer(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Landroid/bluetooth/BluetoothGattServer;
    .locals 0

    iget-object p0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServer:Landroid/bluetooth/BluetoothGattServer;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetregisteredDevices(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)Ljava/util/Set;
    .locals 0

    iget-object p0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->registeredDevices:Ljava/util/Set;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mbyteArrayToJSON(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;[B)Lorg/json/JSONObject;
    .locals 0

    invoke-direct {p0, p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->byteArrayToJSON([B)Lorg/json/JSONObject;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mgetAdvertiseErrorString(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;I)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->getAdvertiseErrorString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$monBluetoothStateChange(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;Landroid/content/Intent;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->onBluetoothStateChange(Landroid/content/Intent;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$msendServiceStateChange(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V
    .locals 0

    invoke-direct {p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->sendServiceStateChange()V

    return-void
.end method

.method static bridge synthetic -$$Nest$sfgetCLIENT_CHARACTERISTIC_CONFIGURATION_UUID()Ljava/util/UUID;
    .locals 1

    sget-object v0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->CLIENT_CHARACTERISTIC_CONFIGURATION_UUID:Ljava/util/UUID;

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 1

    const-string v0, "00002902-0000-1000-8000-00805f9b34fb"

    .line 77
    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->CLIENT_CHARACTERISTIC_CONFIGURATION_UUID:Ljava/util/UUID;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 61
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    .line 101
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 102
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->registeredDevices:Ljava/util/Set;

    .line 107
    new-instance v0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$1;

    invoke-direct {v0, p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$1;-><init>(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V

    iput-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothStates:Ljava/util/Map;

    .line 646
    new-instance v0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;

    invoke-direct {v0, p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$3;-><init>(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V

    iput-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServerCallback:Landroid/bluetooth/BluetoothGattServerCallback;

    .line 817
    new-instance v0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;

    invoke-direct {v0, p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$4;-><init>(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V

    iput-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->advertiseCallback:Landroid/bluetooth/le/AdvertiseCallback;

    return-void
.end method

.method private addStateListener()V
    .locals 3

    iget-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateReceiver:Landroid/content/BroadcastReceiver;

    if-nez v0, :cond_0

    .line 597
    new-instance v0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$2;

    invoke-direct {v0, p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$2;-><init>(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V

    iput-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateReceiver:Landroid/content/BroadcastReceiver;

    .line 606
    :cond_0
    :try_start_0
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.bluetooth.adapter.action.STATE_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 607
    iget-object v1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->webView:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaWebView;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 609
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Error registering state receiver: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "BLEPeripheral"

    invoke-static {v2, v1, v0}, Lorg/apache/cordova/LOG;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_0
    return-void
.end method

.method private byteArrayToJSON([B)Lorg/json/JSONObject;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 891
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "CDVType"

    const-string v2, "ArrayBuffer"

    .line 892
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const/4 v1, 0x2

    .line 893
    invoke-static {p1, v1}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object p1

    const-string v1, "data"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    return-object v0
.end method

.method private createClientCharacteristicConfigurationDescriptor()Landroid/bluetooth/BluetoothGattDescriptor;
    .locals 3

    .line 898
    new-instance v0, Landroid/bluetooth/BluetoothGattDescriptor;

    sget-object v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->CLIENT_CHARACTERISTIC_CONFIGURATION_UUID:Ljava/util/UUID;

    const/16 v2, 0x11

    invoke-direct {v0, v1, v2}, Landroid/bluetooth/BluetoothGattDescriptor;-><init>(Ljava/util/UUID;I)V

    return-object v0
.end method

.method private getAdvertiseErrorString(I)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x1

    if-eq p1, v0, :cond_4

    const/4 v0, 0x2

    if-eq p1, v0, :cond_3

    const/4 v0, 0x3

    if-eq p1, v0, :cond_2

    const/4 v0, 0x4

    if-eq p1, v0, :cond_1

    const/4 v0, 0x5

    if-eq p1, v0, :cond_0

    .line 865
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "UNKNOWN_ERROR - Error code: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const-string p1, "ADVERTISE_FAILED_FEATURE_UNSUPPORTED - Advertising feature not supported"

    return-object p1

    :cond_1
    const-string p1, "ADVERTISE_FAILED_INTERNAL_ERROR - Internal Bluetooth error"

    return-object p1

    :cond_2
    const-string p1, "ADVERTISE_FAILED_ALREADY_STARTED - Advertising already started"

    return-object p1

    :cond_3
    const-string p1, "ADVERTISE_FAILED_TOO_MANY_ADVERTISERS - Too many advertisers active"

    return-object p1

    :cond_4
    const-string p1, "ADVERTISE_FAILED_DATA_TOO_LARGE - Data exceeds 31 byte limit"

    return-object p1
.end method

.method private getAdvertiseSettings()Landroid/bluetooth/le/AdvertiseSettings;
    .locals 3

    .line 789
    new-instance v0, Landroid/bluetooth/le/AdvertiseSettings$Builder;

    invoke-direct {v0}, Landroid/bluetooth/le/AdvertiseSettings$Builder;-><init>()V

    const/4 v1, 0x1

    .line 790
    invoke-virtual {v0, v1}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setAdvertiseMode(I)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v0

    const/4 v2, 0x2

    .line 791
    invoke-virtual {v0, v2}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setTxPowerLevel(I)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v0

    .line 792
    invoke-virtual {v0, v1}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setConnectable(Z)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v0

    .line 793
    invoke-virtual {v0}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->build()Landroid/bluetooth/le/AdvertiseSettings;

    move-result-object v0

    return-object v0
.end method

.method private getAdvertisementData(Ljava/util/UUID;)Landroid/bluetooth/le/AdvertiseData;
    .locals 2

    .line 808
    new-instance v0, Landroid/bluetooth/le/AdvertiseData$Builder;

    invoke-direct {v0}, Landroid/bluetooth/le/AdvertiseData$Builder;-><init>()V

    const/4 v1, 0x0

    .line 809
    invoke-virtual {v0, v1}, Landroid/bluetooth/le/AdvertiseData$Builder;->setIncludeTxPowerLevel(Z)Landroid/bluetooth/le/AdvertiseData$Builder;

    const/4 v1, 0x1

    .line 810
    invoke-virtual {v0, v1}, Landroid/bluetooth/le/AdvertiseData$Builder;->setIncludeDeviceName(Z)Landroid/bluetooth/le/AdvertiseData$Builder;

    .line 811
    new-instance v1, Landroid/os/ParcelUuid;

    invoke-direct {v1, p1}, Landroid/os/ParcelUuid;-><init>(Ljava/util/UUID;)V

    invoke-virtual {v0, v1}, Landroid/bluetooth/le/AdvertiseData$Builder;->addServiceUuid(Landroid/os/ParcelUuid;)Landroid/bluetooth/le/AdvertiseData$Builder;

    .line 813
    invoke-virtual {v0}, Landroid/bluetooth/le/AdvertiseData$Builder;->build()Landroid/bluetooth/le/AdvertiseData;

    move-result-object p1

    return-object p1
.end method

.method private isIndicate(Landroid/bluetooth/BluetoothGattCharacteristic;)Z
    .locals 0

    .line 887
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothGattCharacteristic;->getProperties()I

    move-result p1

    and-int/lit8 p1, p1, 0x20

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method private isNotify(Landroid/bluetooth/BluetoothGattCharacteristic;)Z
    .locals 0

    .line 883
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothGattCharacteristic;->getProperties()I

    move-result p1

    and-int/lit8 p1, p1, 0x10

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method private notifyRegisteredDevices(Landroid/bluetooth/BluetoothGattCharacteristic;)V
    .locals 4

    .line 870
    invoke-direct {p0, p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->isIndicate(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    move-result v0

    iget-object v1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->registeredDevices:Ljava/util/Set;

    .line 872
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/bluetooth/BluetoothDevice;

    iget-object v3, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServer:Landroid/bluetooth/BluetoothGattServer;

    .line 873
    invoke-virtual {v3, v2, p1, v0}, Landroid/bluetooth/BluetoothGattServer;->notifyCharacteristicChanged(Landroid/bluetooth/BluetoothDevice;Landroid/bluetooth/BluetoothGattCharacteristic;Z)Z

    goto :goto_0

    :cond_0
    return-void
.end method

.method private onBluetoothStateChange(Landroid/content/Intent;)V
    .locals 2

    .line 533
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "android.bluetooth.adapter.action.STATE_CHANGED"

    .line 535
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "android.bluetooth.adapter.extra.STATE"

    const/high16 v1, -0x80000000

    .line 536
    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    .line 537
    invoke-direct {p0, p1}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->sendBluetoothStateChange(I)V

    :cond_0
    return-void
.end method

.method private removeStateListener()V
    .locals 3

    iget-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    .line 616
    :try_start_0
    iget-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->webView:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaWebView;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 618
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Error un-registering state receiver: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "BLEPeripheral"

    invoke-static {v2, v1, v0}, Lorg/apache/cordova/LOG;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateCallback:Lorg/apache/cordova/CallbackContext;

    iput-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateReceiver:Landroid/content/BroadcastReceiver;

    iput-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->serviceStateChangedCallback:Lorg/apache/cordova/CallbackContext;

    return-void
.end method

.method private sendBluetoothStateChange(I)V
    .locals 3

    iget-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateCallback:Lorg/apache/cordova/CallbackContext;

    if-eqz v0, :cond_0

    .line 543
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    iget-object v2, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothStates:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-direct {v0, v1, p1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Ljava/lang/String;)V

    const/4 p1, 0x1

    .line 544
    invoke-virtual {v0, p1}, Lorg/apache/cordova/PluginResult;->setKeepCallback(Z)V

    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateCallback:Lorg/apache/cordova/CallbackContext;

    .line 545
    invoke-virtual {p1, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 549
    :cond_0
    invoke-direct {p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->sendServiceStateChange()V

    return-void
.end method

.method private sendServiceStateChange()V
    .locals 6

    iget-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->serviceStateChangedCallback:Lorg/apache/cordova/CallbackContext;

    if-eqz v0, :cond_4

    .line 556
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "bluetoothEnabled"

    iget-object v2, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v2, :cond_0

    .line 559
    invoke-virtual {v2}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    move v2, v3

    goto :goto_0

    :cond_0
    move v2, v4

    :goto_0
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v1, "bluetoothState"

    iget-object v2, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v2, :cond_1

    iget-object v5, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothStates:Ljava/util/Map;

    .line 560
    invoke-virtual {v2}, Landroid/bluetooth/BluetoothAdapter;->getState()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v5, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    goto :goto_1

    :cond_1
    const-string v2, "unknown"

    :goto_1
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v1, :cond_2

    .line 565
    invoke-virtual {v1}, Landroid/bluetooth/BluetoothAdapter;->getBluetoothLeAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;

    move-result-object v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->advertisingStartedCallback:Lorg/apache/cordova/CallbackContext;

    if-eqz v1, :cond_2

    move v1, v3

    goto :goto_2

    :cond_2
    move v1, v4

    :goto_2
    const-string v2, "isAdvertising"

    .line 568
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v1, "advertisingName"

    iget-object v2, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    .line 570
    invoke-virtual {v2}, Landroid/bluetooth/BluetoothAdapter;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "servicesCount"

    iget-object v2, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 574
    invoke-interface {v2}, Ljava/util/Map;->size()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "connectedDevicesCount"

    iget-object v2, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->registeredDevices:Ljava/util/Set;

    .line 577
    invoke-interface {v2}, Ljava/util/Set;->size()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "gattServerActive"

    iget-object v2, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServer:Landroid/bluetooth/BluetoothGattServer;

    if-eqz v2, :cond_3

    move v4, v3

    .line 580
    :cond_3
    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v1, "timestamp"

    .line 583
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v0, v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 585
    new-instance v1, Lorg/apache/cordova/PluginResult;

    sget-object v2, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v1, v2, v0}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 586
    invoke-virtual {v1, v3}, Lorg/apache/cordova/PluginResult;->setKeepCallback(Z)V

    iget-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->serviceStateChangedCallback:Lorg/apache/cordova/CallbackContext;

    .line 587
    invoke-virtual {v0, v1}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    :catch_0
    move-exception v0

    const-string v1, "BLEPeripheral"

    const-string v2, "Error creating status change JSON"

    .line 590
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_4
    :goto_3
    return-void
.end method

.method private stopAdvertisingIfStarted()V
    .locals 3

    iget-object v0, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v0, :cond_0

    .line 134
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getBluetoothLeAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;

    move-result-object v0

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->advertiseCallback:Landroid/bluetooth/le/AdvertiseCallback;

    .line 137
    invoke-virtual {v0, v1}, Landroid/bluetooth/le/BluetoothLeAdvertiser;->stopAdvertising(Landroid/bluetooth/le/AdvertiseCallback;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "BLEPeripheral"

    const-string v2, "Failed to stop advertising during cleanup"

    .line 139
    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    :goto_0
    return-void
.end method

.method private uuidFromString(Ljava/lang/String;)Ljava/util/UUID;
    .locals 0

    .line 879
    invoke-static {p1}, Lcom/megster/cordova/ble/peripheral/UUIDHelper;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/apache/cordova/CordovaArgs;Lorg/apache/cordova/CallbackContext;)Z
    .locals 20
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    move-object/from16 v1, p0

    move-object/from16 v0, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    iget-object v4, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    const-string v5, "createService"

    const-string v6, "BLEPeripheral"

    const/4 v7, 0x0

    if-nez v4, :cond_3

    .line 148
    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 157
    iget-object v4, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v4}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v4

    .line 158
    invoke-virtual {v4}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v8

    .line 159
    invoke-virtual {v8}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v8

    const-string v9, "android.hardware.bluetooth_le"

    .line 160
    invoke-virtual {v8, v9}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_0

    const-string v0, "This hardware does not support Bluetooth Low Energy"

    .line 163
    invoke-static {v6, v0}, Lorg/apache/cordova/LOG;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 164
    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return v7

    :cond_0
    const-string v8, "bluetooth"

    .line 168
    invoke-virtual {v4, v8}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/bluetooth/BluetoothManager;

    if-nez v4, :cond_1

    const-string v0, "bluetoothManager is null"

    .line 170
    invoke-static {v6, v0}, Lorg/apache/cordova/LOG;->e(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "Unable to get the Bluetooth Manager"

    .line 171
    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return v7

    .line 174
    :cond_1
    invoke-virtual {v4}, Landroid/bluetooth/BluetoothManager;->getAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v8

    iput-object v8, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    .line 176
    invoke-virtual {v8}, Landroid/bluetooth/BluetoothAdapter;->isMultipleAdvertisementSupported()Z

    move-result v8

    if-nez v8, :cond_2

    const-string v0, "This hardware does not support creating Bluetooth Low Energy peripherals"

    .line 179
    invoke-static {v6, v0}, Lorg/apache/cordova/LOG;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 180
    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return v7

    .line 184
    :cond_2
    iget-object v8, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v8}, Lorg/apache/cordova/CordovaInterface;->getContext()Landroid/content/Context;

    move-result-object v8

    iget-object v9, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServerCallback:Landroid/bluetooth/BluetoothGattServerCallback;

    invoke-virtual {v4, v8, v9}, Landroid/bluetooth/BluetoothManager;->openGattServer(Landroid/content/Context;Landroid/bluetooth/BluetoothGattServerCallback;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v4

    iput-object v4, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServer:Landroid/bluetooth/BluetoothGattServer;

    :cond_3
    const-string v4, "setCharacteristicValueChangedListener"

    .line 190
    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const/4 v8, 0x1

    if-eqz v4, :cond_4

    iput-object v3, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->characteristicValueChangedCallback:Lorg/apache/cordova/CallbackContext;

    goto/16 :goto_c

    :cond_4
    const-string v4, "setServiceStateChangedListener"

    .line 194
    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    iput-object v3, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->serviceStateChangedCallback:Lorg/apache/cordova/CallbackContext;

    goto/16 :goto_c

    :cond_5
    const-string v4, "setBluetoothStateChangedListener"

    .line 201
    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    iget-object v0, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateCallback:Lorg/apache/cordova/CallbackContext;

    if-eqz v0, :cond_6

    const-string v0, "State callback already registered."

    .line 204
    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto/16 :goto_c

    :cond_6
    iput-object v3, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stateCallback:Lorg/apache/cordova/CallbackContext;

    .line 207
    invoke-direct/range {p0 .. p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->addStateListener()V

    goto/16 :goto_c

    .line 211
    :cond_7
    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    .line 213
    invoke-virtual {v2, v7}, Lorg/apache/cordova/CordovaArgs;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    .line 215
    new-instance v2, Landroid/bluetooth/BluetoothGattService;

    invoke-direct {v2, v0, v7}, Landroid/bluetooth/BluetoothGattService;-><init>(Ljava/util/UUID;I)V

    iget-object v4, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 219
    invoke-interface {v4, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 221
    invoke-virtual/range {p3 .. p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_c

    :cond_8
    const-string v4, "addCharacteristic"

    .line 223
    invoke-virtual {v0, v4}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v4

    const/4 v5, 0x2

    if-eqz v4, :cond_b

    .line 225
    invoke-virtual {v2, v7}, Lorg/apache/cordova/CordovaArgs;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    .line 226
    invoke-virtual {v2, v8}, Lorg/apache/cordova/CordovaArgs;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v4}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v4

    .line 227
    invoke-virtual {v2, v5}, Lorg/apache/cordova/CordovaArgs;->getInt(I)I

    move-result v5

    const/4 v6, 0x3

    .line 228
    invoke-virtual {v2, v6}, Lorg/apache/cordova/CordovaArgs;->getInt(I)I

    move-result v2

    .line 230
    new-instance v6, Landroid/bluetooth/BluetoothGattCharacteristic;

    invoke-direct {v6, v4, v5, v2}, Landroid/bluetooth/BluetoothGattCharacteristic;-><init>(Ljava/util/UUID;II)V

    iget-object v2, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 234
    invoke-interface {v2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothGattService;

    .line 235
    invoke-virtual {v0, v6}, Landroid/bluetooth/BluetoothGattService;->addCharacteristic(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    .line 238
    invoke-direct {v1, v6}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->isNotify(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    move-result v0

    if-nez v0, :cond_9

    invoke-direct {v1, v6}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->isIndicate(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 239
    :cond_9
    invoke-direct/range {p0 .. p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->createClientCharacteristicConfigurationDescriptor()Landroid/bluetooth/BluetoothGattDescriptor;

    move-result-object v0

    invoke-virtual {v6, v0}, Landroid/bluetooth/BluetoothGattCharacteristic;->addDescriptor(Landroid/bluetooth/BluetoothGattDescriptor;)Z

    .line 242
    :cond_a
    invoke-virtual/range {p3 .. p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_c

    :cond_b
    const-string v4, "createServiceFromJSON"

    .line 244
    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const-string v9, "descriptors"

    const-string v10, "properties"

    const-string v11, "characteristics"

    const-string v12, " to GATT Server"

    const-string v13, "Error adding "

    const-string v14, "permissions"

    const-string v15, "uuid"

    if-eqz v4, :cond_13

    .line 246
    invoke-virtual {v2, v7}, Lorg/apache/cordova/CordovaArgs;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v0

    .line 249
    :try_start_0
    invoke-virtual {v0, v15}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v2

    .line 250
    new-instance v4, Landroid/bluetooth/BluetoothGattService;

    invoke-direct {v4, v2, v7}, Landroid/bluetooth/BluetoothGattService;-><init>(Ljava/util/UUID;I)V

    .line 252
    invoke-virtual {v0, v11}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    move v5, v7

    .line 253
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v11

    if-ge v5, v11, :cond_11

    .line 254
    invoke-virtual {v0, v5}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v11

    .line 255
    invoke-virtual {v11, v15}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v1, v7}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v7

    .line 256
    invoke-virtual {v11, v10}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v8

    move-object/from16 p1, v0

    .line 257
    invoke-virtual {v11, v14}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    move-object/from16 v17, v14

    .line 258
    new-instance v14, Landroid/bluetooth/BluetoothGattCharacteristic;

    invoke-direct {v14, v7, v8, v0}, Landroid/bluetooth/BluetoothGattCharacteristic;-><init>(Ljava/util/UUID;II)V

    .line 261
    invoke-direct {v1, v14}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->isNotify(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    move-result v0

    if-nez v0, :cond_c

    invoke-direct {v1, v14}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->isIndicate(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    move-result v0

    if-eqz v0, :cond_d

    .line 262
    :cond_c
    invoke-direct/range {p0 .. p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->createClientCharacteristicConfigurationDescriptor()Landroid/bluetooth/BluetoothGattDescriptor;

    move-result-object v0

    invoke-virtual {v14, v0}, Landroid/bluetooth/BluetoothGattCharacteristic;->addDescriptor(Landroid/bluetooth/BluetoothGattDescriptor;)Z

    .line 266
    :cond_d
    invoke-virtual {v11, v9}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    const/4 v7, 0x0

    .line 267
    :goto_1
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v8

    if-ge v7, v8, :cond_10

    .line 268
    invoke-virtual {v0, v7}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v8

    .line 270
    invoke-virtual {v8, v15}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-direct {v1, v11}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v11

    move-object/from16 p2, v0

    const-string v0, "value"

    .line 277
    invoke-virtual {v8, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 279
    new-instance v8, Landroid/bluetooth/BluetoothGattDescriptor;

    move-object/from16 v18, v9

    const/4 v9, 0x1

    invoke-direct {v8, v11, v9}, Landroid/bluetooth/BluetoothGattDescriptor;-><init>(Ljava/util/UUID;I)V

    .line 281
    invoke-virtual {v14, v8}, Landroid/bluetooth/BluetoothGattCharacteristic;->addDescriptor(Landroid/bluetooth/BluetoothGattDescriptor;)Z

    move-result v9

    if-nez v9, :cond_e

    .line 282
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Failed to add descriptor "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    const/4 v2, 0x1

    return v2

    .line 286
    :cond_e
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-virtual {v8, v9}, Landroid/bluetooth/BluetoothGattDescriptor;->setValue([B)Z

    move-result v8

    if-nez v8, :cond_f

    .line 287
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Failed to set descriptor value to "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    const/4 v2, 0x1

    return v2

    :cond_f
    add-int/lit8 v7, v7, 0x1

    move-object/from16 v0, p2

    move-object/from16 v9, v18

    goto :goto_1

    :cond_10
    move-object/from16 v18, v9

    .line 293
    invoke-virtual {v4, v14}, Landroid/bluetooth/BluetoothGattService;->addCharacteristic(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    add-int/lit8 v5, v5, 0x1

    move-object/from16 v0, p1

    move-object/from16 v14, v17

    move-object/from16 v9, v18

    const/4 v7, 0x0

    const/4 v8, 0x1

    goto/16 :goto_0

    :cond_11
    iget-object v0, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 297
    invoke-interface {v0, v2, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServer:Landroid/bluetooth/BluetoothGattServer;

    .line 299
    invoke-virtual {v0, v4}, Landroid/bluetooth/BluetoothGattServer;->addService(Landroid/bluetooth/BluetoothGattService;)Z

    move-result v0

    if-eqz v0, :cond_12

    .line 300
    invoke-virtual/range {p3 .. p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_c

    .line 302
    :cond_12
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v4}, Landroid/bluetooth/BluetoothGattService;->getUuid()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_c

    :catch_0
    move-exception v0

    const-string v2, "Invalid JSON for Service"

    .line 306
    invoke-static {v6, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 307
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 308
    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto/16 :goto_c

    :cond_13
    move-object/from16 v18, v9

    move-object/from16 v17, v14

    const-string v4, "publishService"

    .line 311
    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const-string v7, " not found"

    const-string v8, "Service "

    if-eqz v4, :cond_16

    const/4 v4, 0x0

    .line 313
    invoke-virtual {v2, v4}, Lorg/apache/cordova/CordovaArgs;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    iget-object v2, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 314
    invoke-interface {v2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/bluetooth/BluetoothGattService;

    if-nez v2, :cond_14

    .line 317
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    :goto_2
    const/4 v2, 0x1

    return v2

    :cond_14
    iget-object v4, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServer:Landroid/bluetooth/BluetoothGattServer;

    .line 321
    invoke-virtual {v4, v2}, Landroid/bluetooth/BluetoothGattServer;->addService(Landroid/bluetooth/BluetoothGattService;)Z

    move-result v2

    if-eqz v2, :cond_15

    .line 324
    invoke-virtual/range {p3 .. p3}, Lorg/apache/cordova/CallbackContext;->success()V

    .line 327
    invoke-direct/range {p0 .. p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->sendServiceStateChange()V

    goto/16 :goto_c

    .line 329
    :cond_15
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v13}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto/16 :goto_c

    :cond_16
    const-string v4, "removeService"

    .line 332
    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_19

    const/4 v4, 0x0

    .line 334
    invoke-virtual {v2, v4}, Lorg/apache/cordova/CordovaArgs;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    iget-object v2, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 335
    invoke-interface {v2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/bluetooth/BluetoothGattService;

    if-nez v2, :cond_17

    .line 338
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " not found in local services"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto :goto_2

    :cond_17
    iget-object v4, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServer:Landroid/bluetooth/BluetoothGattServer;

    .line 343
    invoke-virtual {v4, v2}, Landroid/bluetooth/BluetoothGattServer;->removeService(Landroid/bluetooth/BluetoothGattService;)Z

    move-result v2

    if-eqz v2, :cond_18

    iget-object v2, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 347
    invoke-interface {v2, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 348
    invoke-virtual/range {p3 .. p3}, Lorg/apache/cordova/CallbackContext;->success()V

    .line 351
    invoke-direct/range {p0 .. p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->sendServiceStateChange()V

    goto/16 :goto_c

    .line 353
    :cond_18
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "Failed to remove service "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " from GATT Server"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v6, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 354
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v5, "Error removing "

    invoke-direct {v2, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto/16 :goto_c

    :cond_19
    const-string v4, "startAdvertising"

    .line 357
    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const-string v9, "BLE advertising not supported on this device"

    if-eqz v4, :cond_1b

    const/4 v4, 0x0

    .line 359
    invoke-virtual {v2, v4}, Lorg/apache/cordova/CordovaArgs;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    const/4 v4, 0x1

    .line 360
    invoke-virtual {v2, v4}, Lorg/apache/cordova/CordovaArgs;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 362
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v7, "Starting BLE advertising for service: "

    invoke-direct {v5, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v6, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v5, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    .line 364
    invoke-virtual {v5}, Landroid/bluetooth/BluetoothAdapter;->getBluetoothLeAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;

    move-result-object v5

    if-nez v5, :cond_1a

    .line 367
    invoke-virtual {v3, v9}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return v4

    :cond_1a
    iget-object v4, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    .line 372
    invoke-virtual {v4, v2}, Landroid/bluetooth/BluetoothAdapter;->setName(Ljava/lang/String;)Z

    const-wide/16 v6, 0x1f4

    .line 376
    :try_start_1
    invoke-static {v6, v7}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_3

    .line 378
    :catch_1
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Thread;->interrupt()V

    .line 382
    :goto_3
    invoke-direct/range {p0 .. p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->getAdvertiseSettings()Landroid/bluetooth/le/AdvertiseSettings;

    move-result-object v2

    .line 383
    invoke-direct {v1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->getAdvertisementData(Ljava/util/UUID;)Landroid/bluetooth/le/AdvertiseData;

    move-result-object v0

    const/4 v4, 0x0

    iget-object v6, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->advertiseCallback:Landroid/bluetooth/le/AdvertiseCallback;

    .line 386
    invoke-virtual {v5, v2, v0, v4, v6}, Landroid/bluetooth/le/BluetoothLeAdvertiser;->startAdvertising(Landroid/bluetooth/le/AdvertiseSettings;Landroid/bluetooth/le/AdvertiseData;Landroid/bluetooth/le/AdvertiseData;Landroid/bluetooth/le/AdvertiseCallback;)V

    iput-object v3, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->advertisingStartedCallback:Lorg/apache/cordova/CallbackContext;

    .line 391
    invoke-direct/range {p0 .. p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->sendServiceStateChange()V

    goto/16 :goto_c

    :cond_1b
    const-string v4, "setCharacteristicValue"

    .line 393
    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_20

    const/4 v4, 0x0

    .line 395
    invoke-virtual {v2, v4}, Lorg/apache/cordova/CordovaArgs;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    const/4 v4, 0x1

    .line 396
    invoke-virtual {v2, v4}, Lorg/apache/cordova/CordovaArgs;->getString(I)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v1, v6}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->uuidFromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v4

    .line 397
    invoke-virtual {v2, v5}, Lorg/apache/cordova/CordovaArgs;->getArrayBuffer(I)[B

    move-result-object v2

    iget-object v5, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 399
    invoke-interface {v5, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/bluetooth/BluetoothGattService;

    if-nez v5, :cond_1c

    .line 401
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto/16 :goto_2

    .line 405
    :cond_1c
    invoke-virtual {v5, v4}, Landroid/bluetooth/BluetoothGattService;->getCharacteristic(Ljava/util/UUID;)Landroid/bluetooth/BluetoothGattCharacteristic;

    move-result-object v5

    if-nez v5, :cond_1d

    .line 408
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v5, "Characteristic "

    invoke-direct {v2, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " not found on service "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto/16 :goto_2

    .line 412
    :cond_1d
    invoke-virtual {v5, v2}, Landroid/bluetooth/BluetoothGattCharacteristic;->setValue([B)Z

    .line 414
    invoke-direct {v1, v5}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->isNotify(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    move-result v0

    if-nez v0, :cond_1e

    invoke-direct {v1, v5}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->isIndicate(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    move-result v0

    if-eqz v0, :cond_1f

    .line 415
    :cond_1e
    invoke-direct {v1, v5}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->notifyRegisteredDevices(Landroid/bluetooth/BluetoothGattCharacteristic;)V

    .line 418
    :cond_1f
    invoke-virtual/range {p3 .. p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_c

    :cond_20
    const/4 v4, 0x0

    const-string v2, "stopAdvertising"

    .line 420
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_22

    iget-object v0, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    .line 422
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getBluetoothLeAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;

    move-result-object v0

    if-nez v0, :cond_21

    .line 425
    invoke-virtual {v3, v9}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    const/4 v9, 0x1

    return v9

    :cond_21
    const/4 v9, 0x1

    :try_start_2
    iget-object v2, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->advertiseCallback:Landroid/bluetooth/le/AdvertiseCallback;

    .line 430
    invoke-virtual {v0, v2}, Landroid/bluetooth/le/BluetoothLeAdvertiser;->stopAdvertising(Landroid/bluetooth/le/AdvertiseCallback;)V

    .line 431
    invoke-virtual/range {p3 .. p3}, Lorg/apache/cordova/CallbackContext;->success()V

    .line 434
    invoke-direct/range {p0 .. p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->sendServiceStateChange()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto/16 :goto_c

    :catch_2
    move-exception v0

    const-string v2, "Failed to stop advertising"

    .line 436
    invoke-static {v6, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 437
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "Failed to stop advertising: "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto/16 :goto_c

    :cond_22
    const/4 v9, 0x1

    const-string v2, "showBluetoothSettings"

    .line 440
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_23

    .line 442
    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.settings.BLUETOOTH_SETTINGS"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 443
    iget-object v2, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v2}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    .line 444
    invoke-virtual/range {p3 .. p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_c

    :cond_23
    const-string v2, "enable"

    .line 446
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_24

    iput-object v3, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->enableBluetoothCallback:Lorg/apache/cordova/CallbackContext;

    .line 449
    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.bluetooth.adapter.action.REQUEST_ENABLE"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 450
    iget-object v2, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    const/16 v3, 0x11

    invoke-interface {v2, v1, v0, v3}, Lorg/apache/cordova/CordovaInterface;->startActivityForResult(Lorg/apache/cordova/CordovaPlugin;Landroid/content/Intent;I)V

    goto/16 :goto_c

    :cond_24
    const-string v2, "getServiceState"

    .line 452
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2d

    .line 455
    :try_start_3
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v2, "bluetoothEnabled"

    iget-object v5, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v5, :cond_25

    .line 459
    invoke-virtual {v5}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v5

    if-eqz v5, :cond_25

    move v5, v9

    goto :goto_4

    :cond_25
    move v5, v4

    :goto_4
    invoke-virtual {v0, v2, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v2, "bluetoothState"

    iget-object v5, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v5, :cond_26

    iget-object v7, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothStates:Ljava/util/Map;

    .line 460
    invoke-virtual {v5}, Landroid/bluetooth/BluetoothAdapter;->getState()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v7, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    goto :goto_5

    :cond_26
    const-string v5, "unknown"

    :goto_5
    invoke-virtual {v0, v2, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v2, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v2, :cond_27

    .line 465
    invoke-virtual {v2}, Landroid/bluetooth/BluetoothAdapter;->getBluetoothLeAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;

    move-result-object v2

    if-eqz v2, :cond_27

    iget-object v2, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->advertisingStartedCallback:Lorg/apache/cordova/CallbackContext;

    if-eqz v2, :cond_27

    move v2, v9

    goto :goto_6

    :cond_27
    move v2, v4

    :goto_6
    const-string v5, "isAdvertising"

    .line 469
    invoke-virtual {v0, v5, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v2, "advertisingName"

    iget-object v5, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    .line 471
    invoke-virtual {v5}, Landroid/bluetooth/BluetoothAdapter;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v2, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 475
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    iget-object v5, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->services:Ljava/util/Map;

    .line 476
    invoke-interface {v5}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_7
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_2b

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Map$Entry;

    .line 477
    new-instance v8, Lorg/json/JSONObject;

    invoke-direct {v8}, Lorg/json/JSONObject;-><init>()V

    .line 478
    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Landroid/bluetooth/BluetoothGattService;

    .line 480
    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/UUID;

    invoke-virtual {v7}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v8, v15, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v7, "type"

    .line 481
    invoke-virtual {v12}, Landroid/bluetooth/BluetoothGattService;->getType()I

    move-result v13

    if-nez v13, :cond_28

    const-string v13, "primary"

    goto :goto_8

    :cond_28
    const-string v13, "secondary"

    :goto_8
    invoke-virtual {v8, v7, v13}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 484
    new-instance v7, Lorg/json/JSONArray;

    invoke-direct {v7}, Lorg/json/JSONArray;-><init>()V

    .line 485
    invoke-virtual {v12}, Landroid/bluetooth/BluetoothGattService;->getCharacteristics()Ljava/util/List;

    move-result-object v12

    invoke-interface {v12}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v12

    :goto_9
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_2a

    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Landroid/bluetooth/BluetoothGattCharacteristic;

    .line 486
    new-instance v14, Lorg/json/JSONObject;

    invoke-direct {v14}, Lorg/json/JSONObject;-><init>()V

    .line 487
    invoke-virtual {v13}, Landroid/bluetooth/BluetoothGattCharacteristic;->getUuid()Ljava/util/UUID;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v14, v15, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 488
    invoke-virtual {v13}, Landroid/bluetooth/BluetoothGattCharacteristic;->getProperties()I

    move-result v4

    invoke-virtual {v14, v10, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 489
    invoke-virtual {v13}, Landroid/bluetooth/BluetoothGattCharacteristic;->getPermissions()I

    move-result v4

    move-object/from16 v9, v17

    invoke-virtual {v14, v9, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 492
    new-instance v4, Lorg/json/JSONArray;

    invoke-direct {v4}, Lorg/json/JSONArray;-><init>()V

    .line 493
    invoke-virtual {v13}, Landroid/bluetooth/BluetoothGattCharacteristic;->getDescriptors()Ljava/util/List;

    move-result-object v13

    invoke-interface {v13}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v13

    :goto_a
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_29

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Landroid/bluetooth/BluetoothGattDescriptor;

    move-object/from16 p1, v5

    .line 494
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 495
    invoke-virtual/range {v16 .. v16}, Landroid/bluetooth/BluetoothGattDescriptor;->getUuid()Ljava/util/UUID;

    move-result-object v17

    move-object/from16 v19, v10

    invoke-virtual/range {v17 .. v17}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v5, v15, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 496
    invoke-virtual/range {v16 .. v16}, Landroid/bluetooth/BluetoothGattDescriptor;->getPermissions()I

    move-result v10

    invoke-virtual {v5, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 497
    invoke-virtual {v4, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    move-object/from16 v5, p1

    move-object/from16 v10, v19

    goto :goto_a

    :cond_29
    move-object/from16 p1, v5

    move-object/from16 v19, v10

    move-object/from16 v5, v18

    .line 499
    invoke-virtual {v14, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 501
    invoke-virtual {v7, v14}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    move-object/from16 v18, v5

    move-object/from16 v17, v9

    move-object/from16 v10, v19

    const/4 v4, 0x0

    const/4 v9, 0x1

    move-object/from16 v5, p1

    goto :goto_9

    :cond_2a
    move-object/from16 p1, v5

    move-object/from16 v19, v10

    move-object/from16 v9, v17

    move-object/from16 v5, v18

    .line 503
    invoke-virtual {v8, v11, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 505
    invoke-virtual {v2, v8}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    move-object/from16 v18, v5

    move-object/from16 v17, v9

    move-object/from16 v10, v19

    const/4 v4, 0x0

    const/4 v9, 0x1

    move-object/from16 v5, p1

    goto/16 :goto_7

    :cond_2b
    const-string v4, "services"

    .line 507
    invoke-virtual {v0, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v2, "connectedDevicesCount"

    iget-object v4, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->registeredDevices:Ljava/util/Set;

    .line 510
    invoke-interface {v4}, Ljava/util/Set;->size()I

    move-result v4

    invoke-virtual {v0, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v2, "gattServerActive"

    iget-object v4, v1, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->gattServer:Landroid/bluetooth/BluetoothGattServer;

    if-eqz v4, :cond_2c

    const/4 v7, 0x1

    goto :goto_b

    :cond_2c
    const/4 v7, 0x0

    .line 513
    :goto_b
    invoke-virtual {v0, v2, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 515
    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->success(Lorg/json/JSONObject;)V
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_c

    :catch_3
    move-exception v0

    const-string v2, "Error creating service status JSON"

    .line 518
    invoke-static {v6, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 519
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "Failed to get service status: "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    :goto_c
    const/4 v7, 0x1

    goto :goto_d

    :cond_2d
    const/4 v7, 0x0

    :goto_d
    return v7
.end method

.method public initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V
    .locals 0

    .line 116
    invoke-super {p0, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    return-void
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    const/16 p3, 0x11

    if-ne p1, p3, :cond_2

    const/4 p1, -0x1

    if-ne p2, p1, :cond_0

    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->enableBluetoothCallback:Lorg/apache/cordova/CallbackContext;

    if-eqz p1, :cond_1

    .line 634
    invoke-virtual {p1}, Lorg/apache/cordova/CallbackContext;->success()V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->enableBluetoothCallback:Lorg/apache/cordova/CallbackContext;

    if-eqz p1, :cond_1

    const-string p2, "User did not enable Bluetooth"

    .line 638
    invoke-virtual {p1, p2}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    :cond_1
    :goto_0
    const/4 p1, 0x0

    iput-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->enableBluetoothCallback:Lorg/apache/cordova/CallbackContext;

    :cond_2
    return-void
.end method

.method public onDestroy()V
    .locals 0

    .line 121
    invoke-direct {p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->removeStateListener()V

    .line 122
    invoke-direct {p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stopAdvertisingIfStarted()V

    return-void
.end method

.method public onReset()V
    .locals 0

    .line 127
    invoke-direct {p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->removeStateListener()V

    .line 128
    invoke-direct {p0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;->stopAdvertisingIfStarted()V

    return-void
.end method
