.class public Lcom/taobao/monitor/ProcedureLauncher;
.super Ljava/lang/Object;
.source "ProcedureLauncher.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/ProcedureLauncher$Delay;
    }
.end annotation


# static fields
.field private static init:Z = false


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static OS()[Ljava/lang/String;
    .locals 7

    const/4 v0, 0x0

    :try_start_0
    const-string v1, "android.os.SystemProperties"

    .line 128
    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "get"

    const/4 v3, 0x1

    new-array v4, v3, [Ljava/lang/Class;

    const-class v5, Ljava/lang/String;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    const-string v4, "ro.yunos.version"

    aput-object v4, v2, v6

    .line 129
    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-array v3, v3, [Ljava/lang/Object;

    const-string v4, "java.vm.name"

    aput-object v4, v3, v6

    .line 130
    invoke-virtual {v1, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-object v0, v1

    goto :goto_1

    :catch_0
    move-exception v1

    goto :goto_0

    :catch_1
    move-exception v1

    move-object v2, v0

    .line 132
    :goto_0
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 134
    :goto_1
    filled-new-array {v2, v0}, [Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static getAppBuildVersion(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "context"
        }
    .end annotation

    .line 89
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 90
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p0

    const/4 v1, 0x0

    .line 92
    :try_start_0
    invoke-virtual {p0, v0, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 94
    invoke-virtual {p0}, Landroid/content/pm/PackageInfo;->getLongVersionCode()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 96
    :cond_0
    iget p0, p0, Landroid/content/pm/PackageInfo;->versionCode:I

    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const-string p0, ""

    return-object p0
.end method

.method public static init(Landroid/content/Context;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "context",
            "params"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    sget-boolean v0, Lcom/taobao/monitor/ProcedureLauncher;->init:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    sput-boolean v0, Lcom/taobao/monitor/ProcedureLauncher;->init:Z

    .line 34
    invoke-static {}, Lcom/taobao/monitor/ProcedureGlobal;->instance()Lcom/taobao/monitor/ProcedureGlobal;

    move-result-object v0

    .line 35
    invoke-virtual {v0, p0}, Lcom/taobao/monitor/ProcedureGlobal;->setContext(Landroid/content/Context;)Lcom/taobao/monitor/ProcedureGlobal;

    .line 36
    invoke-static {p0, p1}, Lcom/taobao/monitor/ProcedureLauncher;->initHeader(Landroid/content/Context;Ljava/util/Map;)V

    .line 37
    sget-object p0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    sget-object p1, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->setReal(Lcom/taobao/monitor/procedure/IProcedureManager;)Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    .line 38
    sget-object p0, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    sget-object p1, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_FACTORY:Lcom/taobao/monitor/procedure/ProcedureFactory;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->setReal(Lcom/taobao/monitor/procedure/IProcedureFactory;)Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    :cond_0
    return-void
.end method

.method private static initHeader(Landroid/content/Context;Ljava/util/Map;)V
    .locals 3
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "context",
            "params"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 46
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/taobao/monitor/procedure/Header;->appId:Ljava/lang/String;

    const-string v0, "onlineAppKey"

    .line 47
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "12278902"

    invoke-static {v0, v1}, Lcom/taobao/monitor/ProcedureLauncher;->safeString(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/taobao/monitor/procedure/Header;->appKey:Ljava/lang/String;

    .line 48
    invoke-static {p0}, Lcom/taobao/monitor/ProcedureLauncher;->getAppBuildVersion(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/monitor/procedure/Header;->appBuild:Ljava/lang/String;

    const-string p0, "appVersion"

    .line 50
    invoke-interface {p1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    new-instance v0, Lcom/taobao/monitor/ProcedureLauncher$1;

    invoke-direct {v0}, Lcom/taobao/monitor/ProcedureLauncher$1;-><init>()V

    invoke-static {p0, v0}, Lcom/taobao/monitor/ProcedureLauncher;->safeString(Ljava/lang/Object;Lcom/taobao/monitor/ProcedureLauncher$Delay;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/monitor/procedure/Header;->appVersion:Ljava/lang/String;

    const-string p0, "appPatch"

    .line 66
    invoke-interface {p1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    const-string v0, ""

    invoke-static {p0, v0}, Lcom/taobao/monitor/ProcedureLauncher;->safeString(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/monitor/procedure/Header;->appPatch:Ljava/lang/String;

    const-string p0, "channel"

    .line 67
    invoke-interface {p1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0, v0}, Lcom/taobao/monitor/ProcedureLauncher;->safeString(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/monitor/procedure/Header;->channel:Ljava/lang/String;

    const-string p0, "deviceId"

    .line 68
    invoke-interface {p1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0, v0}, Lcom/taobao/monitor/ProcedureLauncher;->safeString(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/monitor/procedure/Header;->utdid:Ljava/lang/String;

    .line 70
    invoke-static {}, Lcom/taobao/monitor/ProcedureLauncher;->OS()[Ljava/lang/String;

    move-result-object p0

    const/4 v1, 0x0

    .line 71
    aget-object v1, p0, v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    .line 72
    aget-object p0, p0, v1

    sput-object p0, Lcom/taobao/monitor/procedure/Header;->os:Ljava/lang/String;

    goto :goto_0

    :cond_0
    const-string p0, "android"

    .line 74
    sput-object p0, Lcom/taobao/monitor/procedure/Header;->os:Ljava/lang/String;

    :goto_0
    const-string p0, "process"

    .line 77
    invoke-interface {p1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    new-instance v1, Lcom/taobao/monitor/ProcedureLauncher$2;

    invoke-direct {v1}, Lcom/taobao/monitor/ProcedureLauncher$2;-><init>()V

    invoke-static {p0, v1}, Lcom/taobao/monitor/ProcedureLauncher;->safeString(Ljava/lang/Object;Lcom/taobao/monitor/ProcedureLauncher$Delay;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/monitor/procedure/Header;->processName:Ljava/lang/String;

    .line 84
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/monitor/procedure/Header;->session:Ljava/lang/String;

    const-string p0, "ttid"

    .line 85
    invoke-interface {p1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0, v0}, Lcom/taobao/monitor/ProcedureLauncher;->safeString(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/monitor/procedure/Header;->ttid:Ljava/lang/String;

    return-void
.end method

.method private static safeString(Ljava/lang/Object;Lcom/taobao/monitor/ProcedureLauncher$Delay;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "string",
            "delay"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lcom/taobao/monitor/ProcedureLauncher$Delay<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 115
    instance-of v0, p0, Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 116
    check-cast p0, Ljava/lang/String;

    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    .line 120
    :cond_0
    invoke-interface {p1}, Lcom/taobao/monitor/ProcedureLauncher$Delay;->call()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    return-object p0
.end method

.method private static safeString(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "string",
            "defaultValue"
        }
    .end annotation

    .line 106
    instance-of v0, p0, Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 107
    check-cast p0, Ljava/lang/String;

    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    :cond_0
    return-object p1
.end method
