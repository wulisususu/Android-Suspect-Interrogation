.class public Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;
.super Ljava/lang/Object;
.source "CrashReporterPlugin.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;->start(Lcom/alibaba/ha/protocol/AliHaParam;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;

.field public final synthetic val$appId:Ljava/lang/String;

.field public final synthetic val$appKey:Ljava/lang/String;

.field public final synthetic val$appSecret:Ljava/lang/String;

.field public final synthetic val$appVersion:Ljava/lang/String;

.field public final synthetic val$channel:Ljava/lang/String;

.field public final synthetic val$context:Landroid/content/Context;

.field public final synthetic val$enableInterceptNotMainThreadException:Z

.field public final synthetic val$userNick:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;ZLandroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->this$0:Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;

    iput-boolean p2, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$enableInterceptNotMainThreadException:Z

    iput-object p3, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$context:Landroid/content/Context;

    iput-object p4, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$appId:Ljava/lang/String;

    iput-object p5, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$appKey:Ljava/lang/String;

    iput-object p6, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$appSecret:Ljava/lang/String;

    iput-object p7, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$appVersion:Ljava/lang/String;

    iput-object p8, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$channel:Ljava/lang/String;

    iput-object p9, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$userNick:Ljava/lang/String;

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .line 65
    new-instance v8, Lcom/alibaba/motu/crashreporter/ReporterConfigure;

    invoke-direct {v8}, Lcom/alibaba/motu/crashreporter/ReporterConfigure;-><init>()V

    const/4 v0, 0x1

    .line 66
    invoke-virtual {v8, v0}, Lcom/alibaba/motu/crashreporter/ReporterConfigure;->setEnableDumpSysLog(Z)V

    .line 67
    invoke-virtual {v8, v0}, Lcom/alibaba/motu/crashreporter/ReporterConfigure;->setEnableDumpRadioLog(Z)V

    .line 68
    invoke-virtual {v8, v0}, Lcom/alibaba/motu/crashreporter/ReporterConfigure;->setEnableDumpEventsLog(Z)V

    .line 69
    invoke-virtual {v8, v0}, Lcom/alibaba/motu/crashreporter/ReporterConfigure;->setEnableCatchANRException(Z)V

    const/4 v0, 0x0

    .line 70
    iput-boolean v0, v8, Lcom/alibaba/motu/crashreporter/ReporterConfigure;->enableDeduplication:Z

    .line 71
    iput-boolean v0, v8, Lcom/alibaba/motu/crashreporter/ReporterConfigure;->enableUncaughtExceptionIgnore:Z

    iget-boolean v0, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$enableInterceptNotMainThreadException:Z

    .line 72
    iput-boolean v0, v8, Lcom/alibaba/motu/crashreporter/ReporterConfigure;->enableUncaughtExceptionIgnore:Z

    .line 78
    :try_start_0
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$context:Landroid/content/Context;

    iget-object v2, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$appId:Ljava/lang/String;

    iget-object v3, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$appKey:Ljava/lang/String;

    iget-object v4, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$appSecret:Ljava/lang/String;

    iget-object v5, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$appVersion:Ljava/lang/String;

    iget-object v6, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$channel:Ljava/lang/String;

    iget-object v7, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$userNick:Ljava/lang/String;

    invoke-virtual/range {v0 .. v8}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->enable(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/motu/crashreporter/ReporterConfigure;)Z

    .line 79
    invoke-static {}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->getInstance()Lcom/alibaba/motu/crashreporter/MotuCrashReporter;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;->val$context:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/alibaba/motu/crashreporter/MotuCrashReporter;->registerLifeCallbacks(Landroid/content/Context;)V

    .line 82
    new-instance v0, Lcom/alibaba/ha/adapter/service/crash/CrashActivityCallBack;

    invoke-direct {v0}, Lcom/alibaba/ha/adapter/service/crash/CrashActivityCallBack;-><init>()V

    .line 83
    invoke-static {v0}, Lcom/alibaba/ha/adapter/service/crash/CrashService;->addJavaCrashListener(Lcom/alibaba/ha/adapter/service/crash/JavaCrashListener;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    const-string v1, "AliHaAdapter"

    const-string v2, "crashreporter plugin start failure "

    .line 85
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method
