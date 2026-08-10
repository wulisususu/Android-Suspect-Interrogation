.class public Lanet/channel/AwcnConfig;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field public static final HTTP3_ENABLE:Ljava/lang/String; = "HTTP3_ENABLE"

.field public static final NEXT_LAUNCH_FORBID:Ljava/lang/String; = "NEXT_LAUNCH_FORBID"

.field private static volatile a:Z = false

.field private static volatile b:Z = true

.field private static volatile c:Z = true

.field private static volatile d:Z = true

.field private static volatile e:Z = false

.field private static volatile f:Z = true

.field private static volatile g:J = 0x2932e00L

.field private static volatile h:Z = true

.field private static volatile i:Z = true

.field private static j:Z = true

.field private static k:Z = false

.field private static volatile l:Z = false

.field private static volatile m:Z = true

.field private static volatile n:Z = false

.field private static volatile o:I = 0x2710

.field private static volatile p:Z = false

.field private static volatile q:Z = true

.field private static volatile r:I = -0x1

.field private static volatile s:Z = true

.field private static volatile t:Z = true

.field private static volatile u:Z = false

.field private static volatile v:Z = true

.field private static volatile w:Ljava/util/concurrent/CopyOnWriteArrayList; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile x:Z = true

.field private static volatile y:Z = true


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getAccsReconnectionDelayPeriod()I
    .locals 1

    sget v0, Lanet/channel/AwcnConfig;->o:I

    return v0
.end method

.method public static getIpv6BlackListTtl()J
    .locals 2

    sget-wide v0, Lanet/channel/AwcnConfig;->g:J

    return-wide v0
.end method

.method public static getXquicCongControl()I
    .locals 1

    sget v0, Lanet/channel/AwcnConfig;->r:I

    return v0
.end method

.method public static isAccsSessionCreateForbiddenInBg()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->a:Z

    return v0
.end method

.method public static isAllowHttpDnsNotify(Ljava/lang/String;)Z
    .locals 1

    sget-object v0, Lanet/channel/AwcnConfig;->w:Ljava/util/concurrent/CopyOnWriteArrayList;

    if-eqz v0, :cond_1

    .line 305
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lanet/channel/AwcnConfig;->w:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 308
    invoke-virtual {v0, p0}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result p0

    return p0

    :cond_1
    :goto_0
    const/4 p0, 0x0

    return p0
.end method

.method public static isAppLifeCycleListenerEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->j:Z

    return v0
.end method

.method public static isAsyncLoadStrategyEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->k:Z

    return v0
.end method

.method public static isCarrierInfoEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->y:Z

    return v0
.end method

.method public static isCookieHeaderRedundantFix()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->t:Z

    return v0
.end method

.method public static isHorseRaceEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->c:Z

    return v0
.end method

.method public static isHttp3Enable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->p:Z

    return v0
.end method

.method public static isHttp3OrangeEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->q:Z

    return v0
.end method

.method public static isHttpsSniEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->b:Z

    return v0
.end method

.method public static isIdleSessionCloseEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->f:Z

    return v0
.end method

.method public static isIpStackDetectByUdpConnect()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->s:Z

    return v0
.end method

.method public static isIpv6BlackListEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->i:Z

    return v0
.end method

.method public static isIpv6Enable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->h:Z

    return v0
.end method

.method public static isNetworkDetectEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->n:Z

    return v0
.end method

.method public static isPing6Enable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->m:Z

    return v0
.end method

.method public static isQuicEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->e:Z

    return v0
.end method

.method public static isSendConnectInfoByBroadcast()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->u:Z

    return v0
.end method

.method public static isSendConnectInfoByService()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->v:Z

    return v0
.end method

.method public static isTbNextLaunch()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->l:Z

    return v0
.end method

.method public static isTnetHeaderCacheEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->d:Z

    return v0
.end method

.method public static isWifiInfoEnable()Z
    .locals 1

    sget-boolean v0, Lanet/channel/AwcnConfig;->x:Z

    return v0
.end method

.method public static registerPresetSessions(Ljava/lang/String;)V
    .locals 10

    .line 98
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isTargetProcess()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 101
    :cond_0
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    .line 106
    :cond_1
    :try_start_0
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0, p0}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 107
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result p0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, p0, :cond_4

    .line 109
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "host"

    .line 110
    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 111
    invoke-static {v4}, Lanet/channel/strategy/utils/c;->c(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    goto :goto_1

    :cond_2
    const-string v3, "protocol"

    .line 114
    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v5, "rtt"

    .line 115
    invoke-virtual {v2, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "publicKey"

    .line 116
    invoke-virtual {v2, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 117
    invoke-static {}, Lanet/channel/strategy/StrategyTemplate;->getInstance()Lanet/channel/strategy/StrategyTemplate;

    move-result-object v7

    invoke-static {v3, v5, v6}, Lanet/channel/strategy/ConnProtocol;->valueOf(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lanet/channel/strategy/ConnProtocol;

    move-result-object v3

    invoke-virtual {v7, v4, v3}, Lanet/channel/strategy/StrategyTemplate;->registerConnProtocol(Ljava/lang/String;Lanet/channel/strategy/ConnProtocol;)V

    const-string v3, "isKeepAlive"

    .line 119
    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    const/4 v5, 0x1

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    .line 121
    invoke-static/range {v4 .. v9}, Lanet/channel/SessionInfo;->create(Ljava/lang/String;ZZLanet/channel/IAuth;Lanet/channel/heartbeat/IHeartbeat;Lanet/channel/DataFrameCb;)Lanet/channel/SessionInfo;

    move-result-object v2

    .line 122
    invoke-static {}, Lanet/channel/SessionCenter;->getInstance()Lanet/channel/SessionCenter;

    move-result-object v3

    invoke-virtual {v3, v2}, Lanet/channel/SessionCenter;->registerSessionInfo(Lanet/channel/SessionInfo;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    :cond_4
    :goto_1
    return-void
.end method

.method public static setAccsReconnectionDelayPeriod(I)V
    .locals 1

    if-gez p0, :cond_0

    const/4 p0, 0x0

    :cond_0
    const/16 v0, 0x2710

    if-le p0, v0, :cond_1

    move p0, v0

    :cond_1
    sput p0, Lanet/channel/AwcnConfig;->o:I

    return-void
.end method

.method public static setAccsSessionCreateForbiddenInBg(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->a:Z

    return-void
.end method

.method public static setAppLifeCycleListenerEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->j:Z

    return-void
.end method

.method public static setAsyncLoadStrategyEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->k:Z

    return-void
.end method

.method public static setCarrierInfoEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->y:Z

    return-void
.end method

.method public static setCookieHeaderRedundantFix(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->t:Z

    return-void
.end method

.method public static setHorseRaceEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->c:Z

    return-void
.end method

.method public static setHttp3Enable(Z)V
    .locals 3

    sput-boolean p0, Lanet/channel/AwcnConfig;->p:Z

    const-string v0, "enable"

    .line 224
    invoke-static {p0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    filled-new-array {v0, p0}, [Ljava/lang/Object;

    move-result-object p0

    const-string v0, "awcn.AwcnConfig"

    const-string v1, "[setHttp3Enable]"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2, p0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public static setHttp3OrangeEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->q:Z

    return-void
.end method

.method public static setHttpDnsNotifyWhiteList(Ljava/lang/String;)V
    .locals 5

    .line 283
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    .line 287
    :try_start_0
    new-instance v1, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    .line 288
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2, p0}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    move p0, v0

    .line 289
    :goto_0
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-ge p0, v3, :cond_2

    .line 290
    invoke-virtual {v2, p0}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v3

    .line 291
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    goto :goto_1

    .line 294
    :cond_1
    invoke-virtual {v1, v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    :goto_1
    add-int/lit8 p0, p0, 0x1

    goto :goto_0

    :cond_2
    sput-object v1, Lanet/channel/AwcnConfig;->w:Ljava/util/concurrent/CopyOnWriteArrayList;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception p0

    const/4 v1, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v2, "awcn.AwcnConfig"

    const-string v3, "[setHttpDnsNotifyWhiteList] error"

    .line 298
    invoke-static {v2, v3, v1, p0, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_2
    return-void
.end method

.method public static setHttpsSniEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->b:Z

    return-void
.end method

.method public static setIdleSessionCloseEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->f:Z

    return-void
.end method

.method public static setIpStackDetectByUdpConnect(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->s:Z

    return-void
.end method

.method public static setIpv6BlackListEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->i:Z

    return-void
.end method

.method public static setIpv6BlackListTtl(J)V
    .locals 0

    sput-wide p0, Lanet/channel/AwcnConfig;->g:J

    return-void
.end method

.method public static setIpv6Enable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->h:Z

    return-void
.end method

.method public static setNetworkDetectEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->n:Z

    return-void
.end method

.method public static setPing6Enable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->m:Z

    return-void
.end method

.method public static setQuicEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->e:Z

    return-void
.end method

.method public static setSendConnectInfoByBroadcast(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->u:Z

    return-void
.end method

.method public static setSendConnectInfoByService(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->v:Z

    return-void
.end method

.method public static setTbNextLaunch(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->l:Z

    return-void
.end method

.method public static setTnetHeaderCacheEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->d:Z

    return-void
.end method

.method public static setWifiInfoEnable(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/AwcnConfig;->x:Z

    return-void
.end method

.method public static setXquicCongControl(I)V
    .locals 0

    if-gez p0, :cond_0

    return-void

    :cond_0
    sput p0, Lanet/channel/AwcnConfig;->r:I

    return-void
.end method
