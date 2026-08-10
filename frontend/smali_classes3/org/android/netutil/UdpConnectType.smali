.class public Lorg/android/netutil/UdpConnectType;
.super Ljava/lang/Object;
.source "UdpConnectType.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static native nativeTestUdpConnectIpv4()I
.end method

.method private static native nativeTestUdpConnectIpv6()I
.end method

.method public static testUdpConnectIpv4()Z
    .locals 1

    .line 11
    invoke-static {}, Lorg/android/netutil/UdpConnectType;->nativeTestUdpConnectIpv4()I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static testUdpConnectIpv6()Z
    .locals 1

    .line 16
    invoke-static {}, Lorg/android/netutil/UdpConnectType;->nativeTestUdpConnectIpv6()I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
