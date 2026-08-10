.class public Lcom/alibaba/ha/adapter/service/crash/CrashService;
.super Ljava/lang/Object;
.source "CrashService.java"


# static fields
.field public static isValid:Z = false


# direct methods
.method public static constructor <clinit>()V
    .locals 1

    :try_start_0
    const-string v0, "com.alibaba.motu.crashreporter.MotuCrashReporter"

    .line 19
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z

    :goto_0
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addCustomInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 107
    :cond_0
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->addCustomInfo(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static addJavaCrashListener(Lcom/alibaba/ha/adapter/service/crash/JavaCrashListener;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 35
    :cond_0
    new-instance v0, Lcom/alibaba/ha/adapter/service/crash/JavaCrashListenerAdapter;

    invoke-direct {v0, p0}, Lcom/alibaba/ha/adapter/service/crash/JavaCrashListenerAdapter;-><init>(Lcom/alibaba/ha/adapter/service/crash/JavaCrashListener;)V

    .line 36
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object p0

    invoke-virtual {p0, v0}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->setCrashCaughtListener(Lcom/alibaba/motu/crashreporter/IUTCrashCaughtListener;)V

    return-void
.end method

.method public static addNativeHeaderInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 99
    :cond_0
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->addNativeHeaderInfo(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static changeHost(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_1

    .line 49
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->changeHost(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public static setErrorCallback(Lcom/alibaba/ha/protocol/crash/ErrorCallback;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 115
    :cond_0
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->setErrorCallback(Lcom/alibaba/ha/protocol/crash/ErrorCallback;)V

    return-void
.end method

.method public static updateApppVersion(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 62
    :cond_0
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->setAppVersion(Ljava/lang/String;)V

    return-void
.end method

.method public static updateChannel(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 86
    :cond_0
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->setTTid(Ljava/lang/String;)V

    return-void
.end method

.method public static updateUserNick(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/crash/CrashService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 74
    :cond_0
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->setUserNick(Ljava/lang/String;)V

    return-void
.end method
