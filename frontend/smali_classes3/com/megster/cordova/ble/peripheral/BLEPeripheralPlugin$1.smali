.class Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$1;
.super Ljava/util/Hashtable;
.source "BLEPeripheralPlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/Hashtable<",
        "Ljava/lang/Integer;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;


# direct methods
.method constructor <init>(Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;)V
    .locals 1

    iput-object p1, p0, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$1;->this$0:Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin;

    .line 107
    invoke-direct {p0}, Ljava/util/Hashtable;-><init>()V

    const/16 p1, 0xa

    .line 108
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v0, "off"

    invoke-virtual {p0, p1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/16 p1, 0xd

    .line 109
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v0, "turningOff"

    invoke-virtual {p0, p1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/16 p1, 0xc

    .line 110
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v0, "on"

    invoke-virtual {p0, p1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/16 p1, 0xb

    .line 111
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v0, "turningOn"

    invoke-virtual {p0, p1, v0}, Lcom/megster/cordova/ble/peripheral/BLEPeripheralPlugin$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
