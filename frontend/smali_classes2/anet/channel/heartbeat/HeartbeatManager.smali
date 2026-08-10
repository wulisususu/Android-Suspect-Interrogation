.class public Lanet/channel/heartbeat/HeartbeatManager;
.super Ljava/lang/Object;
.source "Taobao"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getDefaultBackgroundAccsHeartbeat()Lanet/channel/heartbeat/IHeartbeat;
    .locals 1

    .line 13
    new-instance v0, Lanet/channel/heartbeat/a;

    invoke-direct {v0}, Lanet/channel/heartbeat/a;-><init>()V

    return-object v0
.end method

.method public static getDefaultHeartbeat()Lanet/channel/heartbeat/IHeartbeat;
    .locals 1

    .line 9
    new-instance v0, Lanet/channel/heartbeat/b;

    invoke-direct {v0}, Lanet/channel/heartbeat/b;-><init>()V

    return-object v0
.end method
