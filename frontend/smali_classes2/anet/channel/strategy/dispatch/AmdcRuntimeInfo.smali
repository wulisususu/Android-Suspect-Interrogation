.class public Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static final TAG:Ljava/lang/String; = "awcn.AmdcRuntimeInfo"

.field private static volatile amdcLimitLevel:I = 0x0

.field private static volatile amdcLimitTime:J = 0x0L

.field public static volatile appChannel:Ljava/lang/String; = null

.field public static volatile appName:Ljava/lang/String; = null

.field public static volatile appVersion:Ljava/lang/String; = null

.field private static volatile context:Landroid/content/Context; = null

.field private static volatile forceHttps:Z = false

.field private static iSign:Lanet/channel/strategy/dispatch/IAmdcSign;

.field public static volatile latitude:D

.field public static volatile longitude:D

.field private static params:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getAmdcLimitLevel()I
    .locals 4

    sget v0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->amdcLimitLevel:I

    if-lez v0, :cond_0

    .line 50
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sget-wide v2, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->amdcLimitTime:J

    sub-long/2addr v0, v2

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    sput-wide v2, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->amdcLimitTime:J

    const/4 v0, 0x0

    sput v0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->amdcLimitLevel:I

    :cond_0
    sget v0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->amdcLimitLevel:I

    return v0
.end method

.method public static getContext()Landroid/content/Context;
    .locals 1

    sget-object v0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->context:Landroid/content/Context;

    return-object v0
.end method

.method public static declared-synchronized getParams()Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const-class v0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->params:Ljava/util/Map;

    if-nez v1, :cond_0

    .line 95
    sget-object v1, Ljava/util/Collections;->EMPTY_MAP:Ljava/util/Map;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 97
    :cond_0
    :try_start_1
    new-instance v1, Ljava/util/HashMap;

    sget-object v2, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->params:Ljava/util/Map;

    invoke-direct {v1, v2}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static getSign()Lanet/channel/strategy/dispatch/IAmdcSign;
    .locals 1

    sget-object v0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->iSign:Lanet/channel/strategy/dispatch/IAmdcSign;

    return-object v0
.end method

.method public static isForceHttps()Z
    .locals 1

    sget-boolean v0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->forceHttps:Z

    return v0
.end method

.method public static setAppInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->appName:Ljava/lang/String;

    sput-object p1, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->appVersion:Ljava/lang/String;

    sput-object p2, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->appChannel:Ljava/lang/String;

    return-void
.end method

.method public static setContext(Landroid/content/Context;)V
    .locals 0

    sput-object p0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->context:Landroid/content/Context;

    return-void
.end method

.method public static setForceHttps(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->forceHttps:Z

    return-void
.end method

.method public static declared-synchronized setParam(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    const-class v0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->params:Ljava/util/Map;

    if-nez v1, :cond_0

    .line 88
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    sput-object v1, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->params:Ljava/util/Map;

    :cond_0
    sget-object v1, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->params:Ljava/util/Map;

    .line 90
    invoke-interface {v1, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 91
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static setSign(Lanet/channel/strategy/dispatch/IAmdcSign;)V
    .locals 0

    sput-object p0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->iSign:Lanet/channel/strategy/dispatch/IAmdcSign;

    return-void
.end method

.method public static updateAmdcLimit(II)V
    .locals 4

    .line 41
    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string v1, "time"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "level"

    filled-new-array {v3, v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "awcn.AmdcRuntimeInfo"

    const-string v2, "set amdc limit"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3, v0}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-ltz p0, :cond_1

    const/4 v0, 0x3

    if-le p0, v0, :cond_0

    goto :goto_0

    :cond_0
    sput p0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->amdcLimitLevel:I

    .line 46
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    int-to-long p0, p1

    const-wide/16 v2, 0x3e8

    mul-long/2addr p0, v2

    add-long/2addr v0, p0

    sput-wide v0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->amdcLimitTime:J

    :cond_1
    :goto_0
    return-void
.end method

.method public static updateLocation(DD)V
    .locals 0

    sput-wide p0, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->latitude:D

    sput-wide p2, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->longitude:D

    return-void
.end method
