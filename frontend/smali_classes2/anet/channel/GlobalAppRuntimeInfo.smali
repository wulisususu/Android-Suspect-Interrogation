.class public Lanet/channel/GlobalAppRuntimeInfo;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static a:Landroid/content/Context;

.field private static b:Lanet/channel/entity/ENV;

.field private static c:Ljava/lang/String;

.field private static d:Ljava/lang/String;

.field private static e:Ljava/lang/String;

.field private static f:Ljava/lang/String;

.field private static g:Ljava/lang/String;

.field private static volatile h:Z

.field private static i:Landroid/content/SharedPreferences;

.field private static volatile j:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile k:J

.field private static l:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 34
    sget-object v0, Lanet/channel/entity/ENV;->ONLINE:Lanet/channel/entity/ENV;

    sput-object v0, Lanet/channel/GlobalAppRuntimeInfo;->b:Lanet/channel/entity/ENV;

    const-string v0, ""

    sput-object v0, Lanet/channel/GlobalAppRuntimeInfo;->c:Ljava/lang/String;

    sput-object v0, Lanet/channel/GlobalAppRuntimeInfo;->d:Ljava/lang/String;

    const/4 v0, 0x1

    sput-boolean v0, Lanet/channel/GlobalAppRuntimeInfo;->h:Z

    const/4 v0, 0x0

    sput-object v0, Lanet/channel/GlobalAppRuntimeInfo;->i:Landroid/content/SharedPreferences;

    sput-object v0, Lanet/channel/GlobalAppRuntimeInfo;->j:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addBucketInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 184
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 187
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x20

    if-gt v0, v1, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v1, :cond_1

    goto :goto_0

    :cond_1
    const-class v0, Lanet/channel/GlobalAppRuntimeInfo;

    .line 190
    monitor-enter v0

    :try_start_0
    sget-object v1, Lanet/channel/GlobalAppRuntimeInfo;->j:Ljava/util/concurrent/CopyOnWriteArrayList;

    if-nez v1, :cond_2

    .line 192
    new-instance v1, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    sput-object v1, Lanet/channel/GlobalAppRuntimeInfo;->j:Ljava/util/concurrent/CopyOnWriteArrayList;

    :cond_2
    sget-object v1, Lanet/channel/GlobalAppRuntimeInfo;->j:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 194
    invoke-virtual {v1, p0}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    sget-object p0, Lanet/channel/GlobalAppRuntimeInfo;->j:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 195
    invoke-virtual {p0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 196
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0

    :cond_3
    :goto_0
    return-void
.end method

.method public static getBucketInfo()Ljava/util/concurrent/CopyOnWriteArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->j:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-object v0
.end method

.method public static getContext()Landroid/content/Context;
    .locals 1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->a:Landroid/content/Context;

    return-object v0
.end method

.method public static getCurrentProcess()Ljava/lang/String;
    .locals 1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->d:Ljava/lang/String;

    return-object v0
.end method

.method public static getEnv()Lanet/channel/entity/ENV;
    .locals 1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->b:Lanet/channel/entity/ENV;

    return-object v0
.end method

.method public static getInitTime()J
    .locals 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    sget-wide v0, Lanet/channel/GlobalAppRuntimeInfo;->k:J

    return-wide v0
.end method

.method public static getStartType()I
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 215
    invoke-static {}, Lanet/channel/fulltrace/a;->a()Lanet/channel/fulltrace/IFullTraceAnalysis;

    move-result-object v0

    invoke-interface {v0}, Lanet/channel/fulltrace/IFullTraceAnalysis;->getSceneInfo()Lanet/channel/fulltrace/b;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 217
    iget v0, v0, Lanet/channel/fulltrace/b;->a:I

    return v0

    :cond_0
    const/4 v0, -0x1

    return v0
.end method

.method public static getTtid()Ljava/lang/String;
    .locals 1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->e:Ljava/lang/String;

    return-object v0
.end method

.method public static getUserId()Ljava/lang/String;
    .locals 1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->f:Ljava/lang/String;

    return-object v0
.end method

.method public static getUtdid()Ljava/lang/String;
    .locals 1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->g:Ljava/lang/String;

    if-nez v0, :cond_0

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->a:Landroid/content/Context;

    if-eqz v0, :cond_0

    .line 166
    invoke-static {v0}, Lanet/channel/util/Utils;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lanet/channel/GlobalAppRuntimeInfo;->g:Ljava/lang/String;

    :cond_0
    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->g:Ljava/lang/String;

    return-object v0
.end method

.method public static isAppBackground()Z
    .locals 1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->a:Landroid/content/Context;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    sget-boolean v0, Lanet/channel/GlobalAppRuntimeInfo;->h:Z

    return v0
.end method

.method public static isTargetProcess()Z
    .locals 2

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->c:Ljava/lang/String;

    .line 86
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->d:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->c:Ljava/lang/String;

    sget-object v1, Lanet/channel/GlobalAppRuntimeInfo;->d:Ljava/lang/String;

    .line 89
    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    return v0

    :cond_1
    :goto_0
    const/4 v0, 0x1

    return v0
.end method

.method public static isTargetProcess(Ljava/lang/String;)Z
    .locals 1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->c:Ljava/lang/String;

    .line 93
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->c:Ljava/lang/String;

    .line 96
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p0

    return p0

    :cond_1
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method public static setBackground(Z)V
    .locals 0

    sput-boolean p0, Lanet/channel/GlobalAppRuntimeInfo;->h:Z

    return-void
.end method

.method public static setContext(Landroid/content/Context;)V
    .locals 4

    sput-object p0, Lanet/channel/GlobalAppRuntimeInfo;->a:Landroid/content/Context;

    if-eqz p0, :cond_3

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->d:Ljava/lang/String;

    .line 59
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 60
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    invoke-static {p0, v0}, Lanet/channel/util/Utils;->getProcessName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lanet/channel/GlobalAppRuntimeInfo;->d:Ljava/lang/String;

    :cond_0
    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->c:Ljava/lang/String;

    .line 63
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 65
    invoke-static {p0}, Lanet/channel/util/Utils;->getMainProcessName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lanet/channel/GlobalAppRuntimeInfo;->c:Ljava/lang/String;

    :cond_1
    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->i:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    if-nez v0, :cond_2

    .line 69
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p0

    sput-object p0, Lanet/channel/GlobalAppRuntimeInfo;->i:Landroid/content/SharedPreferences;

    const-string v0, "UserId"

    .line 70
    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lanet/channel/GlobalAppRuntimeInfo;->f:Ljava/lang/String;

    :cond_2
    sget-object p0, Lanet/channel/GlobalAppRuntimeInfo;->d:Ljava/lang/String;

    const-string v0, "TargetProcess"

    sget-object v2, Lanet/channel/GlobalAppRuntimeInfo;->c:Ljava/lang/String;

    const-string v3, "CurrentProcess"

    .line 73
    filled-new-array {v3, p0, v0, v2}, [Ljava/lang/Object;

    move-result-object p0

    const-string v0, "awcn.GlobalAppRuntimeInfo"

    const-string v2, ""

    invoke-static {v0, v2, v1, p0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_3
    return-void
.end method

.method public static setCurrentProcess(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lanet/channel/GlobalAppRuntimeInfo;->d:Ljava/lang/String;

    return-void
.end method

.method public static setEnv(Lanet/channel/entity/ENV;)V
    .locals 0

    sput-object p0, Lanet/channel/GlobalAppRuntimeInfo;->b:Lanet/channel/entity/ENV;

    return-void
.end method

.method public static setInitTime(J)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    sput-wide p0, Lanet/channel/GlobalAppRuntimeInfo;->k:J

    return-void
.end method

.method public static setTargetProcess(Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lanet/channel/GlobalAppRuntimeInfo;->c:Ljava/lang/String;

    return-void
.end method

.method public static setTtid(Ljava/lang/String;)V
    .locals 5

    sput-object p0, Lanet/channel/GlobalAppRuntimeInfo;->e:Ljava/lang/String;

    .line 118
    :try_start_0
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "@"

    .line 123
    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, -0x1

    const/4 v3, 0x0

    if-eq v0, v2, :cond_0

    .line 124
    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_0
    move-object v4, v3

    :goto_0
    add-int/lit8 v0, v0, 0x1

    .line 126
    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    const-string v0, "_"

    .line 127
    invoke-virtual {p0, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    if-eq v0, v2, :cond_1

    .line 128
    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    add-int/lit8 v0, v0, 0x1

    .line 129
    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    move-object p0, v1

    :cond_1
    sput-object v3, Lanet/channel/GlobalAppRuntimeInfo;->l:Ljava/lang/String;

    .line 134
    invoke-static {p0, v3, v4}, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->setAppInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public static setUserId(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->f:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 145
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    sput-object p0, Lanet/channel/GlobalAppRuntimeInfo;->f:Ljava/lang/String;

    .line 147
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object v0

    invoke-static {}, Lanet/channel/strategy/dispatch/DispatchConstants;->getAmdcServerDomain()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lanet/channel/strategy/IStrategyInstance;->forceRefreshStrategy(Ljava/lang/String;)V

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->i:Landroid/content/SharedPreferences;

    if-eqz v0, :cond_1

    .line 149
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "UserId"

    invoke-interface {v0, v1, p0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    :cond_1
    return-void
.end method

.method public static setUtdid(Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lanet/channel/GlobalAppRuntimeInfo;->g:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 159
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    sput-object p0, Lanet/channel/GlobalAppRuntimeInfo;->g:Ljava/lang/String;

    :cond_1
    return-void
.end method
